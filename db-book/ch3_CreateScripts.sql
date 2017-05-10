/* create */
CREATE TABLE department (
    dept_name VARCHAR(20) NOT NULL,
    building VARCHAR(15),
    budget NUMERIC(12 , 2 ) not null check(budget > 0),
    CONSTRAINT pk_department PRIMARY KEY (dept_name)
)ENGINE=INNODB;


/* course table */
CREATE TABLE course (
    course_id VARCHAR(8) NOT NULL,
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credit NUMERIC(2 , 0 ) check(credits > 0),
    PRIMARY KEY (course_id),
    CONSTRAINT fk_course_department FOREIGN KEY(dept_name)
    REFERENCES department(dept_name)
    on  delete cascade
    on update cascade
)ENGINE=INNODB;

/* instructor table */
CREATE TABLE instructor (
    ID VARCHAR(15),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(10 , 2 ) check(salary > 29000),
    PRIMARY KEY (ID),
    constraint fk_instructor_department FOREIGN KEY (dept_name)
        REFERENCES department(dept_name)
)ENGINE=INNODB;


/* student */
CREATE TABLE student (
    ID VARCHAR(15),
    name VARCHAR(20),
    dept_name VARCHAR(20),
    tot_credit NUMERIC(3 , 0 ),
    PRIMARY KEY (ID),
    CONSTRAINT fk_student_department FOREIGN KEY (dept_name)
        REFERENCES department (dept_name)
);


/* Adviser */
create table advisor
(
student_id VARCHAR(15),
instructor_id VARCHAR(15),
primary key (student_id),

constraint fk_adviser_student foreign key (student_id) references student(ID),
constraint fk_adviser_instructor foreign key (instructor_id) references instructor(ID)
);



/* classroom */
create table classroom
(
building VARCHAR(15),
room_number VARCHAR(7),
capacity decimal(3),
primary key (building, room_number)
)ENGINE=InnoDB;

/* section */
CREATE TABLE section (
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6) check(semester in ('Fall','Winter','Spring','Summer')),
    year NUMERIC(4 , 0 ) check(year between 1759 and 2100),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    
    PRIMARY KEY (course_id , sec_id , semester , year),
     CONSTRAINT fk_section_course FOREIGN KEY (course_id)
         REFERENCES course (course_id),
     CONSTRAINT fk_section_classroom_building FOREIGN KEY (building, room_number)
         REFERENCES classroom (building, room_number)
)  ENGINE=INNODB;

/* teaches */
CREATE TABLE teaches (
    ID VARCHAR(15),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4 , 0 ),
    PRIMARY KEY (ID , course_id , sec_id , semester , year),
    FOREIGN KEY (course_id)
        REFERENCES course(course_id)
	-- constraint fk_teach_instructor foreign key (ID) references 
    -- instructor(ID)
)ENGINE=INNODB; 

/* preq relation */
CREATE TABLE prereq (
    course_id VARCHAR(8) NOT NULL,
    prereq_id VARCHAR(8) NOT NULL,
    PRIMARY KEY (course_id , prereq_id),
    CONSTRAINT fk_prereq_course FOREIGN KEY (course_id)
        REFERENCES course (course_id),
    CONSTRAINT fk_prereq_prereq FOREIGN KEY (prereq_id)
        REFERENCES course (course_id)
) ENGINE=INNODB;



/* takes table */
create table takes
(
ID varchar(15),
course_id varchar(8),
sec_id varchar(8),
semester varchar(6),
year numeric(4,0),

grade varchar(2),

primary key (ID,course_id,sec_id,semester,year),
constraint fk_takes_section foreign key (course_id , sec_id , semester , year) references
section(course_id,sec_id,semester,year)

)Engine = InnoDB;

/* grades */
create table grade_points(
grade varchar(2), 
points numeric(2,1)
)engine = InnoDB;





















