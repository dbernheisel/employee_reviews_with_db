require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'development.sqlite3' #name of file on disk
)

class EmployeeMigration < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :department_id
      t.boolean :satisfactory, default: true
      t.integer :salary
      #t.decimal :salary, precision: 5, scale: 2
      t.timestamps null: false
    end
  end
end
