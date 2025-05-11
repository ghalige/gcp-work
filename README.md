gcp-infra/
├── terragrunt.hcl
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
│   ├── dns/ # Now uses official module
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── bastion-host/ # Now uses official module
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── envs/
    ├── dev/
    │   └── terragrunt.hcl
    └── qa/
        └── terragrunt.hcl
