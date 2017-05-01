adviser#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: course
#------------------------------------------------------------

CREATE TABLE course(
        course_id Varchar (8) NOT NULL ,
        PRIMARY KEY (course_id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: prereq
#------------------------------------------------------------

CREATE TABLE prereq(
        course_id   Varchar (8) NOT NULL ,
        course_id_1 Varchar (8) NOT NULL ,
        PRIMARY KEY (course_id ,course_id_1 )
)ENGINE=InnoDB;

ALTER TABLE prereq ADD CONSTRAINT FK_prereq_course_id FOREIGN KEY (course_id) REFERENCES course(course_id);
ALTER TABLE prereq ADD CONSTRAINT FK_prereq_course_id_1 FOREIGN KEY (course_id_1) REFERENCES course(course_id);
