require 'yaml'
require 'pp'

KNOWN_HOUSES = { 'Stark' => ['King Robb Stark'], 'Martell' => ['Prince Oberyn Martell'] }
# HOUSES_PRIORITIES = { 'Stark': 100, 'Martell': 100 }

h_db = YAML.load_file('db.yaml')

h_db.each do |k, h|
  # p k, KNOWN_HOUSES.keys
  if KNOWN_HOUSES[k]
    h_db[k][:leaders] = KNOWN_HOUSES[k]
  else
    h_db[k][:leaders] = [ h[:lord], h[:ser] ].compact
  end
end

File.open('db.yaml', 'w') do |f|
  f.write(h_db.to_yaml)
end

puts 'Finished !!!'