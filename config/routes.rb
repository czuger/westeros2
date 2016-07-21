Rails.application.routes.draw do

  resources :game_boards
  get 'game_board/show'

  get 'game_board/new'

  get 'game_board/create'

    resources :game_board, only: [ :show ]  do
      scope module: :alliances do
        resources :bets, only: [ :new, :create ]
        resource :alliances, only: [ :show ] do
          get :log
        end
      end
    end

  root 'map#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
