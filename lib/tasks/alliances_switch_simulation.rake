desc 'Simulate alliances switch'
task :simulate_alliances_switch => :environment do

  GGameBoard.destroy_all
  GGameBoard.create!
  gb = GGameBoard.first

  stark = HHouse.find_by_code_name( :stark )
  lannister = HHouse.find_by_code_name( :lannister )
  tully = HHouse.find_by_code_name( :tully )
  greyjoy = HHouse.find_by_code_name( :greyjoy )

  gb.set_alliance_negotiation_rights( stark, true )
  gb.set_alliance_negotiation_rights( lannister, true )

  gb.create_alliance( stark, tully, 10 )
  gb.create_alliance( lannister, greyjoy, 10 )

  gb.refresh_tokens

end