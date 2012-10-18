APP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/ap11_config.yml")[Rails.env]
OAI_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/oai_config.yml")[Rails.env]
