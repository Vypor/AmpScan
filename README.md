AmpScan v0.1
=======

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
