/*************************************************
******************** EXO 1 ***********************
**************************************************/
select*
from teaches
;

-- 4.1
-- a )
select instructor.ID, name, count(distinct sec_id) as NB
from instructor left outer join teaches on instructor.ID = teaches.ID
group by instructor.ID
;

select instructor.ID,name, count(distinct sec_id) as Nsection
from instructor left outer join teaches on instructor.ID = teaches.ID
group by ID, name
;

-- b) using a scalar subquery 
select ID, name, (select count(distinct sec_id)
                  from teaches as T
                  where I.ID = T.ID) as NB
from instructor as I
;

select ID, name, (select count(distinct sec_id)
                  from teaches as T
                  where I.ID = T.ID) as NB
from instructor as I
;


select I.ID, name, count(distinct T.sec_id) as NB
from instructor as I, teaches as T
where I.ID = T.ID
group by I.ID, name
union 
select I.ID, name, 0
from instructor as I, teaches as T
where I.ID not in (select ID from teaches)
group by I.ID, name
;

-- c) 
select course_id, sec_id, instructor.ID, instructor.name
from (section left outer join teaches using(course_id, sec_id, semester, year))
join instructor using(ID)
where semester = 'Spring' and year = 2010
; 

select course_id, sec_id, instructor.ID, instructor.name
from (section natural left outer join teaches )
join instructor using(ID)
where semester = 'Spring' and year = 2010
; 

select course_id, sec_id, ID, (select case 
								  when name is null then name = '-'
                                  when name is not null then name
                                  end
						  ) as isntructorName
from(section natural left outer join teaches) natural left outer join instructor
where semester = 'Spring' and year = 2010
;

-- d) 

select dept_name, count(ID) as NumberOfInstructors
from department natural left outer join instructor
group by dept_name
;

select dept_name, count(ID) as NumberOfInstructors
from department left outer join instructor using (dept_name)
group by dept_name
;


/*************************************************
******************** EXO 2 ***********************
**************************************************/
/*
* 4.2 ) 
*/
-- a) 
select*
from student natural left outer join takes
order by student.name
;


select S.ID, S.name, S.dept_name, S.tot_credit, T.course_id, T.sec_id, T.semester, T.year, T.grade
from student as S, takes as T 
where S.ID = T.ID
union 
select S.ID, S.name, S.dept_name, S.tot_credit, null, null, null, null, null 
from student as S
where not exists (select T.ID from takes as T where S.ID = T.ID)
;

-- b) 
select*
from student left outer join takes on student.ID = takes.ID
union all
select*
from student right outer join takes on student.ID = takes.ID
;

select*
from student left outer join takes on student.ID = takes.ID
union 
select*
from student right outer join takes on student.ID = takes.ID
;

-- Emulation 

select S.ID, S.name, S.dept_name, S.tot_credit,S.ID, T.course_id, T.sec_id, T.semester, T.year, T.grade
from student as S, takes as T 
where S.ID = T.ID
union 
select S.ID, S.name, S.dept_name, S.tot_credit, S.ID,null, null, null, null, null 
from student as S
where not exists (select T.ID from takes as T where S.ID = T.ID)
union 
select S.ID, null, null, null, S.ID, T.course_id, T.sec_id, T.semester, T.year, T.grade
from takes as T, student as S
where T.course_id not in (select course_id
                          from student natural join takes)
;

select S.ID, S.name, S.dept_name, S.tot_credit,S.ID, T.course_id, T.sec_id, T.semester, T.year, T.grade
from student as S, takes as T 
where S.ID = T.ID
union 
select S.ID, S.name, S.dept_name, S.tot_credit, S.ID,null, null, null, null, null 
from student as S
where not exists (select T.ID from takes as T where S.ID = T.ID)
union 
select ID, null, null, null, ID, T.course_id, T.sec_id, T.semester, T.year, T.grade
from takes as T
where not exists (select ID from student where T.ID = student.ID)
;



/*************************************************
******************** EXO 3 ***********************
**************************************************/








































































