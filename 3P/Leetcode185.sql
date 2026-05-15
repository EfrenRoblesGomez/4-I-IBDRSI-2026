# Write your MySQL query statement below
with RankedSalaries As (
    select
    d.name As Department,
    e.name As Employee,
    e.salary As Salary,
    DENSE_RANK() over(
        partition by e.departmentId
        order by e.salary desc
    ) As salary_rank
    from Employee e
    join Department d on e.departmentId = d.id
)
select
    Department,
    Employee,
    Salary
from RankedSalaries
where salary_rank <= 3;
