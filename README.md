AmpScan v0.1
=======
**Dependencies**
Net::DNS

        http://search.cpan.org/CPAN/authors/id/N/NL/NLNETLABS/Net-DNS-0.76.tar.gz
Net::Pcap

        http://search.cpan.org/~saper/Net-Pcap-0.17/Pcap.pm
Net::Pcap::Easy

        http://search.cpan.org/~jettero/Net-Pcap-Easy-1.4207/Easy.pod
**Usage's:**

Run Dnslistner before you start the Dnsscan.
    
    Usage: perl Dnslistener.pl <interface> <maxbytesize> <outputfile>
    
    perl Dnslistener.pl eth1 3000
    
Next run the scan script.

    Usage: perl Dnsscan.pl <ip_start> <ip_end> <domain>
    
    perl Dnsscan.pl 67.2.0.0 68.0.0.0 vmware.com
    

OpenScan
----------
Used for scanning with your own packets. found in the Openscan directory.
