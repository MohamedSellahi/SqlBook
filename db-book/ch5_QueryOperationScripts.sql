/******************************************************
********************** Chapter 5 ********************** 
*******************************************************/
/*
* 5.2.1 Declaring and invocking functions and Procedures
------------------------------------------------------*/
/* given the name of department, count the number of instructors
in that department 
*/
select count(*)
from instructor 
where dept_name = 'Physics'
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

/* */





































