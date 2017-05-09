/******************************************************
********************** Chapter 4 ********************** 
******************************************************/
/*
* 4.1) Join Expressions
----------------------*/
/*
* 4.1.1) Join Conditions
----------------------*/
select*
from student join takes on student.ID = takes.ID
;
-- exactly equivalent to 
/*
select*
from student, takes
where student.ID = takes.ID
*/

-- to display ID once 
/*
select student.ID as ID, name, dept_name, tot_credit,
       course_id, sec_id, semester, year, grade
from student join takes on student.ID = takes.ID
;
*/

/*
* 4.1.2) Outer Joins
*-------------------*/
/*
this type of join is used to preserve tuples that are 
not present in both relations being joined as compared 
to the natural join. the tuple not common to both 
relations will be filled with null values for columns 
not defined in the other relation. 
*/
select*
from student natural join takes
;
select*
from student
;

/*
* left outer join: preserves tuples the relation named 
* before the left outer operation
*/
select*
from student natural left outer join takes
;
/* use outer join to retreive students how have not 
taken a course */
select ID
from student natural left outer join takes 
where course_id is null
;


/*
* the right outer join is symmetric to the left outer join
*/
select*
from takes natural right outer join student
;

/*
* the full outer join: is the combination of the above two
*/
/*Display a list of all students in the Comp. Sci department,
along with the course sections, if any, that they have taken 
in Spring 2009. all course sections from Spring 2009 must be 
displayed, even if no student from the Comp. Sci department 
has taken the course section.*/
select*
from (select* 
      from student 
      where dept_name = 'Comp.Sci.') as S
          natural left outer join
      (select* 
       from takes 
       where semester = 'Spring'
       and year = 2009) as D

;
select*
from (select* 
      from student 
      where dept_name = 'Comp.Sci.') as S
          natural left outer join
      (select* 
       from takes 
       where semester = 'Spring'
       and year = 2009) as D
;

select*
from 
  (select* 
       from takes 
       where semester = 'Spring'
       and year = 2009) as D
         natural left outer join
       (select* 
      from student 
      where dept_name = 'Comp.Sci.') as S
            
;

/* Remark :
USing 'on' clause with outer joins 
*/

select*
from student left outer join takes on student.ID = takes.id
;
/* compare this to */
select*
from student left outer join takes on true
where student.ID = takes.ID
;

/*
* 4.1.3) Join Types and Conditions
*--------------------------------*/

/*
--------------------+-------------------+
	JoinType		|	Join Condition	|
--------------------+-------------------+
inner join			|	natural			|
left outer join		| on <condition>	|
right outer join	| using(A1, A2, ...)|
					|					|
--------------------+-------------------+
*/
-- a) natural join: same columns are kept ones in the result
select*
from student natural join takes
;

-- b) as in a, however the join culumn is speciified in the 
-- using clause
select*
from student join takes using(ID)
;

-- c) as in b but duplicate collumns are kept in the result
select*
from student join takes on student.ID = takes.ID
;

-- d) the outer join version are pretty the same as for the above 
-- queries, however tuples abscent from one relation are kept in the 
-- result, and padded with null values for the non shared cullumns 
-- from the other relation (left, right or full )
select*
from student natural left outer join takes
;

select* 
from student left outer join takes using(ID)
;

select*
from student left outer join takes on student.ID = takes.ID
;

/*
* 4.2 Views
----------*/
/*
* 4.1 View definition
---------------------*/
/* view realtion faculty */
create view faculty as 
select ID, name, dept_name
from instructor
;


/* create view that lists all the courses offered by the 
phyics department in the fall 2009 with the building and 
room number */
create view physics_fall_2009 as 
select course.course_id, sec_id, building, room_number
from course, section
where course.course_id = section.course_id
and course.dept_name = 'Physics'
and section.semester = 'Fall'
and section.year = 2009
;


/*
* 4.2.2 Using Views in SQL Queries 
---------------------------------*/

select course_id
from physics_fall_2009
where building = 'Watson'
;

/* specifiying the attribute names of a view explicitly */
create view department_total_salary(dept_name, total_salary) as 
select dept_name, sum(salary)
from instructor
group by dept_name
;

/*using one view in the definition of annother */
create view physics_fall_2009_watson as 
select course_id, room_number
from physics_fall_2009
where building = 'Watson'
;

/*
this is equivalent to */
create view physics_fall_2009_watson as 
(select course_id, room_number
from 
(select course.course_id, building, room_number
from course, section
where course.course_id = section.course_id
and course.dept_name = 'Physics' 
and section.semester = 'Fall'
and section.year = 2009
)
where building = 'Watson'
)
;

create view instructor_info as 
select ID, name, building 
from instructor, department
where instructor.dept_name = department.dept_name
;

/*
* 4.2.3 Materialized Views 
--------------------------*/
/* 
  Marerialized views: views stored in the database, but garanteed 
to be updated by database system when the actual relations used in 
the defintion of the view are changed.
The process of keeping materialized views up to date is called 
materialized view maintainance

*/


/*
* 4.3 Transactions 
******************/
/* a transaction consists of a sequence of query and / or 
update statments */

/*
* 4.4 Integrity constraints:
***************************/


/*
* 4.5 SQL DAta Types
-------------------*/

/*
* 4.5.1) Date and time types 
---------------------------
-> date '2001-04-25'
-> time '09:30:00'
-> timestamp '2001-04-25 10:29:01.45'

*/

insert into student(ID, name, dept_name)
values 
('12789', 'Newman','Comp.Sci.')
;

-- delete from student 
-- where name = 'Newman'
-- 
-- ;
-- 
-- select*
-- from student

/*
* 4.5.3 Index Creation
--------------------*/

/* create index on student name */
-- alter table student add index studentName_index using BTREE (name);
select dept_name
from student 
where ID = '12789'
;

 /*
 * 4.5.5 User defined Types 
 -------------------------*/
 






























































































