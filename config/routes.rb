Rails.application.routes.draw do

  resources :g_game_boards do
    scope module: :alliances do
      resources :bets, only: [ :new, :create ]
      resource :alliances, only: [ :show ] do
        get :log
      end
    end
    get :next_turn
    resources :g_armies_hiring, only: [ :create ]
  end

  root 'g_game_boards#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
