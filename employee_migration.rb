require 'active_record'

def EmployeeMigration < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string, :name
      t.string, :phone
      t.boolean, :satisfactory
      t.decimal, :salary, precision: 5, scale: 2
      t.timestamps, null: false
    end
  end
end
