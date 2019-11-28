DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;

CREATE TYPE gender_type AS ENUM ('male', 'female');
CREATE TYPE staff_position_type AS ENUM('doctor', 'administrator', 'nurse', 'security', 'IT_administrator');
CREATE TYPE notification_status_type AS ENUM('open', 'closed');
CREATE TYPE ticket_status_type AS ENUM('open', 'closed');

-- auth
CREATE SEQUENCE IF NOT EXISTS auth_seq;

CREATE TABLE IF NOT EXISTS auth(
  id int DEFAULT NEXTVAL ('auth_seq'),
  login varchar(255) UNIQUE,
  password1 varchar(20),
  name varchar(20),
  PRIMARY KEY (id)
);


-- passport
CREATE TABLE IF NOT EXISTS passport (
  seria int check (seria > 0),
  number int check (number > 0),
  birth timestamp(0),
  f_name varchar(50),
  l_name varchar(50),
  gender gender_type,
  address varchar(100),
  PRIMARY KEY (seria, number)
);

-- staff
CREATE SEQUENCE IF NOT EXISTS staff_seq;

CREATE TABLE IF NOT EXISTS staff(
  id int DEFAULT NEXTVAL ('staff_seq'),
  first_name varchar(20),
  last_name varchar(20),
  room int,
  auth_id int,
  birthday date,
  position staff_position_type,
  gender gender_type,
  FOREIGN KEY (auth_id) REFERENCES auth(id),
  PRIMARY KEY (id)
);

-- camera
CREATE SEQUENCE IF NOT EXISTS camera_seq;

CREATE TABLE IF NOT EXISTS camera (
  id int DEFAULT NEXTVAL ('camera_seq'),
  name varchar(200),
  LOCATION POINT,
  staff_id INT,
  FOREIGN KEY (staff_id) REFERENCES staff(id),
  PRIMARY key (id)
);

-- patient
CREATE SEQUENCE IF NOT EXISTS patient_seq;

CREATE TABLE IF NOT EXISTS patient (
  id int DEFAULT NEXTVAL ('patient_seq'),
  bank_account_id int,
  auth_id int,
  phone_num VARCHAR(30),
  insurance_policy_id int,
  passport_seria int check (passport_seria > 0),
  passport_number int check (passport_number > 0),
  FOREIGN KEY (
    passport_seria,
    passport_number
  ) REFERENCES passport(seria, number),
  FOREIGN KEY (auth_id) REFERENCES auth(id),
  PRIMARY KEY (id)
);

-- complain
CREATE SEQUENCE IF NOT EXISTS complain_seq;

CREATE TABLE IF NOT EXISTS complain (
  id int DEFAULT NEXTVAL ('complain_seq'),
  theme varchar(50),
  creation_date timestamp(0),
  complain_text varchar(255),
  PRIMARY KEY (id)
);

-- ticket
CREATE SEQUENCE IF NOT EXISTS ticket_seq;

CREATE TABLE IF NOT EXISTS ticket (
  id int DEFAULT NEXTVAL ('ticket_seq'),
  ticket_text varchar(255),
  creation_date timestamp(0),
  closing_date timestamp(0),
  PRIMARY KEY (id)
);

-- notification
CREATE SEQUENCE IF NOT EXISTS notification_seq;

CREATE TABLE IF NOT EXISTS notification (
  id int DEFAULT NEXTVAL ('notification_seq'),
  notification_text varchar(255),
  notification_status notification_status_type,
  PRIMARY KEY (id)
);

-- invoice
CREATE SEQUENCE IF NOT EXISTS invoice_seq;

CREATE TABLE IF NOT EXISTS invoice(
  id int DEFAULT NEXTVAL ('invoice_seq'),
  amount int check (amount > 0),
  date_of_creation timestamp(0),
  reason varchar(255),
  PRIMARY KEY (id)
);

-- appointment
CREATE SEQUENCE IF NOT EXISTS appointment_seq;

CREATE TABLE IF NOT EXISTS appointment(
  id int DEFAULT NEXTVAL ('appointment_seq'),
  occurrence_date timestamp(0),
  diagnosis varchar(255),
  description varchar(255),
  reason_to_create varchar(255),
  PRIMARY KEY (id)
);

-- appointment_patient_doctor_relation
CREATE SEQUENCE IF NOT EXISTS appointment_patient_doctor_relation_seq;

CREATE TABLE IF NOT EXISTS appointment_patient_doctor_relation (
  id int DEFAULT NEXTVAL ('appointment_patient_doctor_relation_seq'),
  appointment_id int,
  patient_id int,
  doctor_id int,
  FOREIGN KEY (appointment_id) REFERENCES appointment(id),
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  FOREIGN KEY (doctor_id) REFERENCES staff(id),
  PRIMARY KEY (id)
);

-- patient_ticket_relation
CREATE SEQUENCE IF NOT EXISTS patient_ticket_relation_seq;

CREATE TABLE IF NOT EXISTS patient_ticket_relation(
  id int DEFAULT NEXTVAL ('patient_ticket_relation_seq'),
  patient_id int,
  ticket_id int,
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  FOREIGN KEY (ticket_id) REFERENCES ticket(id),
  PRIMARY KEY (id)
);

-- staff_ticket_relation
CREATE SEQUENCE IF NOT EXISTS staff_ticket_relation_seq;

CREATE TABLE staff_ticket_relation(
  id int DEFAULT NEXTVAL ('staff_ticket_relation_seq'),
  staff_id int,
  ticket_id int,
  ticket_status ticket_status_type,
  FOREIGN KEY (staff_id) REFERENCES staff(id),
  FOREIGN KEY (ticket_id) REFERENCES ticket(id),
  PRIMARY KEY (id)
);

-- notification_staff_relation
CREATE SEQUENCE IF NOT EXISTS notification_staff_relation_seq;

CREATE TABLE notification_staff_relation(
  id int DEFAULT NEXTVAL ('notification_staff_relation_seq'),
  notification_id int,
  staff_id int,
  FOREIGN KEY (notification_id) REFERENCES notification(id),
  FOREIGN KEY (staff_id) REFERENCES staff(id),
  PRIMARY KEY (id)
);

-- notification_patient_relation
CREATE SEQUENCE IF NOT EXISTS notification_patient_relation_seq;

CREATE TABLE notification_patient_relation(
  id int DEFAULT NEXTVAL ('notification_patient_relation_seq'),
  notification_id int,
  patient_id int,
  FOREIGN KEY (notification_id) REFERENCES notification(id),
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  PRIMARY KEY (id)
);

-- patient_invoice_staff_relation
CREATE SEQUENCE patient_invoice_staff_relation_seq;

CREATE TABLE patient_invoice_staff_relation (
  id int DEFAULT NEXTVAL ('patient_invoice_staff_relation_seq'),
  staff_id int,
  patient_id int,
  invoice_id int,
  FOREIGN KEY (staff_id) REFERENCES staff(id),
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  FOREIGN KEY (invoice_id) REFERENCES invoice(id),
  PRIMARY KEY (id)
);

-- patient_complain_relation
CREATE SEQUENCE IF NOT EXISTS patient_complain_relation_seq;

CREATE TABLE patient_complain_relation(
  id int DEFAULT NEXTVAL ('patient_complain_relation_seq'),
  patient_id int,
  complain_id int,
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  FOREIGN KEY (complain_id) REFERENCES complain(id),
  PRIMARY KEY (id)
);

-- doctor_nurse_relation
CREATE SEQUENCE IF NOT EXISTS doctor_nurse_relation_seq;

CREATE TABLE IF NOT EXISTS doctor_nurse_relation (
  id int DEFAULT NEXTVAL ('doctor_nurse_relation_seq'),
  doctor_id int,
  nurse_id int,
  FOREIGN KEY (doctor_id) REFERENCES staff(id),
  FOREIGN KEY (nurse_id) REFERENCES staff(id),
  PRIMARY KEY (id)
);

