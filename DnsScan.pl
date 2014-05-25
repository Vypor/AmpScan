use IO::Socket;
use Net::DNS;
use Socket;
my $count;

if ( $#ARGV != 2 ) {
    print "Usage: DnsScan.pl <ip_start> <ip_end> <domain>\n";
    print "Example: perl DnsScan.pl 100.0.0.0 101.0.0.0 vmware.com\n";
    print "Coded by Vypor, https://github.com/Vypor\n";
    exit(1);
}

my $start  = $ARGV[0];
my $end    = $ARGV[1];
my $domain = $ARGV[2];

#Make The Packet
my $dnspacket = new Net::DNS::Packet( $domain, 'IN', 'ANY' );
$dnspacket->header->qr(0);    #Query Responce Flag
$dnspacket->header->aa(0);    #Authoritative Flag
$dnspacket->header->tc(0);    #Truncated Flag
$dnspacket->header->ra(0);    #Recursion Desired
$dnspacket->header->rd(1);    #Recursion Available
$udp_max = $dnspacket->header->size(65527);    #Max Allowed Byte Size
my $dnsdata = $dnspacket->data;

my $start_address  = unpack 'N', inet_aton($start);
my $finish_address = unpack 'N', inet_aton($end);

for my $address ( $start_address .. $finish_address ) {

    my $str = sprintf inet_ntoa( pack 'N', $address );

    $count++;
    print "Sent $count Requests.\r";

    my $socket = IO::Socket::INET->new(
        Proto    => 'udp',
        PeerPort => 53,
        SockPort => 53,
        PeerAddr => $str,
    ) or die "Could not create socket: $!\n";

    $socket->send($dnsdata) or die "Send Error: $!\n";

}
