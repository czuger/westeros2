require 'yaml'
require 'pp'

h_db = YAML.load_file('db2.yaml')

h_db.each do |k, h|
  h_db[k][:vassality_level] = 0
  h_db[k][:vassals] = []

  suzerain = h
  upper_suzerain = suzerain[:vassal_of]

  # p h
  while upper_suzerain
    suzerain = h_db[upper_suzerain]
    upper_suzerain = h_db[upper_suzerain]

    unless upper_suzerain
      h_db.delete(k)
      break
    end

    upper_suzerain = upper_suzerain[:vassal_of]
  end

  h_db[k][:faction] = suzerain[:name] if h_db[k]
end

restart = true
while restart
  restart = false
  h_db.each do |k, h|
    next unless h[:vassal_of]
    suzerain = h_db[ h[:vassal_of] ]

    # p h, suzerain

    if h[:vassality_level] <= suzerain[:vassality_level]
      h_db[k][:vassality_level] += 1
      h_db[k][:suzerain_blason] = suzerain[:blason]
      restart = true
    end
  end
end

2.downto(0).each do |i|
  h_db.each do |k, h|
    next unless h[:vassality_level] == i

    suzerain = h_db[ h[:vassal_of] ]
    next unless suzerain

    suzerain[:vassals] << h
  end
end

factions = {}
cleaned_houses = {}

h_db.each do |k, h|
  next unless h[:vassality_level] == 0
  next unless %w( Stark Lannister Tyrell Martell Baratheon Tully Arryn ).include?(h[:faction])

  factions[h[:faction]] = {}
end

h_db.each do |k, h|
  next unless %w( Stark Lannister Tyrell Martell Baratheon Tully Arryn ).include?(h[:faction])

  h.delete(:vassals)

  factions[h[:faction]][k] = h[:name]

  cleaned_houses[k] = h
end

File.open('factions.yaml', 'w') do |f|
  f.write(factions.to_yaml)
end

File.open('houses.yaml', 'w') do |f|
  f.write(cleaned_houses.to_yaml)
end

# File.open('houses_ranks.txt', 'w') do |f|
#   cleaned_houses.map{ |k, h| [ h[:faction], h[:name], 0 ] }.sort.each do |h|
#     f.puts( [ h[0], h[1], 0 ].join(':' ) )
#   end
# end