class GGameBoard < ApplicationRecord

  has_many :g_game_board_tokens, dependent: :destroy, class_name: 'Tokens::GGameBoardToken'
  has_many :g_game_board_tokens_cities, dependent: :destroy, class_name: 'Tokens::City'

  has_many :g_game_board_players, dependent: :destroy

  has_many :westeros_alliances_al_logs, :class_name => 'Alliances::AlLog', dependent: :destroy

  has_many :al_alliances, dependent: :destroy, class_name: 'Alliances::AlAlliance'
  has_many :al_enemies, dependent: :destroy, class_name: 'Alliances::AlEnemy'
  has_many :al_houses, dependent: :destroy, class_name: 'Alliances::AlHouse'
  has_many :al_bets, dependent: :destroy, class_name: 'Alliances::AlBet'
  has_many :al_alliance_masters, dependent: :destroy, class_name: 'Alliances::AlAllianceMaster'

  has_many :g_houses, dependent: :destroy

  include Alliances::AlliancesEngine::GAlliancesBetEngine
  include Alliances::AlliancesEngine::GAllianceCoreEngine
  include Alliances::AlliancesEngine::GEnemiesCoreEngine

  include Tokens::RefreshCities
  include Misc::GameBoardHouse

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


end
