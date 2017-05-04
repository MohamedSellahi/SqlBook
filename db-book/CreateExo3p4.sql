
/* person */
create table person(
driver_id varchar(8),
name varchar(15),
address varchar(30),
primary key (driver_id)
)engine = InnoDB
;

/* car */
create table car(
license varchar(8),
model varchar(10),
year numeric(4,0),
primary key (license)
)engine = InnoDB
;

/* accident */
create table accident(
report_number numeric(8,0),
acc_date numeric (4,0),
location varchar(30),
primary key (report_number)
)engine = InnoDB
;

/* owns */
create table owns(
driver_id varchar(8),
license varchar(8),
primary key (driver_id, license),
foreign key (driver_id) references person(driver_id),
foreign key (license) references car(license)
)engine = InnoDB
;

create table participated(
report_number numeric(8,0),
license varchar(8),
driver_id varchar(8),
damage_ammount numeric(8,2),
primary key (report_number,license),
foreign key (license) references car(license),
foreign key (driver_id) references person(driver_id)

)engine = InnoDB
;
