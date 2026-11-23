# Connects CPU-based scaling rules to the deployed VMSS.
resource "azurerm_monitor_autoscale_setting" "vmss" {
  name                = var.autoscale_setting_name
  resource_group_name = var.resource_group_name
  location            = var.selected_region
  target_resource_id  = var.vmss_id
  enabled             = true

  # Bounds autoscaling and sets the instance count used when the profile starts.
  profile {
    name = "default"

    # Azure expects capacity values as strings in this resource schema.
    capacity {
      minimum = tostring(var.minimum_instances)
      default = tostring(var.default_instances)
      maximum = tostring(var.maximum_instances)
    }

    # Add one instance when average CPU exceeds the configured scale-out threshold.
    rule {
      # Evaluate the VMSS CPU metric over a five-minute average window.
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.vmss_id
        metric_namespace   = "Microsoft.Compute/virtualMachineScaleSets"
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.scale_out_cpu_threshold
      }

      # Increase capacity by one, then wait before evaluating another scale action.
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    # Remove one instance when average CPU falls below the configured scale-in threshold.
    rule {
      # Use the same CPU metric and observation window as the scale-out rule.
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.vmss_id
        metric_namespace   = "Microsoft.Compute/virtualMachineScaleSets"
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.scale_in_cpu_threshold
      }

      # Decrease capacity by one, respecting the profile's minimum instance count.
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}