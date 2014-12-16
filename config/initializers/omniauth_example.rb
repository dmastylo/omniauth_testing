Devise.setup do |config|
  config.omniauth :facebook, "KEY", "SECRET"
  config.omniauth :twitter, "KEY", "SECRET"
  config.omniauth :linked_in, "KEY", "SECRET"
end
