/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  version = "~> 3.0"
}

locals {
  network_name = "vm-test-vpc"
  subnet_01 = "${local.network_name}-subnet-01"
}

module "vpc" {
  source = "terraform-google-modules/network/google"
  project_id   = var.project_id
  network_name = local.network_name

  subnets = [
    {
      subnet_name   = local.subnet_01
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.region
    },
  ]
}

module "instance_template" {
  source = "../../modules/vm/modules/instance_template"
  region          = var.region
  project_id      = var.project_id
  subnetwork      = local.subnet_01
  service_account = {
    email = null
    scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/devstorage.full_control",
    ]
  }

  depends_on = [module.vpc]
}

module "compute_instance" {
  source = "../../modules/vm/modules/compute_instance"
  region            = var.region
  subnetwork        = local.subnet_01
  hostname          = "instance-simple"
  instance_template = module.instance_template.self_link
  num_instances     = 1
  access_config = [{
    nat_ip       = null
    network_tier = "PREMIUM"
  }, ]

  depends_on = [module.vpc]
}
