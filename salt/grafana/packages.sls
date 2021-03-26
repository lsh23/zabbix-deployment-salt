install_grafana_packages:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - software-properties-common 
      - wget

add_grafana_repository:
  pkgrepo.managed:
    - name: deb https://packages.grafana.com/enterprise/deb stable main
    - file: /etc/apt/sources.list.d/grafana.list
    - key_url: https://packages.grafana.com/gpg.key

upgrade_apt:
  module.run:
    - name: pkg.upgrade

install_grafana:
  pkg.installed:
    - pkgs:
      - grafana-enterprise

install_grafana_zabbix_plugins:
  cmd.run:
    - name: grafana-cli plugins install alexanderzobnin-zabbix-app

grafana-server:
  file.managed:
    - names:
      - /etc/grafana/grafana.ini:
        - source: salt://grafana/conf/grafana.ini
      - /etc/grafana/provisioning/datasources/zabbix.yml:
        - source: salt://grafana/conf/zabbix.yml
    - template: jinja
  service.running:
    - watch:
      - file: /etc/grafana/grafana.ini
