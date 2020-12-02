web: jemalloc.sh bundle exec puma -C config/puma.rb
release: bundle exec rake db:migrate
worker: RAILS_MAX_THREADS=${SIDEKIQ_CONCURRENCY:-25} jemalloc.sh bundle exec sidekiq -t 25 -q default -q mailers
