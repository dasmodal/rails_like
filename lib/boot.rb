# frozen_string_literal: true

# initialize and config DB
db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration
end

# require all lib .rb files
Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].each { |file| require_relative file }
# require all app .rb files
Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].each { |file| require_relative file }

# run migrations if DB config presence
if DB
  migrations_dir = File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations')
  Sequel::Migrator.run(DB, migrations_dir)
end

ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), '..', 'app', 'routes.yml')))
