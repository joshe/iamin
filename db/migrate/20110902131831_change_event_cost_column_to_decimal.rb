class ChangeEventCostColumnToDecimal < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.change :event_cost, :decimal, { :precision => 8, :scale => 2 }
    end
  end

  def self.down
    change_table :events do |t|
      t.change :event_cost, :float
    end
  end
end
