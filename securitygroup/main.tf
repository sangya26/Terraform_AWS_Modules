module "securitygroup" {
  source          = "./securitygroup"
  security_groups = var.security_groups
  common_tags = {                      #(Optional) Map of tags to assign to the resource.
    Name        = "pec-bta-db-sg"      # Update Seucrity group name here
    ProjectName = "TRHC_AWS_Migration" # Update Project name
    Provisioner = "Terraform"
  }
}