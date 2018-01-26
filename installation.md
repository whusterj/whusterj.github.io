# Installing Jekyll on Ubuntu 16.04

Here's a cheat sheet to install ruby and Jekyll for development purposes. This uses rbenv to manage the installation, so there's no need to install ruby or gems globally as sudo.

## Step 1 — Installing Jekyll

[Source](https://stackoverflow.com/questions/37720892/you-dont-have-write-permissions-for-the-var-lib-gems-2-3-0-directory)

```bash
cd $HOME
sudo apt-get update 
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev ruby-dev make gcc -y

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.5.0
rbenv global 2.5.0
ruby -v

# Install jekyll and bundler
gem install jekyll bundler
rbenv rehash
```

## Step 2 — Running Jekyll for Development

```bash
jekyll serve
```
