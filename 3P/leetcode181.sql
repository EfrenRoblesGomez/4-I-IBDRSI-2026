# Write your MySQL query statement below
select e.name AS Employee
from Employee e
inner join employee m on e.managerID = m.id
where e.salary > m.salary;
