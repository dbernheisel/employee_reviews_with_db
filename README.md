# Employee Reviews with a Database

## Description

Practicing with SQLite3 and ActiveRecord.
See this ERD [LucidChart](https://www.lucidchart.com/documents/view/344365a8-55c7-4977-8b7b-3a4da4cb3a49)

*Normal Mode*
- [x] Return the total number of employees in a department.
- [x] Return the employee who is being paid the least in a department.
- [x] Return all employees in a department, ordered alphabetically by name.
- [x] Return all employees who are getting paid more than the average salary.
- [x] Return all employees with names which are palindromes.
- [x] Return the department with the most employees.
- [x] Move everyone from one department to another department.
- [x] Give a raise of 10% to ALL employees with good reviews.  This is different from the raise method which already exists, and also needs to operate over all employees of ALL departments.

*Hard Mode*
- [x] Add a companies table.  Add one company called "The Iron Yard."
- [x] Add a foreign key on the departments table which points to companies. Associate all existing departments with The Iron Yard.
- [ ] Change the employee `salary` field to `rate`.  Do math on each employee to convert an annual salary to an hourly rate, then save the new hourly rate in the field.

The last migration will not be reversible if you write it in a `change` method.  Instead, write both `up` and `down` methods.

*Nightmare Mode*
- [ ] Modify your application to keep track of every employee's history.  In other words, you should keep a record of each position that the employee has held at any company.  You should know when each position started and ended.
- [ ] Write a method on an employee which takes a particular date.  The method should return the company and department name in which the employee worked on that date.
- [ ] Write a method on an employee which gives back an array of intervals during which the employee was not employed.
- [ ] Write a method on a department which gives back the employee which has worked longest in that department (ever).  If the employee left and came back, his or her total should include time across all positions with that department.
- [ ] Write a method on a company which gives back all employees who have been with the company for longer than 5 years.
- [ ] Write a method which returns all departments, ordered by the total number of employee-days which have been worked for that department.
