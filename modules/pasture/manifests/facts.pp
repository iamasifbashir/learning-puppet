notify { "The OS Family is ${facts['os']['family']}": }

notify { "Block device details: ${facts['disk']}": }
