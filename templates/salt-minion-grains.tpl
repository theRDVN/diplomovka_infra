my_environment: ${env}
server_type: ${server_type}
component: 
%{ for components in component ~}
  - ${components}
%{ endfor ~}
cluster: ${cluster}
module: ${project}
network: ${network_name}
appuser: ${app_user}
saltinfra: minion
site: ${site}