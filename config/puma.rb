daemonize true

pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'

threads 16,32
workers 16
preload_app!
