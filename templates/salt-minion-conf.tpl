master: ${saltmaster}
id: ${hostname}
master_port: 4506
publish_port: 4505
saltenv: ${env}
state_top_saltenv: ${env}
default_top: ${env}
test: False
logging:
  log_file: /var/log/salt/minion
  log_level: warning
  log_datefmt: '%H:%M:%S'