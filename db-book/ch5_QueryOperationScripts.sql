/******************************************************
********************** Chapter 5 ********************** 
*******************************************************/
select 
    count(*)
from
    instructor
where
    dept_name = 'Physics'
;
/**/

DROP function IF EXISTS dept_count;
DELIMITER // 
CREATE DEFINER=root@localhost FUNCTION dept_count(dept_name varchar(20)) RETURNS int
BEGIN
declare d_count int;
select count(*) into d_count
from instructor
where instructor.dept_name = dept_name;

RETURN d_count;
END//
DELIMITER ;

/* using the function */
select dept_count('Physics')
;

/* function that ereturns a table */
/* in my sql, only procedure can return tables */
/*{STRING|INTEGER|REAL|DECIMAL}*/


DROP procedure IF EXISTS `instructors_of`;

DELIMITER $$
CREATE PROCEDURE `instructors_of` (in dept_name varchar(15))
BEGIN
select* from instructor 
where instructor.dept_name = dept_name;
END$$
DELIMITER ;

/* Use procedure */
Call instructors_of('Physics');

/* use function in query */
select 
    dept_name, budget
from
    department
where
    dept_count(dept_name) < 2
;

/*dept-count as a procedure */

drop procedure if exists dept_count_proc; 
delimiter $$
create procedure dept_count_proc(in dept_name varchar(20), out d_count int) 
begin
select count(*) into d_count
from instructor 
where instructor.dept_name = dept_name;
end$$
delimiter ;

/* call the procedure*/

set @d_count = 0;
call db_book.dept_count_proc('physics', @d_count);
select @d_count;



DROP procedure IF EXISTS `instructors_of_proc`;

DELIMITER $$
CREATE PROCEDURE `instructors_of_proc` (in dept_name varchar(15), out d_count int)
BEGIN
select count(*) into d_count
from instructor
where instructor.dept_name = dept_name;

select*
from instructor 
where instructor.dept_name = dept_name;
END$$
DELIMITER ;

set @val = 0;
call db_book.instructors_of_proc('physics', @val);
select @val;













































