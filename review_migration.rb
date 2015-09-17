require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'development.sqlite3' #name of file on disk
)

class ReviewMigration < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :text
      t.integer :employee_id
      t.timestamps null: false
    end
  end
end
