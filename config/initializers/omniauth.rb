#
# Authentication:
# Omniauth / Facebook
#
Rails.application.config.middleware.use OmniAuth::Builder do
  ENV['FACEBOOK_KEY'] = '421625021224006'
  ENV['FACEBOOK_SECRET'] = '45eecdde5bf46da98d5c5084b5332e1e'

  provider :developer unless Rails.env.production?
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end

