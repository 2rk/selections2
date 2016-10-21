require "selections/version"
require "active_record"
require "active_support/concern"
require "ranked-model"

module Selections
  module BelongsToSelection
    def belongs_to_selection(name, scope = nil, options = {})
      belongs_to name, scope, options
    end


    ActiveSupport.on_load :active_record do
      extend Selections::BelongsToSelection
    end
  end


end