-- generation
INSERT INTO auth (login, password1, name) VALUES ('floods1942@yahoo.com', 'GI0594WK16', 'Antonio') ;
INSERT INTO auth (login, password1, name) VALUES ('benzein1957@outlook.com', 'AK5403OG89', 'Leslie') ;
INSERT INTO auth (login, password1, name) VALUES ('scurry2011@outlook.com', 'SU5337SR68', 'Delta') ;
INSERT INTO auth (login, password1, name) VALUES ('newborns2039@gmail.com', 'RG3111JK86', 'Derick') ;
INSERT INTO auth (login, password1, name) VALUES ('bastion1973@outlook.com', 'IW5389VE86', 'Gaylord') ;
INSERT INTO auth (login, password1, name) VALUES ('dovetailed1915@yandex.com', 'JN8695KU41', 'Johnsie') ;
INSERT INTO auth (login, password1, name) VALUES ('aouad1979@gmail.com', 'PG5431JU14', 'Kiley') ;
INSERT INTO auth (login, password1, name) VALUES ('supersaturating2046@yandex.com', 'RP6202UL76', 'Reita') ;
INSERT INTO auth (login, password1, name) VALUES ('keyless2016@yahoo.com', 'ND4528LS60', 'Charles') ;
INSERT INTO auth (login, password1, name) VALUES ('denominate1817@gmail.com', 'QV8583JP86', 'Ethan') ;
INSERT INTO auth (login, password1, name) VALUES ('escobilla1845@gmail.com', 'HH8965UF50', 'Israel') ;
INSERT INTO auth (login, password1, name) VALUES ('burian2040@yahoo.com', 'PF1399JA84', 'Carry') ;
INSERT INTO auth (login, password1, name) VALUES ('ander2001@live.com', 'SB5744NU50', 'Shad') ;
INSERT INTO auth (login, password1, name) VALUES ('spacial1953@outlook.com', 'PZ2577PE61', 'Gaylene') ;
INSERT INTO auth (login, password1, name) VALUES ('clandestine1862@outlook.com', 'EF4507MO04', 'Teodora') ;
INSERT INTO auth (login, password1, name) VALUES ('weld1811@gmail.com', 'NV7230NR72', 'Bert') ;
INSERT INTO auth (login, password1, name) VALUES ('aromatised1909@live.com', 'YA3664NO05', 'Shona') ;
INSERT INTO auth (login, password1, name) VALUES ('amberoid2037@outlook.com', 'GH9427YE60', 'Luba') ;
INSERT INTO auth (login, password1, name) VALUES ('bugler1823@live.com', 'PW2239ZC00', 'Guy') ;
INSERT INTO auth (login, password1, name) VALUES ('protomartyr1944@live.com', 'ZI2261DH74', 'Nelson') ;
INSERT INTO auth (login, password1, name) VALUES ('eland1919@outlook.com', 'MD3655KY41', 'Eleni') ;
INSERT INTO auth (login, password1, name) VALUES ('conger2027@gmail.com', 'SW9253SK70', 'Jere') ;
INSERT INTO auth (login, password1, name) VALUES ('photographic1953@yandex.com', 'IN7423PH81', 'Veta') ;
INSERT INTO auth (login, password1, name) VALUES ('emond1996@gmail.com', 'LZ9178IN13', 'Neda') ;
INSERT INTO auth (login, password1, name) VALUES ('schematic1883@outlook.com', 'IG2690IW90', 'Lamont') ;
INSERT INTO auth (login, password1, name) VALUES ('didie1892@gmail.com', 'EZ4117NK25', 'Myles') ;
INSERT INTO auth (login, password1, name) VALUES ('nesty1919@yahoo.com', 'YZ9331VT04', 'Rachal') ;
INSERT INTO auth (login, password1, name) VALUES ('turnsoles1955@yandex.com', 'TJ4618WY13', 'Markita') ;
INSERT INTO auth (login, password1, name) VALUES ('banes1932@yahoo.com', 'IG3617JZ57', 'Marilu') ;
INSERT INTO auth (login, password1, name) VALUES ('ingots1827@gmail.com', 'CF1290CO05', 'Elvie') ;
INSERT INTO auth (login, password1, name) VALUES ('massekhoth2033@gmail.com', 'NP8029KQ66', 'Delsie') ;
INSERT INTO auth (login, password1, name) VALUES ('deepfreezed2047@yahoo.com', 'DA7029FZ69', 'Collin') ;
INSERT INTO auth (login, password1, name) VALUES ('aspersion2028@yahoo.com', 'XE0871WB00', 'Chad') ;
INSERT INTO auth (login, password1, name) VALUES ('petal1861@yandex.com', 'VM2670CI42', 'Winston') ;
INSERT INTO auth (login, password1, name) VALUES ('demimark1904@outlook.com', 'ZQ5241GW19', 'Gerald') ;
INSERT INTO auth (login, password1, name) VALUES ('parlay1856@outlook.com', 'KB2651YY46', 'Emmanuel') ;
INSERT INTO auth (login, password1, name) VALUES ('religiousness1811@yahoo.com', 'NZ8279NC57', 'Clinton') ;
INSERT INTO auth (login, password1, name) VALUES ('alleluia2017@yahoo.com', 'XD8197PN98', 'Gail') ;
INSERT INTO auth (login, password1, name) VALUES ('salaried1857@gmail.com', 'JQ5645JC15', 'France') ;
INSERT INTO auth (login, password1, name) VALUES ('jayhawker1909@yahoo.com', 'OW2338FR82', 'Martin') ;
INSERT INTO auth (login, password1, name) VALUES ('undertenancy1841@gmail.com', 'BI2665NU18', 'Yasuko') ;
INSERT INTO auth (login, password1, name) VALUES ('croteau1933@live.com', 'GJ6290RA76', 'Luciano') ;
INSERT INTO auth (login, password1, name) VALUES ('agitprop1922@gmail.com', 'FX6237QG49', 'Kanisha') ;
INSERT INTO auth (login, password1, name) VALUES ('bernadin1808@yahoo.com', 'IC5199FP62', 'Rory') ;
INSERT INTO auth (login, password1, name) VALUES ('aesthetic1809@yahoo.com', 'ZC2072LE78', 'Julius') ;
INSERT INTO auth (login, password1, name) VALUES ('nuanced1811@gmail.com', 'AI8736UW46', 'Pura') ;
INSERT INTO auth (login, password1, name) VALUES ('biplab1952@outlook.com', 'IV6385SN68', 'Wallace') ;
INSERT INTO auth (login, password1, name) VALUES ('acromegalies2018@outlook.com', 'CP8354SI99', 'Earlie') ;
INSERT INTO auth (login, password1, name) VALUES ('acoustic1881@live.com', 'FL8470YQ08', 'Keira') ;
INSERT INTO auth (login, password1, name) VALUES ('capturer1810@gmail.com', 'PX1022GK47', 'Al') ;
INSERT INTO auth (login, password1, name) VALUES ('cleancut1875@yahoo.com', 'CN6090IX55', 'Isidro') ;
INSERT INTO auth (login, password1, name) VALUES ('noncircularly2021@yandex.com', 'YD1527OW58', 'Dirk') ;
INSERT INTO auth (login, password1, name) VALUES ('expatriate1941@live.com', 'IP4765BN38', 'Alisia') ;
INSERT INTO auth (login, password1, name) VALUES ('dories2066@gmail.com', 'IZ6480WT52', 'Flo') ;
INSERT INTO auth (login, password1, name) VALUES ('agnail1809@yahoo.com', 'GS8034JR94', 'Carita') ;
INSERT INTO auth (login, password1, name) VALUES ('fidejussion2059@outlook.com', 'WV0744HS75', 'Lynwood') ;
INSERT INTO auth (login, password1, name) VALUES ('arming1809@gmail.com', 'LR0681VV71', 'Leopoldo') ;
INSERT INTO auth (login, password1, name) VALUES ('mediatorial1876@gmail.com', 'YC0460TJ44', 'Gerald') ;
INSERT INTO auth (login, password1, name) VALUES ('erastus2024@gmail.com', 'SL4669CS51', 'Tomiko') ;
INSERT INTO auth (login, password1, name) VALUES ('shivey1923@gmail.com', 'VZ7899EI57', 'Art') ;
INSERT INTO auth (login, password1, name) VALUES ('interleaver1981@yandex.com', 'MR7151WV97', 'Nenita') ;
INSERT INTO auth (login, password1, name) VALUES ('dendrobatinae1883@yahoo.com', 'ND4907DJ10', 'Octavio') ;
INSERT INTO auth (login, password1, name) VALUES ('abstain2018@yahoo.com', 'YU0512JD16', 'Man') ;
INSERT INTO auth (login, password1, name) VALUES ('battling2009@live.com', 'JD0652US41', 'Eric') ;
INSERT INTO auth (login, password1, name) VALUES ('coquelicot1935@gmail.com', 'TM5522QB37', 'Rubin') ;
INSERT INTO auth (login, password1, name) VALUES ('culinary1915@yahoo.com', 'SK8802GS46', 'Blossom') ;
INSERT INTO auth (login, password1, name) VALUES ('paludrin1965@gmail.com', 'RG7478CI04', 'Stanton') ;
INSERT INTO auth (login, password1, name) VALUES ('infest1806@outlook.com', 'KH4614WA81', 'Steven') ;
INSERT INTO auth (login, password1, name) VALUES ('moggie1949@yandex.com', 'RW0804CU15', 'Drusilla') ;
INSERT INTO auth (login, password1, name) VALUES ('anamorphose1897@live.com', 'SK9559JU21', 'Margy') ;
INSERT INTO auth (login, password1, name) VALUES ('daphna1983@gmail.com', 'IR9087MP79', 'Rosario') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Bronwyn', 'Sykes', 6, 71, '2007-02-15', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('enamels1878@live.com', 'MC3996MD30', 'Elvin') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Joey', 'Rivera', 97, 72, '1998-01-29', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('kingliest2006@live.com', 'EF1971EV85', 'Jonas') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Bernard', 'Burns', 36, 73, '1992-08-26', 'security', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('46835', '2020-10-04 11:59:07.921021', 'It is also a garbage-coll') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Ports are used to communi', '2000-11-19 16:44:17.080861', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('callery1873@yahoo.com', 'WH3367OT45', 'Willian') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Arnoldo', 'Ingram', 26, 74, '1983-11-18', 'security', 'female') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Danyell', '(100, 144)', 4) ;
INSERT INTO auth (login, password1, name) VALUES ('bergaptene1930@yandex.com', 'YY7868AE14', 'Latia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Sung', 'Baird', 75, 75, '1965-03-15', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('rotted1886@live.com', 'GE2798YZ78', 'Otelia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Emmaline', 'Mcfadden', 26, 76, '1955-04-25', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('unbetrothed1949@live.com', 'II1254ZF45', 'Ian') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jeannetta', 'Mcgowan', 65, 77, '1994-12-17', 'security', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('30871', '2020-05-04 16:29:55.790541', 'Any element of a tuple ca') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Erlang is known for its d', '2012-02-07 11:09:00.269785', 'Atoms can contain any cha') ;
INSERT INTO auth (login, password1, name) VALUES ('alger1953@outlook.com', 'XH2265RP24', 'Joline') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Cornelius', 'Simmons', 64, 78, '2016-02-03', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Joella', '(28, 112)', 8) ;
INSERT INTO auth (login, password1, name) VALUES ('index1979@live.com', 'SO4680VK68', 'Estell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rene', 'Cash', 68, 79, '1977-08-05', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('smokers1853@gmail.com', 'VT8239ZZ71', 'Lawerence') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jonah', 'Calhoun', 24, 80, '2009-01-24', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('tandoori2043@gmail.com', 'FK2424BW31', 'Terrell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kent', 'Middleton', 10, 81, '1963-08-23', 'doctor', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('5019', '2007-10-10 10:38:59.796594', 'Do you come here often? D') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('They are written as strin', '2017-06-17 16:19:00.434586', 'Erlang is a general-purpo') ;
INSERT INTO auth (login, password1, name) VALUES ('console1931@yandex.com', 'CY9789VK08', 'Deedee') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Cleotilde', 'Juarez', 95, 82, '1994-09-27', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Amal', '(122, 57)', 12) ;
INSERT INTO auth (login, password1, name) VALUES ('tuke1961@live.com', 'FC5096RM19', 'Gaston') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Amiee', 'Gaines', 52, 83, '1987-12-09', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('cherokee2059@gmail.com', 'CG3835BY47', 'Myles') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Phil', 'Ferrell', 32, 84, '2003-03-10', 'nurse', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('rhyolite1859@yahoo.com', 'KA3939RX07', 'Hyun') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lon', 'Dalton', 20, 85, '1966-05-10', 'nurse', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('18009', '2006-03-14 16:51:11.832040', 'Make me a sandwich. Tuple') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Atoms are used within a p', '2004-05-31 10:05:08.143431', 'Tuples are containers for') ;
INSERT INTO auth (login, password1, name) VALUES ('bottlefeed2045@outlook.com', 'LO3421HD04', 'Freddy') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Sammie', 'Williamson', 49, 86, '1966-08-04', 'security', 'female') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Leslie', '(92, 147)', 16) ;
INSERT INTO auth (login, password1, name) VALUES ('whale2034@outlook.com', 'OB2329ET92', 'Chi') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Allyn', 'Wright', 68, 87, '1957-12-09', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('emera1927@yahoo.com', 'JK3407VP13', 'Bobette') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Elene', 'Hester', 35, 88, '1954-08-27', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('torot2001@yandex.com', 'SX8438RM48', 'Louie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Maile', 'Rios', 35, 89, '1984-08-19', 'administrator', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('44677', '2010-04-15 15:51:04.816559', 'Atoms can contain any cha') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Erlang is a general-purpo', '2008-02-21 14:40:39.910544', 'Ports are created with th') ;
INSERT INTO auth (login, password1, name) VALUES ('exciton1827@yahoo.com', 'FV9846XJ03', 'Evia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tawna', 'Raymond', 81, 90, '1992-07-02', 'security', 'female') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Shaunta', '(16, 50)', 20) ;
INSERT INTO auth (login, password1, name) VALUES ('conniption2022@yandex.com', 'CY9691SR58', 'Beatris') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Hisako', 'Bass', 58, 91, '1997-02-19', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('sourbellies1928@live.com', 'RY8048JF79', 'Barton') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Shalanda', 'Morse', 74, 92, '1962-05-27', 'nurse', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('samba1981@outlook.com', 'MY8490SD43', 'Coralee') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ela', 'Harmon', 80, 93, '1988-06-13', 'IT_administrator', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('77637', '2006-04-09 11:50:30.015717', 'Its main implementation i') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Where are my pants? In 19', '2020-05-17 10:16:47.413878', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('crocky1912@yandex.com', 'YJ6462OJ21', 'Emil') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Raymundo', 'Rocha', 94, 94, '1980-06-03', 'security', 'female') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Maynard', '(83, 122)', 24) ;
INSERT INTO auth (login, password1, name) VALUES ('cagatay1876@yandex.com', 'KK5034UT96', 'Pat') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Norberto', 'Medina', 48, 95, '1966-10-05', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('datura1888@live.com', 'MF0290EM35', 'Jeanelle') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Yong', 'Little', 78, 96, '1970-12-04', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('powered1918@yandex.com', 'BG9699VU52', 'Bradley') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dania', 'Hill', 91, 97, '2011-01-24', 'nurse', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('6166', '2011-08-04 12:24:03.478156', 'In 1989 the building was ') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Erlang is known for its d', '2016-03-24 15:25:10.663044', 'They are written as strin') ;
INSERT INTO auth (login, password1, name) VALUES ('loment1894@gmail.com', 'NF9000YO80', 'Cletus') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Chas', 'Bolton', 48, 98, '2018-12-04', 'security', 'female') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Codi', '(68, 59)', 28) ;
INSERT INTO auth (login, password1, name) VALUES ('spoonyism2019@outlook.com', 'KF9565GL22', 'Brady') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jason', 'Simmons', 41, 99, '1994-04-01', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('unthumped1953@live.com', 'UJ4866RF43', 'Britany') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Isaiah', 'Ramsey', 74, 100, '1976-05-02', 'nurse', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('wolverine1903@yandex.com', 'ML8106VO51', 'Pandora') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Blossom', 'Garza', 26, 101, '2011-05-14', 'security', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('71808', '2003-06-22 11:08:51.023221', 'Make me a sandwich. Type ') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Haskell features a type s', '2007-05-21 16:38:49.916783', 'Ports are used to communi') ;
INSERT INTO auth (login, password1, name) VALUES ('smidgin1990@yandex.com', 'MH8547AC91', 'Lael') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kim', 'Stewart', 34, 102, '2010-10-04', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Jerica', '(42, 14)', 32) ;
INSERT INTO auth (login, password1, name) VALUES ('booby2068@live.com', 'RR4947PP70', 'Francis') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Williams', 'Blair', 66, 103, '2001-01-28', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('bedlamps2035@yandex.com', 'OG2970UG05', 'Chong') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Maryanna', 'Boyle', 54, 104, '1958-05-31', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('crataegus1954@gmail.com', 'LQ3232YD07', 'Jerrell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Cletus', 'Harrison', 79, 105, '1975-05-04', 'nurse', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('57455', '2011-01-24 16:41:36.035098', 'Atoms can contain any cha') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('The syntax {D1,D2,...,Dn}', '2003-02-27 14:36:20.660174', 'The sequential subset of ') ;
INSERT INTO auth (login, password1, name) VALUES ('deanthropomorphism1802@gmail.com', 'JM6322XC74', 'Diego') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jacinto', 'Fowler', 13, 106, '1973-12-30', 'security', 'female') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Latrina', '(171, 52)', 36) ;
INSERT INTO auth (login, password1, name) VALUES ('speron2014@yahoo.com', 'LZ6247TY25', 'Odis') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Leonida', 'Neal', 87, 107, '2001-09-06', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('corvettes1939@live.com', 'PP9602JS66', 'Shelton') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Yun', 'Jones', 92, 108, '1952-03-31', 'nurse', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('caulicles1930@outlook.com', 'WR2941DF95', 'Danyel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Otha', 'Oneill', 99, 109, '1991-11-06', 'IT_administrator', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('24254', '2012-12-27 12:12:25.509719', 'Erlang is known for its d') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('I dont even care. Ports a', '2005-03-24 10:27:31.232107', 'The arguments can be prim') ;
INSERT INTO auth (login, password1, name) VALUES ('cinter1807@yahoo.com', 'ZB3782QT45', 'Rossie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kenton', 'Gomez', 70, 110, '1979-03-02', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Olimpia', '(0, 164)', 40) ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4901, 624346, '1958-09-13', 'Ricardo', 'Owens', 'female', 'Technical Author') ;
INSERT INTO auth (login, password1, name) VALUES ('sedatives2042@gmail.com', 'FP9577AF22', 'Robt') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6525, 953288, '1972-10-22', 'Katia', 'Blankenship', 'male', 'Ambulance Crew') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (111, 898624, 17051, 6525, 953288, '+74322983408') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('23631', '2013-07-24 12:25:28.633317', 'Atoms are used within a p') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2143, 522814, '2001-06-03', 'Yael', 'Wade', 'male', 'Barmaid') ;
INSERT INTO auth (login, password1, name) VALUES ('ental1808@yahoo.com', 'SY0777NM90', 'Eleanora') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0282, 967295, '1975-09-13', 'Thanh', 'Pitts', 'female', 'Barrister') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (112, 032109, 33886, 0282, 967295, '+10774000181') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('43950', '2020-03-08 10:55:14.198175', 'The sequential subset of ') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3213, 426549, '2012-03-23', 'Dwayne', 'Rodriquez', 'female', 'Operative') ;
INSERT INTO auth (login, password1, name) VALUES ('antirepublican1928@live.com', 'SM8248RB27', 'Renato') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8700, 851881, '1964-04-01', 'Arturo', 'Oneal', 'female', 'Tour Agent') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (113, 413551, 67200, 8700, 851881, '+33633820325') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('85049', '2015-04-13 16:29:15.410809', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1623, 634332, '1984-11-20', 'Andrew', 'Wong', 'female', 'Refrigeration Engineer') ;
INSERT INTO auth (login, password1, name) VALUES ('lanson2051@gmail.com', 'SU8499MD84', 'Josphine') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6824, 617157, '1976-09-18', 'Shandra', 'Clayton', 'male', 'Horticultural Consultant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (114, 236580, 01125, 6824, 617157, '+78627547934') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('79537', '2019-04-27 15:29:19.411350', 'The sequential subset of ') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6626, 696348, '2017-11-21', 'Dirk', 'Downs', 'male', 'Typewriter Engineer') ;
INSERT INTO auth (login, password1, name) VALUES ('remeant1935@gmail.com', 'CK8581SQ25', 'Agustin') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8106, 427602, '1988-08-13', 'Stevie', 'Conner', 'male', 'Stud Hand') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (115, 664952, 49576, 8106, 427602, '+13672481163') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('54190', '2001-03-08 15:31:06.885540', 'She spent her earliest ye') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9375, 046782, '1959-01-11', 'Deloras', 'Conner', 'female', 'Hosiery Mechanic') ;
INSERT INTO auth (login, password1, name) VALUES ('elfreda1812@outlook.com', 'QK0543CC57', 'Janetta') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9263, 626383, '1960-07-31', 'Marcellus', 'Patterson', 'male', 'Reprographic Assistant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (116, 670442, 81756, 9263, 626383, '+69480801348') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('96073', '2014-06-22 14:16:43.524314', 'Haskell is a standardized') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5049, 518716, '1985-11-04', 'Christopher', 'Owen', 'male', 'Tennis Coach') ;
INSERT INTO auth (login, password1, name) VALUES ('chakras1971@yahoo.com', 'NG2342YP15', 'Andreas') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8441, 189495, '2015-11-17', 'Emmie', 'Benson', 'female', 'Hairdresser') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (117, 894577, 37085, 8441, 189495, '+81581540425') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('62079', '2016-08-27 14:35:19.473483', 'Initially composing light') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2008, 378428, '1982-02-11', 'Leon', 'Brooks', 'male', 'Technical Analyst') ;
INSERT INTO auth (login, password1, name) VALUES ('nervimuscular1870@yahoo.com', 'CN7111RU03', 'Katia') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4768, 302986, '1988-02-02', 'Marielle', 'Fernandez', 'male', 'Vehicle Engineer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (118, 824054, 57807, 4768, 302986, '+83932507660') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('7920', '2018-01-31 10:37:54.076068', 'He looked inquisitively a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0102, 809054, '1977-03-11', 'Enrique', 'Stuart', 'male', 'Nuclear Scientist') ;
INSERT INTO auth (login, password1, name) VALUES ('malleablize1940@yandex.com', 'GY0254MB64', 'Melita') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1273, 694460, '2018-09-18', 'Janiece', 'Luna', 'female', 'Travel Representative') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (119, 816350, 31836, 1273, 694460, '+93857576450') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('75994', '2018-08-30 12:40:06.486866', 'The arguments can be prim') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8070, 004830, '1988-05-25', 'Tamisha', 'Hardin', 'female', 'Gallery Owner') ;
INSERT INTO auth (login, password1, name) VALUES ('pygofer1890@outlook.com', 'QM5824QL75', 'Ambrose') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4877, 130852, '1986-04-22', 'Ivan', 'Roman', 'female', 'Metal Worker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (120, 670371, 30927, 4877, 130852, '+57839775212') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('26419', '2010-04-02 11:35:38.255388', 'They are written as strin') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5670, 121097, '1962-07-30', 'Frida', 'Boyer', 'female', 'Publisher') ;
INSERT INTO auth (login, password1, name) VALUES ('lag1821@yahoo.com', 'SL9904MW05', 'Adena') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7223, 446633, '1971-10-27', 'Brock', 'Robertson', 'female', 'Hairdresser') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (121, 557039, 22801, 7223, 446633, '+99229474027') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('17619', '2001-09-24 15:22:44.935629', 'They are written as strin') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0859, 131095, '2019-01-23', 'Garry', 'Bruce', 'male', 'Microbiologist') ;
INSERT INTO auth (login, password1, name) VALUES ('ithomiidae2021@gmail.com', 'BA1263NP08', 'Jeni') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0496, 842482, '2004-01-26', 'Wilbur', 'Perez', 'male', 'Trading Standards') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (122, 911431, 03179, 0496, 842482, '+36809129849') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('9257', '2015-03-20 14:35:42.134339', 'Type classes first appear') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3530, 214878, '2019-04-19', 'Delta', 'Hatfield', 'female', 'Preacher') ;
INSERT INTO auth (login, password1, name) VALUES ('meanwhile2063@outlook.com', 'UN4653RT86', 'Julius') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3959, 599696, '1983-01-24', 'Edra', 'Lowery', 'female', 'Hotelier') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (123, 344373, 46045, 3959, 599696, '+65279656891') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('7424', '2003-12-26 16:33:29.722545', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0764, 248949, '2003-08-25', 'Cordell', 'Bradley', 'female', 'Software Engineer') ;
INSERT INTO auth (login, password1, name) VALUES ('rajarshi1892@outlook.com', 'FG3700NV43', 'Tonie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3652, 431788, '2019-07-20', 'Shera', 'Wallace', 'male', 'Pest Controller') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (124, 876527, 55076, 3652, 431788, '+05236341871') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('22120', '2000-08-09 15:17:31.228947', 'Do you come here often? H') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8046, 377790, '1979-12-10', 'Pierre', 'Aguilar', 'male', 'Cafe Staff') ;
INSERT INTO auth (login, password1, name) VALUES ('alleluia1808@outlook.com', 'FW6021KL02', 'Kathern') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2251, 904072, '1990-05-24', 'Tory', 'Maxwell', 'male', 'Music Teacher') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (125, 723192, 86696, 2251, 904072, '+76500217380') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('54503', '2020-04-24 16:47:58.516957', 'Haskell features a type s') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7161, 496162, '1985-12-25', 'Laraine', 'Valdez', 'female', 'Milliner') ;
INSERT INTO auth (login, password1, name) VALUES ('ardea1874@yandex.com', 'CY4694XA04', 'Deon') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0799, 572160, '1952-02-21', 'Arturo', 'Silva', 'male', 'Machine Operator') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (126, 028357, 93384, 0799, 572160, '+11725496828') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('64134', '2019-07-05 14:04:56.454677', 'Atoms can contain any cha') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4659, 014639, '1977-12-21', 'Rickey', 'Reynolds', 'female', 'Screen Writer') ;
INSERT INTO auth (login, password1, name) VALUES ('myalgic1892@outlook.com', 'SW6783QR87', 'Robin') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4438, 655340, '2003-11-17', 'Twana', 'Lee', 'female', 'Investment Banker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (127, 921897, 59124, 4438, 655340, '+69940321926') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('14448', '2014-11-11 16:34:55.843676', 'Ports are created with th') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7741, 773700, '1975-04-09', 'Kip', 'Cochran', 'male', 'Planning Manager') ;
INSERT INTO auth (login, password1, name) VALUES ('religiousness1842@live.com', 'SY9307YB50', 'Rodrick') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6264, 695059, '1959-07-06', 'Ezekiel', 'Fields', 'male', 'Premises Security') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (128, 189413, 84337, 6264, 695059, '+82349723304') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('61077', '2020-12-21 12:40:02.499110', 'The arguments can be prim') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4301, 890301, '1977-05-09', 'Gerry', 'Leon', 'male', 'Furniture Dealer') ;
INSERT INTO auth (login, password1, name) VALUES ('scintillator1817@yandex.com', 'GJ7558QO51', 'Giuseppina') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7502, 175211, '1990-02-18', 'Elinore', 'Freeman', 'male', 'Mineralologist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (129, 670499, 34833, 7502, 175211, '+34495394707') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('72224', '2009-01-03 14:31:22.074697', 'Type classes first appear') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5669, 604397, '2012-06-30', 'Ismael', 'Adkins', 'male', 'Marine Consultant') ;
INSERT INTO auth (login, password1, name) VALUES ('lallans1931@live.com', 'DB2939WP50', 'Douglass') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9142, 476180, '1982-10-25', 'Lyle', 'Kelly', 'female', 'Works Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (130, 105826, 74700, 9142, 476180, '+22861371697') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('46247', '2008-12-09 10:14:09.623623', 'Atoms can contain any cha') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9389, 564124, '1984-05-05', 'Ward', 'Sanchez', 'female', 'Prison Chaplain') ;
INSERT INTO auth (login, password1, name) VALUES ('medical1973@yandex.com', 'NR8272VG67', 'Jesusita') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4674, 721078, '1988-07-30', 'Herschel', 'Morris', 'female', 'Seamstress') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (131, 823110, 37772, 4674, 721078, '+14823637691') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('46159', '2013-09-25 12:54:59.089655', 'The arguments can be prim') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8547, 347081, '1966-08-07', 'Melani', 'Charles', 'male', 'Foundry Worker') ;
INSERT INTO auth (login, password1, name) VALUES ('emu1916@live.com', 'YY7743EM66', 'Wenona') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5439, 747641, '2010-02-17', 'Dione', 'Warner', 'male', 'Instrument Technician') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (132, 349472, 64806, 5439, 747641, '+59268256503') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('60164', '2000-12-09 16:32:26.998512', 'Ports are used to communi') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3772, 472603, '2011-05-04', 'Prince', 'Nelson', 'female', 'Hot Foil Printer') ;
INSERT INTO auth (login, password1, name) VALUES ('millenia1912@live.com', 'GH2668QN89', 'Lewis') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8079, 869560, '1968-02-18', 'Seymour', 'Ballard', 'female', 'Butler') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (133, 498376, 59342, 8079, 869560, '+36307125489') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('87289', '2000-05-02 13:24:31.674166', 'It is also a garbage-coll') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4581, 182099, '1993-11-09', 'Curtis', 'Kramer', 'male', 'Travel Clerk') ;
INSERT INTO auth (login, password1, name) VALUES ('benzalazine2053@live.com', 'JY5075OL74', 'Kaylene') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0580, 101749, '2016-06-25', 'Lawerence', 'Long', 'male', 'Hardware Dealer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (134, 418498, 74797, 0580, 101749, '+05283826952') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('76313', '2011-10-12 14:52:37.305222', 'Atoms are used within a p') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6704, 462945, '1954-10-08', 'Adam', 'Rivera', 'male', 'Shoe Repairer') ;
INSERT INTO auth (login, password1, name) VALUES ('awave2022@outlook.com', 'PU4132CI86', 'Garth') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1994, 242059, '2015-09-07', 'Kandis', 'Spears', 'male', 'Stewardess') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (135, 376899, 83031, 1994, 242059, '+09355621919') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('35864', '2008-05-13 13:48:42.553892', 'Type classes first appear') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6040, 604198, '1955-05-09', 'Marine', 'Hunt', 'male', 'Paint Consultant') ;
INSERT INTO auth (login, password1, name) VALUES ('bauch1804@outlook.com', 'IL8976ZT75', 'Celine') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5846, 430725, '1960-04-28', 'Hye', 'Baxter', 'male', 'Polisher') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (136, 995177, 25059, 5846, 430725, '+69000443583') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('60558', '2004-02-09 11:52:10.431998', 'He looked inquisitively a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2615, 101854, '2006-11-11', 'Trinidad', 'Castillo', 'female', 'Teacher') ;
INSERT INTO auth (login, password1, name) VALUES ('sivaist2019@live.com', 'OA5768NW01', 'Jere') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2854, 498162, '2007-08-23', 'Leigha', 'Juarez', 'female', 'Pawnbroker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (137, 116728, 87498, 2854, 498162, '+94769995876') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('53046', '2009-05-10 13:42:30.221823', 'Messages can be sent to a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3180, 632808, '1999-09-11', 'Hyo', 'Webb', 'male', 'Househusband') ;
INSERT INTO auth (login, password1, name) VALUES ('cologs2041@live.com', 'TO7601AP53', 'Reita') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7115, 894553, '1994-12-08', 'Michel', 'Robertson', 'male', 'Goods Handler') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (138, 080161, 24918, 7115, 894553, '+45193629605') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('62841', '2004-04-21 10:16:50.485709', 'Its main implementation i') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2653, 418765, '2012-05-07', 'Naida', 'Lee', 'male', 'Wine Merchant') ;
INSERT INTO auth (login, password1, name) VALUES ('planted1934@yandex.com', 'HX4012JK65', 'Charlie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6811, 095574, '2010-04-12', 'Verlene', 'Lowe', 'female', 'Circus Proprietor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (139, 615970, 24078, 6811, 095574, '+14572622835') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('52047', '2012-02-28 15:30:30.788332', 'Atoms are used within a p') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5947, 898048, '1971-12-20', 'Russell', 'Chase', 'female', 'Medical Officer') ;
INSERT INTO auth (login, password1, name) VALUES ('phrenosinic2036@outlook.com', 'QT5074QX38', 'Wilburn') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9320, 759367, '1996-02-04', 'Kirstie', 'Sharp', 'female', 'Operator') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (140, 179629, 61127, 9320, 759367, '+65636846080') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('18197', '2001-12-19 16:45:26.026644', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9017, 296666, '1991-10-04', 'Mireille', 'Oneil', 'female', 'Marine Pilot') ;
INSERT INTO auth (login, password1, name) VALUES ('bitterbush1954@yandex.com', 'JN7476ID82', 'Qiana') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9403, 001846, '2007-09-15', 'Tinisha', 'Glass', 'male', 'Training Instructor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (141, 064944, 17379, 9403, 001846, '+15220443024') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('57686', '2020-09-01 15:44:50.983977', 'Its main implementation i') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7754, 293564, '2008-01-09', 'Donte', 'Chapman', 'male', 'Midwife') ;
INSERT INTO auth (login, password1, name) VALUES ('intrigued2013@yandex.com', 'HV0233BS76', 'Annabell') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4199, 677200, '1965-08-25', 'Hershel', 'Gentry', 'female', 'Car Wash Attendant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (142, 700872, 93767, 4199, 677200, '+26876188210') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('35354', '2019-04-24 15:22:22.613064', 'Messages can be sent to a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2906, 742402, '2011-09-29', 'Shelby', 'Peters', 'male', 'Marine Engineer') ;
INSERT INTO auth (login, password1, name) VALUES ('churchill1934@gmail.com', 'QY4380PI84', 'Lloyd') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4753, 203242, '1962-02-09', 'Stanley', 'Quinn', 'female', 'Stage Mover') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (143, 769055, 04737, 4753, 203242, '+51593035077') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('56404', '2009-05-15 10:37:29.298043', 'Erlang is a general-purpo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9738, 728997, '1963-10-29', 'Wilfredo', 'Hewitt', 'male', 'Jewellery') ;
INSERT INTO auth (login, password1, name) VALUES ('brassard2017@yahoo.com', 'OF7382KJ12', 'Mignon') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8483, 128397, '1965-04-03', 'Tiffaney', 'David', 'female', 'Auxiliary Nurse') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (144, 174599, 34453, 8483, 128397, '+70700092513') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('84475', '2014-07-08 12:42:07.065772', 'Its main implementation i') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3472, 110649, '1993-07-28', 'Alverta', 'Hamilton', 'female', 'Systems Analyst') ;
INSERT INTO auth (login, password1, name) VALUES ('unmodifiableness1970@gmail.com', 'DZ7898IN21', 'Errol') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6606, 249587, '1967-09-20', 'Duncan', 'Montgomery', 'female', 'Publicity Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (145, 549820, 75044, 6606, 249587, '+68135079596') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('54535', '2005-07-19 15:06:41.455036', 'It is also a garbage-coll') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3818, 763828, '1987-06-30', 'Lucien', 'Haynes', 'male', 'Project Engineer') ;
INSERT INTO auth (login, password1, name) VALUES ('enkidu1832@yahoo.com', 'DH0736GM70', 'Oretha') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5781, 575959, '2003-05-28', 'Philip', 'Yang', 'female', 'Bus Company') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (146, 831161, 60838, 5781, 575959, '+89955548861') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('57659', '2010-03-19 14:59:52.056902', 'Any element of a tuple ca') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3233, 284450, '1957-06-17', 'Johnson', 'Harvey', 'female', 'Rally Driver') ;
INSERT INTO auth (login, password1, name) VALUES ('unpinched1875@outlook.com', 'ID1329QZ06', 'Abel') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8938, 946500, '1973-06-11', 'Nadene', 'Summers', 'female', 'Motor Trader') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (147, 988477, 99921, 8938, 946500, '+98902091871') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('16346', '2007-04-04 12:59:06.736289', 'Where are my pants? The s') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3012, 280601, '1987-04-26', 'Gerardo', 'Ewing', 'female', 'Van Driver') ;
INSERT INTO auth (login, password1, name) VALUES ('deforestation1988@live.com', 'ZK8020IT25', 'Jesusita') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1814, 695960, '2005-07-21', 'Karmen', 'Levine', 'male', 'Pasteuriser') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (148, 019484, 80116, 1814, 695960, '+00651377213') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('68588', '2013-08-18 15:42:07.871008', 'Haskell features a type s') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9816, 667380, '1994-03-28', 'Bennett', 'Larsen', 'female', 'Accounts Clerk') ;
INSERT INTO auth (login, password1, name) VALUES ('bucketman2041@live.com', 'EE4539FX49', 'Trinidad') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1959, 062918, '1987-03-06', 'Antione', 'Parrish', 'female', 'Prison Officer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (149, 062869, 90681, 1959, 062918, '+60302286629') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('29519', '2013-06-22 15:29:37.360031', 'Any element of a tuple ca') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2264, 817264, '1986-02-03', 'Jule', 'Ramos', 'female', 'Picture Editor') ;
INSERT INTO auth (login, password1, name) VALUES ('jebus1920@outlook.com', 'EB9019NR85', 'Thurman') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3077, 433335, '2006-05-08', 'Omar', 'Sexton', 'male', 'Housing Assistant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (150, 730411, 04911, 3077, 433335, '+14818185742') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('26537', '2001-01-29 10:55:41.981741', 'Do you come here often? D') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2004-11-01T14:44:02.623387', '2004-11-04T14:44:02.623387', 'Type classes first appear') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Ports are used to communi', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2004-10-20T11:15:23.848676', '2004-10-24T11:15:23.848676', 'Initially composing light') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2003-07-13T11:20:33.296771', '2003-07-18T11:20:33.296771', 'Atoms are used within a p') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('They are written as strin', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2004-01-22T12:36:42.523799', '2004-01-29T12:36:42.523799', 'Type classes first appear') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Make me a sandwich. Erlan', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2011-06-06T13:38:55.653966', '2011-06-13T13:38:55.653966', 'Do you have any idea why ') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Make me a sandwich. Tuple', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2000-06-05T14:49:21.874020', '2000-06-10T14:49:21.874020', 'The Galactic Empire is ne') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms are used within a p', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2001-12-28T14:41:08.668047', '2002-01-01T14:41:08.668047', 'He looked inquisitively a') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2008-09-03T16:17:40.174314', '2008-09-10T16:17:40.174314', 'Ports are created with th') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The Galactic Empire is ne', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2003-09-06T11:16:22.465639', '2003-09-12T11:16:22.465639', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Initially composing light', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2011-06-24T16:34:04.621479', '2011-06-27T16:34:04.621479', 'Haskell is a standardized') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The sequential subset of ', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-06-27T15:21:28.004800', '2019-06-29T15:21:28.004800', 'He looked inquisitively a') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2005-05-22T15:55:09.784591', '2005-05-24T15:55:09.784591', 'Ports are used to communi') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you have any idea why ', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2006-05-26T12:38:23.701764', '2006-05-30T12:38:23.701764', 'They are written as strin') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you have any idea why ', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2014-05-27T12:54:56.398082', '2014-06-01T12:54:56.398082', 'Initially composing light') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Type classes first appear', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2004-02-09T12:07:37.997370', '2004-02-16T12:07:37.997370', 'Any element of a tuple ca') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-07-11T15:27:02.324716', '2019-07-15T15:27:02.324716', 'Its main implementation i') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Messages can be sent to a', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2000-08-17T16:01:48.645696', '2000-08-21T16:01:48.645696', 'The arguments can be prim') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Make me a sandwich. He lo', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2001-03-13T16:04:51.239901', '2001-03-20T16:04:51.239901', 'Its main implementation i') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-11-15T10:54:03.330304', '2012-11-19T10:54:03.330304', 'It is also a garbage-coll') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Tuples are containers for', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2004-01-03T12:44:42.747728', '2004-01-09T12:44:42.747728', 'Initially composing light') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Erlang is known for its d', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2014-08-14T14:31:02.801667', '2014-08-17T14:31:02.801667', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The sequential subset of ', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2002-09-02T15:58:06.735929', '2002-09-05T15:58:06.735929', 'She spent her earliest ye') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The sequential subset of ', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2004-01-20T12:03:29.486007', '2004-01-24T12:03:29.486007', 'Its main implementation i') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2016-12-18T16:15:25.721092', '2016-12-22T16:15:25.721092', 'Make me a sandwich. Make ') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('It is also a garbage-coll', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2005-08-26T11:17:13.939041', '2005-08-30T11:17:13.939041', 'Do you have any idea why ') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('They are written as strin', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-03-17T16:20:54.070972', '2019-03-21T16:20:54.070972', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The syntax {D1,D2,...,Dn}', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2011-11-09T11:07:10.650417', '2011-11-16T11:07:10.650417', 'He looked inquisitively a') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('They are written as strin', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2002-03-13T16:44:32.264082', '2002-03-17T16:44:32.264082', 'Atoms can contain any cha') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2016-11-25T12:09:06.413256', '2016-12-02T12:09:06.413256', 'Ports are created with th') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Erlang is a general-purpo', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2015-12-04T14:45:31.051465', '2015-12-10T14:45:31.051465', 'The Galactic Empire is ne') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-04-21 14:15:01.201178', 'The Galact', 'Erlang is a general-purpo', 'Atoms can ') ;
INSERT INTO auth (login, password1, name) VALUES ('prelacy1953@yandex.com', 'LF7214ZY08', 'Sang') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5632, 064244, '2015-09-29', 'Rayford', 'Dunn', 'female', 'Transport Engineer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (151, 837093, 21723, 5632, 064244, '+50056257685') ;
INSERT INTO auth (login, password1, name) VALUES ('alegre2037@yahoo.com', 'SW5001PW42', 'Mika') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Melodee', 'Baird', 37, 152, '2004-07-23', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2013-09-24 16:03:01.062338', 'In 1989 th', 'Atoms can contain any cha', 'Haskell is') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (2, 41, 41) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-08-29 11:03:55.938865', 'Its main i', 'They are written as strin', 'Do you hav') ;
INSERT INTO auth (login, password1, name) VALUES ('cerite1964@outlook.com', 'ZH3238ZZ55', 'Alonso') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7480, 497550, '1954-07-12', 'Doug', 'Duran', 'male', 'Fund Raiser') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (153, 429906, 17935, 7480, 497550, '+28881024377') ;
INSERT INTO auth (login, password1, name) VALUES ('dangersome2030@live.com', 'ZR4664NH96', 'Maximo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dana', 'Castaneda', 47, 154, '1968-02-16', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-12-09 15:59:27.044565', 'Atoms are ', 'Initially composing light', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (4, 42, 42) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-05-02 16:09:41.047659', 'Make me a ', 'Erlang is known for its d', 'Ports are ') ;
INSERT INTO auth (login, password1, name) VALUES ('vegan2050@yandex.com', 'JZ2611XI38', 'Lorean') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2171, 360231, '1960-04-30', 'Tegan', 'Holloway', 'female', 'Word Processing Operator') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (155, 115499, 22948, 2171, 360231, '+72991376586') ;
INSERT INTO auth (login, password1, name) VALUES ('unrooted2033@yahoo.com', 'VB2811BB73', 'Antone') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Norbert', 'Pickett', 87, 156, '2017-03-26', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-08-15 13:18:13.816676', 'Haskell fe', 'Erlang is a general-purpo', 'Tuples are') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (6, 43, 43) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-05-14 13:39:10.062165', 'Atoms are ', 'Do you have any idea why ', 'Messages c') ;
INSERT INTO auth (login, password1, name) VALUES ('decries1971@gmail.com', 'LZ2492GP83', 'Tracey') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6086, 595062, '2001-04-01', 'Shannon', 'Downs', 'female', 'Cafe Owner') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (157, 150757, 10309, 6086, 595062, '+27571065890') ;
INSERT INTO auth (login, password1, name) VALUES ('bongos2040@yandex.com', 'ZT7883MJ74', 'Azalee') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lavelle', 'Dunn', 84, 158, '2011-10-23', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-07-14 16:59:57.954043', 'They are w', 'Do you have any idea why ', 'Do you hav') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (8, 44, 44) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-09-14 11:03:19.634382', 'Its main i', 'They are written as strin', 'Do you com') ;
INSERT INTO auth (login, password1, name) VALUES ('twinflower1885@gmail.com', 'RV8172ZE68', 'Darryl') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6549, 623863, '2013-11-22', 'Justin', 'Norton', 'female', 'Lampshade Maker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (159, 256431, 59692, 6549, 623863, '+62497632653') ;
INSERT INTO auth (login, password1, name) VALUES ('requisitely1821@yandex.com', 'QZ2787QJ74', 'Deandrea') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kandra', 'Jennings', 5, 160, '1960-01-08', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-08-29 13:56:03.246442', 'Its main i', 'He looked inquisitively a', 'Initially ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (10, 45, 45) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-06-20 15:20:37.604442', 'She spent ', 'Its main implementation i', 'It is also') ;
INSERT INTO auth (login, password1, name) VALUES ('naphthoxide2027@yandex.com', 'JE8866ER15', 'Shu') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4364, 375782, '2011-01-26', 'Tama', 'Mullins', 'male', 'Operative') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (161, 749250, 53843, 4364, 375782, '+07195494670') ;
INSERT INTO auth (login, password1, name) VALUES ('backgammon2005@yandex.com', 'HI1260MQ12', 'Edmond') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jim', 'Maxwell', 21, 162, '1955-03-25', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-01-15 14:04:03.269268', 'Ports are ', 'Atoms can contain any cha', 'Haskell is') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (12, 46, 46) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2006-12-17 14:51:08.779625', 'Messages c', 'Do you have any idea why ', 'They are w') ;
INSERT INTO auth (login, password1, name) VALUES ('cocking1892@yandex.com', 'SI1279WX25', 'Emerson') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9358, 429054, '1954-04-21', 'Roland', 'Morse', 'female', 'Executive') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (163, 570927, 53128, 9358, 429054, '+92328200904') ;
INSERT INTO auth (login, password1, name) VALUES ('dinners1886@gmail.com', 'MK7322XN28', 'Cleveland') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lance', 'Herman', 35, 164, '2018-06-23', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-10-13 11:56:02.946454', 'Haskell fe', 'The Galactic Empire is ne', 'Do you hav') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (14, 47, 47) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-01-09 11:12:08.684109', 'He looked ', 'She spent her earliest ye', 'Erlang is ') ;
INSERT INTO auth (login, password1, name) VALUES ('signor2067@outlook.com', 'CT2069IL25', 'Prince') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7497, 415986, '1983-01-05', 'Regan', 'Maxwell', 'male', 'Investment Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (165, 935975, 32306, 7497, 415986, '+23324430308') ;
INSERT INTO auth (login, password1, name) VALUES ('verdi2037@gmail.com', 'DG0350IN64', 'Rolf') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jeromy', 'Rowland', 44, 166, '1973-05-30', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-06-24 16:43:41.800443', 'The argume', 'Erlang is known for its d', 'Atoms are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (16, 48, 48) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-01-17 14:26:47.318426', 'The sequen', 'I dont even care. She spe', 'I dont eve') ;
INSERT INTO auth (login, password1, name) VALUES ('arnis1834@yahoo.com', 'BH2925HE47', 'Franklyn') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4910, 972306, '2006-09-28', 'Ramon', 'Mcgowan', 'male', 'School Inspector') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (167, 652469, 49546, 4910, 972306, '+79143875181') ;
INSERT INTO auth (login, password1, name) VALUES ('abhorrent2048@gmail.com', 'UD1155EM54', 'Else') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dexter', 'Nunez', 71, 168, '2017-06-14', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-11-27 12:10:56.201463', 'They are w', 'Erlang is a general-purpo', 'He looked ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (18, 49, 49) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-01-01 16:01:29.876581', 'The Galact', 'Haskell features a type s', 'Ports are ') ;
INSERT INTO auth (login, password1, name) VALUES ('ribbon1982@live.com', 'CW3471VQ49', 'Mendy') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3317, 572275, '1999-06-26', 'Yuonne', 'York', 'female', 'Stock Controller') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (169, 808740, 04934, 3317, 572275, '+67981673847') ;
INSERT INTO auth (login, password1, name) VALUES ('poule1963@gmail.com', 'GU5832UX48', 'Luke') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Beatris', 'Sexton', 90, 170, '2005-12-04', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-07-20 11:10:41.522620', 'Any elemen', 'Atoms can contain any cha', 'The argume') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (20, 50, 50) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-10-04 14:02:53.381645', 'It is also', 'They are written as strin', 'Do you hav') ;
INSERT INTO auth (login, password1, name) VALUES ('lumen1974@yahoo.com', 'EB4190JB07', 'Danae') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1105, 672498, '1996-12-05', 'Antonietta', 'Valentine', 'male', 'Fork Lift Truck Driver') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (171, 842592, 57596, 1105, 672498, '+42190162769') ;
INSERT INTO auth (login, password1, name) VALUES ('starship1835@gmail.com', 'YM5706WH68', 'Malvina') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Noah', 'Levy', 43, 172, '1971-06-13', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-01-09 16:45:18.549537', 'In 1989 th', 'Haskell is a standardized', 'It is also') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (22, 51, 51) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-05-03 11:36:18.056529', 'Its main i', 'The sequential subset of ', 'Its main i') ;
INSERT INTO auth (login, password1, name) VALUES ('inaccessibility1866@gmail.com', 'CT9376UK34', 'Ellis') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3717, 209881, '1991-12-19', 'Leon', 'Barrett', 'female', 'Minibus Driver') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (173, 650050, 52840, 3717, 209881, '+49353517263') ;
INSERT INTO auth (login, password1, name) VALUES ('pig1821@yandex.com', 'MG1394QR59', 'Joey') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tomas', 'Higgins', 22, 174, '1979-05-06', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-02-10 11:56:07.093919', 'He looked ', 'Ports are used to communi', 'Atoms can ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (24, 52, 52) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-06-30 14:05:59.848254', 'I dont eve', 'The sequential subset of ', 'In 1989 th') ;
INSERT INTO auth (login, password1, name) VALUES ('bedrooms1930@outlook.com', 'XY4964PK49', 'Donnetta') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2630, 702928, '1983-11-22', 'Hayden', 'Hayes', 'male', 'Outdoor Pursuits') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (175, 642561, 97968, 2630, 702928, '+01193294079') ;
INSERT INTO auth (login, password1, name) VALUES ('aliyah2042@live.com', 'BJ2517NO17', 'Fermin') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Roger', 'Bond', 75, 176, '1966-04-18', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-02-29 15:43:26.640724', 'Atoms can ', 'Make me a sandwich. Haske', 'Messages c') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (26, 53, 53) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-04-26 14:50:37.622001', 'Make me a ', 'Any element of a tuple ca', 'Its main i') ;
INSERT INTO auth (login, password1, name) VALUES ('prunitrin1829@gmail.com', 'EZ9716QR62', 'Truman') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4657, 085154, '1962-05-27', 'Jonas', 'Nash', 'male', 'Jockey') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (177, 865717, 74655, 4657, 085154, '+24423219324') ;
INSERT INTO auth (login, password1, name) VALUES ('continuum1930@outlook.com', 'CD9517MX49', 'Derek') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Latoria', 'Torres', 81, 178, '1957-03-23', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-08-06 13:14:43.597762', 'Atoms are ', 'Where are my pants? It is', 'Atoms are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (28, 54, 54) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-07-13 11:46:07.836675', 'Messages c', 'Its main implementation i', 'The sequen') ;
INSERT INTO auth (login, password1, name) VALUES ('mandatary1828@live.com', 'QO4601VD25', 'Alita') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6027, 077049, '2003-03-25', 'Kimbra', 'Fields', 'male', 'Lavatory Attendant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (179, 765834, 92309, 6027, 077049, '+59935118333') ;
INSERT INTO auth (login, password1, name) VALUES ('viper2042@live.com', 'OJ3768FV74', 'Judson') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Devin', 'Petty', 40, 180, '1990-11-19', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-06-15 12:19:01.068938', 'The syntax', 'They are written as strin', 'Any elemen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (30, 55, 55) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-12-26 12:50:51.437680', 'Messages c', 'Atoms can contain any cha', 'Atoms can ') ;
INSERT INTO auth (login, password1, name) VALUES ('subglobularly1948@yandex.com', 'XZ5721WW72', 'Rebbecca') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2113, 625041, '1972-09-26', 'Rozanne', 'Mullen', 'male', 'Advertising Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (181, 554785, 88288, 2113, 625041, '+86913452151') ;
INSERT INTO auth (login, password1, name) VALUES ('poodle1884@gmail.com', 'HS9716YF91', 'Marvella') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rafael', 'William', 47, 182, '2019-11-03', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2004-09-28 13:46:58.100167', 'The argume', 'Ports are used to communi', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (32, 56, 56) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-06-05 16:52:12.362142', 'They are w', 'She spent her earliest ye', 'I dont eve') ;
INSERT INTO auth (login, password1, name) VALUES ('armourer1806@yandex.com', 'VD2486TQ86', 'Jacques') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2408, 394431, '2019-10-17', 'Elijah', 'Schroeder', 'male', 'Legal Advisor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (183, 376170, 52610, 2408, 394431, '+71584826154') ;
INSERT INTO auth (login, password1, name) VALUES ('catheads1870@outlook.com', 'AP0403NZ60', 'Asa') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Joya', 'Monroe', 15, 184, '1998-10-29', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2013-06-21 11:55:08.402026', 'Ports are ', 'They are written as strin', 'Any elemen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (34, 57, 57) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-04-05 14:59:42.483862', 'Initially ', 'The syntax {D1,D2,...,Dn}', 'Ports are ') ;
INSERT INTO auth (login, password1, name) VALUES ('gloamings1869@live.com', 'VA8958XI89', 'Christoper') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4113, 434332, '2001-05-24', 'Kathline', 'Calhoun', 'male', 'Induction Moulder') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (185, 061322, 40162, 4113, 434332, '+27644044467') ;
INSERT INTO auth (login, password1, name) VALUES ('inducing1903@yandex.com', 'IH6113RT60', 'Trevor') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Roxy', 'Ortega', 25, 186, '2014-02-15', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-10-12 14:02:06.412817', 'Erlang is ', 'Atoms are used within a p', 'Messages c') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (36, 58, 58) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-10-05 16:49:36.490267', 'Haskell is', 'Its main implementation i', 'Initially ') ;
INSERT INTO auth (login, password1, name) VALUES ('iodimetry1882@outlook.com', 'DS9761VS32', 'Janise') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1097, 364044, '2015-04-22', 'Shala', 'Rosa', 'female', 'Assessor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (187, 668917, 67790, 1097, 364044, '+42992283703') ;
INSERT INTO auth (login, password1, name) VALUES ('dolman1886@outlook.com', 'PE7213CC10', 'Verdell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Desmond', 'Collins', 99, 188, '1965-04-06', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-02-05 13:45:21.249407', 'Atoms are ', 'Messages can be sent to a', 'Its main i') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (38, 59, 59) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-10-18 13:47:26.777602', 'Type class', 'Atoms can contain any cha', 'Its main i') ;
INSERT INTO auth (login, password1, name) VALUES ('chloropalladic1976@yandex.com', 'BI8759FD04', 'Thurman') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5484, 978621, '2009-03-04', 'Carl', 'Martinez', 'female', 'Shot Blaster') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (189, 166494, 28258, 5484, 978621, '+46973735729') ;
INSERT INTO auth (login, password1, name) VALUES ('amril1856@outlook.com', 'LQ2917RF00', 'Zane') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Shay', 'Mccoy', 75, 190, '2005-03-25', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-09-21 11:46:49.927599', 'Haskell fe', 'Erlang is a general-purpo', 'Atoms are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (40, 60, 60) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-07-23 11:51:41.125448', 'Where are ', 'Initially composing light', 'Tuples are') ;
INSERT INTO auth (login, password1, name) VALUES ('breaststroker2001@yahoo.com', 'HU3344GL05', 'Stefania') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9306, 381351, '1967-06-01', 'Jack', 'Walsh', 'female', 'Technical Instructor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (191, 735638, 25815, 9306, 381351, '+03446669524') ;
INSERT INTO auth (login, password1, name) VALUES ('mermnad1814@yandex.com', 'NE4569NX30', 'Quincy') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Leon', 'Burke', 47, 192, '1975-09-16', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-02-11 13:24:17.224325', 'It is also', 'The sequential subset of ', 'Type class') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (42, 61, 61) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-10-17 13:56:56.921100', 'Where are ', 'Do you have any idea why ', 'Ports are ') ;
INSERT INTO auth (login, password1, name) VALUES ('lanson2033@gmail.com', 'II4475OK53', 'Tawna') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9582, 809778, '2005-12-29', 'Hayden', 'Sharp', 'female', 'Furniture Dealer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (193, 311396, 70119, 9582, 809778, '+42882686151') ;
INSERT INTO auth (login, password1, name) VALUES ('myriophyllite1985@gmail.com', 'EZ7581AW42', 'Amado') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jayson', 'Scott', 6, 194, '1976-09-10', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-01-11 10:00:24.888893', 'Ports are ', 'Ports are created with th', 'Ports are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (44, 62, 62) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-01-26 11:11:32.786877', 'In 1989 th', 'Its main implementation i', 'He looked ') ;
INSERT INTO auth (login, password1, name) VALUES ('bisquette1909@live.com', 'RC4238JO41', 'Lenny') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2059, 182927, '1986-08-19', 'Criselda', 'Kemp', 'male', 'Landlord') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (195, 457490, 12941, 2059, 182927, '+23222521554') ;
INSERT INTO auth (login, password1, name) VALUES ('blowing1840@live.com', 'VM0325DE40', 'Phung') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kiesha', 'Ward', 73, 196, '1956-08-10', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-06-17 12:48:35.127691', 'Do you hav', 'Do you have any idea why ', 'He looked ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (46, 63, 63) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-04-11 10:12:08.847259', 'Ports are ', 'Atoms can contain any cha', 'Make me a ') ;
INSERT INTO auth (login, password1, name) VALUES ('absit1846@gmail.com', 'WW1584MH29', 'Nadene') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1923, 222006, '2011-01-25', 'Velvet', 'Hendrix', 'male', 'Aerobic Instructor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (197, 381751, 89117, 1923, 222006, '+91073147049') ;
INSERT INTO auth (login, password1, name) VALUES ('churn1877@live.com', 'WA8334HB29', 'Basilia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lon', 'Mathews', 66, 198, '1978-12-11', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-07-11 14:26:41.553439', 'Initially ', 'Haskell is a standardized', 'The syntax') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (48, 64, 64) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-10-25 10:24:12.133893', 'Its main i', 'Atoms are used within a p', 'Messages c') ;
INSERT INTO auth (login, password1, name) VALUES ('pulselessness2028@live.com', 'IR2849DB42', 'Reinaldo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4534, 097083, '1955-10-20', 'Chance', 'Carrillo', 'female', 'Accountant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (199, 597683, 01979, 4534, 097083, '+73313559250') ;
INSERT INTO auth (login, password1, name) VALUES ('reinvent1963@yahoo.com', 'LI7650UY42', 'Davis') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Felipe', 'Boyd', 62, 200, '1984-12-05', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-12-22 14:05:12.319453', 'Atoms can ', 'Initially composing light', 'Initially ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (50, 65, 65) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-05-11 11:45:56.548531', 'Erlang is ', 'Haskell features a type s', 'Haskell is') ;
INSERT INTO auth (login, password1, name) VALUES ('undiscording1868@gmail.com', 'YZ6580PU22', 'Emilio') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6340, 477691, '1981-05-17', 'Jenae', 'Petersen', 'male', 'Brewer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (201, 027813, 09964, 6340, 477691, '+20664265423') ;
INSERT INTO auth (login, password1, name) VALUES ('dessa1802@live.com', 'PJ0025XK52', 'Lonnie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Warner', 'Church', 50, 202, '1958-06-06', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2004-05-15 14:11:17.789432', 'Initially ', 'Messages can be sent to a', 'Do you hav') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (52, 66, 66) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-01-11 13:58:20.130760', 'Atoms are ', 'She spent her earliest ye', 'Ports are ') ;
INSERT INTO auth (login, password1, name) VALUES ('brydges1815@yandex.com', 'NI8546XI30', 'Genna') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6557, 587106, '2019-08-24', 'Manie', 'Acevedo', 'female', 'Sail Maker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (203, 738632, 49315, 6557, 587106, '+18389770182') ;
INSERT INTO auth (login, password1, name) VALUES ('attune2044@gmail.com', 'CY3409UH97', 'Vern') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Han', 'Figueroa', 9, 204, '1974-09-02', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-08-26 10:25:25.494859', 'Ports are ', 'Erlang is a general-purpo', 'The syntax') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (54, 67, 67) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-03-30 14:57:24.170923', 'Haskell fe', 'It is also a garbage-coll', 'It is also') ;
INSERT INTO auth (login, password1, name) VALUES ('perivenous1887@outlook.com', 'LJ5879BM99', 'Bradly') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0457, 310747, '1972-09-12', 'Sharita', 'Riley', 'female', 'Site Engineer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (205, 678584, 69011, 0457, 310747, '+74811710683') ;
INSERT INTO auth (login, password1, name) VALUES ('subinterval2012@live.com', 'GO0208PS79', 'Chester') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Denita', 'Scott', 44, 206, '2008-10-01', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2004-08-03 12:39:51.366793', 'Atoms are ', 'The syntax {D1,D2,...,Dn}', 'It is also') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (56, 68, 68) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-03-04 15:04:19.069380', 'Where are ', 'Do you have any idea why ', 'Atoms can ') ;
INSERT INTO auth (login, password1, name) VALUES ('unfickle1942@gmail.com', 'AO4211FP57', 'Dan') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5669, 750844, '2008-09-12', 'Alphonso', 'Witt', 'male', 'Potter') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (207, 647878, 88494, 5669, 750844, '+42133525057') ;
INSERT INTO auth (login, password1, name) VALUES ('nongaseous2000@gmail.com', 'UL0522SJ81', 'Dallas') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dayle', 'Kim', 5, 208, '1960-06-20', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-10-03 11:50:29.565105', 'Type class', 'Do you come here often? D', 'He looked ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (58, 69, 69) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-10-17 10:17:18.575937', 'Make me a ', 'I dont even care. Initial', 'They are w') ;
INSERT INTO auth (login, password1, name) VALUES ('chimu1922@live.com', 'NJ0409WX99', 'Rudy') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6676, 393322, '1983-09-24', 'Millard', 'Mayo', 'male', 'Analyst') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (209, 604388, 51788, 6676, 393322, '+07569316039') ;
INSERT INTO auth (login, password1, name) VALUES ('silhouette1982@outlook.com', 'MF7891AA41', 'Woodrow') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Catheryn', 'Norton', 64, 210, '1990-02-11', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-02-20 16:30:52.445363', 'Any elemen', 'Atoms are used within a p', 'Ports are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (60, 70, 70) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-09-11 16:07:11.394738', 'Where are ', 'The Galactic Empire is ne', 'Do you hav') ;
INSERT INTO auth (login, password1, name) VALUES ('indecency2009@yahoo.com', 'XQ1771PR85', 'Nathanael') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4041, 759186, '2002-11-16', 'Palmer', 'Whitney', 'male', 'Art Dealer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (211, 022862, 34671, 4041, 759186, '+80890983183') ;
INSERT INTO auth (login, password1, name) VALUES ('spent1862@gmail.com', 'RX4409OS71', 'Hilario') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Felton', 'Bowers', 5, 212, '1996-03-25', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2006-05-06 15:24:11.681221', 'She spent ', 'Ports are created with th', 'Initially ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (62, 71, 71) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-08-28 12:51:35.756651', 'The syntax', 'Ports are used to communi', 'The Galact') ;
INSERT INTO auth (login, password1, name) VALUES ('occipitoiliac1980@live.com', 'LG1690CV94', 'Katerine') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3927, 255129, '1998-01-17', 'Jamel', 'Underwood', 'male', 'Forwarding Agent') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (213, 365206, 07362, 3927, 255129, '+32434521175') ;
INSERT INTO auth (login, password1, name) VALUES ('aluminosis2013@live.com', 'LT3373WJ77', 'Marc') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Anya', 'Byers', 26, 214, '1976-01-05', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-09-22 12:26:22.566979', 'They are w', 'Type classes first appear', 'The sequen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (64, 72, 72) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-04-16 11:37:24.964121', 'He looked ', 'Erlang is a general-purpo', 'Atoms can ') ;
INSERT INTO auth (login, password1, name) VALUES ('amaryllis1806@gmail.com', 'DK3766XV21', 'Jasper') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7023, 153456, '1982-09-22', 'Marco', 'Patton', 'male', 'Plant Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (215, 045189, 74550, 7023, 153456, '+96613171365') ;
INSERT INTO auth (login, password1, name) VALUES ('wren1899@yandex.com', 'KM5149BL42', 'Lakeesha') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dante', 'Rhodes', 95, 216, '2003-01-17', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-08-01 13:42:06.615715', 'The argume', 'The syntax {D1,D2,...,Dn}', 'It is also') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (66, 73, 73) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-01-08 15:45:02.882639', 'Erlang is ', 'She spent her earliest ye', 'Do you hav') ;
INSERT INTO auth (login, password1, name) VALUES ('deprive1824@yandex.com', 'CH6499FE77', 'Terisa') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1294, 390869, '1995-03-27', 'Colin', 'Eaton', 'female', 'Progress Chaser') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (217, 757623, 35987, 1294, 390869, '+82222955898') ;
INSERT INTO auth (login, password1, name) VALUES ('astral1945@gmail.com', 'SW1642XP05', 'Marivel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ryan', 'Summers', 65, 218, '1977-08-12', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2013-11-20 15:09:51.790918', 'Do you hav', 'Make me a sandwich. Do yo', 'Ports are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (68, 74, 74) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-08-24 12:21:37.641683', 'It is also', 'The arguments can be prim', 'Messages c') ;
INSERT INTO auth (login, password1, name) VALUES ('embryony1967@gmail.com', 'ME2805KO26', 'Steven') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3604, 396879, '2002-01-17', 'Bryan', 'Beach', 'female', 'Tennis Coach') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (219, 965680, 42870, 3604, 396879, '+35360178680') ;
INSERT INTO auth (login, password1, name) VALUES ('zeuzera1833@yandex.com', 'KW0602TT90', 'Clarita') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Connie', 'Bond', 51, 220, '1988-04-24', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-06-20 15:02:45.303976', 'The Galact', 'The syntax {D1,D2,...,Dn}', 'Atoms are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (70, 75, 75) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-06-22 13:39:33.494398', 'Haskell fe', 'It is also a garbage-coll', 'Where are ') ;
INSERT INTO auth (login, password1, name) VALUES ('evehood1917@outlook.com', 'JB4232CX13', 'Scottie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1667, 628357, '2011-12-22', 'Williemae', 'Mcdaniel', 'male', 'Marquee Erector') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (221, 148510, 98371, 1667, 628357, '+41000977126') ;
INSERT INTO auth (login, password1, name) VALUES ('classifier2059@outlook.com', 'ST6162YC75', 'Alvera') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Yoshie', 'Kerr', 41, 222, '1970-04-23', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-07-28 15:15:22.091023', 'Messages c', 'Any element of a tuple ca', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (72, 76, 76) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-06-21 15:12:40.968890', 'Messages c', 'The sequential subset of ', 'Messages c') ;
INSERT INTO auth (login, password1, name) VALUES ('perduring1801@outlook.com', 'MD2991VI95', 'Arnulfo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3798, 215339, '1952-01-28', 'Roscoe', 'Hooper', 'female', 'Pasteuriser') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (223, 536893, 11366, 3798, 215339, '+09350233327') ;
INSERT INTO auth (login, password1, name) VALUES ('dumbs1932@outlook.com', 'NC1941TV60', 'Cassey') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lisandra', 'Mcleod', 47, 224, '1987-06-18', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-10-16 11:04:46.176835', 'Erlang is ', 'She spent her earliest ye', 'Haskell is') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (74, 77, 77) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2013-12-10 10:55:41.087360', 'Make me a ', 'Haskell is a standardized', 'Make me a ') ;
INSERT INTO auth (login, password1, name) VALUES ('burps1943@yandex.com', 'RQ2922CZ45', 'Elza') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1613, 740680, '1952-12-04', 'Suzi', 'Bullock', 'male', 'Street Entertainer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (225, 911187, 84109, 1613, 740680, '+06411377482') ;
INSERT INTO auth (login, password1, name) VALUES ('miffs2009@live.com', 'MG9894KU44', 'Wally') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Simonne', 'Ball', 82, 226, '1960-09-19', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-12-11 15:23:02.419117', 'They are w', 'Do you have any idea why ', 'Do you hav') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (76, 78, 78) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-04-17 12:27:49.741331', 'Its main i', 'Erlang is a general-purpo', 'Erlang is ') ;
INSERT INTO auth (login, password1, name) VALUES ('mesel2013@yahoo.com', 'RF1010WT97', 'Ardath') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3603, 732384, '1975-05-09', 'Sabine', 'Everett', 'male', 'Typesetter') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (227, 919731, 07854, 3603, 732384, '+76436960647') ;
INSERT INTO auth (login, password1, name) VALUES ('meerkat1802@gmail.com', 'TG2116GU65', 'Maxwell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Remedios', 'Sloan', 96, 228, '1951-07-08', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-05-03 11:02:27.935998', 'The sequen', 'Type classes first appear', 'She spent ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (78, 79, 79) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-01-23 13:11:50.303378', 'Ports are ', 'He looked inquisitively a', 'Do you hav') ;
INSERT INTO auth (login, password1, name) VALUES ('ceara1929@live.com', 'BQ4898PR48', 'Ali') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0530, 246309, '1963-10-27', 'Colton', 'Hogan', 'male', 'Hairdresser') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (229, 309886, 47816, 0530, 246309, '+12637623209') ;
INSERT INTO auth (login, password1, name) VALUES ('rugal2035@live.com', 'WV4640WB50', 'Ronald') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tomoko', 'Colon', 35, 230, '1998-12-27', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-05-02 16:07:38.734482', 'Do you com', 'Where are my pants? Ports', 'Haskell is') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (80, 80, 80) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-04-06 14:27:40.633671', 'The argume', 'Ports are created with th', 'Make me a ') ;
INSERT INTO auth (login, password1, name) VALUES ('kapp2047@live.com', 'FR0096LO31', 'Casie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8035, 403098, '1986-01-20', 'Elijah', 'Cline', 'female', 'Blacksmith') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (231, 680716, 07309, 8035, 403098, '+69786296196') ;
INSERT INTO auth (login, password1, name) VALUES ('confused1917@yahoo.com', 'GO4277TG02', 'Tereasa') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tonita', 'Benson', 11, 232, '2014-06-27', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-04-30 16:56:07.818505', 'The syntax', 'Tuples are containers for', 'They are w') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (82, 81, 81) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2006-04-15 10:42:30.544553', 'Tuples are', 'Tuples are containers for', 'Erlang is ') ;
INSERT INTO auth (login, password1, name) VALUES ('esposito1893@yandex.com', 'NH2316TE59', 'Joey') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5973, 064109, '2006-10-06', 'Bethann', 'Santiago', 'female', 'Church Officer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (233, 304400, 59586, 5973, 064109, '+65144214166') ;
INSERT INTO auth (login, password1, name) VALUES ('hiddenmost2051@gmail.com', 'SL1693YH47', 'Raymond') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ewa', 'Kirkland', 81, 234, '1959-08-17', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-12-16 15:08:43.288153', 'Ports are ', 'Haskell features a type s', 'Type class') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (84, 82, 82) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-05-17 12:42:40.982782', 'Atoms can ', 'Atoms are used within a p', 'They are w') ;
INSERT INTO auth (login, password1, name) VALUES ('able1831@yandex.com', 'HJ8780FK53', 'Carylon') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3199, 989794, '2010-05-13', 'Jere', 'Padilla', 'male', 'Furniture Remover') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (235, 308671, 85873, 3199, 989794, '+79740230297') ;
INSERT INTO auth (login, password1, name) VALUES ('caribous2049@gmail.com', 'ZZ5246YJ60', 'Demarcus') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Melia', 'Sexton', 56, 236, '1964-04-13', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-12-29 13:31:26.000749', 'I dont eve', 'In 1989 the building was ', 'Any elemen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (86, 83, 83) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-05-14 11:13:05.682757', 'Erlang is ', 'They are written as strin', 'Its main i') ;
INSERT INTO auth (login, password1, name) VALUES ('bunni2036@live.com', 'DE7728XH85', 'Raymundo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3656, 694794, '2019-10-16', 'Anjelica', 'Cain', 'female', 'Professional Boxer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (237, 301385, 62128, 3656, 694794, '+44140723519') ;
INSERT INTO auth (login, password1, name) VALUES ('bouto1933@live.com', 'KU6724MF24', 'Lashaunda') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Francene', 'Oneil', 93, 238, '1965-07-01', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2004-12-04 12:24:06.600259', 'Erlang is ', 'Tuples are containers for', 'Haskell is') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (88, 84, 84) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-08-18 15:53:30.494539', 'They are w', 'Where are my pants? Do yo', 'She spent ') ;
INSERT INTO auth (login, password1, name) VALUES ('creative2031@gmail.com', 'TJ8968MY90', 'Lean') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4576, 501472, '2015-08-05', 'Jacinto', 'Avila', 'female', 'Riding Instructor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (239, 958335, 13226, 4576, 501472, '+82276365194') ;
INSERT INTO auth (login, password1, name) VALUES ('guidon2012@yandex.com', 'BE2581CI29', 'Ozell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Breann', 'Burton', 53, 240, '1966-02-23', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-04-27 12:51:24.064947', 'He looked ', 'Atoms are used within a p', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (90, 85, 85) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-10-06 16:09:36.812490', 'Erlang is ', 'She spent her earliest ye', 'Make me a ') ;
INSERT INTO auth (login, password1, name) VALUES ('camion1974@yahoo.com', 'NF1467FG53', 'Sydney') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3811, 379586, '1972-01-01', 'Daphine', 'Frederick', 'male', 'Analytical Chemist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (241, 383226, 34098, 3811, 379586, '+50885394217') ;
INSERT INTO auth (login, password1, name) VALUES ('cheirospasm1803@outlook.com', 'EI5622PI75', 'Marcell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Chante', 'Haley', 76, 242, '1996-11-27', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-09-09 14:49:05.776089', 'Ports are ', 'The syntax {D1,D2,...,Dn}', 'Any elemen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (92, 86, 86) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-08-08 14:57:41.484752', 'Initially ', 'Initially composing light', 'Messages c') ;
INSERT INTO auth (login, password1, name) VALUES ('coward1911@live.com', 'TD1997QW35', 'Clemencia') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7749, 744177, '1979-09-22', 'Toby', 'Francis', 'female', 'Chef') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (243, 690426, 86057, 7749, 744177, '+27382080888') ;
INSERT INTO auth (login, password1, name) VALUES ('finalist1912@yandex.com', 'NA2408RN72', 'Alec') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dick', 'Foster', 55, 244, '1997-02-08', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-10-17 11:29:30.026561', 'The Galact', 'Haskell is a standardized', 'Do you com') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (94, 87, 87) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-04-28 15:06:35.946158', 'Initially ', 'The arguments can be prim', 'Make me a ') ;
INSERT INTO auth (login, password1, name) VALUES ('shaping1974@live.com', 'YM7151HO35', 'Avery') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2047, 597282, '1970-08-28', 'Willene', 'Wilkerson', 'male', 'Professional Boxer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (245, 274477, 34790, 2047, 597282, '+35083443351') ;
INSERT INTO auth (login, password1, name) VALUES ('chape1995@live.com', 'OL6556ZZ85', 'Isidro') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Evan', 'Morse', 7, 246, '1995-06-24', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-08-08 13:14:57.605890', 'Type class', 'Erlang is known for its d', 'I dont eve') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (96, 88, 88) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-09-21 15:13:00.693890', 'Haskell fe', 'Type classes first appear', 'He looked ') ;
INSERT INTO auth (login, password1, name) VALUES ('cinque1888@gmail.com', 'JU6318SM73', 'Melynda') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4534, 980931, '1985-08-19', 'Chas', 'Boone', 'female', 'Botanist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (247, 347543, 26195, 4534, 980931, '+36505235358') ;
INSERT INTO auth (login, password1, name) VALUES ('sprit1874@outlook.com', 'YK9006XH42', 'Yong') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Yan', 'Rojas', 7, 248, '1993-02-18', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-07-14 15:14:08.011430', 'Ports are ', 'Ports are created with th', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (98, 89, 89) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-11-25 12:21:20.450245', 'In 1989 th', 'Do you come here often? T', 'The sequen') ;
INSERT INTO auth (login, password1, name) VALUES ('rebend1943@outlook.com', 'MG9994CM34', 'Barbar') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0750, 477462, '1952-04-26', 'Bobbye', 'Holt', 'female', 'Circus Proprietor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (249, 239172, 61670, 0750, 477462, '+00771872699') ;
INSERT INTO auth (login, password1, name) VALUES ('curite1934@yahoo.com', 'WM1537DO28', 'Ashley') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Shakita', 'Battle', 24, 250, '1995-01-20', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-12-27 11:56:53.885264', 'Type class', 'She spent her earliest ye', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (100, 90, 90) ;
INSERT INTO auth (login, password1, name) VALUES ('huckaback1853@outlook.com', 'BY5258WM54', 'Ernest') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Van', 'Petersen', 84, 251, '1972-06-22', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('javanese1883@live.com', 'CD4361VK89', 'Chante') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Wilfred', 'Burgess', 80, 252, '2011-03-04', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (91, 92) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms are used within a p', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('dimity1809@live.com', 'RP1826RD60', 'Genevie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7692, 725331, '2002-01-23', 'Trenton', 'Sanford', 'female', 'Receptionist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (253, 464086, 26064, 7692, 725331, '+10640980238') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (31, 91) ;
INSERT INTO auth (login, password1, name) VALUES ('festellae1969@outlook.com', 'PE6277NL61', 'Clay') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0592, 705558, '1965-01-11', 'Conchita', 'Joyce', 'female', 'Plant Driver') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (254, 580656, 09608, 0592, 705558, '+74672034639') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('The arguments can be prim', '2020-03-19 11:21:22.227758', 'Initially composing light') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (92, 11) ;
INSERT INTO auth (login, password1, name) VALUES ('rearwards2020@live.com', 'IO5576CM22', 'Carmen') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4753, 936927, '1996-08-17', 'Abel', 'Avery', 'female', 'Bus Company') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (255, 877953, 10705, 4753, 936927, '+82288690033') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('3598', '2005-05-27 15:37:06.588987', 'Erlang is known for its d') ;
INSERT INTO auth (login, password1, name) VALUES ('staurotide2023@yahoo.com', 'MB3548HJ03', 'Dione') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Maricruz', 'Petty', 26, 256, '2000-08-21', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (93, 93, 51) ;
INSERT INTO auth (login, password1, name) VALUES ('vocationalism1835@gmail.com', 'PQ4266BW02', 'Mahalia') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0974, 441828, '1993-11-27', 'Kristopher', 'Mccarthy', 'female', 'Marketing Assistant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (257, 713597, 87929, 0974, 441828, '+21723790136') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-10-14T11:19:18.810179', '2013-10-18T11:19:18.810179', 'Tuples are containers for') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (94, 31) ;
INSERT INTO auth (login, password1, name) VALUES ('concrete2046@gmail.com', 'GH6691OG06', 'Renaldo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Sherley', 'Mckenzie', 27, 258, '1959-06-30', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('beefsteak1977@yahoo.com', 'VW9558WA08', 'Lianne') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lester', 'Haney', 5, 259, '1975-01-03', 'nurse', 'female') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (94, 95) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms can contain any cha', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('chromomere1978@yahoo.com', 'HC7257SX50', 'Hyun') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1424, 711509, '1982-09-21', 'Shena', 'Holman', 'female', 'Waitress') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (260, 252226, 84336, 1424, 711509, '+64877255799') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (32, 95) ;
INSERT INTO auth (login, password1, name) VALUES ('caboodle1842@gmail.com', 'JF7888TQ33', 'Jerica') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2318, 518009, '1952-06-14', 'Haywood', 'Kemp', 'female', 'Teacher') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (261, 157008, 80154, 2318, 518009, '+74512144982') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('The syntax {D1,D2,...,Dn}', '2016-10-03 16:31:26.080169', 'Type classes first appear') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (96, 12) ;
INSERT INTO auth (login, password1, name) VALUES ('wilders1939@live.com', 'EW7485SN81', 'Jim') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0051, 507982, '1977-03-01', 'Terence', 'Moore', 'female', 'Gas Fitter') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (262, 947040, 10727, 0051, 507982, '+48631002050') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('35263', '2017-07-16 16:11:17.256013', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO auth (login, password1, name) VALUES ('tennists1828@yandex.com', 'PJ1939RQ08', 'Eufemia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jaime', 'Trevino', 26, 263, '1990-04-23', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (96, 97, 52) ;
INSERT INTO auth (login, password1, name) VALUES ('pentasulphide1951@yandex.com', 'DB3142XI06', 'Annis') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0544, 402567, '1989-05-04', 'Osvaldo', 'Hopper', 'female', 'Miller') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (264, 074931, 75280, 0544, 402567, '+34489251783') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-06-29T12:55:02.340052', '2019-07-05T12:55:02.340052', 'They are written as strin') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (98, 32) ;
INSERT INTO auth (login, password1, name) VALUES ('decimolar1985@yahoo.com', 'ML9164AW19', 'Moises') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Shakia', 'Stevens', 98, 265, '1968-02-27', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('pronounal1962@live.com', 'HV7502XN05', 'Loyce') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Hedy', 'Medina', 25, 266, '1971-12-03', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (97, 98) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Erlang is known for its d', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('heth1856@yandex.com', 'DV3489AR31', 'Jefferson') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5181, 396835, '2013-10-29', 'Francisco', 'Paul', 'male', 'Theatre Technician') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (267, 747656, 40966, 5181, 396835, '+58607813125') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (33, 99) ;
INSERT INTO auth (login, password1, name) VALUES ('theek1803@live.com', 'KK9329IK64', 'Shaun') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1054, 955627, '1955-11-17', 'Casie', 'Becker', 'female', 'Production Hand') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (268, 969900, 44645, 1054, 955627, '+89273004821') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('She spent her earliest ye', '2001-02-01 15:09:52.408547', 'Messages can be sent to a') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (100, 13) ;
INSERT INTO auth (login, password1, name) VALUES ('tubenose1837@live.com', 'WG6376VK59', 'Samara') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3979, 867022, '1989-05-10', 'Cedric', 'Love', 'male', 'Landlady') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (269, 524867, 77899, 3979, 867022, '+35277465673') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('28116', '2016-07-16 10:31:41.860274', 'Ports are created with th') ;
INSERT INTO auth (login, password1, name) VALUES ('unfinable1829@yahoo.com', 'TB1846NA15', 'Leonie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Sueann', 'Herring', 95, 270, '1989-05-01', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (99, 101, 53) ;
INSERT INTO auth (login, password1, name) VALUES ('kouprey1977@yahoo.com', 'FX4543IO48', 'Kaylene') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3350, 219195, '1982-10-29', 'Bobbie', 'Albert', 'female', 'Hop Merchant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (271, 191229, 68609, 3350, 219195, '+68605924185') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2015-03-27T15:03:32.323060', '2015-04-02T15:03:32.323060', 'Atoms are used within a p') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (102, 33) ;
INSERT INTO auth (login, password1, name) VALUES ('sillago1987@yahoo.com', 'YB3433PE89', 'Mozella') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Gabriele', 'Hogan', 99, 272, '1999-09-28', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('anthema1908@yahoo.com', 'DK5193IV82', 'Laurence') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Nguyet', 'Griffin', 86, 273, '2006-08-15', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (100, 101) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you come here often? A', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('jyngine1836@yandex.com', 'WR6891XG37', 'Clifton') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1084, 377241, '1956-07-04', 'Tyler', 'Maddox', 'female', 'Claims Assessor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (274, 337890, 22079, 1084, 377241, '+03308717983') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (34, 103) ;
INSERT INTO auth (login, password1, name) VALUES ('groten1827@yahoo.com', 'NR4180UB17', 'Seth') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4729, 636613, '1975-02-24', 'Lane', 'Wagner', 'female', 'Massage Therapist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (275, 657288, 58434, 4729, 636613, '+88155558928') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Any element of a tuple ca', '2006-03-16 15:28:58.177117', 'Erlang is known for its d') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (104, 14) ;
INSERT INTO auth (login, password1, name) VALUES ('elinor2057@gmail.com', 'WP1533GO76', 'Nubia') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2587, 384613, '1985-11-24', 'Shera', 'Skinner', 'female', 'Purchasing Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (276, 312637, 61363, 2587, 384613, '+17952162482') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('38539', '2017-05-05 11:02:30.647618', 'Atoms can contain any cha') ;
INSERT INTO auth (login, password1, name) VALUES ('caribou1941@yahoo.com', 'HT0306SM45', 'Bong') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Marcus', 'Newton', 52, 277, '1953-11-28', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (102, 105, 54) ;
INSERT INTO auth (login, password1, name) VALUES ('rhinoplasty1869@live.com', 'TX4940ZD05', 'Efrain') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3670, 835482, '1951-01-03', 'Paz', 'Ball', 'male', 'Fuel Merchant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (278, 952141, 76829, 3670, 835482, '+45232241737') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2000-01-06T14:57:00.117659', '2000-01-11T14:57:00.117659', 'Haskell features a type s') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (106, 34) ;
INSERT INTO auth (login, password1, name) VALUES ('debilitate2032@outlook.com', 'VJ3511EL50', 'Bobbie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tyron', 'Ortega', 10, 279, '1954-11-09', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('poesy1939@outlook.com', 'CC6606NE17', 'Myles') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jeffrey', 'England', 32, 280, '1993-05-13', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (103, 104) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('It is also a garbage-coll', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('alleluia1947@outlook.com', 'BB2576QV50', 'Leon') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8920, 706496, '1998-05-15', 'Shelby', 'Neal', 'female', 'Bacon Curer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (281, 022521, 87582, 8920, 706496, '+94170345134') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (35, 107) ;
INSERT INTO auth (login, password1, name) VALUES ('dwale2050@outlook.com', 'TT7292KH60', 'Antone') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5052, 395298, '1965-03-27', 'Milton', 'Kim', 'male', 'Textile Engineer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (282, 343612, 15849, 5052, 395298, '+08784695725') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Erlang is known for its d', '2011-10-19 14:37:24.395153', 'The arguments can be prim') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (108, 15) ;
INSERT INTO auth (login, password1, name) VALUES ('dastardly1934@gmail.com', 'IC1498GH06', 'Christopher') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1156, 194312, '1955-08-08', 'Yulanda', 'Yates', 'female', 'Bill Poster') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (283, 249139, 83314, 1156, 194312, '+78773401627') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('54846', '2019-10-25 11:00:55.671630', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('snobby1955@yandex.com', 'YE4801MV88', 'Luciano') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Raleigh', 'Bush', 78, 284, '2006-07-01', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (105, 109, 55) ;
INSERT INTO auth (login, password1, name) VALUES ('marcello1885@yahoo.com', 'UF0892PZ26', 'Chauncey') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0435, 861635, '1990-11-15', 'Albertina', 'Prince', 'female', 'Machine Tool') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (285, 661494, 29670, 0435, 861635, '+25381308759') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-04-05T12:28:28.809742', '2019-04-12T12:28:28.809742', 'Tuples are containers for') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (110, 35) ;
INSERT INTO auth (login, password1, name) VALUES ('boodie1803@live.com', 'FP7935KY35', 'Isaiah') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Sana', 'Slater', 8, 286, '1987-01-16', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('consultary1933@yahoo.com', 'VS5448OL91', 'Arthur') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kristofer', 'Malone', 5, 287, '1999-03-25', 'nurse', 'female') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (106, 107) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Haskell is a standardized', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('boran1921@live.com', 'IU3695MG56', 'Brenton') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1755, 353871, '1974-02-19', 'Horace', 'Travis', 'male', 'Chauffeur') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (288, 550840, 40887, 1755, 353871, '+33426805663') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (36, 111) ;
INSERT INTO auth (login, password1, name) VALUES ('unawakableness1913@gmail.com', 'JU8198SF78', 'Zachery') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6064, 469110, '1961-05-15', 'Wilber', 'Stokes', 'male', 'Radio Operator') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (289, 887541, 37491, 6064, 469110, '+89879306996') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Do you come here often? T', '2017-01-27 12:30:43.352603', 'Ports are created with th') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (112, 16) ;
INSERT INTO auth (login, password1, name) VALUES ('sabed1939@gmail.com', 'EF8260HH11', 'Gema') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3695, 827220, '2007-12-16', 'Otis', 'Nguyen', 'male', 'Statistician') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (290, 298932, 57613, 3695, 827220, '+40293417120') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('32077', '2015-12-01 13:46:08.562291', 'Haskell features a type s') ;
INSERT INTO auth (login, password1, name) VALUES ('transform1842@live.com', 'LA1869UF99', 'Nelia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ula', 'Perez', 57, 291, '1962-12-30', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (108, 113, 56) ;
INSERT INTO auth (login, password1, name) VALUES ('glomerate1938@yandex.com', 'SF3300FH20', 'Arnette') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2642, 390180, '2002-08-22', 'Christopher', 'Gonzales', 'female', 'Saddler') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (292, 641290, 51964, 2642, 390180, '+06195345498') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2009-01-11T16:16:24.536848', '2009-01-18T16:16:24.536848', 'It is also a garbage-coll') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (114, 36) ;
INSERT INTO auth (login, password1, name) VALUES ('nobelist1890@yahoo.com', 'JB8621BE09', 'Leandro') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Leisha', 'Santos', 48, 293, '2009-09-11', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('avuncular2068@outlook.com', 'UQ4041HD94', 'Danny') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Augustus', 'Armstrong', 17, 294, '1989-11-01', 'nurse', 'female') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (109, 110) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Where are my pants? Do yo', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('pagandoms1958@gmail.com', 'MF2033VZ41', 'Brendan') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8680, 168833, '1955-05-26', 'Shandra', 'Martinez', 'female', 'Physician') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (295, 980990, 13611, 8680, 168833, '+77720971994') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (37, 115) ;
INSERT INTO auth (login, password1, name) VALUES ('abime1863@outlook.com', 'YP5790GR13', 'Soo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7138, 377992, '1970-03-10', 'Garland', 'Stevenson', 'male', 'Millwright') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (296, 897812, 16130, 7138, 377992, '+14455368534') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Ports are created with th', '2008-09-06 13:13:35.049626', 'Ports are used to communi') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (116, 17) ;
INSERT INTO auth (login, password1, name) VALUES ('touchable2056@outlook.com', 'HR3099DH48', 'Hana') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1025, 509097, '2004-06-28', 'Aurelio', 'Salas', 'male', 'Television Engineer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (297, 678064, 01948, 1025, 509097, '+63444503610') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('15560', '2001-04-19 12:39:11.999435', 'Messages can be sent to a') ;
INSERT INTO auth (login, password1, name) VALUES ('expansible2067@outlook.com', 'KU1487CT37', 'Joella') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Darell', 'England', 92, 298, '1992-11-06', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (111, 117, 57) ;
INSERT INTO auth (login, password1, name) VALUES ('adapa1978@outlook.com', 'SD5000TU29', 'Karmen') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9894, 702381, '2014-04-15', 'Reanna', 'Phelps', 'male', 'Trout Farmer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (299, 688331, 83020, 9894, 702381, '+02310748708') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2017-11-10T13:52:09.759147', '2017-11-14T13:52:09.759147', 'Initially composing light') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (118, 37) ;
INSERT INTO auth (login, password1, name) VALUES ('dacryoadenitis1805@live.com', 'PO3482DW32', 'Hubert') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ara', 'Mercado', 32, 300, '1971-05-04', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('blacky1837@gmail.com', 'AP4160HV81', 'Elwood') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Nathan', 'Patrick', 72, 301, '1995-08-24', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (112, 113) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you come here often? T', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('tromometric1948@gmail.com', 'MU5411WP71', 'Bill') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4785, 388059, '1983-02-09', 'Ned', 'Monroe', 'male', 'Military Leader') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (302, 318620, 14821, 4785, 388059, '+93869787811') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (38, 119) ;
INSERT INTO auth (login, password1, name) VALUES ('compellable1949@yandex.com', 'MP6939FC29', 'Maynard') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5316, 729527, '2005-05-09', 'Oralee', 'Oconnor', 'male', 'Tacker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (303, 974079, 09869, 5316, 729527, '+35674988260') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Haskell features a type s', '2006-12-28 12:28:29.313153', 'Any element of a tuple ca') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (120, 18) ;
INSERT INTO auth (login, password1, name) VALUES ('semiticism1946@live.com', 'NT5161QH79', 'Ty') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2646, 411532, '2013-04-14', 'Cary', 'Stafford', 'male', 'Lathe Operator') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (304, 483598, 16017, 2646, 411532, '+39531938464') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('35976', '2001-05-31 15:57:10.967852', 'Haskell features a type s') ;
INSERT INTO auth (login, password1, name) VALUES ('branchful1968@gmail.com', 'MJ5123BB89', 'Shakira') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Qiana', 'Newton', 52, 305, '1958-11-24', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (114, 121, 58) ;
INSERT INTO auth (login, password1, name) VALUES ('bellboy2006@yandex.com', 'KA0606WA32', 'Samual') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2204, 133485, '1951-04-03', 'Cheryll', 'Bullock', 'male', 'Tyre Fitter') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (306, 054206, 79761, 2204, 133485, '+31570840381') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2009-04-28T16:29:55.964733', '2009-05-01T16:29:55.964733', 'In 1989 the building was ') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (122, 38) ;
INSERT INTO auth (login, password1, name) VALUES ('benjie1867@gmail.com', 'LM7167JY57', 'Adan') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Florrie', 'Manning', 10, 307, '1997-03-26', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('allergy1858@yahoo.com', 'LK7372OL10', 'Dannette') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Torrie', 'Mejia', 37, 308, '1995-02-28', 'nurse', 'female') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (115, 116) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('It is also a garbage-coll', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('coyish1959@gmail.com', 'LF5191QC06', 'Tanna') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2674, 264196, '1963-04-06', 'Joaquina', 'Soto', 'male', 'Aerobic Instructor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (309, 308512, 77196, 2674, 264196, '+77372596584') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (39, 123) ;
INSERT INTO auth (login, password1, name) VALUES ('boarding1910@yandex.com', 'GX1408GY33', 'Shea') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4447, 567659, '1971-05-06', 'Gwyn', 'Ballard', 'male', 'Lighthouse Keeper') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (310, 162577, 04554, 4447, 567659, '+68512837362') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Ports are created with th', '2001-03-03 15:38:08.633409', 'Atoms are used within a p') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (124, 19) ;
INSERT INTO auth (login, password1, name) VALUES ('killas1985@yahoo.com', 'QI6226YB83', 'Jann') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7145, 070588, '2006-08-10', 'Dong', 'Meyers', 'female', 'Money Broker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (311, 456017, 53341, 7145, 070588, '+40576046566') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('67391', '2014-12-09 11:35:09.112770', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO auth (login, password1, name) VALUES ('arney1886@live.com', 'JH7381RY20', 'Song') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ilda', 'Mathews', 51, 312, '1995-10-06', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (117, 125, 59) ;
INSERT INTO auth (login, password1, name) VALUES ('catbird1947@gmail.com', 'MW2121VW86', 'Tiffaney') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0833, 799805, '1995-10-20', 'Laree', 'Gardner', 'male', 'Caretaker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (313, 364653, 67951, 0833, 799805, '+50455107248') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2015-04-06T11:40:22.946510', '2015-04-08T11:40:22.946510', 'Ports are created with th') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (126, 39) ;
INSERT INTO auth (login, password1, name) VALUES ('eupeptically1978@yandex.com', 'PN1592OS71', 'Alejandro') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Magaret', 'Small', 15, 314, '1977-12-24', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('eggfish1981@yandex.com', 'WR1786UA41', 'Latashia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Levi', 'Weeks', 83, 315, '2007-12-14', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (118, 119) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('It is also a garbage-coll', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('astonisher1872@outlook.com', 'OZ5342VA22', 'Javier') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1920, 551620, '1997-02-11', 'Russell', 'Orr', 'male', 'Transport Planner') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (316, 129246, 34150, 1920, 551620, '+62829389599') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (40, 127) ;
INSERT INTO auth (login, password1, name) VALUES ('congregant1991@yandex.com', 'UL5555US15', 'Marica') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4385, 150760, '2002-05-03', 'Sha', 'Jones', 'female', 'Upholsterer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (317, 327122, 66894, 4385, 150760, '+22102696495') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Ports are created with th', '2008-08-19 15:53:44.961994', 'Atoms can contain any cha') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (128, 20) ;
INSERT INTO auth (login, password1, name) VALUES ('acryl1891@yandex.com', 'XX8253HR54', 'Darren') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0336, 250862, '1967-01-24', 'Shantay', 'Berg', 'female', 'Psychiatrist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (318, 856348, 48361, 0336, 250862, '+72900413633') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('66480', '2018-03-22 11:34:09.095850', 'Do you have any idea why ') ;
INSERT INTO auth (login, password1, name) VALUES ('derivedness1958@yandex.com', 'OJ5509CR78', 'Lang') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Denisha', 'Morgan', 39, 319, '1985-04-23', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (120, 129, 60) ;
INSERT INTO auth (login, password1, name) VALUES ('capomo2058@yahoo.com', 'DO2293LA89', 'Stephen') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2894, 990284, '2012-01-24', 'Willette', 'Mcmillan', 'male', 'Health Care Assistant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (320, 326528, 62732, 2894, 990284, '+30302566206') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2004-08-23T12:35:47.393197', '2004-08-29T12:35:47.393197', 'Type classes first appear') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (130, 40) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Type classes first appear', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('wising1967@yahoo.com', 'OQ3444LV13', 'Vern') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lourie', 'Knight', 83, 321, '1977-09-25', 'doctor', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (41, 121) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-12-31T14:51:43.451567', '2013-01-03T14:51:43.451567', 'Do you come here often? D') ;
INSERT INTO auth (login, password1, name) VALUES ('squibling1926@gmail.com', 'QB3509OK50', 'Morgan') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Genaro', 'Suarez', 26, 322, '1963-08-05', 'nurse', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (122, 41, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('multifilament1818@live.com', 'KN4208ZB26', 'Lieselotte') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dannielle', 'Dennis', 84, 323, '2016-01-28', 'IT_administrator', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (42, 123) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2011-11-09T13:14:08.308086', '2011-11-15T13:14:08.308086', 'Erlang is known for its d') ;
INSERT INTO auth (login, password1, name) VALUES ('briar1829@gmail.com', 'IT9187CA78', 'Sandy') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Azzie', 'Mccullough', 23, 324, '1955-12-19', 'doctor', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (124, 42, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms are used within a p', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('trippet1938@yahoo.com', 'JH5357AW08', 'Herman') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Erich', 'Emerson', 47, 325, '2009-11-21', 'doctor', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (43, 125) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2018-01-23T16:55:44.953083', '2018-01-29T16:55:44.953083', 'The arguments can be prim') ;
INSERT INTO auth (login, password1, name) VALUES ('imbonity1828@outlook.com', 'PD4059IQ09', 'Shawanda') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Junko', 'David', 79, 326, '2004-06-02', 'IT_administrator', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (126, 43, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you have any idea why ', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('uranite1895@yahoo.com', 'UN6817HD12', 'Rickie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rocco', 'Hubbard', 18, 327, '1988-06-18', 'nurse', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (44, 127) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2004-03-25T13:48:07.133555', '2004-03-29T13:48:07.133555', 'He looked inquisitively a') ;
INSERT INTO auth (login, password1, name) VALUES ('deuteron2013@yandex.com', 'XV8683OP07', 'Valeri') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Demetrice', 'Love', 15, 328, '2011-11-23', 'security', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (128, 44, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Make me a sandwich. The G', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('cocooned2034@gmail.com', 'CO3564YZ20', 'Hobert') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Cory', 'Craig', 54, 329, '1978-11-14', 'doctor', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (45, 129) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-09-30T12:27:50.297177', '2019-10-06T12:27:50.297177', 'I dont even care. Its mai') ;
INSERT INTO auth (login, password1, name) VALUES ('eastland1832@outlook.com', 'NG3079QI63', 'Junior') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ellis', 'Burris', 72, 330, '2013-05-23', 'security', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (130, 45, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('stork1887@yandex.com', 'WE5199TM13', 'Jamal') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Carlos', 'Hodge', 25, 331, '1982-05-15', 'doctor', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (46, 131) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2014-02-24T14:59:35.271341', '2014-03-01T14:59:35.271341', 'Do you have any idea why ') ;
INSERT INTO auth (login, password1, name) VALUES ('sherramoor1926@live.com', 'IW6895PS77', 'Hien') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Glen', 'Mcconnell', 56, 332, '2013-12-05', 'administrator', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (132, 46, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Haskell is a standardized', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('bobbee2034@yahoo.com', 'OI7379VQ38', 'Cedrick') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Cordell', 'Snyder', 74, 333, '1964-04-05', 'IT_administrator', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (47, 133) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-06-18T14:29:42.292692', '2013-06-21T14:29:42.292692', 'Any element of a tuple ca') ;
INSERT INTO auth (login, password1, name) VALUES ('canthuthi1851@outlook.com', 'MY4561HU15', 'Toshiko') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Aron', 'Roth', 49, 334, '1988-10-24', 'nurse', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (134, 47, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you have any idea why ', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('chenault2070@yahoo.com', 'HO5484LF41', 'Nguyet') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dante', 'Conley', 86, 335, '2003-11-30', 'IT_administrator', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (48, 135) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2000-07-28T15:27:11.299361', '2000-08-02T15:27:11.299361', 'The sequential subset of ') ;
INSERT INTO auth (login, password1, name) VALUES ('absorbed1907@yandex.com', 'IO4083YS02', 'Denyse') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Willard', 'Reed', 64, 336, '1974-06-25', 'nurse', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (136, 48, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('They are written as strin', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('audette1919@live.com', 'RT1409RZ05', 'Arlie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Gordon', 'Hooper', 63, 337, '2006-04-07', 'doctor', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (49, 137) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2018-06-24T15:12:33.701172', '2018-06-30T15:12:33.701172', 'Messages can be sent to a') ;
INSERT INTO auth (login, password1, name) VALUES ('countor1991@live.com', 'LE3637WD71', 'Romeo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dustin', 'Cherry', 83, 338, '1971-06-03', 'doctor', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (138, 49, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms are used within a p', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('unmelted1915@yahoo.com', 'DY8765XG54', 'Isreal') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Delmy', 'Wilkins', 21, 339, '1962-06-10', 'doctor', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (50, 139) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-09-09T11:08:28.575888', '2019-09-15T11:08:28.575888', 'I dont even care. It is a') ;
INSERT INTO auth (login, password1, name) VALUES ('impertinentness2050@gmail.com', 'IN7099UI67', 'Elvie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rheba', 'Craft', 73, 340, '1982-10-19', 'administrator', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (140, 50, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The sequential subset of ', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('codeias2065@gmail.com', 'QL7071RX52', 'Nigel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Mariano', 'Workman', 20, 341, '2013-07-07', 'nurse', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (51, 141) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-05-02T14:59:43.035932', '2013-05-06T14:59:43.035932', 'Its main implementation i') ;
INSERT INTO auth (login, password1, name) VALUES ('hypoiodous2005@yandex.com', 'VM5367UW23', 'Esteban') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kirby', 'Floyd', 52, 342, '1955-07-06', 'nurse', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (142, 51, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Messages can be sent to a', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('irony2048@outlook.com', 'CF9109GM08', 'Lean') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Vania', 'Blackwell', 25, 343, '2003-10-15', 'nurse', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (52, 143) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-10-07T14:43:25.844776', '2012-10-12T14:43:25.844776', 'They are written as strin') ;
INSERT INTO auth (login, password1, name) VALUES ('degenerative2002@gmail.com', 'EF3232SA67', 'Charmain') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Harrison', 'Hurst', 46, 344, '1967-11-07', 'administrator', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (144, 52, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('robin1800@yahoo.com', 'JS8463FL92', 'Lurlene') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tamica', 'Stevenson', 1, 345, '1994-06-03', 'nurse', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (53, 145) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2018-02-17T16:13:50.986334', '2018-02-21T16:13:50.986334', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('locust1941@yahoo.com', 'QU3102CJ01', 'Tobie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tynisha', 'Hensley', 70, 346, '1998-11-14', 'doctor', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (146, 53, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('I dont even care. Ports a', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('myrmecoid1841@yahoo.com', 'TW3862TZ27', 'Winfred') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Season', 'Salas', 73, 347, '1973-11-27', 'doctor', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (54, 147) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2001-08-21T11:56:35.571487', '2001-08-28T11:56:35.571487', 'Any element of a tuple ca') ;
INSERT INTO auth (login, password1, name) VALUES ('shrew1994@yandex.com', 'OJ9744QB11', 'Rosy') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Cathern', 'Stone', 56, 348, '1988-02-20', 'doctor', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (148, 54, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Messages can be sent to a', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('antonin1818@yahoo.com', 'ES8309DC78', 'Hassan') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Hiroko', 'Moore', 38, 349, '1990-05-17', 'IT_administrator', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (55, 149) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2010-10-03T10:54:03.550438', '2010-10-06T10:54:03.550438', 'The Galactic Empire is ne') ;
INSERT INTO auth (login, password1, name) VALUES ('surahs1995@live.com', 'IT1045IY32', 'Kristian') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Elvis', 'Taylor', 46, 350, '1986-01-14', 'doctor', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (150, 55, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Type classes first appear', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('binda1977@outlook.com', 'RW6075NW66', 'Shirleen') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Damon', 'Swanson', 69, 351, '1976-10-05', 'doctor', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (56, 151) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2003-03-07T16:41:31.796958', '2003-03-09T16:41:31.796958', 'They are written as strin') ;
INSERT INTO auth (login, password1, name) VALUES ('chimu1866@gmail.com', 'IT8548RB16', 'Sol') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rosendo', 'Valencia', 71, 352, '1954-12-04', 'nurse', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (152, 56, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('surreal1955@gmail.com', 'FL5716JC97', 'Gwyneth') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Willie', 'Norton', 22, 353, '1959-10-04', 'administrator', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (57, 153) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2006-10-29T13:02:36.170056', '2006-11-03T13:02:36.170056', 'The arguments can be prim') ;
INSERT INTO auth (login, password1, name) VALUES ('bribe2058@live.com', 'UR8615WG65', 'Cassaundra') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lloyd', 'Higgins', 91, 354, '1950-06-04', 'administrator', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (154, 57, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Ports are created with th', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('bolete2069@live.com', 'VS8370RF23', 'Rodrick') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Herschel', 'Bridges', 18, 355, '1984-04-02', 'nurse', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (58, 155) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2015-10-28T13:01:36.807178', '2015-11-04T13:01:36.807178', 'Any element of a tuple ca') ;
INSERT INTO auth (login, password1, name) VALUES ('alexandrite1939@yahoo.com', 'WK3910FG63', 'Wonda') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dorla', 'Maynard', 12, 356, '1968-08-21', 'nurse', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (156, 58, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Messages can be sent to a', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('cecon1972@gmail.com', 'QC3368RE31', 'Carey') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Gus', 'Huber', 34, 357, '1988-12-19', 'doctor', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (59, 157) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2018-04-07T11:26:20.049459', '2018-04-09T11:26:20.049459', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('bolio2062@yandex.com', 'XU0835EZ20', 'Eusebio') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Arnulfo', 'Salinas', 37, 358, '2017-05-13', 'security', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (158, 59, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Haskell is a standardized', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('adriaan2026@outlook.com', 'AL3057SI02', 'Ludivina') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Preston', 'Lowe', 39, 359, '1969-05-04', 'IT_administrator', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (60, 159) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2002-06-06T13:23:04.338032', '2002-06-11T13:23:04.338032', 'Type classes first appear') ;
INSERT INTO auth (login, password1, name) VALUES ('vulgarian2034@gmail.com', 'CD4862EZ65', 'Kiera') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rosio', 'Hooper', 80, 360, '1957-11-07', 'doctor', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (160, 60, 'closed') ;