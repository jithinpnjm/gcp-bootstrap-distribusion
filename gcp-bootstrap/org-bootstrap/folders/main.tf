module "folders" {
  source                = "../../modules/folders"
  org_id                = var.org_id[var.cos]
  org_node              = var.cos
  folder_business_units = var.folder_business_units
  subfolders            = var.subfolders
}