module "firewall" {
  source              = "./firewall"
  firewall-rule-group = var.firewall-rule-group
  firewall-policy-tf  = var.firewall-policy-tf
  firewall-tf         = var.firewall-tf
  firewall-logging-tf = var.firewall-logging-tf
}

