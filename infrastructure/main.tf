locals {
  // Get PIM configuration from YAML
  resource_pim         = yamldecode(file("${path.module}/../configuration/pim-dev-nsg.yml"))["pim_configuration"]
  resource_group_pim   = yamldecode(file("${path.module}/../configuration/pim-dev-rgp.yml"))["pim_configuration"]
  subscription_pim     = yamldecode(file("${path.module}/../configuration/subscription-one.yml"))["pim_configuration"]
  management_group_pim = yamldecode(file("${path.module}/../configuration/management-group.yml"))["pim_configuration"]
}

module "rgp_pim" {
  source   = "./modules/resourcegroup_pim_role"
  for_each = local.resource_group_pim.roles

  role_name           = each.value.name
  resource_group_name = local.resource_group_pim.resource_group_name

  require_activation_justification = try(each.value.require_activation_justification, null)
  require_activation_approval      = try(each.value.require_activation_approval, null)

  maximum_active_assignment_duration   = try(each.value.maximum_active_assignment_duration, null)
  maximum_eligible_assignment_duration = try(each.value.maximum_eligible_assignment_duration, null)
  maximum_activation_duration          = try(each.value.maximum_activation_duration, null)

  allow_permanent_active   = try(each.value.allow_permanent_active, null)
  allow_permanent_eligible = try(each.value.allow_permanent_eligible, null)

  approver_group_name = try(each.value.approver_group_name, null)

  active_assignments   = try(each.value.active_assignments, null)
  eligible_assignments = try(each.value.eligible_assignments, null)
}

module "subscription_pim" {
  source   = "./modules/subscription_pim_role"
  for_each = local.subscription_pim.roles

  role_name       = each.value.name
  subscription_id = local.subscription_pim.subscription_id

  require_activation_justification = try(each.value.require_activation_justification, null)
  require_activation_approval      = try(each.value.require_activation_approval, null)

  maximum_active_assignment_duration   = try(each.value.maximum_active_assignment_duration, null)
  maximum_eligible_assignment_duration = try(each.value.maximum_eligible_assignment_duration, null)
  maximum_activation_duration          = try(each.value.maximum_activation_duration, null)

  allow_permanent_active   = try(each.value.allow_permanent_active, null)
  allow_permanent_eligible = try(each.value.allow_permanent_eligible, null)

  approver_group_name = try(each.value.approver_group_name, null)

  active_assignments   = try(each.value.active_assignments, null)
  eligible_assignments = try(each.value.eligible_assignments, null)
}

module "managementgroup_pim" {
  source   = "./modules/managementgroup_pim_role"
  for_each = local.management_group_pim.roles

  role_name           = each.value.name
  management_group_id = local.management_group_pim.management_group_id

  require_activation_justification = try(each.value.require_activation_justification, null)
  require_activation_approval      = try(each.value.require_activation_approval, null)

  maximum_active_assignment_duration   = try(each.value.maximum_active_assignment_duration, null)
  maximum_eligible_assignment_duration = try(each.value.maximum_eligible_assignment_duration, null)
  maximum_activation_duration          = try(each.value.maximum_activation_duration, null)

  allow_permanent_active   = try(each.value.allow_permanent_active, null)
  allow_permanent_eligible = try(each.value.allow_permanent_eligible, null)

  approver_group_name = try(each.value.approver_group_name, null)

  active_assignments   = try(each.value.active_assignments, null)
  eligible_assignments = try(each.value.eligible_assignments, null)
}

module "resource_pim" {
  source   = "./modules/resource_pim_role"
  for_each = local.resource_pim.roles

  role_name     = each.value.name
  resource_name = local.resource_pim.resource_name

  require_activation_justification = try(each.value.require_activation_justification, null)
  require_activation_approval      = try(each.value.require_activation_approval, null)

  maximum_active_assignment_duration   = try(each.value.maximum_active_assignment_duration, null)
  maximum_eligible_assignment_duration = try(each.value.maximum_eligible_assignment_duration, null)
  maximum_activation_duration          = try(each.value.maximum_activation_duration, null)

  allow_permanent_active   = try(each.value.allow_permanent_active, null)
  allow_permanent_eligible = try(each.value.allow_permanent_eligible, null)

  approver_group_name = try(each.value.approver_group_name, null)

  active_assignments   = try(each.value.active_assignments, null)
  eligible_assignments = try(each.value.eligible_assignments, null)
}
