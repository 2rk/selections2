$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "selections"
require "active_record"
require "ranked-model"
require "shoulda/matchers"
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :tickets do |t|
  t.integer :priority_id
  t.timestamps
end

ActiveRecord::Migration.create_table :selections do |t|
  t.integer :position
  t.string :type
  t.timestamps
end

class Selection < ActiveRecord::Base #:nodoc:
  include Selections
end

class Priority < Selection #:nodoc:

end

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
  end
end
