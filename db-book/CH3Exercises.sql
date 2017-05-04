/************************************************************************************
*******************************       EXO 3.1       *********************************
*************************************************************************************/
-- a) find the titles of the courses in the COMP.Sci 
--    department that have 3 cedits 

select title
from course
where dept_name = 'Comp. Sci.' and credits = 3
;

/* b) Find the IDs of all students who were taught by an instructor
* named Einstein; make sure there are no duplicates in the result */
select *
from takes natural join student  				-- get all the courses taken by each student
where course_id in (select course_id			-- keep those that have taken at list one course taught by Einstein
					from teaches natural join instructor
                    where teaches.ID = instructor.ID and 
                          instructor.name = 'Einstein'                          
                    )
;

select TS.name, TI.name
from takes natural join student as TS, teaches natural join instructor as TI
where takes.course_id = teaches.course_id and
      TI.name = 'Einstein'
      ;

select TS.name, TI.name
from takes natural join student as TS, teaches natural join instructor as TI
where takes.course_id = teaches.course_id and
      TI.name = 'Einstein'
      ;
      
select student.name, instructor.name
from student, takes, instructor, teaches
where teaches.course_id = takes.course_id and
	  teaches.ID = instructor.ID and
      student.ID = takes.ID and 
      instructor.name = 'Einstein'
      ;

select distinct student.ID, student.name
from (student join takes using(ID) join 
     (instructor join teaches using(ID)) using (course_id,sec_id,semester,year))
     where instructor.name = 'Einstein'
;

/*
* b) Find the highest salary of any instructor */
select max(salary)
from instructor
;
/*
* c) Find all instructors ezarning the highest salary */
select name
from instructor
where salary = (select max(salary) from instructor )
;

/*
* e) find the enrollement of each section that was offered in Autumn 2009 */

-- sol1: takes the join of section and takes, 
-- group by sec_id and course_id, then count ids 
select sec_id, course_id, count(ID)
from section natural join takes 
where semester = 'Fall' and year = 2009
group by sec_id, course_id
order by sec_id asc, course_id asc
;

-- sol2: generate table of course_id and sec_id
-- for each tuple in this table, compute number of students 
-- in a subquery

select course_id, sec_id, (select count(ID)
							from takes
                            where takes.semester = section.semester
							   and takes.year = section.year
                               and takes.course_id = section.course_id
                               ) as studentCount
from section
where year = 2009 and semester = 'Fall'
;
                               
/*
* f) find the maximum enrollement accress all sections 
     in autumn 2009 */
select max(ID_count)
from(select course_id, count(ID) as ID_count
     from section natural join takes
     where semester = 'Fall' and year = 2009
     group by course_id, sec_id) as TAB
     ;

/************************************************************************************
*******************************       EXO 3.2       *********************************
*************************************************************************************/
/* a) dislpay course taken by student ID=12345 and corresponding 
      grade and credits obtained */
select ID, takes.course_id, credits, grade_points.grade, 
          grade_points.points, points * credits as totGrade
from takes natural join course, grade_points
where ID = '12345'
and takes.grade = grade_points.grade
;


(select sum(credits*points)
from (takes natural join course) natural join grade_points
where ID = '12345'
)
union
(select 0
from student 
where student.ID = '12345' and not exists(select*from takes where takes.ID = '12345') 
)
;

-- book
select sum(credits*points)
from (takes natural join course) natural join grade_points
where ID = '12345'
;




/*
* b) find the average grade-point average (GPA) for the abouve student 
*    that is the total grade points devided by the total crédits for 
*    the associated courses 
*/

select takes.course_id, course.credits,
       grade_points.points, points * credits as totGrade
       
from takes natural join course , grade_points
where ID = '12345'
and takes.grade = grade_points.grade
;

-- Sol 1
select sum(credits)  as totCredit, sum(totGrade) as totGrades, sum(totGrade)/sum(credits)
from (select ID, takes.course_id, course.credits,
				grade_points.points, points * credits as totGrade
       
				from takes natural join course , grade_points
				where takes.grade = grade_points.grade 
                
                ) as OneStudent
where OneStudent.ID = '12345'
;

-- Sol 2
select sum(credits * points)/sum(credits) as GPA
from (takes natural join course) natural join grade_points
where ID = '12345'
;

/*
* c) find the average grade-point average (GPA) for all student 
*    that is the total grade points devided by the total crédits for 
*    the associated courses 
*/
select ID, sum(credits)  as totCredit, sum(totGrade) as totGrades ,
       sum(totGrade)/nullif(sum(credits),0) as GPA
from (select ID, takes.course_id, course.credits,
				grade_points.points, points * credits as totGrade
       
				from takes natural join course , grade_points
				where takes.grade = grade_points.grade 
                
                ) as OneStudent
group by ID
;

select ID, sum(credits * points)/nullif(sum(credits),0) as GPA
from (takes natural join course) natural join grade_points
group by ID
;

/************************************************************************************
*******************************       EXO 3.3       *********************************
*************************************************************************************/

/* a) Increase the salary of each instructor in the Comp. Sci.
      department by 10% */
update instructor
set salary = salary*1.1
where dept_name = 'Comp. Sci.'
;

/* a) delete all courses that have not been offered */
delete from course
where course_id not in (select course_id
                        from section)
;

/* Insert every student whose tot credit is greater than 100 
as an instructor in the same department with a salary of 10,000*/
insert into instructor
 (select ID, name, dept_name , 10000
        from student
        where tot_cred > 100)
;

/************************************************************************************
*******************************       EXO 3.4       *********************************
*************************************************************************************/

/*
* a) find the total number of people owned cars that were
* onvolved in accident in 2009 
*/
select sum(distinct driver_id)
from (owns natural join participated) natural join accident
where accident.acc_date = 2009
;

/*
select count(distinct name)
from person, participated, accident
where accident.report_number = participated.report_number 
and participated.driver_id = person.driver_id
and acc_date between date'1989-01-00' and date'1989-12-31'
;

*/

/*
* a) Add new accodent to database 
*********************************/
insert into accident
values
(1111, 2010,'some where in montpellier')
;

insert into participated
select 1111, c.license, o.driver_id, 3000
from person p, owns o, car c
where p.name = 'John' 
  and p.driver_id = o.driver_id
  and o.license = c.license
  and c.model = 'Toyota'

;
/*
* c) Delete the Mazda bellonging to John Smith */
-- delete the relation John Smith owns ---> 
delete from owns
where driver_id = (select driver_id from person where name = 'John Smith')
  and 'Mazda' in (select model from car where model = 'Mazda')
;

-- book

delete from car
where model = 'Mazda'
  and license in (select license 
				  from person p, owns o
                  where p.name = 'John' and p.driver_id = o.driver_id
                  )
;

 



        





































