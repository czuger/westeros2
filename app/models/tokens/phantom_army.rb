module Tokens
  class PhantomArmy < Tokens::GGameBoardToken

    def token_classes
      ep = extra_parameters
      [ :hidden_token, "phantom_army_for_city_#{ep[:city_id]}", :phantom_token ]
    end

  end
end
