SimpleTokenAuthentication.configure do |config|
  config.header_names = { device: { email: 'X-Device-Email', authentication_token: 'X-Device-Token' },
    user: { email: 'X-User-Email', authentication_token: 'X-User-Token' }}
end