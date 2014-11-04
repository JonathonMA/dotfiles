#!/usr/bin/env ruby
# git_packages.rb - manage local packages from git repos
CONFIG = {
  "~/.nvm" => "git://github.com/creationix/nvm.git",
  "~/.rbenv" => "git://github.com/sstephenson/rbenv.git",
  "~/.rbenv/plugins/ruby-build" => "git://github.com/sstephenson/ruby-build.git",
  "~/.rbenv/plugins/rbenv-aliases" => "git://github.com/tpope/rbenv-aliases.git",
  "~/.rbenv/plugins/rbenv-bundler-ruby-version" => "git://github.com/aripollak/rbenv-bundler-ruby-version.git",
  "~/.rbenv/plugins/rbenv-gem-rehash" => "git://github.com/sstephenson/rbenv-gem-rehash.git",
}

require 'pathname'

class GitPackage
  def initialize(location, repo)
    @location = Pathname.new File.expand_path(location)
    @repo = repo
  end

  def cloned?
    (@location + ".git").exist?
  end

  def exist?
    @location.exist?
  end

  def misconfigured?
    exist? && !cloned?
  end

  def clone_or_update!
    if misconfigured?
      log "#{@location} is misconfigured"
      return
    end

    if cloned?
      update!
    else
      clone!
    end
  end

  def clone!
    log "Cloning #{@location}"
    system *%W(git clone #{@repo} #{@location})
  end

  def update!
    log "Updating #{@location}"
    Dir.chdir(@location) do
      system *%W(git pull)
    end
  end

  private

  def log(message)
    puts message
  end
end

CONFIG.each do |dir, repo|
  GitPackage.new(dir, repo).clone_or_update!
end
