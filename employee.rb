require 'active_record'
require './review'
require 'pry'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'development.sqlite3' #name of file on disk
)

class Employee < ActiveRecord::Base
  belongs_to :department
  has_many :reviews
  #validates :name, presence: true
  #validates :salary, presence: true

  def recent_review
    reviews.last
  end

  def satisfactory?
    self.satisfactory
  end

  def give_raise(amount)
    self.salary += amount
    self.save
  end

  def give_review(review)
    return false if review.nil?
    self.reviews << review
    assess_performance
    self.save
  end

  def assess_performance
    good_terms = [/positive/i, /good/i, /\b(en)?courag(e[sd]?|ing)\b/i, /ease/i, /improvement/i, /quick(ly)?/i, /incredibl[ey]/i, /\bimpress[edving]?{2,3}/i]
    bad_terms = [/\broom\bfor\bimprovement/i, /\boccur(ed)?\b/i, /not/i, /\bnegative\b/i, /less/i, /\bun[a-z]?{4,9}\b/i, /\b((inter)|e|(dis))?rupt[ivnge]{0,3}\b/i]
    good_terms = Regexp.union(good_terms)
    bad_terms = Regexp.union(bad_terms)

    count_good = reviews.last.text.scan(good_terms).length
    count_bad = reviews.last.text.scan(bad_terms).length

    self.satisfactory = (count_good - count_bad > 0)
    self.save
  end

  def self.palindrome_employees
    palindrome_employees = []
    Employee.select(:name).each do |e|
      palindrome_employees << e.name if e.name.downcase == e.name.downcase.reverse
    end
    palindrome_employees
  end

  def self.give_raise(amount: 0, percentage: 0, only_satisfactory: true)
    return false if amount == 0 && percentage == 0
    return false if amount != 0 && percentage != 0
    percentage != 0 ? percentage_mode = true : percentage_mode = false
    getting_raise = []
    if only_satisfactory
      Employee.select { |e| e.satisfactory? }
    else
      getting_raise = Employee.select(:salary)
    end
    getting_raise.each do |e|
      amount = e.total_salary * percentage if percentage_mode
      e.give_raise(amount)
      e.save
    end
  end

  def self.total_salary
    Employee.select(:id, :salary).reduce(0) { |sum, e| sum + e.salary }
  end

end
