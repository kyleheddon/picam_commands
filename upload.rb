#!/usr/bin/ruby
require './media_store'
require './home_sec'

file = ARGV[1]

MediaStore.new(file).upload
HomeSec.add_event file
