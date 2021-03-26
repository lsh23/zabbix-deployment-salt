install_zabbix-agent_packages:
  pkg.installed:
    - pkgs:
      - zabbix-agent

zabbix-agent:
  service.running:
    - enable: True