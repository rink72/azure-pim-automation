data "azurerm_role_definition" "rbac_role" {
  name = var.role_name
}

data "azurerm_subscription" "target" {
  subscription_id = var.subscription_id
}

module "pim_role_configuration" {
  source = "../pim_role_configuration"

  resource_id        = data.azurerm_subscription.target.id
  role_definition_id = data.azurerm_role_definition.rbac_role.role_definition_id

  maximum_active_assignment_duration   = var.maximum_active_assignment_duration
  maximum_eligible_assignment_duration = var.maximum_eligible_assignment_duration
  maximum_activation_duration          = var.maximum_activation_duration

  require_activation_justification = var.require_activation_justification

  approver_group_name = var.approver_group_name

  allow_permanent_active   = var.allow_permanent_active
  allow_permanent_eligible = var.allow_permanent_eligible
}

module "active_assignments" {
  source   = "../active_assignment"
  for_each = local.active_assignments

  scope              = data.azurerm_subscription.target.id
  role_definition_id = "${data.azurerm_subscription.target.id}${data.azurerm_role_definition.rbac_role.id}"
  group_name         = each.key
  justification      = each.value.justification
  expiration_date    = each.value.expiration_date

  depends_on = [module.pim_role_configuration]
}

module "eligible_assignments" {
  source   = "../eligible_assignment"
  for_each = local.eligible_assignments

  scope              = data.azurerm_subscription.target.id
  role_definition_id = "${data.azurerm_subscription.target.id}${data.azurerm_role_definition.rbac_role.id}"
  group_name         = each.key
  justification      = each.value.justification
  expiration_date    = each.value.expiration_date

  depends_on = [module.pim_role_configuration]
}
