require "selections/version"
require "active_record"
require "active_support/concern"
require "ranked-model"

module Selections
  module BelongsToSelection
    extend ActiveSupport::Concern
    class_methods do
      def belongs_to_selection(name, scope = nil, options = {})
        belongs_to name, scope, options
        class_eval do
          name.to_s.classify.constantize.all.each do |selection|
            define_method "#{selection.system_code}?" do
              priority_id == selection.id
            end
          end
        end
      end
    end


  end
end
