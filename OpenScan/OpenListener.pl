use strict;
use warnings;
use Net::Pcap::Easy;

if ( $#ARGV != 3 ) {
    print
      "Usage: OpenListener.pl <interface> <maxbytesize> <port> <outpufile>\n";
    print "Example: perl DnsListener.pl eth1 3000\n";
    print "Coded by Vypor, https://github.com/Vypor\n";
    exit(1);
}

my $interface = $ARGV[0];
my $leastsize = $ARGV[1];
my $port      = $ARGV[2];
my $LOGFILE   = $ARGV[3];
my $ethip = `/sbin/ifconfig $interface | grep "inet addr" | awk -F: '{print \$2}' | awk '{print \$1}'`;
$ethip = substr( $ethip, 0, -1 );

my $listener = Net::Pcap::Easy->new(
    dev => $interface,
    filter =>
      "port $port and udp and not src host $ethip and greater $leastsize",
    packets_per_loop => 10,
    bytes_to_capture => 0,
    timeout_in_ms    => 0,    # 0ms means forever
    promiscuous      => 0,    # true or false

    udp_callback => sub {
        my ( $listener, $ether, $ip, $udp, $header ) = @_;

        open( FILE, ">>$LOGFILE" );
        print FILE "$ip->{src_ip} $udp->{len}\n";
        close FILE;
        print "$ip->{src_ip} $udp->{len}\n";
    }
);
1 while $listener->loop;
