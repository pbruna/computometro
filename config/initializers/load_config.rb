# TODO: Mover todo tipo de configuración a este archivo
# TODO: Actualizar README con esta informacion
app_name = Rails.application.class.parent_name.downcase
APP_CONFIG = YAML.load_file("#{Rails.root}/config/#{app_name}.yml")[Rails.env]