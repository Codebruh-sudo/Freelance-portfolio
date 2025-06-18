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
                                                                                                            



    #prometheus/prometheus.yml
                                                                                                            
                                                                                                        
                                                                                                                
global:
  scrape_interval: 10s
    evaluation_interval: 10s

    alerting:
      alertmanagers:
          - static_configs:
                  - targets: ['alertmanager:9093']

                  rule_files:
                    - "alerts.yml"

                    scrape_configs:
                      - job_name: 'prometheus'
                          static_configs:
                                - targets: ['localhost:9090']

                                  - job_name: 'node_exporter'
                                      static_configs:
                                            - targets: ['node_exporter:9100']

                                              - job_name: 'cadvisor'
                                                  static_configs:
                                                        - targets: ['cadvisor:8080']
                                                    

#prometheus/alerts.yml
groups:
  - name: example_alert
      rules:
            - alert: HighCPUUsage
                    expr: 100 - (avg by (instance)(rate(node_cpu_seconds_total{mode="idle"}[1m])) * 100) > 80
                            for: 30s
                                    labels:
                                              severity: warning
                                                      annotations:
                                                                summary: "High CPU usage detected"





#alertmanager/config.yml

global
  resolve_timeout: 1m

  route:
    receiver: 'default'

    receivers:
      - name: 'default'
          email_configs:
                - to: 'your-team@example.com'
                        from: 'alertmanager@example.com'
                                smarthost: 'smtp.example.com:587'
                                        auth_username: 'alertmanager@example.com'
                                                auth_identity: 'alertmanager@example.com'
                                                        auth_password: 'your-password'
                                                        
  resolve_timeout: 1m

  route:
    receiver: 'default'

    receivers:
      - name: 'default'
          email_configs:
                - to: 'your-team@example.com'
                        from: 'alertmanager@example.com'
                                smarthost: 'smtp.example.com:587'
                                        auth_username: 'alertmanager@example.com'
                                                auth_identity: 'alertmanager@example.com'
                                                        auth_password: 'your-password'

                                                                                                                
                                                                                                                      
                                                                                                                        

                                                                                                                            
                                                                                                                    

                                                                                                                            
                                                                                                                                  
                                                                                                                    
                                                                                                                                        

                                                                                                                                              
                                                                                                                                            
                                                                                                                                                        

                                                                                                                                                          
                                                                                                                                                            
                                                                                                                                
