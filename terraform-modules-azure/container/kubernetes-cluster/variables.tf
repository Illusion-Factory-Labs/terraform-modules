variable "azure_kubernetes_clusters" {
  type = map(object({
    # Propriedades obrigatórias
    name                = string
    location            = string
    resource_group_name = string

    default_node_pool = object({
      name    = string
      vm_size = optional(string)

      capacity_reservation_group_id = optional(string)
      auto_scaling_enabled          = optional(bool)
      host_encryption_enabled       = optional(bool)
      node_public_ip_enabled        = optional(bool)
      gpu_driver                    = optional(string)
      gpu_instance                  = optional(string)
      host_group_id                 = optional(string)
      fips_enabled                  = optional(bool)
      kubelet_disk_type             = optional(string)
      max_pods                      = optional(number)
      node_public_ip_prefix_id      = optional(string)
      node_labels                   = optional(map(string))
      only_critical_addons_enabled  = optional(bool)
      orchestrator_version          = optional(string)
      os_disk_size_gb               = optional(number)
      os_disk_type                  = optional(string)
      os_sku                        = optional(string)
      pod_subnet_id                 = optional(string)
      proximity_placement_group_id  = optional(string)
      scale_down_mode               = optional(string)
      snapshot_id                   = optional(string)
      temporary_name_for_rotation   = optional(string)
      type                          = optional(string)
      tags                          = optional(map(string))
      ultra_ssd_enabled             = optional(bool, false)
      vnet_subnet_id                = optional(string)
      workload_runtime              = optional(string)
      zones                         = optional(list(string))
      max_count                     = optional(number, null)
      min_count                     = optional(number, null)
      node_count                    = optional(number)

      kubelet_config = optional(object({
        allowed_unsafe_sysctls    = optional(list(string))
        container_log_max_line    = optional(number)
        container_log_max_size_mb = optional(number)
        cpu_cfs_quota_enabled     = optional(bool)
        cpu_cfs_quota_period      = optional(string)
        cpu_manager_policy        = optional(string)
        image_gc_high_threshold   = optional(number)
        image_gc_low_threshold    = optional(number)
        pod_max_pid               = optional(number)
        topology_manager_policy   = optional(string)
      }))

      linux_os_config = optional(object({
        swap_file_size_mb            = optional(number)
        transparent_huge_page_defrag = optional(string)
        transparent_huge_page        = optional(string)
        sysctl_config = optional(object({
          fs_aio_max_nr                      = optional(number)
          fs_file_max                        = optional(number)
          fs_inotify_max_user_watches        = optional(number)
          fs_nr_open                         = optional(number)
          kernel_threads_max                 = optional(number)
          net_core_netdev_max_backlog        = optional(number)
          net_core_optmem_max                = optional(number)
          net_core_rmem_default              = optional(number)
          net_core_rmem_max                  = optional(number)
          net_core_somaxconn                 = optional(number)
          net_core_wmem_default              = optional(number)
          net_core_wmem_max                  = optional(number)
          net_ipv4_ip_local_port_range_max   = optional(number)
          net_ipv4_ip_local_port_range_min   = optional(number)
          net_ipv4_neigh_default_gc_thresh1  = optional(number)
          net_ipv4_neigh_default_gc_thresh2  = optional(number)
          net_ipv4_neigh_default_gc_thresh3  = optional(number)
          net_ipv4_tcp_fin_timeout           = optional(number)
          net_ipv4_tcp_keepalive_intvl       = optional(number)
          net_ipv4_tcp_keepalive_probes      = optional(number)
          net_ipv4_tcp_keepalive_time        = optional(number)
          net_ipv4_tcp_max_syn_backlog       = optional(number)
          net_ipv4_tcp_max_tw_buckets        = optional(number)
          net_ipv4_tcp_tw_reuse              = optional(bool)
          net_netfilter_nf_conntrack_buckets = optional(number)
          net_netfilter_nf_conntrack_max     = optional(number)
          vm_max_map_count                   = optional(number)
          vm_swappiness                      = optional(number)
          vm_vfs_cache_pressure              = optional(number)
        }))
      }))

      node_network_profile = optional(object({
        application_security_group_ids = optional(list(string))
        node_public_ip_tags            = optional(map(string))

        allowed_host_ports = optional(list(object({
          port_start = optional(number)
          port_end   = optional(number)
          protocol   = optional(string)
        })))
      }))

      upgrade_settings = optional(object({
        drain_timeout_in_minutes      = optional(number)
        node_soak_duration_in_minutes = optional(number)
        max_surge                     = optional(string)
        undrainable_node_behavior     = optional(string)
      }))
    })

    # Propriedades mutuamente exclusivas, pelo menos uma deve ser definida
    dns_prefix                 = optional(string)
    dns_prefix_private_cluster = optional(string)

    # Propriedades opcionais
    ai_toolchain_operator_enabled       = optional(bool, false)
    automatic_upgrade_channel           = optional(string)
    azure_policy_enabled                = optional(bool)
    cost_analysis_enabled               = optional(bool, false)
    custom_ca_trust_certificates_base64 = optional(list(string))
    disk_encryption_set_id              = optional(string)
    edge_zone                           = optional(string)
    http_application_routing_enabled    = optional(bool)
    image_cleaner_enabled               = optional(bool)
    image_cleaner_interval_hours        = optional(number)
    kubernetes_version                  = optional(string)
    local_account_disabled              = optional(bool)
    node_os_upgrade_channel             = optional(string)
    node_resource_group                 = optional(string)
    oidc_issuer_enabled                 = optional(bool)
    open_service_mesh_enabled           = optional(bool)
    private_cluster_enabled             = optional(bool)
    private_dns_zone_id                 = optional(string)
    private_cluster_public_fqdn_enabled = optional(bool)
    sku_tier                            = optional(string)
    workload_identity_enabled           = optional(bool)

    service_principal = optional(object({
      client_id     = string
      client_secret = string
    }))

    aci_connector_linux = optional(object({
      enabled = bool
    }))

    api_server_access_profile = optional(object({
      authorized_ip_ranges = optional(list(string))
    }))

    auto_scaler_profile = optional(object({
      scan_interval = optional(string)
    }))

    azure_active_directory_role_based_access_control = optional(object({
      enabled = bool
    }))

    confidential_computing = optional(object({
      enabled = bool
    }))

    http_proxy_config = optional(object({
      enabled = bool
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    ingress_application_gateway = optional(object({
      enabled = bool
    }))

    key_management_service = optional(object({
      enabled = bool
    }))

    key_vault_secrets_provider = optional(object({
      enabled = bool
    }))

    kubelet_identity = optional(object({
      enabled = bool
    }))

    linux_profile = optional(object({
      admin_username = string
      ssh_key = object({
        key_data = string
      })
    }))

    maintenance_window = optional(object({
      allowed = optional(list(object({
        day   = string
        hours = list(number)
      })))
      not_allowed = optional(list(object({
        start = string
        end   = string
      })))
    }))

    maintenance_window_auto_upgrade = optional(object({
      frequency    = string
      interval     = string
      duration     = number
      day_of_week  = optional(string)
      day_of_month = optional(number)
      week_index   = optional(string)
      start_time   = optional(string)
      utc_offset   = optional(string)
      start_date   = optional(string)
      not_allowed = optional(list(object({
        start = string
        end   = string
      })))
    }))

    maintenance_window_node_os = optional(object({
      enabled = bool
    }))

    microsoft_defender = optional(object({
      enabled = bool
    }))

    monitor_metrics = optional(object({
      enabled = bool
    }))

    network_profile = optional(object({
      network_plugin      = string
      network_mode        = optional(string)
      network_policy      = optional(string)
      dns_service_ip      = optional(string)
      network_data_plane  = optional(string, "azure")
      network_plugin_mode = optional(string)
      outbound_type       = optional(string, "loadBalancer")
      pod_cidr            = optional(string)
      pod_cidrs           = optional(list(string))
      service_cidr        = optional(string)
      service_cidrs       = optional(list(string))
      ip_versions         = optional(list(string), ["IPv4"])
      load_balancer_sku   = optional(string, "standard")

      load_balancer_profile = optional(object({
        backend_pool_type           = optional(string, "NodeIPConfiguration")
        idle_timeout_in_minutes     = optional(number, 30)
        managed_outbound_ip_count   = optional(number)
        managed_outbound_ipv6_count = optional(number, 0)
        outbound_ip_address_ids     = optional(list(string))
        outbound_ip_prefix_ids      = optional(list(string))
        outbound_ports_allocated    = optional(number, 0)
      }))

      nat_gateway_profile = optional(object({
        idle_timeout_in_minutes   = optional(number, 4)
        managed_outbound_ip_count = optional(number)
      }))

      advanced_networking = optional(object({
        observability_enabled = optional(bool, false)
        security_enabled      = optional(bool, false)
      }))
    }))

    bootstrap_profile = optional(object({
      enabled = bool
    }))

    node_provisioning_profile = optional(object({
      enabled = bool
    }))

    oms_agent = optional(object({
      enabled = bool
    }))

    tags = optional(map(string))
  }))

  description = <<EOT
        Dicionário com os 'Azure Kubernetes Clusters' a serem criados. A chave do dicionário será usada como o nome do 
        recurso no Terraform.
    EOT

  validation {
    condition = alltrue(
      [for k, v in var.azure_kubernetes_clusters :
        v.dns_prefix != null ||
      v.dns_prefix_private_cluster != null]
    )
    error_message = "Ao menos uma das propriedades, 'dns_prefix' ou 'dns_prefix_private_cluster', deve ser definida."
  }

  validation {
    condition = alltrue(
      [for _, aks in var.azure_kubernetes_clusters :
        can(regex("^[A-Za-z0-9](?:[A-Za-z0-9-]{0,52}[A-Za-z0-9])?$", aks.dns_prefix)) ||
      can(regex("^[A-Za-z0-9](?:[A-Za-z0-9-]{0,52}[A-Za-z0-9])?$", aks.dns_prefix_private_cluster))]
    )
    error_message = <<EOT
            O valor de 'dns_prefix' deve começar e terminar com uma letra ou número, conter apenas letras, números 
            e hífens e ter entre 1 e 54 caracteres.
        EOT
  }

  validation {
    condition = alltrue(
      [for k, v in var.azure_kubernetes_clusters :
        v.service_principal != null ||
      v.identity != null]
    )
    error_message = "Ao menos uma das propriedades, 'service_principal' ou 'identity', deve ser definida."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags a serem aplicadas a todos os recursos criados por este módulo."
  default     = {}
}
