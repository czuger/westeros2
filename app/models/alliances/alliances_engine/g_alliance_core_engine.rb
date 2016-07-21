module Alliances
  module AlliancesEngine
    module GAllianceCoreEngine

      # True if two houses are allied
      def allied?( master_house, minor_house )
        al_alliances.where( h_house_id: master_house.id, h_peer_house_id: minor_house.id ).exists?
      end

      # Synonym for alliance_members
      def allies( house )
        alliance_members( house )
      end

      # Return all the alliance members for a given house
      # http://www.mitchcrowe.com/10-most-underused-activerecord-relation-methods
      def alliance_members( house )
        HHouse.joins( :al_alliances ).merge( al_alliances.where( h_peer_house_id: house.id ) )
      end

      # Return the master of the alliance (if any)
      def alliance_master( house )
        al = al_alliance_masters.where( h_house_id: house.id ).first
        HHouse.find( al.h_house_master_id ) if al
      end

      # Check if a house is a minor alliance member
      # This is required, because a minor alliance member can't initiate an alliance or declare war
      def minor_alliance_member?( house )
        al_house = al_houses.find_by( h_house_id: house.id )
        al_house&.minor_alliance_member
      end

      # Create an alliance between two houses
      def
      create_alliance( master_house, minor_house, last_bet )
        can_negotiate?( master_house, minor_house )

        minor_allies = ( [ minor_house ] + minor_house.vassals ).uniq
        all_allies = ( [ master_house ] + master_house.vassals + alliance_members( master_house ) + minor_allies ).uniq

        ActiveRecord::Base.transaction do

          # master_house and all it's vassals are marked as a minor alliance member (thus cant't ever be a master member)
          # Minor are included for coherence
          minor_allies.each do |ally|
            al_house = al_houses.where( h_house_id: ally.id ).first_or_initialize
            al_house.last_bet = last_bet
            al_house.save!
          end

          # We need to delete the current alliances of the minor house and all vassals
          minor_allies_ids = minor_allies.map{ |a| a.id }
          al_alliances.where( h_house_id: minor_allies_ids ).delete_all
          al_alliances.where( h_peer_house_id: minor_allies_ids ).delete_all

          # We also need to remove their old enemies
          al_enemies.where( h_house_id: minor_allies_ids ).delete_all
          al_enemies.where( h_peer_house_id: minor_allies_ids).delete_all

          # Setup the alliances links
          all_allies.each do |ally_m|
            all_allies.each do |ally_p|
              next if ally_m == ally_p
              # puts "About to create alliance : #{ally_m}, #{ally_p}"
              # Check if the new allies were enemies, if yes, we remove them
              # enemies_test = al_enemies.where( h_house_id: ally_m.id, h_peer_house_id: ally_p.id ).first
              # enemies_test.delete if enemies_test
              al_alliances.where( h_house_id: ally_m.id, h_peer_house_id: ally_p.id ).first_or_create!
            end
          end

          # We will recreate the alliance_master table
          al_alliance_masters.delete_all
          all_allies.each do |ally|
            al_alliance_masters.where( h_house_id: ally.id, h_house_master_id: master_house.id ).first_or_create!
          end

          # And create the news one
          minor_allies_ids.each do |minor_ally_id|
            enemies( master_house ).pluck( :id ).each do |master_house_enemy_id|
              al_enemies.where( h_house_id: minor_ally_id, h_peer_house_id: master_house_enemy_id ).first_or_create!
              al_enemies.where( h_house_id: master_house_enemy_id, h_peer_house_id: minor_ally_id ).first_or_create!
            end
          end

        end
      end

      private

      # Only master houses can negociate
      # Input : two houses of houses
      def can_negotiate?( master_house, minor_house )
        [ master_house, minor_house ].each do |h|
          raise "#{self.class}##{__method__} : #{h.inspect} not suzerain" if h.vassal?
        end

        if minor_alliance_member?( master_house )
          al_house = al_houses.where( h_house_id: master_house.id )
          raise "#{self.class}##{__method__} : Minor alliance member - #{al_house.to_a.inspect}, #{master_house.inspect}"
        end

        unless major_house?( master_house )
          al_house = al_houses.where( h_house_id: master_house.id )
          raise "#{self.class}##{__method__} : Not a major house : #{al_house.to_a.inspect}, #{master_house.inspect} "
        end


      end

    end
  end
end
