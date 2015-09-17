require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'development.sqlite3' #name of file on disk
)

class Department < ActiveRecord::Base
  has_many :employees
  validates :name, presence: true

  def add_employee(employee)
    return false if employee.nil?
    employees << employee
    self.save
  end

  def move_employee(employee, to_dept)
    return false if employee.nil?
    return false if to_dept.nil?
    employees.delete(employee) if to_dept.add_employee(employee)
    self.save
    to_dept.save
  end

  def total_salary
    employees.reduce(0) { |sum, employee| sum + employee.salary }
  end

  def total_employees
    employees.count
  end

  def least_paid
    employees.select(:name).order(salary: :asc).limit(1)[0]
  end

  def employees_alpha
    employees_names_array = []
    self.employees.select(:name).order(:name).each do |e|
      employees_names_array << e.name
    end
    employees_names_array
  end

  def paid_above_average_employees
    employees_names_array = []
    employees.select(:name).where(["salary > ?", employees.average(:salary)]).each do |e|
      employees_names_array << e.name
    end
    employees_names_array
  end

  def give_raise(total_amount)
    getting_raise = employees.select { |e| e.satisfactory? }
    getting_raise.each { |e| e.give_raise(total_amount / getting_raise.length) }
  end

  def self.biggest_department
    self.employees(:employees).group(:id).order(count: :asc).limit(1)
  end

  def self.merge_departments(stay:, go:)
    return false if stay.nil? || !stay.is_a?(Department)
    return false if go.nil? || !stay.is_a?(Department)
    go.employees.each do |e|
      go.employees.delete(e) if stay.add_employee(e)
    end
    go.save
    stay.save
    return true
  end



end
