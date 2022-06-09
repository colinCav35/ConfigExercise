require "./config_parser.rb"

puts "Loading config file..."
parser = ConfigParser.new("server.conf")
config = parser.read_config

config.each do |key, value|
  puts "Key: #{key}", "Value: #{value}", "Type: #{value.class}", ""
end

puts "Loading invalid config file..." 
invalid_parser = ConfigParser.new("invalid.conf")
begin
  invalid_parser.read_config
rescue IOError => e
  puts e.message
end
