create table emp
(
	eid integer primary key,
	ename varchar(25),
	age int,
	salary float
)

insert into emp values(1000,'Lakmal',33,90000)
insert into emp values(1001,'Nadeeka',24,28000)
insert into emp values(1002,'Amila',26,35000)
insert into emp values(1003,'Nishani',28,60000)
insert into emp values(1004,'Krishan',36,95000)
insert into emp values(1005,'Surangi',37,22000)
insert into emp values(1006,'Shanika',24,18000)
insert into emp values(1007,'Amali',21,20000)
insert into emp values(1008,'Charith',28,35000)
insert into emp values(1009,'Prasad',40,95000)

create table dept
(
did char(12) primary key,
budget float,
managerId int foreign key references emp
)

insert into dept values('Academic',900000,1002)
insert into dept values('Admin',120000,1000)
insert into dept values('Finance',3000000,1008)
insert into dept values('ITSD',4500000,1000)
insert into dept values('Maintenance',40000,1004)
insert into dept values('SESD',20000,1004)
insert into dept values('Marketing',90000,1008)

create table works
(
eid int foreign key references emp,
did Char(12) foreign key references dept,
pct_time int,
primary key(eid,did)
)

insert into works values(1000,'Admin',40)
insert into works values(1000,'ITSD',50)
insert into works values(1001,'Admin',100)
insert into works values(1002,'Academic',100)
insert into works values(1003,'Admin',20)
insert into works values(1003,'Academic',30)
insert into works values(1003,'ITSD',45)
insert into works values(1004,'Admin',60)
insert into works values(1004,'Finance',30)
insert into works values(1006,'Finance',45)
insert into works values(1006,'Maintenance',52)
insert into works values(1008,'Maintenance',30)
insert into works values(1008,'ITSD',30)
insert into works values(1008,'Finance',35)
insert into works values(1009,'Admin',100)

select * from dept
select * from emp
select * from works

---10---

select ename, salary
from emp

---11---

select ename, salary
from emp
order by salary desc

---12---

select ename, salary
from emp
where salary > 50000

---13---

select ename
from emp
where ename LIKE 'S%'

---14---

select d.did, e.ename
from emp e, dept d
where e.eid = d.managerId


---15---

select distinct e.ename, d.managerId
from emp e, dept d
where e.salary > 75000 AND d.managerId = e.eid

---16---

select ename
from emp
where eid not in(select eid from works)

select e.ename 
from emp e left outer join works w on e.eid = w.eid
where w.did IS NULL

---17---

select distinct e.ename, e.age
from emp e, works w
where e.eid = w.eid and w.did IN ('ITSD','Academic')

select e.ename, e.age -- duplicated values in here --
from emp e, works w
where e.eid = w.eid and w.did IN ('ITSD','Academic')

select e.ename, e.age
from emp e, works w
where e.eid = w.eid and w.did = 'ITSD' or w.did = 'Acadamic'

---18--- -- Check this code again --

select e.ename, e.age
from emp e, works w
where e.eid = w.eid and w.did = 'ITSD' and w.eid IN (
												
												select eid
												from works w
												where w.did = 'ITSD'
)

--19--

select d.did, e.ename
from dept d, emp e
where d.managerId = e.eid

--20--

select min(salary) as 'minimun', max(salary) as 'maximum'
from emp

--21--

select e.ename, sum(w.pct_time) as 'total precentage'
from emp e, works w
where e.eid = w.eid
group by e.ename
order by e.ename

--22--

 select d.did, COUNT(w.eid) as 'NoOfEmployees'
 from dept d, works w
 where d.did = w.did
 group by d.did

 select d.did, COUNT(w.eid) as 'NoOfEmployees'
 from dept d left outer join works w on d.did = w.did
 group by d.did

 --23--

 select e.ename 
 from emp e, works w
 where e.eid = w.eid and w.pct_time > 90


 --24--

SELECT w.did
FROM emp e, works w
WHERE e.eid = w.eid
GROUP BY w.did
HAVING SUM(e.salary) > 100000


--25--

 select e.ename
 from emp e
 where e.salary > ALL (select d.budget
					from dept d, works w
					where d.did = w.did and e.eid = w.eid)


--26--

select managerId
from dept
group by managerId
having min(budget) > 100000


--27--

select e.ename
from emp e, dept d
where e.eid = d.managerId and d.budget IN (select max(budget)
											from dept)

--28--

select managerId
from dept
group by managerId
having sum(budget) > 5000000

--29--


select managerId
from dept
group by managerId

having sum(budget) >= ALL (
	select sum(budget)
	from dept
	group by managerId
)
