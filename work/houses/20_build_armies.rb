require 'yaml'
require 'pp'
require 'ostruct'

class ArmyBuilder

  BIG_ARMIES = %w( Stark Lannister Baratheon )
  HOUSES_PRIORITY = { 'Karstark' => 90, 'Bolton' => 80, 'Omble' => 70, 'Tarly' => 90, 'Frey' => 90, 'Torth' => 90 }
  FAMILIES = %w( Stark Lannister Tyrell Martell Baratheon Tully Arryn Port-Réal )

  def initialize
    @houses = YAML.load_file('houses.yaml')
    @factions = YAML.load_file('factions.yaml')

    @armies = {}

    build_armies

    File.open( 'armies.yaml', 'w' ) do |f|
      f.write(@armies.to_yaml)
    end
  end

  def build_army( faction, house, kind, men )
    h = OpenStruct.new( @houses[house] )
    { leader: h.leaders.first, blason: h.blason, name: h.name, allegence: faction, kind: kind, men: men, link: h.url }
  end

  def build_armies
    @factions.each do |k,v|
      footmen = 4
      knights = 2

      if BIG_ARMIES.include?(k)
        footmen = 8
        knights = 4
      end

      @armies[k] = []
      v = v.sort_by { |e| house_priority(e, k) }.reverse

      while footmen > 0 || knights > 0
        if footmen > 0
          @armies[k] << build_army( k, v.shift, :footmen, 2000 )
          footmen -= 1
        else
          @armies[k] << build_army( k, v.shift, :knights, 1000 )
          knights -= 1
        end
      end
    end
  end

  def house_priority( house, faction )
    return 100 if FAMILIES.include?(house)
    return HOUSES_PRIORITY[house] if HOUSES_PRIORITY[house]
    return 30 if @houses[house][:vassal_of] == faction
    return 10 if @houses[house][:lord]
    0
  end

end

ArmyBuilder.new