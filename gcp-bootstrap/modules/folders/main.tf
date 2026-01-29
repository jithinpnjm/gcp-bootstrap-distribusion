// Business unit Folder creation.
resource "google_folder" "business_units" {
  for_each     = toset(var.folder_business_units[var.org_node])
  display_name = each.value
  parent       = "organizations/${var.org_id}"
}

// Create local variable and map folder_cos_realms with business_units.
locals {
  subfolders_obj = toset(flatten([
    for bu, cos in var.subfolders[var.org_node] : [
      for co in cos : {
        display_name        = co
        parent              = "${google_folder.business_units[bu].name}"
        parent_display_name = "${google_folder.business_units[bu].display_name}"
      }
    ]
  ]))
}

//  Subfolder creation.
resource "google_folder" "cos_folders" {
  for_each = {
    for cos in local.subfolders_obj : "${cos.parent_display_name}.${cos.display_name}" => cos
  }
  parent       = each.value.parent
  display_name = each.value.display_name
  depends_on   = [google_folder.business_units]
}
