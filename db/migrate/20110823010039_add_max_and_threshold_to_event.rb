class AddMaxAndThresholdToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :threshold, :integer, :default => 1
    add_column :events, :max, :integer, :default => 0
  end

  def self.down
    remove_column :events, :threshold
    remove_column :events, :max
  end
end
