module Tokens
  class PhantomArmy < Tokens::GGameBoardToken

    def token_classes
      ep = extra_parameters
      [ "phantom_army_for_city_#{ep[:city_id]}", :phantom_token, :recruit_army ]
    end

  end
end
