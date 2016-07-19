module MapHelper

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
    image_tag "tokens/#{filename}", class: :token, style: "left: #{left}px; top: #{top}px;"
  end

end
