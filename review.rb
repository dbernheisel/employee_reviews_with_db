ActiveRecord::Base.establish_connection(
  adapter: "sqlite",
  database: "development.sqlite3"
)

class Review < ActiveRecord::Base
  belongs_to :employee

  attr_reader :review
end
