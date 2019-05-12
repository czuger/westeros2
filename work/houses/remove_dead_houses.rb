require 'yaml'
require 'pp'

h_db = YAML.load_file('db.yaml')

h_db.each do |k, h|
  if h[:rang] && h[:rang].downcase =~ /maison éteinte/
    puts "Disabling house #{k}"
    h_db.delete(k)
  end
end

File.open('db2.yaml', 'w') do |f|
  f.write(h_db.to_yaml)
end