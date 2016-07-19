module MapHelper

  def put_token( x, y, color )
    image_tag 'token.png', class: :token, style: "left: #{coords[0].to_i+11}px; top: #{coords[1].to_i-3}px;"
  end

end
