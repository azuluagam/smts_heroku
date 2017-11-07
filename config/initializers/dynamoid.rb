Dynamoid.configure do |config|
 @aws_access = Rails.application.config.aws_access
 config.namespace = nil
 config.access_key = @aws_access[:access_key_id]
 config.secret_key = @aws_access[:secret_access_key]
 config.region = @aws_access[:region]
end
