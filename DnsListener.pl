use strict;
use warnings;
use Net::Pcap::Easy;

if ( $#ARGV != 3 ) {
    print "Usage: DnsListener.pl <interface> <maxbytesize> <outputfile> <domain>\n";
    print "Example: perl DnsListener.pl eth1 3000 vmware.com\n";
    print "Notice, domain must match on both the listener and the scan script!\n";
    print "Coded by Vypor, https://github.com/Vypor\n";
    exit(1);
}

my $interface = $ARGV[0];
my $leastsize = $ARGV[1];
my $LOGFILE   = $ARGV[2];
my $domain    = $ARGV[3];
my $ethip = `/sbin/ifconfig $interface | grep "inet addr" | awk -F: '{print \$2}' | awk '{print \$1}'`;
$ethip = substr( $ethip, 0, -1 );

my $listener = Net::Pcap::Easy->new(
    dev    => $interface,
    filter => "port 53 and udp and not src host $ethip and greater $leastsize",
    packets_per_loop => 10,
    bytes_to_capture => 0,
    timeout_in_ms    => 0,    # 0ms means forever
    promiscuous      => 0,    # true or false

    udp_callback => sub {
        my ( $listener, $ether, $ip, $udp, $header ) = @_;

        open( FILE, ">>$LOGFILE" );
        print FILE "$ip->{src_ip} $domain $udp->{len}\n";
        close FILE;
        print "$ip->{src_ip} $domain $udp->{len}\n";

    }
);
1 while $listener->loop;
