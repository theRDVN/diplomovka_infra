# This file managed by SaltStack/Terraform, do not edit by hand!!

fileserver_backend:
  - git
  - roots

ext_pillar:
  - git:
    - master https://github.com/theRDVN/diplomovka_base-diplomovka-salt-pillars.git:
      - env: base
    - master https://github.com/theRDVN/diplomovka_common-diplomovka-salt-pillars.git:
      - env: common