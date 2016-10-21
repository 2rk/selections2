require "spec_helper"
describe Selections::BelongsToSelection, type: :model do

  describe '#belongs_to_selection' do
    it 'defines the macro on all AR objects' do
      class Ticket < ActiveRecord::Base
        belongs_to_selection :priority
      end

      expect(Ticket.new).to belong_to(:priority)
    end
  end
end
