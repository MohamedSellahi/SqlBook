/* Departement ralation */
select * from department;

/* Classroom */
select * from classroom;

/* instructor relation */
select * from instructor;

/* teaches relation */
select * from teaches;

/* courses */
select * from course;

/* section relation */
select * from section;


/* prereq */
select * from prereq;

/* basic Query operation */

/* find the names of all instructors */
select instructor.name, instructor.dept_name
from instructor
;

/* frind department name of all instructors */
select instructor.dept_name
from instructor
;

/* the above query is equivalent to 
select all dept_name 
from instructor
;

*/
/* discard repeated dept-names */
select distinct dept_name
from instructor
;

/* simple operation in queries */
select ID, name, dept_name, salary*1.1 as 'new salary'
from instructor
;

/* find the names of instructos, in the computer science 
department, with salary more than 70000 */
select name
from instructor
where dept_name = "Comp.Sci." and salary > 70000
;

/*
* 3.3.2 Queries on multiple relations 
**************************************/

/*Retrieve the names of all instructors along with their 
department names and buildings 
*/
select instructor.name, instructor.dept_name, department.building
from instructor, department
where instructor.dept_name = department.dept_name
;

/* cartesian product of instructor relation and teachs relation */
select instructor.ID, name, instructor.dept_name, instructor.salary,
	   teaches.ID, teaches.course_id, teaches.sec_id, teaches.semester, teaches.year
from instructor, teaches
; 

/* a more meaningfull query */
/* this is an 'outer join ' operation */
select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID
; 

/* cinstructor names and course ids in the Computer sci department */
select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID and instructor.dept_name = "Comp.Sci."
;

/*
* 3.3.3 The natural join 
**************************************/
select name, course_id 
from instructor, teaches
where instructor.ID = teaches.ID
;

/* using the natural join */
select name, course_id
from instructor natural join teaches
;

/* getting all the information about teachers who gives somes
courses */
select*
from instructor natural join teaches
;

/* List names of instructors along with titles of 
corses thet teach */
select name, title
from instructor natural join teaches, course
where teaches.course_id = course.course_id
;

/*compare with this query */
/* this query will give the same results as the previous one
while omitting the all (instructor name, course title) where 
the instructor teaches a course in a department other than 
his own department*/
select name, title
from instructor natural join teaches natural join course
;

/*using joins while specifying exactly the columns that 
should be equated */
select name, title
from (instructor natural join teaches) join course using(course_id)
;

/*
* 3.4.1 the rename operation : p74
****************************/
select name as instructor_name, course_id
from instructor, teaches 
where instructor.ID = teaches.ID
;
/* T and S are called correlation names 
or table alias, correlation variable, tuple variable */
select T.name, S.course_id
from instructor as T, teaches as S
where T.ID = S.ID
;

/* find all instructors whose salary is greater than 
at least one instructor in the biology department */
select distinct T.name, T.salary
from instructor as T, instructor as S
where T.salary > S.salary and S.dept_name = 'Biology'
;

/*
* 3.4.2 String operations : p76
*******************************/

/* pattern matching 
escape character can be specified using the escape keyword 
'ab\%cd%' escape '\' matches any string beginning with ab%cd
*/
select dept_name 
from department
where building like '%Watson%'
;

/*
* 3.4.4 ordering the display of tuples 
*/

/* list in alphabetical order instructors 
of the physics department */
select name
from instructor
where instructor.dept_name = 'Physics'
order by name desc
;

/* list entire instructor relation in descending order 
of salary. if several instructors have the same salary,
order them in ascending order by name */
select*
from instructor
order by salary desc, name asc
;

/*
* 3.4.5 where clause predicates
*/

/* instructors with salaries between 90000 10000 included */
select name, salary
from instructor
where salary between 90000 and 100000
;

select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID and instructor.dept_name = 'Biology'
;

/* which is equivalent to */
select name, course_id 
from instructor, teaches
where (instructor.ID, dept_name) = (teaches.ID, 'Biology')
;


/*
* 3.5 Set Operations
********************/
/* the set of all courses taught an fall 2009 */
select course_id as c1
from section
where semester = 'Fall' and year = 2009
;

/* the set of all courses taght in spring 2010 */
select course_id as c2
from section 
where semester = 'Spring' and year = 2010
;

/*
* 3.5.1 Union operation 
***********************/
/* the union operation: this illiminates duplicates */
(select course_id 
from section
where semester = 'Fall' and year = 2009)
union
(select course_id as c2
from section 
where semester = 'Spring' and year = 2010)
;

/* to keep duplicates */

(select course_id 
from section
where semester = 'Fall' and year = 2009)
union all
(select course_id as c2
from section 
where semester = 'Spring' and year = 2010)
;

/*
* 3.5.2 the intersect operation
*******************************/
/* not available in MySQL*/
select distinct T.course_id
from section as T, section as S
where T.semester = 'Fall' and T.year = 2009
  and S.semester = 'Spring' and S.year = 2010 
  and T.course_id = S.course_id
;

/*
* 3.5.3 the except operation
*******************************/
select course_id
from section 
where semester = 'fall' and year = 2009 
and course_id not in 
(select course_id
from section
where semester = 'Spring' and year = 2010)
;
/*
* 3.6 Null Values 
*****************/

/*
* 3.7 Aggregate functions 
*************************/

/* find the average salary of instructors in the
Computer science department */
select avg(salary) as avg_salary
from instructor
where dept_name = 'Comp.Sci.'
;

/* find the total number of instructors who teach in 
a course in the spring 2010 semester */
select count(distinct ID)
from teaches
where semester = 'Spring' and year = 2010
;
/* counting tuples in a relation */
select count(*)
from course
;










































