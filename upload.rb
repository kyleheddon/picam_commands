#!/usr/bin/ruby
require './lib/media_store'
require './lib/home_sec'
file = ARGV[0]

puts "uploading #{file} to S3"
MediaStore.new(file).upload
puts "upload to S3 complete\n"

puts 'adding event to homesec'
HomeSec.new(file).add_event
puts 'event added'
