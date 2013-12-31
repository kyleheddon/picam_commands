#!/usr/bin/ruby
require './media_repo'
require './security_hub'

file = ARGV[1]

MediaRepo.new(file).upload
SecurityHub.add_motion_event file
