gcp-infra/
├── terragrunt.hcl
├── module-version.yml
├── vars/
│   ├── dev-vars.yml
│   └── qa-vars.yml
├── modules/
│   ├── service-account/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── state-bucket/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── network/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── nat/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── gke/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── dns/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── bastion-host/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── ssl-certificate/ # Now uses google_compute_managed_ssl_certificate resource
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── envs/
    ├── dev/
    │   └── terragrunt.hcl
    └── qa/
        └── terragrunt.hcl
