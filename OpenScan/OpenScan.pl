use IO::Socket;
use Socket;

my $count;

if ( $#ARGV != 2 ) {
    print
"Usage: OpenScan.pl <ip_start> <ip_end> <packetfile> <sendingport> <recivingport>\n";
    print "Example: perl OpenScan.pl 100.0.0.0 101.0.0.0 file.pkt\n";
    print "Coded by Vypor, https://github.com/Vypor\n";
    exit(1);
}

my @darray;
open( my $fh, "<", "$ARGV[2]" ) or die "Failed to open file: $!\n";
while (<$fh>) { chomp; push @darray, $_; }
close $fh;

my $data = join "", @darray;

my $start      = $ARGV[0];
my $end        = $ARGV[1];
my $sendport   = $ARGV[3];
my $reciveport = $ARGV[4];

my $start_address  = unpack 'N', inet_aton($start);
my $finish_address = unpack 'N', inet_aton($end);

for my $address ( $start_address .. $finish_address ) {

    my $str = sprintf inet_ntoa( pack 'N', $address );

    $count++;
    print "Sent $count Requests.\r";

    my $socket = IO::Socket::INET->new(
        Proto    => 'udp',
        PeerPort => $sendport,
        SockPort => $reciveport,
        PeerAddr => $str,
    ) or die "Could not create socket: $!\n";

    $socket->send($data) or die "Send Error: $!\n";

}
