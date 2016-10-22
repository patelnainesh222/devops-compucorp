class masterconfigs::yumupdate {
        exec
        { "yum update" :
                #command => "yum clean all; yum update -y;",
                command => "/bin/yum clean all; /bin/yum --disablerepo=\"*\" --enablerepo=\"rhui-REGION-rhel-server-releases\" -q -y update;",
		before => File['epel-repo'],
        }
}
