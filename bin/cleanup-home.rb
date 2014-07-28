#!/usr/bin/env ruby
# cleanup-home.rb -- cleanup my home directory

require 'pathname'
require 'fileutils'
require 'paint'

class CleanupHome
  DUMPING_GROUND = "tmp"

  def home
    Pathname.new(home_directory)
  end

  def home_directory
    ENV.fetch('HOME')
  end

  def entries
    home.children
  end

  def filtered_entries
    entries.reject do |entry|
      filter = HomeFilter.new(entry)
      filter.dotfile? || filter.ok?
    end
  end

  def cleanup!
    ensure_dumping_ground_exists
    filtered_entries.each do |entry|
      target = dumping_ground.join(entry.basename)
      if target.exist?
        log_existing(entry, target)
      else
        log_move(entry, target)
        FileUtils.mv entry, dumping_ground
      end
    end
  end

  private

  def log(str)
    STDOUT.puts str
  end

  def log_action(action, color, entry)
    log "(%s) %s" % [Paint[action, color], entry]
  end

  def log_existing(entry, target)
    log_action 'S', :yellow, entry
  end

  def log_move(entry, target)
    log_action 'M', :green, entry
  end

  def dumping_ground
    home.join(DUMPING_GROUND)
  end

  def ensure_dumping_ground_exists
    dumping_ground.directory? || dumping_ground.mkdir
  end
end

class HomeFilter
  # TODO: Extract this out into a .keepfile
  OK_FILENAMES = %w(
    Applications
    Code
    Desktop
    Documents
    Downloads
    Library
    VirtualBox\ VMs
    Vagrantfile
    bin
    src
    Movies
    Music
    Mail\ Downloads
    Pictures
    Public
  ) << CleanupHome::DUMPING_GROUND

  def initialize path
    @path = path
  end

  def dotfile?
    filename.start_with? "."
  end

  def ok?
    OK_FILENAMES.include? filename
  end

  private

  def filename
    @path.basename.to_s
  end
end

home = CleanupHome.new
home.cleanup!
