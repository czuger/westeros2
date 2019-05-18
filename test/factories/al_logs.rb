FactoryBot.define do
  factory :al_log, class: Alliances::AlLog do
    g_game_board nil
    turn 3
    alliance_details { {} }
    log_code 1
  end
end
