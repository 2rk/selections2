require "spec_helper"
describe Selections::BelongsToSelection, type: :model do

  describe '#belongs_to_selection' do
    it 'defines the macro on all AR objects' do
      class Ticket < ActiveRecord::Base
        belongs_to_selection :priority
      end

      expect(Ticket.new).to belong_to(:priority)
    end


    it 'creates predicate methods for each system_code' do
      priority = Priority.create!(position: 10, system_code: :priority_high)
      priority_other = Priority.create!(position: 20, system_code: :priority_low)

      class Ticket < ActiveRecord::Base
        include Selections::BelongsToSelection
        belongs_to_selection :priority
      end

      ticket = Ticket.new(priority_id: priority.id)

      expect(ticket).to respond_to(:priority_high?)
      expect(ticket).to respond_to(:priority_low?)
      expect(ticket.priority_high?).to be_truthy
      expect(ticket).to_not respond_to(:priority_other?)
    end

    context 'options' do
      context 'other' do
        it 'other support defaults to off' do
          class Ticket < ActiveRecord::Base
            include Selections::BelongsToSelection
            belongs_to_selection :priority
          end

          ticket = Ticket.new
          expect(ticket).to_not be_priority_option_other
        end
        it 'other support can be enabled' do
          class Ticket < ActiveRecord::Base
            include Selections::BelongsToSelection
            belongs_to_selection :priority, other: true
          end

          ticket = Ticket.new
          expect(ticket).to be_priority_option_other
        end
        it 'it should add delegate of priority_other?' do
          class Ticket < ActiveRecord::Base
            include Selections::BelongsToSelection
            belongs_to_selection :priority, other: true
          end

          ticket = Ticket.new(priority_id: -1)
          expect(ticket).to respond_to(:priority_other?)
          expect(ticket.priority_other?).to be_truthy
        end
      end
    end
  end
end
