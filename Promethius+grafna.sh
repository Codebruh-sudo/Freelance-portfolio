version: '3.8'

services:
  prometheus:
      image: prom/prometheus
          container_name: prometheus
              volumes:
                    - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
                          - ./prometheus/alerts.yml:/etc/prometheus/alerts.yml
                              ports:
                                    - "9090:9090"
                                        command:
                                              - '--config.file=/etc/prometheus/prometheus.yml'
                                                    - '--web.enable-lifecycle'
                                                        depends_on:
                                                              - node_exporter
                                                                    - cadvisor
                                                                          - alertmanager

                                                                            grafana:
                                                                                image: grafana/grafana
                                                                                    container_name: grafana
                                                                                        ports:
                                                                                              - "3000:3000"
                                                                                                  environment:
                                                                                                        - GF_SECURITY_ADMIN_USER=admin
                                                                                                              - GF_SECURITY_ADMIN_PASSWORD=admin
                                                                                                                  volumes:
                                                                                                                        - grafana-storage:/var/lib/grafana
                                                                                                                            depends_on:
                                                                                                                                  - prometheus

                                                                                                                                    node_exporter:
                                                                                                                                        image: prom/node-exporter
                                                                                                                                            container_name: node_exporter
                                                                                                                                                ports:
                                                                                                                                                      - "9100:9100"

                                                                                                                                                        cadvisor:
                                                                                                                                                            image: gcr.io/cadvisor/cadvisor:latest
                                                                                                                                                                container_name: cadvisor
                                                                                                                                                                    ports:
                                                                                                                                                                          - "8080:8080"
                                                                                                                                                                              volumes:
                                                                                                                                                                                    - /:/rootfs:ro
                                                                                                                                                                                          - /var/run:/var/run:ro
                                                                                                                                                                                                - /sys:/sys:ro
                                                                                                                                                                                                      - /var/lib/docker/:/var/lib/docker:ro

                                                                                                                                                                                                        alertmanager:
                                                                                                                                                                                                            image: prom/alertmanager
                                                                                                                                                                                                                container_name: alertmanager
                                                                                                                                                                                                                    ports:
                                                                                                                                                                                                                          - "9093:9093"
                                                                                                                                                                                                                              volumes:
                                                                                                                                                                                                                                    - ./alertmanager/config.yml:/etc/alertmanager/config.yml

                                                                                                                                                                                                                                    volumes:
                                                                                                                                                                                                                                      grafana-storage:
                                                                                                                                                                                                                                      