require 'active_record'

def ReviewMigration < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string, :review
      t.timestamps, null: false
    end
  end
end
