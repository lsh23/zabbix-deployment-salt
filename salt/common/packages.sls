install_zabbix_repository:
  pkg.installed:
    - sources:
      - zabbix-release: https://repo.zabbix.com/zabbix/5.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.2-1+ubuntu18.04_all.deb

update_apt_database:
  module.run:
    - name: pkg.refresh_db
