variable "dx_private_virtual_interfaces" {
  description = <<EOT
Map of dx_private_virtual_interfaces, attributes below
Required:
    - address_family
    - bgp_asn
    - connection_id
    - name
    - vlan
Optional:
    - amazon_address
    - bgp_auth_key
    - customer_address
    - dx_gateway_id
    - mtu
    - region
    - sitelink_enabled
    - tags
    - tags_all
    - vpn_gateway_id
EOT

  type = map(object({
    address_family   = string
    bgp_asn          = number
    connection_id    = string
    name             = string
    vlan             = number
    amazon_address   = optional(string)
    bgp_auth_key     = optional(string)
    customer_address = optional(string)
    dx_gateway_id    = optional(string)
    mtu              = optional(number)
    region           = optional(string)
    sitelink_enabled = optional(bool)
    tags             = optional(map(string))
    tags_all         = optional(map(string))
    vpn_gateway_id   = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.dx_private_virtual_interfaces : (
        v.mtu == null || (contains([1500, 9001], v.mtu))
      )
    ])
    error_message = "must be one of: 1500, 9001"
  }
  validation {
    condition = alltrue([
      for k, v in var.dx_private_virtual_interfaces : (
        v.vlan >= 1 && v.vlan <= 4094
      )
    ])
    error_message = "must be between 1 and 4094"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

