install_zabbix_repository:
  module.run:
    - name: lowpkg.bin_pkg_info
    - path: salt://common/zabbix-release_5.2-1+ubuntu18.04_all.deb

update_apt_database:
  module.run:
    - name: pkg.refresh_db
