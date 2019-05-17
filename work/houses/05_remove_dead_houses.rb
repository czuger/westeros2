require 'yaml'
require 'pp'

UNWANTED_HOUSES = %w( Baelish Mormont )

h_db = YAML.load_file('db.yaml')

h_db.each do |k, h|
  # h_db[k][:vassal_of] = 'Baratheon' if h[:vassal_of] == 'Port-Réal'

  if h[:rang] && h[:rang].downcase =~ /maison éteinte/
    puts "Disabling house #{k}"
    h_db.delete(k)
  end

  if h[:leaders].empty?
    puts "No knights in #{k}"
    h_db.delete(k)
  end

  if UNWANTED_HOUSES.include?( h[:name] )
    h_db.delete(k)
  end


end

File.open('db2.yaml', 'w') do |f|
  f.write(h_db.to_yaml)
end