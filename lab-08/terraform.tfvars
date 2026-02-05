location = "centralus"

nsg_rules = [
  {
    name                   = "AllowSSH"
    priority               = 100
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    destination_port_range = "22"
  },
  {
    name                   = "AllowHTTP"
    priority               = 110
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    destination_port_range = "80"
  },
  {
    name                   = "AllowHTTPS"
    priority               = 120
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    destination_port_range = "443"
  }
]