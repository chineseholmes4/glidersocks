#!/bin/sh

REGION="nrt"

if ! command -v flyctl >/dev/null 2>&1; then
    printf '\e[33mCould not resolve command - flyctl. So, install flyctl first.\n\e[0m'
    curl -L https://fly.io/install.sh | sh
    cp /home/runner/.fly/bin/flyctl /usr/local/bin/
fi

if [ -z "${APP_NAME}" ]; then
    printf '\e[31mPlease set APP_NAME first.\n\e[0m' && exit 1
fi

    flyctl apps create "${APP_NAME}" >/dev/null 2>&1;

printf '\e[33mNext, create app config file - fly.toml.\n\e[0m'
cat <<EOF >./fly.toml
app = "$APP_NAME"
primary_region = "nrt"
kill_signal = "SIGINT"
kill_timeout = 5
processes = []

[env]

[experimental]
  allowed_public_ports = []
  auto_rollback = true

[[services]]
  http_checks = []
  internal_port = 80
  # processes = ["app"]
  protocol = "tcp"
  script_checks = []
  
  [services.concurrency]
    hard_limit = 50
    soft_limit = 35
    type = "connections"
  
  [[services.ports]]
    handlers = ["http"]
    port = 80
  
  [[services.ports]]
    handlers = ["tls", "http"]
    port = 443
  
  [[services.tcp_checks]]
    grace_period = "120s"
    interval = "15s"
    restart_limit = 0
    timeout = "2s"
    
[[services]]
  http_checks = []
  internal_port = 1080
  # processes = ["app"]
  protocol = "tcp"
  script_checks = []

  [services.concurrency]
    hard_limit = 50
    soft_limit = 35
    type = "connections"

  [[services.ports]]
    port = 1080
 
EOF
printf '\e[32mCreate app config file success.\n\e[0m'
printf '\e[33mNext, set app secrets and regions.\n\e[0m'

printf '\e[32mApp secrets and regions set success. Next, deploy the app.\n\e[0m'
flyctl ips allocate-v4
flyctl ips allocate-v6
flyctl deploy --ha=false --detach
# flyctl status --app ${APP_NAME}
