namespace :setup do

  desc 'Reset cities'
  task :reset_cities => :environment do

    CCity.delete_all
    cities = [{:cn=>'winterfell', :q=>-1, :r=>19, :hn=>'stark'}, {:cn=>'fort_terror', :q=>-2, :r=>10, :hn=>'bolton'}, {:cn=>'karhold', :q=>3, :r=>5, :hn=>'karstark'}, {:cn=>'ile_aux_ours', :q=>-11, :r=>24, :hn=>'mormont'}, {:cn=>'corbois', :q=>6, :r=>11, :hn=>'corbois'}, {:cn=>'vivesaigues', :q=>20, :r=>22, :hn=>'tully'}, {:cn=>'havre_pierre', :q=>20, :r=>20, :hn=>'bracken'}, {:cn=>'harrenhal', :q=>24, :r=>16, :hn=>'whent'}, {:cn=>'salvemer', :q=>16, :r=>20, :hn=>'mallister'}, {:cn=>'les_jumeaux', :q=>15, :r=>19, :hn=>'frey'}, {:cn=>'pyk', :q=>14, :r=>29, :hn=>'greyjoy'}, {:cn=>'dix_tours', :q=>14, :r=>26, :hn=>'harloi'}, {:cn=>'noirmaree', :q=>12, :r=>28, :hn=>'noirmaree'}, {:cn=>'vieux_wik', :q=>11, :r=>30, :hn=>'timbal'}, {:cn=>'salfalaise', :q=>13, :r=>30, :hn=>'salfalaise'}, {:cn=>'castral_roc', :q=>22, :r=>29, :hn=>'lannister'}, {:cn=>'cendremarc', :q=>19, :r=>26, :hn=>'marpheux'}, {:cn=>'corval', :q=>24, :r=>23, :hn=>'brax'}, {:cn=>'dent_or', :q=>22, :r=>23, :hn=>'lefford'}, {:cn=>'crakehall', :q=>25, :r=>30, :hn=>'crakehall'}, {:cn=>'les_eyrie', :q=>23, :r=>12, :hn=>'arryn'}, {:cn=>'chene_en_fer', :q=>25, :r=>6, :hn=>'vanbois'}, {:cn=>'sortonne', :q=>13, :r=>13, :hn=>'sunderland'}, {:cn=>'snakewood', :q=>20, :r=>7, :hn=>'lynderly'}, {:cn=>'forchant', :q=>18, :r=>14, :hn=>'belmore'}, {:cn=>'hautjardin', :q=>32, :r=>24, :hn=>'tyrell'}, {:cn=>'villevieille', :q=>37, :r=>29, :hn=>'hightower'}, {:cn=>'la_treille', :q=>40, :r=>33, :hn=>'redwyne'}, {:cn=>'hauteterres', :q=>37, :r=>27, :hn=>'mullendore'}, {:cn=>'tumbleton', :q=>30, :r=>16, :hn=>'piete'}, {:cn=>'accalmie', :q=>40, :r=>8, :hn=>'baratheon'}, {:cn=>'la_vespree', :q=>42, :r=>4, :hn=>'torth'}, {:cn=>'pierheaume', :q=>42, :r=>12, :hn=>'swann'}, {:cn=>'serena', :q=>39, :r=>19, :hn=>'caron'}, {:cn=>'hystack_hall', :q=>36, :r=>9, :hn=>'errol'}, {:cn=>'lancehelion', :q=>53, :r=>5, :hn=>'martell'}, {:cn=>'les_meteores', :q=>42, :r=>24, :hn=>'dayne'}, {:cn=>'la_tombe_du_roy', :q=>41, :r=>19, :hn=>'forrest'}, {:cn=>'wyl', :q=>41, :r=>15, :hn=>'wyl'}, {:cn=>'salrivage', :q=>51, :r=>12, :hn=>'gargalen'}, {:cn=>'pouce_flint', :q=>5, :r=>28, :hn=>'flint'}, {:cn=>'griseaux', :q=>12, :r=>18, :hn=>'reed'}]
    cities.each do |city|
      CCity.create!( code_name: city[ :cn ], q: city[ :q ], r: city[ :r ], h_house_id: HHouse.find_by( code_name: city[ :hn ] ).id )
    end

    #
    # Old conversion code
    #
    # CITIES2 = [{:cn=>'winterfell', :q=>16, :r=>1, :hn=>:stark}, {:cn=>'fort_terror', :q=>25, :r=>-9, :hn=>:bolton}, {:cn=>'karhold', :q=>30, :r=>-9, :hn=>:karstark}, {:cn=>'ile_aux_ours', :q=>11, :r=>-4, :hn=>:mormont}, {:cn=>'corbois', :q=>24, :r=>0, :hn=>:corbois}, {:cn=>'vivesaigues', :q=>13, :r=>25, :hn=>:tully}, {:cn=>'havre_pierre', :q=>15, :r=>23, :hn=>:bracken}, {:cn=>'harrenhal', :q=>19, :r=>23, :hn=>:whent}, {:cn=>'salvemer', :q=>15, :r=>19, :hn=>:mallister}, {:cn=>'les_jumeaux', :q=>16, :r=>17, :hn=>:frey}, {:cn=>'pyk', :q=>6, :r=>26, :hn=>:greyjoy}, {:cn=>'dix_tours', :q=>9, :r=>23, :hn=>:harloi}, {:cn=>'noirmaree', :q=>7, :r=>23, :hn=>:noirmaree}, {:cn=>'vieux_wik', :q=>5, :r=>24, :hn=>:timbal}, {:cn=>'salfalaise', :q=>5, :r=>26, :hn=>:salfalaise}, {:cn=>'castral_roc', :q=>6, :r=>34, :hn=>:lannister}, {:cn=>'cendremarc', :q=>9, :r=>28, :hn=>:marpheux}, {:cn=>'corval', :q=>12, :r=>30, :hn=>:brax}, {:cn=>'dent_or', :q=>12, :r=>28, :hn=>:lefford}, {:cn=>'crakehall', :q=>5, :r=>38, :hn=>:crakehall}, {:cn=>'les_eyrie', :q=>23, :r=>18, :hn=>:arryn}, {:cn=>'chene_en_fer', :q=>29, :r=>14, :hn=>:vanbois}, {:cn=>'sortonne', :q=>22, :r=>9, :hn=>:sunderland}, {:cn=>'snakewood', :q=>28, :r=>10, :hn=>:lynderly}, {:cn=>'forchant', :q=>21, :r=>15, :hn=>:belmore}, {:cn=>'hautjardin', :q=>11, :r=>39, :hn=>:tyrell}, {:cn=>'villevieille', :q=>6, :r=>49, :hn=>:hightower}, {:cn=>'la_treille', :q=>2, :r=>56, :hn=>:redwyne}, {:cn=>'hauteterres', :q=>8, :r=>47, :hn=>:mullendore}, {:cn=>'tumbleton', :q=>19, :r=>29, :hn=>:piete}, {:cn=>'accalmie', :q=>27, :r=>31, :hn=>:baratheon}, {:cn=>'la_vespree', :q=>31, :r=>29, :hn=>:torth}, {:cn=>'pierheaume', :q=>23, :r=>37, :hn=>:swann}, {:cn=>'serena', :q=>16, :r=>41, :hn=>:caron}, {:cn=>'hystack_hall', :q=>26, :r=>28, :hn=>:errol}, {:cn=>'lancehelion', :q=>30, :r=>41, :hn=>:martell}, {:cn=>'les_meteores', :q=>11, :r=>49, :hn=>:dayne}, {:cn=>'la_tombe_du_roy', :q=>16, :r=>43, :hn=>:forrest}, {:cn=>'wyl', :q=>20, :r=>39, :hn=>:wyl}, {:cn=>'salrivage', :q=>23, :r=>46, :hn=>:gargalen}, {:cn=>'pouce_flint', :q=>7, :r=>16, :hn=>:flint}, {:cn=>'griseaux', :q=>17, :r=>13, :hn=>:reed}]
    #
    # GGameBoard.create!
    # g = GGameBoard.first
    # GGameBoardToken.delete_all
    #
    # max_row = 35
    #
    # CITIES2.uniq.each do |city|
    #
    #   puts city.inspect
    #   suzerain_name = HHouse.find_by_code_name( city[ :hn ] ).suzerain_or_self.code_name
    #   house = alliance = suzerain_name
    #
    #   r = city[ :q ]
    #   new_row = max_row - r
    #   q = city[ :r ] - ( ( new_row ) / 1 ) + ( max_row / 2 )
    #
    #   grid = Hex::Grid.new
    #   h = Hex::Axial.new( q, new_row )
    #   coords = grid.to_xy( h )
    #
    #   t_up_fn = 'cu_' + house[ 0..1 ] + '.png'
    #   t_down_fn = 'cd_' + alliance[ 0..1 ] + '.png'
    #
    #   # g.g_game_board_tokens.create!( q: q, r: new_row, left: coords[0]+11, top: coords[1]-3,
    #   #                                up_filename: t_up_fn, down_filename: t_down_fn )
    #
    #   CCity.create!( code_name: city[ :cn ], q: q, r: new_row, h_house_id: HHouse.find_by( code_name: city[ :hn ] ).id )
    # end
  end

end

