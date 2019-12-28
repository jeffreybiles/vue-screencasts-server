require 'sib-api-v3-sdk'

# Instantiate the client\
SibApiV3Sdk.configure do |config|
  config.api_key['api-key'] = ENV['SENDBLUE_API_KEY']
end