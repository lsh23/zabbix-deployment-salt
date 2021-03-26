install_zabbix_repository:
  pkg.installed:
    - sources:
      - zabbix-release: {{ pillar['ZabbixRepositoryURL'] }}
update_apt_database:
  module.run:
    - name: pkg.refresh_db
