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
*  4.2.1) View definition 
*************************/

create view faculty as 
select ID, name, dept_name
from instructor
;

create view physics_fall_2009 as 
select course.course_id, sec_id, building, room_number
from course, section
where course.course_id = section.course_id
  and section.semester = 'Fall'
  and section.year = 2009
;

/*
* 4.2.2) Using view in Sql Queries 
**********************************/
select course_id
from physics_fall_2009
where building = 'Watson'
;

create view department_total_salary(dept_name, total_salar) as 
select dept_name, sum(salary)
from instructor
group by dept_name
;



/*
* 4.4) Integrity constraints 
****************************/
/*
* 4.4.1 Constraints on a single relation
-> not null
-> unique
-> check

*/

/*
* 4.4.5) Referential integrity 
*/
/*
exemple:
create table course(
...
foreign key (dept_name) references department
on delete cascade {[set null], [set default]}
on update cascade
...
)

-- 'on delete' clause means : if a delete of a tuple in department relation
results in this referential-integrity veing violated, the system doesn't reject 
the query, instead, "cascades" to the course relation, deleting the tuple 
that references the department

*/

/*
* 4.4.6 Integrity constraint violtion during transaction
-------------------------------------------------------*/
/* use of 'initially deferred' on constraint: 
the coinstraint would be checked at the end of a transaction
 */

/*
* 4.4.7 Complex Check Conditions and Assertions 
----------------------------------------------*/

/*
* 4.5 SQL data Types and Schemas
********************************/
/* 
* 4.5.1) Date and Time Type 
-------------------------*/
-- date : a calander containing four digit year, day month 
/*

date '2001-04-25'
time '09:30:00'
timestamp '2001-04-25 10:29:01.45'

*/ 































































