require "selections/version"
require "active_record"
require "active_support/concern"
require "ranked-model"

module Selections
  module BelongsToSelection
    extend ActiveSupport::Concern
    class_methods do
      def belongs_to_selection(name, options = {})
        other = options.delete(:other)

        define_method "#{name}_option_other?" do
          other
        end

        belongs_to name, options

        class_eval do
          name.to_s.classify.constantize.all.each do |selection|
            define_method "#{selection.system_code}?" do
              priority_id == selection.id
            end
          end
          if other
            define_method "#{name}_other?" do
              priority_id == -1
            end
          end
        end
      end
    end
  end
end
