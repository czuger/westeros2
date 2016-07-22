module GGameBoardsHelper

  private

  def up_token( token )
    put_token( token, token.up_filename )
  end

  def down_token( token )
    put_token( token, token.down_filename )
  end

  def put_token( token, filename )
    top = token.top
    left = token.left

    token_classes = [ :token ]
    extra_params = {}

    image_tag "tokens/#{filename}", class: token_classes, style: "left: #{left}px; top: #{top}px;", extra_params: extra_params.to_json
  end

end
