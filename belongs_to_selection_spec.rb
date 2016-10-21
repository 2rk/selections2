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
    end
  end
end
