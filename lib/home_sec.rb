require 'json'
require 'httparty'

class HomeSec
  attr_reader :file, :url, :camera_id

  def initialize(file)
    @file = file
    config = YAML.load(open('config.yml'))
    @url = config['homesec']['url']
    @camera_id = config['homesec']['camera_id']
  end

  def add_event
    puts HTTParty.post event_url, body: event, headers: headers
  end

  private

  def event_url
    "#{url}/api/cameras/#{camera_id}/events.json"
  end

  def event
    {
      event: {
        title: 'Motion detected',
        image: file
      }
    }.to_json
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

end
