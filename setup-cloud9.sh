#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [[ ! -d blog ]]; then
  if ! gem list --local --installed rails --version 7.2.4 > /dev/null; then
    echo "Installing Rails 7.2.4..."
    gem install rails -v 7.2.4 --no-document
  fi
  echo "Generating Rails application..."
  rails _7.2.4_ new blog --database=sqlite3 --skip-git --skip-test --skip-javascript --skip-hotwire --skip-bundle
  cp -R rails-source/. blog/
else
  if [[ ! -f blog/bin/rails ]]; then
    echo "The existing blog/ folder is not a Rails application. Please inspect it first." >&2
    exit 1
  fi
  echo "Found existing blog/ folder; preserving your work."
fi

# Store a per-environment secret outside Git before loading any application code.
if [[ ! -f .local-admin.env ]]; then
  password="$(ruby -rsecurerandom -e 'print SecureRandom.urlsafe_base64(18)')"
  printf 'export BLOG_ADMIN_USER=%q\nexport BLOG_ADMIN_PASSWORD=%q\n' 'admin' "$password" > .local-admin.env
  chmod 600 .local-admin.env
fi
set -a
source .local-admin.env
set +a

cd blog
bundle install

ruby - config/environments/development.rb <<'RUBY'
path = ARGV.fetch(0)
source = File.read(path)
marker = "Rails.application.configure do\n"
sentinel = "# ET718 Cloud9 preview (development only)"
unless source.include?(sentinel)
  abort "Cannot locate Rails development configuration" unless source.include?(marker)
  addition = <<~CONFIG
    #{sentinel}
    config.hosts << /[a-z0-9]+\.vfs\.cloud9\.[a-z0-9-]+\.amazonaws\.com/
    config.action_dispatch.default_headers.delete("X-Frame-Options")
  CONFIG
  source.sub!(marker, marker + addition.lines.map { |line| '  ' + line }.join)
  File.write(path, source)
end
RUBY

bin/rails db:prepare
bin/rails db:seed
cat <<'DONE'

SETUP COMPLETE.
- Start your site from the repository folder: bash start-cloud9.sh
- Open Cloud9 > Preview > Preview Running Application (port 8080)
- See the local editor password: cat .local-admin.env
- Do not upload .local-admin.env, config/master.key, or a database to GitHub.
DONE
