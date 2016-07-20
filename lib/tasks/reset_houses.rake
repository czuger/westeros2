namespace :setup do

  desc 'Reset houses'
  task :reset_houses => :environment do
    HHouse.vassals.destroy_all
    HHouse.suzerains.destroy_all

    @stark = HHouse.create_house_and_vassals( :stark, :karstark, :bolton, :corbois, :mormont, :flint, :reed ).first
    @greyjoy = HHouse.create_house_and_vassals( :greyjoy, :noirmaree, :timbal, :harloi, :salfalaise ).first
    @lannister = HHouse.create_house_and_vassals( :lannister, :brax, :marpheux, :lefford, :crakehall ).first
    @tyrell = HHouse.create_house_and_vassals( :tyrell, :hightower, :redwyne, :mullendore, :piete ).first
    @tully = HHouse.create_house_and_vassals( :tully, :bracken, :whent, :mallister, :frey ).first
    @arryn = HHouse.create_house_and_vassals( :arryn, :vanbois, :sunderland, :lynderly, :belmore ).first
    @baratheon = HHouse.create_house_and_vassals( :baratheon, :torth, :swann, :caron, :errol ).first
    @martell = HHouse.create_house_and_vassals( :martell, :dayne, :forrest, :wyl, :gargalen ).first
  end

end
