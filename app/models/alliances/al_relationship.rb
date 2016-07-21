# This is a join class that link all allied houses on a given game board

module Alliances
  class AlRelationship < ActiveRecord::Base
    belongs_to :h_house
    belongs_to :h_peer_house, class_name: 'HHouse', foreign_key: :h_peer_house_id

    has_many :westeros_alliances_al_houses, :class_name => 'Alliances::AlHouse', foreign_key: :h_house_id, primary_key: :h_house_id
  end
end
