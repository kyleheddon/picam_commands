require 'aws/s3'
require 'yaml'

class MediaRepo
  attr_reader :file, :bucket

  def initialize(file)
    @file = file
    @bucket = YAML.load(open('s3.yml'))['bucket']
  end

  def upload
    with_s3_connection {
      upload_s3_object
    }
  end

  private

  def with_s3_connection
    AWS::S3::Base.establish_connection!( access_key_id: ENV['AMAZON_ACCESS_KEY_ID'], secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY'] )
    yield
    AWS::S3::Base.disconnect!
  end

  def upload_s3_object
    AWS::S3::S3Object.store file, open(file), bucket
  end

end
