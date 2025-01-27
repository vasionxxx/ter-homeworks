locals {
  vm_web_name_full = "${var.vpc_name}-${var.vm_web_name}"
  vm_db_name_full  = "${var.vpc_name}-${var.vm_db_name}"
}
