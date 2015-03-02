Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['c000496c8ea80e9327c1'], ENV['07319d56dfe7fd731a731fb8a63eb89094c5b672']
end
