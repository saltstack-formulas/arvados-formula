# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import arvados with context %}

include:
  - ..package
  - {{ sls_config_file }}

arvados-keepstore-service-running-service-running:
  service.running:
    - name: {{ arvados.keepstore.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
    - require:
      - pkg: arvados-keepstore-package-install-pkg-installed
