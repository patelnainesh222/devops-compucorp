node 'ip-172-31-31-19.ap-south-1.compute.internal' {
    file {'/tmp/example-ip':                                            # resource type file and filename
      ensure  => present,                                               # make sure it exists
      mode    => '0644',                                                # file permissions
      content => "Here is my Public IP Address: ${ipaddress_eth0}.\n",  # note the ipaddress_eth0 fact
    }
	include masterconfigs
}

node default {}
