/* create */
CREATE TABLE department (
    dept_name VARCHAR(20) NOT NULL,
    building VARCHAR(15),
    budget NUMERIC(12 , 2 ),
    CONSTRAINT pk_department PRIMARY KEY (dept_name)
)ENGINE=InnoDB;


/* course table */
CREATE TABLE course (
    course_id VARCHAR(8) not null,
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credit NUMERIC(2 , 0 ),
    PRIMARY KEY (course_id), 
    foreign key (dept_name) references department(dept_name)
)ENGINE=InnoDB;

/* instructor table */
CREATE TABLE instructor (
    ID VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(8 , 2 ),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name)
        REFERENCES department(dept_name)
)ENGINE=InnoDB;

/* section */
CREATE TABLE section (
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4 , 0 ),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY (course_id , sec_id , semester , year),
    FOREIGN KEY (course_id)
        REFERENCES course(course_id)
)ENGINE=InnoDB;

/* teaches */
CREATE TABLE teaches (
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4 , 0 ),
    PRIMARY KEY (ID , course_id , sec_id , semester , year),
    FOREIGN KEY (course_id)
        REFERENCES course(course_id)
)ENGINE=InnoDB; 

/* preq relation */
CREATE TABLE prereq (
    course_id VARCHAR(8) NOT NULL,
    prereq_id VARCHAR(8) NOT NULL,
    PRIMARY KEY (course_id , prereq_id),
    CONSTRAINT fk_prereq_course FOREIGN KEY (course_id)
        REFERENCES course (course_id),
    CONSTRAINT fk_prereq_prereq FOREIGN KEY (prereq_id)
        REFERENCES course (course_id)
)  ENGINE=INNODB;





/* setting up constraints */

-- 
-- 


















