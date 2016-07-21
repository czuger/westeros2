class GGameBoard < ApplicationRecord

  has_many :g_game_board_tokens, dependent: :destroy
  has_many :g_game_board_players, dependent: :destroy

  has_many :westeros_alliances_al_logs, :class_name => 'Alliances::AlLog', dependent: :destroy

  has_many :al_alliances, dependent: :destroy, class_name: 'Alliances::AlAlliance'
  has_many :al_enemies, dependent: :destroy, class_name: 'Alliances::AlEnemy'
  has_many :al_houses, dependent: :destroy, class_name: 'Alliances::AlHouse'
  has_many :al_bets, dependent: :destroy, class_name: 'Alliances::AlBet'

  include Alliances::AlliancesEngine::GAlliancesBetEngine
  include Alliances::AlliancesEngine::GAllianceCoreEngine
  include Alliances::AlliancesEngine::GEnemiesCoreEngine

  DECAL_TOP=-3
  DECAL_LEFT=11

  def next_turn
    ActiveRecord::Base.transaction do
      increment( :turn )
      save!
      resolve_bets
      refresh_tokens
    end
  end

  def refresh_tokens
    ActiveRecord::Base.transaction do
      refresh_cities
    end
  end

  private

  def refresh_cities
    GGameBoardToken.where( g_game_board_id: id ).delete_all

    grid = Hex::Grid.new

    CCity.includes(:h_house).all.each do |city|

      h = Hex::Axial.new( city.q, city.r )
      coords = grid.to_xy( h )

      house_name = city.h_house.suzerain_or_self.code_name
      # puts house_name
      master_house = alliance_master( city.h_house )
      # puts master_house.inspect
      master_alliance_name = master_house ? master_house.code_name : house_name
      # puts master_alliance_name.inspect
      # puts

      t_up_fn = 'cu_' + house_name[ 0..1 ] + '.png'
      t_down_fn = 'cd_' + master_alliance_name[ 0..1 ] + '.png'

      g_game_board_tokens.create!(
        q: city.q, r: city.r, left: coords[0]+DECAL_LEFT, top: coords[1]+DECAL_TOP, up_filename: t_up_fn, down_filename: t_down_fn )
    end
  end

end
