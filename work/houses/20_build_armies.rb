require 'yaml'
require 'pp'
require 'ostruct'

class ArmyBuilder

  BIG_ARMIES = %w( Stark Lannister Baratheon )

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
    { leader: h.leaders.first, blason: h.blason, name: h.name, allegence: faction, kind: kind, men: men }
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
end

ArmyBuilder.new