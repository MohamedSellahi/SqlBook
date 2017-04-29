/* Departement ralation */
select * from department;

/* Classroom */
select * from classroom;

/* instructor relation */
select * from instructor;

/* section relation */
select * from section;

/* teaches relation */
select * from teaches;

/* courses */
select * from course;

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


