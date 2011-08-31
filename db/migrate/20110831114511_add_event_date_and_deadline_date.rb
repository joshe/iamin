class AddEventDateAndDeadlineDate < ActiveRecord::Migration
  def self.up
		add_column :events, :event_date, :datetime
		add_column :events, :event_deadline, :datetime
  end

  def self.down
		remove_column :events, :event_deadline
		remove_column :events, :event_date
  end
end
