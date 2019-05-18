require 'ostruct'

class ArmiesController < ApplicationController

  def index
    @armies = YAML.load_file('work/houses/armies.yaml')
  end

  def show
    @armies = YAML.load_file('work/houses/armies.yaml')
    @army = @armies[ params[:id] ].map{ |e| OpenStruct.new( e ) }
  end
end
