module Tokens
  class PhantomArmy < Tokens::GGameBoardToken

    def token_classes
      ep = extra_parameters
      [ "phantom_army_for_city_#{ep[:city_id]}", :phantom_token, :recruit_army, :no_armies_on_token ]
    end

    def extra_params
      { h_id: extra_parameters[ :h_id ] }
    end

  end
end
