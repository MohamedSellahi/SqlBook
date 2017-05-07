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








