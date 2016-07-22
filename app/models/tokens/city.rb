module Tokens
  class City < Tokens::GGameBoardToken

    def extra_params
      extra_parameters
    end

    def token_classes
      [ :can_recruit ]
    end

  end
end
