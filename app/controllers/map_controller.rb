class MapController < ApplicationController
  def show
    @tokens = []
    grid = Hex::Grid.new
    ( 0 .. 45 ).each do |q|
      ( 0 .. 35 ).each do |r|
        h = Hex::Axial.new( q, r )
        @tokens << grid.to_xy( h )
      end
    end
  end
end
