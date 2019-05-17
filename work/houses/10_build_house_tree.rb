require 'yaml'
require 'pp'

class HouseTreeBuilder

  FAMILIES = %w( Stark Lannister Tyrell Martell Baratheon Tully Arryn Port-Réal )

  def initialize
    @h_db = YAML.load_file('db2.yaml')
    @reverse_vassals = {}
    @factions = {}

    compute_reverse_vassals
    FAMILIES.each do |f|
      set_factions f, f
    end
    delete_houses_without_faction

    File.open('factions.yaml', 'w') do |f|
      f.write(@factions.to_yaml)
    end

    File.open('houses.yaml', 'w') do |f|
      f.write(@h_db.to_yaml)
    end

  end

  private

  def compute_reverse_vassals
    @h_db.each do |k, h|
      suzerain = h[:vassal_of]
      if suzerain
        @reverse_vassals[suzerain] ||= []
        @reverse_vassals[suzerain] << k
      end
    end

    # pp @reverse_vassals
  end

  def set_factions( family, faction )
    set_family_faction family, faction
    if @reverse_vassals[family]
      @reverse_vassals[family].each do |sub_family|
        set_family_faction sub_family, faction
        set_factions sub_family, faction
      end
    end
  end

  def set_family_faction( family, faction )
    # p family

    return if family == 'Port-Réal'

    # p family

    @h_db[family][:faction] = faction
    @factions[faction] ||= []
    @factions[faction] << family unless @factions[faction].include?(family)
  end

  def delete_houses_without_faction
    @h_db.delete_if{ |k, v| !v[:faction] }
  end
end

HouseTreeBuilder.new