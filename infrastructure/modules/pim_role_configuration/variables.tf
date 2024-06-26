variable "resource_id" {
  description = "The id of the resource"
  type        = string
}

variable "role_definition_id" {
  description = "The id of the role definition"
  type        = string
}

variable "maximum_active_assignment_duration" {
  description = "The maximum duration of an active assignment in days"
  type        = number
  default     = null
}

variable "maximum_eligible_assignment_duration" {
  description = "The maximum duration of an eligible assignment in days"
  type        = number
  default     = null
}

variable "allow_permanent_active" {
  description = "Allow permanent active assignments"
  type        = bool
  default     = null
}

variable "allow_permanent_eligible" {
  description = "Allow permanent eligible assignments"
  type        = bool
  default     = null
}

variable "maximum_activation_duration" {
  description = "The maximum duration of an activation in hours"
  type        = number
  default     = null
}

variable "require_activation_justification" {
  description = "Require activation justification"
  type        = bool
  default     = null
}

variable "approver_group_name" {
  description = "The name of the approver group"
  type        = string
  default     = null
}
