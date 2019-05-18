require 'yaml'
require 'pp'
require 'ostruct'

class HousesReworker
  UNWANTED_HOUSES = %w( Baelish Mormont Montmarri Payne Clegane )
  KNOWN_HOUSES = { 'Stark' => ['King Robb Stark'], 'Martell' => ['Prince Oberyn Martell'], 'Baratheon' => ['Lord Renly Baratheon'],
                   'Tully' => ['Lord Edmure Tully'], 'Arryn' => ['Lord Harrold Hardyng'] }

  def initialize
    @h_db = YAML.load_file('db.yaml')

    set_up_leaders
    remove_houses
    
    File.open('db2.yaml', 'w') do |f|
      f.write(@h_db.to_yaml)
    end
  end

  def set_up_leaders
    @h_db.each do |k, h|
      h = OpenStruct.new( h )
      
      if KNOWN_HOUSES[k]
        @h_db[k][:leaders] = KNOWN_HOUSES[k]
      else
        @h_db[k][:leaders] = []
        @h_db[k][:leaders] << "Lord #{h.lord}" if h.lord
        @h_db[k][:leaders] << "Ser #{h.ser}" if h.ser
      end
    end
  end

  def remove_houses
    @h_db.each do |k, h|
      # @h_db[k][:vassal_of] = 'Baratheon' if h[:vassal_of] == 'Port-Réal'

      h = OpenStruct.new( h )
      
      if h.rang && h.rang.downcase =~ /maison éteinte/
        puts "Disabling house #{k}"
        @h_db.delete(k)
        next
      end

      if h[:leaders].empty?
        puts "No knights in #{k}"
        @h_db.delete(k)
        next
      end

      if UNWANTED_HOUSES.include?( h.name )
        puts "Unwanted house #{k}"
        @h_db.delete(k)
        next
      end

      h = OpenStruct.new( h )
      unless h.leaders.map{ |e| e.split }.flatten.include?(h.name) || KNOWN_HOUSES[h.name]
        # p h.leaders, h.name
        puts "Removing house #{h.name}, bad name #{h.leaders}"
        @h_db.delete(k)
        next
      end
    end
  end
  
end

HousesReworker.new