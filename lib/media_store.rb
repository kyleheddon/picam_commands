require 'aws/s3'
require 'yaml'

class MediaStore
  attr_reader :file, :bucket, :access_key_id, :secret_access_key

  def initialize(file)
    @file = file
    config = YAML.load(open('config.yml'))
    @bucket = config['s3']['bucket']
    @access_key_id = config['s3']['access_key_id']
    @secret_access_key = config['s3']['secret_access_key']
  end

  def upload
    with_s3_connection {
      upload_s3_object
    }
  end

  private

  def with_s3_connection
    AWS::S3::Base.establish_connection!( access_key_id: access_key_id, secret_access_key: secret_access_key )
    yield
    AWS::S3::Base.disconnect!
  end

  def upload_s3_object
    AWS::S3::S3Object.store file, open(file), bucket
  end

end
