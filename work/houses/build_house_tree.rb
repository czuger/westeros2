require 'yaml'
require 'pp'

h_db = YAML.load_file('db2.yaml')

vassals = {}
new_db = {}

h_db.each do |k, h|
  h_db[k][:vassality_level] = 0
end

restart = true
while restart
  restart = false
  h_db.each do |k, h|
    next unless h[:vassal_of]
    suzerain = h_db[ h[:vassal_of] ]

    p h, suzerain

    if h[:vassality_level] != suzerain[:vassality_level]
      h[:vassality_level] += 1
      restart = true
    end
  end
end

File.open('db3.yaml', 'w') do |f|
  f.write(h_db.to_yaml)
end