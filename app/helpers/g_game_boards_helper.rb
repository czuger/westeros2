module GGameBoardsHelper

  private

  def up_token( token )
    put_token( token, token.up_filename )
  end

  def down_token( token )
    put_token( token, token.down_filename )
  end

  def put_token( token, filename )
    image_tag "tokens/#{filename}", class: :token
  end

  def token_classes( token )
    classes = token.token_classes
    classes << :hidden_token unless token.show
    classes
  end

end
