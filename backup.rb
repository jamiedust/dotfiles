#!/usr/bin/env ruby
require 'fileutils'
require 'english'

# Copy config files into this directory
[
  '.config/nvim/init.vim',
  '.zshrc',
  '.ackrc'
].each do |file|
  begin
    FileUtils.cp("#{ENV['HOME']}/#{file}", __dir__)
  rescue StandardError => e
    puts e
  end
end

# Update GIT repo
Dir.chdir(__dir__)
puts `git pull &&
      git add . && \
      git commit -m 'back up config files' && \
      git push`
if $CHILD_STATUS.exitstatus.zero?
  puts "\nSuccess"
else
  puts "\nThere was a problem"
end
