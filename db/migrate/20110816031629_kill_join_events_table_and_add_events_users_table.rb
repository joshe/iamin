class KillJoinEventsTableAndAddEventsUsersTable < ActiveRecord::Migration
  def self.up
    drop_table :join_events
    create_table :events_users, :id => false do |t|
        t.integer "event_id"
        t.integer "user_id"
      end
      add_index :events_users, ["event_id", "user_id"]
  end

  def self.down
    remove_index :events_users, ["event_id", "user_id"]
    drop_table :events_users
    create_table :join_events do |t|
      t.references :user
      t.references :event
      
      t.timestamps
    end
  end
end
