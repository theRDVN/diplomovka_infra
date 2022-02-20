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

gitfs_remotes:
  - "https://github.com/theRDVN/diplomovka_salt-formula-saltmanage.git":
    - saltenv:
      - common:
        - branch: master
        - mountpoint: salt://files
      - base:
        - branch: master
        - mountpoint: salt://files
  - "https://github.com/theRDVN/diplomovka_salt-formula-linux.git":
    - saltenv:
      - common:
        - branch: master
        - mountpoint: salt://files
      - base:
        - branch: master
        - mountpoint: salt://files
  - "https://github.com/theRDVN/diplomovka_shared-all-salt-states.git":
    - saltenv:
      - common:
        - branch: master
        - mountpoint: salt://files
      - base:
        - branch: master
        - mountpoint: salt://files