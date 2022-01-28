common_services:
%{ for common_service in common_services ~}
  - ${common_service}
%{ endfor ~}
env: ${env}
my_environment: ${env}
saltinfra:
%{ for infra in salt_infra ~}
  - ${infra}
%{ endfor ~}
site: ${site}
testgrain: test