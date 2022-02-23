# This file managed by Salt/Terraform, do not edit by hand!!

file_roots:
  common:
    - /opt/salt/common/artifacts
    - /opt/salt/common/
    - /opt/salt/formulas/diplomovka_salt-formula-linux
    - /opt/salt/formulas/diplomovka_salt-formula-saltmanage
    - /opt/salt/states/diplomovka_shared-all-salt-states
  base:
    - /opt/salt/base/artifacts
    - /opt/salt/base/states
    - /opt/salt/formulas/diplomovka_salt-formula-linux
    - /opt/salt/formulas/diplomovka_salt-formula-saltmanage
    - /opt/salt/states/diplomovka_shared-all-salt-states

pillar_roots:
  common:
    - /opt/salt/common/pillars
  base:
    - /opt/salt/base/pillars