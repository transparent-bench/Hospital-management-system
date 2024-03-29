-- dump file for MySQL 5.7
DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

-- auth

CREATE TABLE IF NOT EXISTS auth(
  id int AUTO_INCREMENT,
  login varchar(255) UNIQUE,
  password1 varchar(20),
  name varchar(20),
  PRIMARY KEY (id)
);


-- passport
CREATE TABLE IF NOT EXISTS passport (
  seria int check (seria > 0),
  number int check (number > 0),
  birth datetime(0),
  f_name varchar(50),
  l_name varchar(50),
  gender enum ('male', 'female'),
  address varchar(100),
  PRIMARY KEY (seria, number)
);

-- staff
CREATE TABLE IF NOT EXISTS staff(
  id int AUTO_INCREMENT,
  first_name varchar(20),
  last_name varchar(20),
  room int,
  auth_id int,
  birthday date,
  position enum ('doctor', 'administrator', 'nurse', 'security', 'IT_administrator'),
  gender ENUM ('male', 'female'),
  FOREIGN KEY (auth_id) REFERENCES auth(id),
  PRIMARY KEY (id)
);

-- camera
CREATE TABLE IF NOT EXISTS camera (
  id int AUTO_INCREMENT,
  name varchar(200),
  LOCATION POINT,
  staff_id INT,
  FOREIGN KEY (staff_id) REFERENCES staff(id),
  PRIMARY key (id)
);

-- patient
CREATE TABLE IF NOT EXISTS patient (
  id int AUTO_INCREMENT,
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
CREATE TABLE IF NOT EXISTS complain (
  id int AUTO_INCREMENT,
  theme varchar(50),
  creation_date datetime(0),
  complain_text varchar(255),
  PRIMARY KEY (id)
);

-- ticket
CREATE TABLE IF NOT EXISTS ticket (
  id int AUTO_INCREMENT,
  ticket_text varchar(255),
  creation_date datetime(0),
  closing_date datetime(0),
  PRIMARY KEY (id)
);

-- notification
CREATE TABLE IF NOT EXISTS notification (
  id int AUTO_INCREMENT,
  notification_text varchar(255),
  notification_status ENUM('open', 'closed'),
  PRIMARY KEY (id)
);

-- invoice
CREATE TABLE IF NOT EXISTS invoice(
  id int AUTO_INCREMENT,
  amount int check (amount > 0),
  date_of_creation datetime(0),
  reason varchar(255),
  PRIMARY KEY (id)
);

-- appointment
CREATE TABLE IF NOT EXISTS appointment(
  id int AUTO_INCREMENT,
  occurrence_date datetime(0),
  diagnosis varchar(255),
  description varchar(255),
  reason_to_create varchar(255),
  PRIMARY KEY (id)
);

-- appointment_patient_doctor_relation
CREATE TABLE IF NOT EXISTS appointment_patient_doctor_relation (
  id int AUTO_INCREMENT,
  appointment_id int,
  patient_id int,
  doctor_id int,
  FOREIGN KEY (appointment_id) REFERENCES appointment(id),
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  FOREIGN KEY (doctor_id) REFERENCES staff(id),
  PRIMARY KEY (id)
);

-- patient_ticket_relation
CREATE TABLE IF NOT EXISTS patient_ticket_relation(
  id int AUTO_INCREMENT,
  patient_id int,
  ticket_id int,
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  FOREIGN KEY (ticket_id) REFERENCES ticket(id),
  PRIMARY KEY (id)
);

-- staff_ticket_relation
CREATE TABLE staff_ticket_relation(
  id int AUTO_INCREMENT,
  staff_id int,
  ticket_id int,
  ticket_status ENUM('open', 'closed'),
  FOREIGN KEY (staff_id) REFERENCES staff(id),
  FOREIGN KEY (ticket_id) REFERENCES ticket(id),
  PRIMARY KEY (id)
);

-- notification_staff_relation
CREATE TABLE notification_staff_relation(
  id int AUTO_INCREMENT,
  notification_id int,
  staff_id int,
  FOREIGN KEY (notification_id) REFERENCES notification(id),
  FOREIGN KEY (staff_id) REFERENCES staff(id),
  PRIMARY KEY (id)
);

-- notification_patient_relation
CREATE TABLE notification_patient_relation(
  id int AUTO_INCREMENT,
  notification_id int,
  patient_id int,
  FOREIGN KEY (notification_id) REFERENCES notification(id),
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  PRIMARY KEY (id)
);

-- patient_invoice_staff_relation
CREATE TABLE patient_invoice_staff_relation (
  id int AUTO_INCREMENT,
  staff_id int,
  patient_id int,
  invoice_id int,
  FOREIGN KEY (staff_id) REFERENCES staff(id),
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  FOREIGN KEY (invoice_id) REFERENCES invoice(id),
  PRIMARY KEY (id)
);

-- patient_complain_relation
CREATE TABLE patient_complain_relation(
  id int AUTO_INCREMENT,
  patient_id int,
  complain_id int,
  FOREIGN KEY (patient_id) REFERENCES patient(id),
  FOREIGN KEY (complain_id) REFERENCES complain(id),
  PRIMARY KEY (id)
);

-- doctor_nurse_relation
CREATE TABLE IF NOT EXISTS doctor_nurse_relation (
  id int AUTO_INCREMENT,
  doctor_id int,
  nurse_id int,
  FOREIGN KEY (doctor_id) REFERENCES staff(id),
  FOREIGN KEY (nurse_id) REFERENCES staff(id),
  PRIMARY KEY (id)
);

INSERT INTO auth (login, password1, name) VALUES ('nonphysiologically1882@outlook.com', 'BV3212CZ69', 'Leslie') ;
INSERT INTO auth (login, password1, name) VALUES ('ardea1920@gmail.com', 'GU3860LN75', 'Jeffery') ;
INSERT INTO auth (login, password1, name) VALUES ('tableau1997@outlook.com', 'DG4338VR07', 'Demetrius') ;
INSERT INTO auth (login, password1, name) VALUES ('reservery1969@gmail.com', 'FJ7307KP85', 'Jacquelyne') ;
INSERT INTO auth (login, password1, name) VALUES ('restipulatory1808@yahoo.com', 'SM9531JV13', 'Enola') ;
INSERT INTO auth (login, password1, name) VALUES ('bribe1989@yahoo.com', 'JW8282LY61', 'Mila') ;
INSERT INTO auth (login, password1, name) VALUES ('daylights1925@yandex.com', 'OJ1146EX19', 'Thanh') ;
INSERT INTO auth (login, password1, name) VALUES ('seal2012@live.com', 'KJ9261KD77', 'Johnson') ;
INSERT INTO auth (login, password1, name) VALUES ('skipjack1820@gmail.com', 'WO4862OA98', 'Shani') ;
INSERT INTO auth (login, password1, name) VALUES ('argento1963@yahoo.com', 'TT9319JL80', 'Clark') ;
INSERT INTO auth (login, password1, name) VALUES ('stripling1882@outlook.com', 'FZ0051SI88', 'Carie') ;
INSERT INTO auth (login, password1, name) VALUES ('jarbird1885@yandex.com', 'QK4066IU69', 'Macie') ;
INSERT INTO auth (login, password1, name) VALUES ('yealing1803@yandex.com', 'VH9918AY65', 'Andrew') ;
INSERT INTO auth (login, password1, name) VALUES ('recycled1809@gmail.com', 'PF6567WA01', 'Riva') ;
INSERT INTO auth (login, password1, name) VALUES ('kabiki1969@outlook.com', 'ED6793YU70', 'Titus') ;
INSERT INTO auth (login, password1, name) VALUES ('invigoration1968@gmail.com', 'OE9705DA93', 'Cyrus') ;
INSERT INTO auth (login, password1, name) VALUES ('patching1979@yandex.com', 'HY0978QB34', 'Fausto') ;
INSERT INTO auth (login, password1, name) VALUES ('bolete2007@yahoo.com', 'FA8515QA31', 'Jarvis') ;
INSERT INTO auth (login, password1, name) VALUES ('blunter1890@live.com', 'YG1642CL97', 'Loreen') ;
INSERT INTO auth (login, password1, name) VALUES ('anticyclone1921@yahoo.com', 'MB0306QM80', 'Alan') ;
INSERT INTO auth (login, password1, name) VALUES ('coggly1998@yahoo.com', 'KX9323PX67', 'Steven') ;
INSERT INTO auth (login, password1, name) VALUES ('quebrachos2006@outlook.com', 'BU9220GD80', 'Edyth') ;
INSERT INTO auth (login, password1, name) VALUES ('outplodding1888@gmail.com', 'KB2298YT12', 'Gabriele') ;
INSERT INTO auth (login, password1, name) VALUES ('skinkers1909@outlook.com', 'KD6253YT87', 'Jared') ;
INSERT INTO auth (login, password1, name) VALUES ('nonstereotyped2068@yandex.com', 'DG9239VP18', 'Rivka') ;
INSERT INTO auth (login, password1, name) VALUES ('anvil1967@gmail.com', 'CY3245CX02', 'Bernetta') ;
INSERT INTO auth (login, password1, name) VALUES ('cassat1973@outlook.com', 'BM7607OM37', 'Don') ;
INSERT INTO auth (login, password1, name) VALUES ('hamline2050@gmail.com', 'BE9461WT87', 'Alvin') ;
INSERT INTO auth (login, password1, name) VALUES ('dimension1880@yandex.com', 'SZ9673TJ20', 'Na') ;
INSERT INTO auth (login, password1, name) VALUES ('copperleaf1969@live.com', 'BI2163OS26', 'Stanton') ;
INSERT INTO auth (login, password1, name) VALUES ('uvulectomy1915@yahoo.com', 'SJ6865EV97', 'Thad') ;
INSERT INTO auth (login, password1, name) VALUES ('retractor1912@outlook.com', 'XI9483RP91', 'Kiley') ;
INSERT INTO auth (login, password1, name) VALUES ('arock1840@outlook.com', 'UZ2391HX44', 'Jadwiga') ;
INSERT INTO auth (login, password1, name) VALUES ('ental1893@outlook.com', 'IL5515EW71', 'Keith') ;
INSERT INTO auth (login, password1, name) VALUES ('ultrasonic1870@live.com', 'AJ5164GX26', 'Nam') ;
INSERT INTO auth (login, password1, name) VALUES ('arctalian1890@outlook.com', 'HD6405UN12', 'Maybell') ;
INSERT INTO auth (login, password1, name) VALUES ('cocain1826@gmail.com', 'DE1990SS96', 'Harland') ;
INSERT INTO auth (login, password1, name) VALUES ('palmira2033@live.com', 'EM6223OI08', 'Shirley') ;
INSERT INTO auth (login, password1, name) VALUES ('cadging2023@yandex.com', 'OE6540UV85', 'Shaun') ;
INSERT INTO auth (login, password1, name) VALUES ('nondenotative1944@yahoo.com', 'BO2713GS47', 'Gary') ;
INSERT INTO auth (login, password1, name) VALUES ('ballsy1995@yahoo.com', 'YP7531ET97', 'Grady') ;
INSERT INTO auth (login, password1, name) VALUES ('brackets2061@yahoo.com', 'FE7506NI22', 'Clarine') ;
INSERT INTO auth (login, password1, name) VALUES ('jaborin1946@yahoo.com', 'TD9177UI42', 'Torri') ;
INSERT INTO auth (login, password1, name) VALUES ('backgammon1880@live.com', 'WW3261QY38', 'Rasheeda') ;
INSERT INTO auth (login, password1, name) VALUES ('suedes1910@gmail.com', 'MP6144SL83', 'Geoffrey') ;
INSERT INTO auth (login, password1, name) VALUES ('angioleucitis1836@yandex.com', 'VV3927SZ97', 'Donovan') ;
INSERT INTO auth (login, password1, name) VALUES ('akita2069@yandex.com', 'PC4131JO95', 'Tracy') ;
INSERT INTO auth (login, password1, name) VALUES ('joiningly2041@yahoo.com', 'NY5502LO41', 'Randell') ;
INSERT INTO auth (login, password1, name) VALUES ('monopodes1999@live.com', 'DS7060YV24', 'Drucilla') ;
INSERT INTO auth (login, password1, name) VALUES ('mongeese1989@gmail.com', 'ZV8429NV99', 'Francisco') ;
INSERT INTO auth (login, password1, name) VALUES ('falconry2035@yandex.com', 'BK7923WH66', 'Emiko') ;
INSERT INTO auth (login, password1, name) VALUES ('quackster2002@outlook.com', 'HO3492UP43', 'Vashti') ;
INSERT INTO auth (login, password1, name) VALUES ('stong1893@gmail.com', 'DQ9254EQ85', 'Genevive') ;
INSERT INTO auth (login, password1, name) VALUES ('balmoral1810@live.com', 'ID4414CH38', 'Michel') ;
INSERT INTO auth (login, password1, name) VALUES ('annamaria1923@yandex.com', 'NL5441BB68', 'Verline') ;
INSERT INTO auth (login, password1, name) VALUES ('jetteau2042@gmail.com', 'KB6386NM90', 'Loriann') ;
INSERT INTO auth (login, password1, name) VALUES ('appleton1900@live.com', 'UQ6356TO46', 'Patrick') ;
INSERT INTO auth (login, password1, name) VALUES ('uninvigoratively1845@live.com', 'RK0798OW04', 'Aracelis') ;
INSERT INTO auth (login, password1, name) VALUES ('capistrano1927@outlook.com', 'QB8428CQ46', 'Fabian') ;
INSERT INTO auth (login, password1, name) VALUES ('arming1915@yahoo.com', 'SN4338HJ97', 'Latashia') ;
INSERT INTO auth (login, password1, name) VALUES ('cedric1983@yahoo.com', 'YS2829WN29', 'Titus') ;
INSERT INTO auth (login, password1, name) VALUES ('unshadily1996@gmail.com', 'QA9821CC31', 'Len') ;
INSERT INTO auth (login, password1, name) VALUES ('woesome2062@yahoo.com', 'ZO9481HA02', 'Barrett') ;
INSERT INTO auth (login, password1, name) VALUES ('europeanization1909@gmail.com', 'IR1256AV37', 'Dannette') ;
INSERT INTO auth (login, password1, name) VALUES ('pipits2025@yandex.com', 'IU2702QI30', 'Jeffry') ;
INSERT INTO auth (login, password1, name) VALUES ('prussic1867@gmail.com', 'IH9800WO00', 'Latashia') ;
INSERT INTO auth (login, password1, name) VALUES ('coral1860@yahoo.com', 'YU5351EP90', 'Caprice') ;
INSERT INTO auth (login, password1, name) VALUES ('discriminant1952@outlook.com', 'JS4378WV87', 'Danille') ;
INSERT INTO auth (login, password1, name) VALUES ('claimer1848@gmail.com', 'BA0874UX32', 'Nadene') ;
INSERT INTO auth (login, password1, name) VALUES ('claustrum1871@yandex.com', 'ZK3218HB74', 'Bennie') ;
INSERT INTO auth (login, password1, name) VALUES ('abhorrent2015@yandex.com', 'UB2429YA15', 'Wendie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Natalya', 'Olsen', 58, 71, '2000-04-23', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('discordia1814@yandex.com', 'RQ0273ID27', 'Isaac') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rutha', 'Mcgowan', 86, 72, '2016-07-10', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('biologists1812@yandex.com', 'GP2949BF48', 'Francisco') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Isiah', 'Alvarado', 39, 73, '1977-05-23', 'IT_administrator', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('49094', '2014-09-01 15:25:38.695023', 'Its main implementation i') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Ports are created with th', '2003-05-07 16:50:51.076997', 'The arguments can be prim') ;
INSERT INTO auth (login, password1, name) VALUES ('converse1952@live.com', 'SE0370IZ87', 'Samuel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Melany', 'Farrell', 12, 74, '2012-09-01', 'security', 'female') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Shea', POINT(96, 115), 4) ;
INSERT INTO auth (login, password1, name) VALUES ('butterfish1937@outlook.com', 'IV7519TT61', 'Bryant') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Teofila', 'Simmons', 45, 75, '1988-10-30', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('nonexpeditiousness1898@yahoo.com', 'OT4697UJ95', 'Theo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Scott', 'Lucas', 42, 76, '1966-02-17', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('depravities1963@outlook.com', 'LF3839EF96', 'Raul') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('King', 'Peterson', 43, 77, '1964-04-23', 'doctor', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('63640', '2006-01-01 12:14:15.914962', 'Tuples are containers for') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Where are my pants? Atoms', '2009-04-06 13:50:17.746986', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO auth (login, password1, name) VALUES ('spiring1981@live.com', 'BW9405TH41', 'Vinita') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jayson', 'Reid', 85, 78, '1971-08-23', 'security', 'female') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Jarod', POINT(145, 166), 8) ;
INSERT INTO auth (login, password1, name) VALUES ('benjie1874@live.com', 'LU1760WF48', 'Blake') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Quinton', 'Webster', 1, 79, '1964-11-13', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('ashlin1981@gmail.com', 'CY6168IL97', 'Jon') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jordon', 'Patton', 74, 80, '1968-11-20', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('penicilliform1860@gmail.com', 'YH7062XT59', 'Quincy') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ellan', 'Randall', 90, 81, '1972-11-05', 'administrator', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('45294', '2017-08-01 11:57:58.236072', 'Ports are created with th') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Erlang is a general-purpo', '2006-12-16 14:03:34.308390', 'Ports are used to communi') ;
INSERT INTO auth (login, password1, name) VALUES ('peatery1829@yandex.com', 'ZY6179TO15', 'Billye') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Laurice', 'Roth', 91, 82, '2015-04-02', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Randolph', POINT(56, 91), 12) ;
INSERT INTO auth (login, password1, name) VALUES ('carolus1976@yandex.com', 'XT6567IF11', 'Marlin') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Nestor', 'Bender', 90, 83, '2016-09-01', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('donga2029@gmail.com', 'XK4256TG68', 'Horace') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Leonel', 'Allen', 5, 84, '1965-08-28', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('schuit1874@gmail.com', 'SD4669DD49', 'Sylvie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dione', 'Stout', 20, 85, '1987-01-11', 'IT_administrator', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('34455', '2015-09-27 12:29:43.917997', 'Tuples are containers for') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('I dont even care. She spe', '2001-08-02 13:43:42.155400', 'Haskell is a standardized') ;
INSERT INTO auth (login, password1, name) VALUES ('arvin1879@yahoo.com', 'AX2720TZ44', 'Korey') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ronny', 'Richard', 1, 86, '1993-02-21', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Clarence', POINT(140, 103), 16) ;
INSERT INTO auth (login, password1, name) VALUES ('subelliptic1939@yandex.com', 'CQ9099ZG07', 'Nicholas') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Marybelle', 'Talley', 2, 87, '1993-08-26', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('goatroot2058@yahoo.com', 'WZ8943BH39', 'Doloris') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Wayne', 'Bell', 25, 88, '1973-09-22', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('climbed1919@live.com', 'EA1494XT29', 'Theron') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Garret', 'Cole', 11, 89, '1979-03-01', 'doctor', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('43158', '2012-07-23 15:22:16.707620', 'Ports are used to communi') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('She spent her earliest ye', '2000-10-16 12:42:34.563748', 'Do you have any idea why ') ;
INSERT INTO auth (login, password1, name) VALUES ('ashlie1867@yahoo.com', 'IT7379PR35', 'Hunter') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Stevie', 'Kerr', 40, 90, '1984-12-05', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Wava', POINT(140, 137), 20) ;
INSERT INTO auth (login, password1, name) VALUES ('dalt1828@outlook.com', 'IL7191RO49', 'Emory') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Shawnta', 'Shaw', 61, 91, '1955-03-11', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('caron1995@live.com', 'TM1585MM93', 'Vinnie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ayako', 'Workman', 77, 92, '1966-06-17', 'nurse', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('concretization1812@gmail.com', 'WU8270JB33', 'Vena') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Shaun', 'Kemp', 55, 93, '1963-01-05', 'security', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('55531', '2000-10-10 16:44:39.984229', 'Initially composing light') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Any element of a tuple ca', '2014-01-01 10:31:39.273446', 'Do you come here often? I') ;
INSERT INTO auth (login, password1, name) VALUES ('anthracnose1894@yahoo.com', 'IZ4380FE17', 'Rivka') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Billie', 'Hobbs', 82, 94, '1979-02-01', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Sandee', POINT(10, 138), 24) ;
INSERT INTO auth (login, password1, name) VALUES ('propositi1813@live.com', 'BY3295NX95', 'Darron') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Julio', 'Watkins', 79, 95, '1958-06-20', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('puffs1830@gmail.com', 'SO9152NT25', 'Eduardo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Sebrina', 'Kane', 26, 96, '2000-11-05', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('geologizing1833@yahoo.com', 'GJ1633FV71', 'Abe') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kennith', 'Mcbride', 64, 97, '2019-01-11', 'IT_administrator', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('19216', '2015-09-22 11:16:00.103023', 'They are written as strin') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Ports are created with th', '2002-06-06 10:28:39.649720', 'Haskell features a type s') ;
INSERT INTO auth (login, password1, name) VALUES ('blazers1875@yandex.com', 'WG2606KU49', 'Taunya') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Elenora', 'Barron', 23, 98, '1966-11-05', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Marchelle', POINT(17, 82), 28) ;
INSERT INTO auth (login, password1, name) VALUES ('combaz1813@outlook.com', 'WC5200AJ68', 'Nathaniel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dario', 'Hayden', 81, 99, '1953-10-16', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('stoat1908@yandex.com', 'NF4791YD64', 'Elton') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kory', 'Wooten', 39, 100, '2003-02-15', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('stallions1978@yandex.com', 'BS0876YP30', 'Marion') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jesusa', 'Gilmore', 41, 101, '1961-10-28', 'security', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('14255', '2004-08-15 12:58:09.478401', 'Its main implementation i') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('The arguments can be prim', '2004-06-06 12:43:59.800434', 'Ports are created with th') ;
INSERT INTO auth (login, password1, name) VALUES ('schoolbookish2050@outlook.com', 'ZN8091YA00', 'Scott') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Allyn', 'White', 13, 102, '2002-09-11', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Rupert', POINT(49, 160), 32) ;
INSERT INTO auth (login, password1, name) VALUES ('peelings1844@outlook.com', 'LK3109IV03', 'Casie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tyler', 'Payne', 65, 103, '1967-12-25', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('sunshiny2019@yahoo.com', 'TW6273CO99', 'Krysten') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Brant', 'Witt', 93, 104, '1984-09-07', 'nurse', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('swilltub2049@yahoo.com', 'WN1318ZJ95', 'Kennith') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kayce', 'Whitley', 21, 105, '1966-10-12', 'IT_administrator', 'male') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('79975', '2004-09-11 15:02:36.801078', 'The arguments can be prim') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('The arguments can be prim', '2017-07-21 11:24:29.542411', 'The arguments can be prim') ;
INSERT INTO auth (login, password1, name) VALUES ('vises1835@live.com', 'IN1621XN64', 'Corrinne') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Thora', 'Kaufman', 50, 106, '1992-11-01', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Fatimah', POINT(145, 157), 36) ;
INSERT INTO auth (login, password1, name) VALUES ('incognitos2062@live.com', 'EB6951XI49', 'Merrie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lauren', 'Combs', 84, 107, '1964-05-02', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('staurotide1903@live.com', 'BH0157ZV92', 'Mignon') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Carmine', 'Byrd', 7, 108, '2015-05-27', 'nurse', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('superstardom1960@live.com', 'FR8185GU82', 'Hai') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Neta', 'Bolton', 69, 109, '1950-05-14', 'IT_administrator', 'female') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('36894', '2005-10-20 13:04:58.033950', 'Do you have any idea why ') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('The Galactic Empire is ne', '2017-08-18 12:02:44.814426', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('tamias1978@live.com', 'QZ9914HK49', 'Michal') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Roberto', 'Howe', 49, 110, '1975-04-17', 'security', 'male') ;
INSERT INTO camera (name, location, staff_id) VALUES ('Armando', POINT(54, 101), 40) ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4395, 956343, '1989-05-26', 'Tempie', 'Watson', 'female', 'Hospital Doctor') ;
INSERT INTO auth (login, password1, name) VALUES ('constructor1831@yandex.com', 'HP1003XR19', 'Williams') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8347, 588770, '2013-12-16', 'Noble', 'Carey', 'female', 'Theatre Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (111, 701131, 27233, 8347, 588770, '+46973354124') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('25852', '2003-11-24 16:16:28.440702', 'Do you have any idea why ') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5611, 108907, '2008-05-12', 'Titus', 'Jacobs', 'female', 'Plant Manager') ;
INSERT INTO auth (login, password1, name) VALUES ('suing1903@yahoo.com', 'FB5944DZ40', 'Margareta') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4697, 413686, '1972-06-07', 'Cordia', 'Aguilar', 'male', 'Physiologist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (112, 704366, 91921, 4697, 413686, '+94085179065') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('20000', '2016-05-03 16:05:17.698256', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3040, 313113, '1974-04-13', 'Quentin', 'Cain', 'male', 'Marketing Coordinator') ;
INSERT INTO auth (login, password1, name) VALUES ('dog1947@live.com', 'UI1941OS14', 'Liberty') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7314, 184273, '2010-06-05', 'Jack', 'Bryan', 'female', 'Window Cleaner') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (113, 904520, 54893, 7314, 184273, '+75588091444') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('40993', '2009-05-29 14:45:09.326925', 'Initially composing light') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9690, 136278, '1984-12-09', 'Ed', 'Carson', 'female', 'IT Consultant') ;
INSERT INTO auth (login, password1, name) VALUES ('enhancer1962@yandex.com', 'OK4332IT01', 'Clemente') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2004, 309034, '1970-08-02', 'Evelin', 'Estes', 'female', 'Acoustic Engineer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (114, 492755, 07827, 2004, 309034, '+50211566290') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('80461', '2010-06-09 12:10:59.626892', 'Messages can be sent to a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2032, 820414, '2007-08-31', 'Fred', 'Whitley', 'male', 'Nursing Sister') ;
INSERT INTO auth (login, password1, name) VALUES ('fabrizio1856@outlook.com', 'UB7934EX27', 'Bryan') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2387, 792013, '1958-10-15', 'Johnathan', 'Collier', 'female', 'Claims Assessor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (115, 695623, 13666, 2387, 792013, '+59780337614') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('45989', '2000-05-26 14:08:06.544160', 'Ports are used to communi') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8576, 837391, '2015-02-20', 'Clemente', 'Watts', 'male', 'Turkey Farmer') ;
INSERT INTO auth (login, password1, name) VALUES ('subrector1806@live.com', 'WT5644BU60', 'Lorean') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9873, 157839, '2000-08-31', 'Tuan', 'Mendez', 'male', 'Mattress Maker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (116, 842532, 64870, 9873, 157839, '+39651991698') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('82998', '2011-03-25 15:03:08.367524', 'Atoms can contain any cha') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3750, 890052, '1953-12-09', 'Tinisha', 'Weber', 'female', 'Typesetter') ;
INSERT INTO auth (login, password1, name) VALUES ('superinference2066@outlook.com', 'WB4642UR68', 'Marybelle') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3985, 341480, '1998-11-29', 'Chasidy', 'Calhoun', 'male', 'Health Nurse') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (117, 303617, 46081, 3985, 341480, '+17829694445') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('92487', '2016-09-05 12:17:10.196941', 'She spent her earliest ye') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9198, 318455, '1987-08-21', 'Ron', 'Decker', 'female', 'Nutritionist') ;
INSERT INTO auth (login, password1, name) VALUES ('andrease1855@gmail.com', 'MN5422LI99', 'Desire') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9998, 737911, '2009-04-21', 'Lyle', 'Santos', 'female', 'Museum Assistant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (118, 739732, 03123, 9998, 737911, '+73832921235') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('26355', '2009-01-13 10:13:33.152688', 'He looked inquisitively a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9712, 049663, '1957-04-30', 'Hsiu', 'Everett', 'male', 'Postman') ;
INSERT INTO auth (login, password1, name) VALUES ('standardbred1985@outlook.com', 'ZR5164DH76', 'Shaunte') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8978, 690687, '1997-12-20', 'Devon', 'Sloan', 'female', 'Property Developer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (119, 159742, 77118, 8978, 690687, '+25883075504') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('14343', '2019-01-21 10:10:41.482577', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1117, 728267, '1972-04-14', 'Anderson', 'Velazquez', 'female', 'Pasteuriser') ;
INSERT INTO auth (login, password1, name) VALUES ('cantalas1958@outlook.com', 'FD6137GM58', 'Pearlene') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4239, 107486, '1958-04-07', 'Emmett', 'Gilliam', 'male', 'Gardener') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (120, 388182, 10183, 4239, 107486, '+42273320003') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('44979', '2003-11-07 13:17:55.015533', 'Where are my pants? Atoms') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7688, 862700, '1968-04-26', 'Sanford', 'Ellison', 'female', 'Steel Erector') ;
INSERT INTO auth (login, password1, name) VALUES ('brann1938@outlook.com', 'JU6594OE25', 'Jon') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1500, 894843, '2003-04-06', 'Rocco', 'Berger', 'female', 'Miner') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (121, 360965, 34104, 1500, 894843, '+34775585285') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('91101', '2008-07-12 13:53:15.203070', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1829, 876016, '1988-02-15', 'Lyla', 'Pacheco', 'female', 'Employee') ;
INSERT INTO auth (login, password1, name) VALUES ('undistinguished2058@live.com', 'DF2077QD12', 'Trinh') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1683, 312397, '1986-06-19', 'Milton', 'Salazar', 'male', 'Show Jumper') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (122, 607373, 93249, 1683, 312397, '+95377916344') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('37642', '2010-04-03 14:21:27.685569', 'She spent her earliest ye') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5442, 427084, '2006-11-18', 'Lanie', 'Rich', 'female', 'Anaesthetist') ;
INSERT INTO auth (login, password1, name) VALUES ('amarvel1897@outlook.com', 'OE1659SN01', 'Wilfredo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9544, 051024, '1981-08-11', 'Shavon', 'Bryant', 'male', 'Auctioneer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (123, 205824, 88708, 9544, 051024, '+38649463114') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('22283', '2016-04-25 14:22:34.071392', 'She spent her earliest ye') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8994, 207898, '1954-07-01', 'Galina', 'Sandoval', 'male', 'Vicar') ;
INSERT INTO auth (login, password1, name) VALUES ('dumper1886@live.com', 'VP6878ZV84', 'Brett') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7418, 235978, '1992-05-02', 'Raymond', 'Nichols', 'male', 'Homecare Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (124, 626979, 48245, 7418, 235978, '+28475218296') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('26516', '2019-08-05 12:57:23.426067', 'The sequential subset of ') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3583, 817416, '1984-12-15', 'Mirtha', 'Mccormick', 'female', 'Booking Clerk') ;
INSERT INTO auth (login, password1, name) VALUES ('everard1804@live.com', 'WK6421UU84', 'Rayford') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0944, 481302, '1990-07-05', 'Telma', 'Conner', 'female', 'Marine Pilot') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (125, 982816, 27671, 0944, 481302, '+67152249025') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('1465', '2001-02-08 15:02:16.543781', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8220, 607646, '1995-12-04', 'Thomas', 'Wells', 'male', 'Motor Dealer') ;
INSERT INTO auth (login, password1, name) VALUES ('enrica2040@outlook.com', 'MD1152PU73', 'Rusty') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2628, 560474, '1958-08-20', 'Jamey', 'Potts', 'female', 'Casual Worker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (126, 691592, 30623, 2628, 560474, '+13024350225') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('82478', '2011-02-16 15:36:40.776392', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5175, 166192, '2016-02-11', 'Willia', 'William', 'female', 'Historian') ;
INSERT INTO auth (login, password1, name) VALUES ('dropsy1821@yahoo.com', 'CX3472PR44', 'Maryalice') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0180, 681477, '1978-01-20', 'Gearldine', 'Beasley', 'male', 'Transcriber') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (127, 836515, 99592, 0180, 681477, '+18019826227') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('32311', '2019-03-28 11:12:19.138502', 'The arguments can be prim') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2857, 383918, '1958-11-21', 'Herbert', 'Knight', 'male', 'Bus Valeter') ;
INSERT INTO auth (login, password1, name) VALUES ('elusions1844@live.com', 'DZ6213MW29', 'Katelynn') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7663, 309110, '1977-11-19', 'Donnie', 'Soto', 'male', 'Property Buyer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (128, 795341, 87729, 7663, 309110, '+75556057405') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('14441', '2014-02-15 13:14:11.193545', 'Make me a sandwich. He lo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6581, 343024, '1988-11-14', 'Lavera', 'Mcgee', 'male', 'Gas Fitter') ;
INSERT INTO auth (login, password1, name) VALUES ('drseuss2042@yahoo.com', 'AR7207BP46', 'Charlsie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1493, 318536, '1967-11-04', 'Vannessa', 'Moon', 'male', 'Child Minder') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (129, 862214, 27466, 1493, 318536, '+53308216156') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('79372', '2019-09-23 15:52:48.248310', 'Do you have any idea why ') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9749, 902805, '1968-10-20', 'Kanesha', 'Torres', 'male', 'Line Worker') ;
INSERT INTO auth (login, password1, name) VALUES ('pokeroot1838@yahoo.com', 'ZQ5095PM66', 'Leanora') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1043, 170533, '1992-11-03', 'Hannelore', 'Kaufman', 'male', 'Wood Worker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (130, 980544, 95370, 1043, 170533, '+39173143669') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('45365', '2009-04-04 14:38:13.768546', 'Atoms are used within a p') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5553, 079473, '1989-11-01', 'Kendall', 'Berry', 'male', 'Chiropractor') ;
INSERT INTO auth (login, password1, name) VALUES ('minae1859@gmail.com', 'OX5051FK00', 'Rocco') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0601, 818607, '1984-10-25', 'Salvador', 'Witt', 'female', 'Bill Poster') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (131, 034609, 32341, 0601, 818607, '+74926073329') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('4571', '2003-08-12 14:00:48.474400', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3718, 984516, '2013-11-23', 'Numbers', 'Rich', 'female', 'Health Care Assistant') ;
INSERT INTO auth (login, password1, name) VALUES ('restrict1916@yandex.com', 'ZO4339LI48', 'Rosario') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0627, 863538, '1965-12-16', 'Quyen', 'Malone', 'male', 'Chiropodist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (132, 124144, 30177, 0627, 863538, '+63188455973') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('86537', '2020-08-25 11:32:56.763551', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7730, 318144, '1958-02-27', 'Joella', 'Garrison', 'male', 'Archivist') ;
INSERT INTO auth (login, password1, name) VALUES ('soaplees1808@outlook.com', 'ZA3548WG60', 'Denver') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8617, 055950, '1953-09-30', 'Rigoberto', 'Whitehead', 'male', 'Typist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (133, 301579, 99054, 8617, 055950, '+05961894947') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('64512', '2003-12-20 12:58:59.093997', 'Messages can be sent to a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0390, 669158, '1960-08-27', 'Ginette', 'Harvey', 'male', 'Steel Erector') ;
INSERT INTO auth (login, password1, name) VALUES ('integrate1954@yandex.com', 'VV1878XR85', 'Ardell') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3896, 135501, '1950-07-14', 'Tyrell', 'Davis', 'female', 'Trout Farmer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (134, 026612, 48772, 3896, 135501, '+56605476750') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('99866', '2013-12-12 11:28:32.842446', 'Atoms are used within a p') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0337, 241513, '1992-01-25', 'Shaun', 'Larson', 'male', 'Charity Worker') ;
INSERT INTO auth (login, password1, name) VALUES ('guppy1843@outlook.com', 'GV4991MH66', 'Pearly') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1083, 253661, '2015-05-23', 'Belkis', 'Cantu', 'female', 'Playgroup Assistant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (135, 175688, 14095, 1083, 253661, '+16223437761') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('40050', '2007-12-09 12:28:45.233388', 'The arguments can be prim') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9483, 499495, '1958-05-11', 'Kurtis', 'Stone', 'female', 'Gun Smith') ;
INSERT INTO auth (login, password1, name) VALUES ('sixteenths2050@live.com', 'QZ4332YM25', 'Zachary') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5064, 726803, '1990-10-16', 'Pat', 'Hernandez', 'male', 'Scaffolder') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (136, 632052, 38913, 5064, 726803, '+27991518213') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('89372', '2010-06-21 16:35:43.226232', 'Make me a sandwich. They ') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4863, 235939, '2000-11-22', 'Marcel', 'Hatfield', 'female', 'Warden') ;
INSERT INTO auth (login, password1, name) VALUES ('adjoining2005@yahoo.com', 'ZL5212ES98', 'Brett') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7215, 685427, '1999-11-28', 'Harris', 'Burt', 'male', 'Catering Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (137, 370153, 11100, 7215, 685427, '+24805526586') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('96946', '2017-02-26 14:56:38.987887', 'Make me a sandwich. Erlan') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0536, 600673, '1990-02-25', 'Burma', 'Moody', 'female', 'Porter') ;
INSERT INTO auth (login, password1, name) VALUES ('camber1923@live.com', 'OO7866PT78', 'Neida') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1558, 224932, '1975-01-04', 'Diego', 'Massey', 'female', 'Wood Cutter') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (138, 689637, 45939, 1558, 224932, '+97963110148') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('92337', '2000-11-21 13:14:05.676920', 'Ports are created with th') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2410, 592900, '1984-08-09', 'Bruno', 'Morrow', 'male', 'Systems Analyst') ;
INSERT INTO auth (login, password1, name) VALUES ('dower2020@yandex.com', 'GW9195UA25', 'Pa') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3254, 859298, '1967-07-05', 'Lazaro', 'Burnett', 'male', 'Investment Strategist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (139, 142592, 58051, 3254, 859298, '+71119422365') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('74892', '2016-03-19 12:59:07.928524', 'The arguments can be prim') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0995, 359978, '1953-09-22', 'Mayola', 'Arnold', 'female', 'Nurseryman') ;
INSERT INTO auth (login, password1, name) VALUES ('stripling1841@yandex.com', 'LU7946HS18', 'Josh') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6442, 682878, '1999-05-14', 'Tod', 'Benson', 'male', 'Church Officer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (140, 953296, 45318, 6442, 682878, '+46316401235') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('56338', '2016-01-10 11:50:48.920570', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4552, 224904, '2013-11-22', 'Marilou', 'Foster', 'male', 'Gaming Club Proprietor') ;
INSERT INTO auth (login, password1, name) VALUES ('ditone1961@outlook.com', 'PC8595LB57', 'Sam') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6413, 279242, '2003-03-06', 'Everette', 'Garcia', 'female', 'Auctioneer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (141, 937208, 00290, 6413, 279242, '+04883510524') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('62718', '2012-01-09 16:39:57.169628', 'They are written as strin') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7781, 283318, '1951-04-17', 'Maryland', 'Booth', 'female', 'Induction Moulder') ;
INSERT INTO auth (login, password1, name) VALUES ('flossie1816@outlook.com', 'RM2760FJ37', 'Zachariah') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8320, 729339, '1955-08-26', 'Danika', 'Stokes', 'female', 'Catering Staff') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (142, 909561, 61141, 8320, 729339, '+52124087181') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('14501', '2018-10-24 13:44:36.491175', 'Type classes first appear') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5396, 493053, '1957-07-06', 'Soo', 'Woods', 'female', 'Parts Manager') ;
INSERT INTO auth (login, password1, name) VALUES ('misdeemed1843@live.com', 'QA0337QQ99', 'Asley') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9173, 128422, '1997-11-04', 'Augustus', 'Russell', 'male', 'Sub-Postmistress') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (143, 883800, 86936, 9173, 128422, '+47856090878') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('42073', '2006-08-07 12:00:05.555792', 'Messages can be sent to a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8876, 562569, '2015-03-26', 'Diedre', 'Craig', 'female', 'Animal Breeder') ;
INSERT INTO auth (login, password1, name) VALUES ('elided1943@outlook.com', 'IH4328BS47', 'Dennis') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3647, 808557, '1964-10-03', 'Irwin', 'Sosa', 'female', 'Lithographer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (144, 364598, 70216, 3647, 808557, '+85137956206') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('55103', '2015-02-19 16:57:23.726352', 'Make me a sandwich. The s') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3508, 549876, '1972-06-11', 'Doyle', 'Acevedo', 'male', 'Office Worker') ;
INSERT INTO auth (login, password1, name) VALUES ('breaklist1823@outlook.com', 'NY0941DR43', 'Britni') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2205, 659398, '1990-10-07', 'Trevor', 'Richard', 'female', 'Gas Technician') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (145, 502027, 93552, 2205, 659398, '+65834014174') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('7978', '2014-10-20 13:44:10.053697', 'The sequential subset of ') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9774, 103709, '2018-01-27', 'Colby', 'Rice', 'female', 'Booking Agent') ;
INSERT INTO auth (login, password1, name) VALUES ('nace2030@yandex.com', 'XE1600BB54', 'China') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1793, 617339, '1965-12-08', 'Dudley', 'Malone', 'male', 'Handyman') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (146, 425284, 57798, 1793, 617339, '+50331898805') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('87598', '2020-12-24 15:01:12.457454', 'The Galactic Empire is ne') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0517, 642171, '1978-01-09', 'Derek', 'Medina', 'female', 'Progress Chaser') ;
INSERT INTO auth (login, password1, name) VALUES ('semitropic2047@yahoo.com', 'QW4391VJ20', 'Ling') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3698, 122896, '1957-06-07', 'Alysha', 'Hughes', 'female', 'Literary Agent') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (147, 902495, 35222, 3698, 122896, '+56310263268') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('53119', '2015-11-23 13:33:14.389416', 'Do you have any idea why ') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8343, 537678, '2005-05-07', 'Bryanna', 'Russo', 'male', 'Hop Merchant') ;
INSERT INTO auth (login, password1, name) VALUES ('depicting1898@gmail.com', 'ZB5806XC84', 'Stanley') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1197, 552594, '2017-08-10', 'Yukiko', 'Blackwell', 'male', 'Weighbridge Clerk') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (148, 951463, 53936, 1197, 552594, '+79351144998') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('68446', '2000-05-17 13:06:13.902948', 'Ports are used to communi') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3880, 603293, '2006-04-01', 'Sherlene', 'Meyer', 'male', 'Merchant Banker') ;
INSERT INTO auth (login, password1, name) VALUES ('stingray1881@yahoo.com', 'OH0315VS50', 'Keesha') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7919, 422855, '2016-12-03', 'Isela', 'Thomas', 'female', 'Consultant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (149, 648869, 92499, 7919, 422855, '+26826587146') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('58428', '2001-11-10 13:39:25.164107', 'Make me a sandwich. The a') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3215, 726818, '2005-02-18', 'Norberto', 'Turner', 'male', 'Lift Engineer') ;
INSERT INTO auth (login, password1, name) VALUES ('chrystal1890@live.com', 'IW4439DE81', 'Chante') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8926, 871569, '1989-01-11', 'Maurice', 'Nunez', 'female', 'Boat Builder') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (150, 975810, 13682, 8926, 871569, '+39915791334') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('89299', '2007-06-01 15:42:27.926229', 'Haskell is a standardized') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2008-03-25T12:23:25.337437', '2008-03-30T12:23:25.337437', 'Atoms can contain any cha') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The Galactic Empire is ne', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2001-08-12T12:25:19.369058', '2001-08-14T12:25:19.369058', 'Do you have any idea why ') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The Galactic Empire is ne', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-07-08T11:29:49.627939', '2013-07-10T11:29:49.627939', 'She spent her earliest ye') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Haskell features a type s', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2005-06-15T15:45:46.995090', '2005-06-20T15:45:46.995090', 'Its main implementation i') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2020-01-23T13:18:54.477507', '2020-01-30T13:18:54.477507', 'Erlang is known for its d') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Initially composing light', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-09-25T10:58:04.517697', '2012-10-01T10:58:04.517697', 'Ports are created with th') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms are used within a p', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2006-11-19T14:17:30.319478', '2006-11-21T14:17:30.319478', 'Where are my pants? The G') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Messages can be sent to a', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2008-01-23T14:57:21.136719', '2008-01-27T14:57:21.136719', 'Its main implementation i') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('It is also a garbage-coll', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-03-11T12:52:31.600544', '2019-03-16T12:52:31.600544', 'Its main implementation i') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('They are written as strin', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2002-10-22T15:05:13.723212', '2002-10-26T15:05:13.723212', 'Its main implementation i') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('In 1989 the building was ', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2020-05-20T16:53:30.058699', '2020-05-25T16:53:30.058699', 'The Galactic Empire is ne') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The arguments can be prim', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2001-07-27T14:11:28.237587', '2001-08-03T14:11:28.237587', 'Where are my pants? Erlan') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Haskell is a standardized', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-05-16T12:54:06.184340', '2013-05-22T12:54:06.184340', 'Ports are used to communi') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The sequential subset of ', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2007-10-20T10:12:21.055383', '2007-10-26T10:12:21.055383', 'They are written as strin') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Tuples are containers for', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2001-03-27T15:46:55.926169', '2001-03-31T15:46:55.926169', 'Its main implementation i') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-02-17T15:07:29.259670', '2012-02-23T15:07:29.259670', 'Make me a sandwich. It is') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Any element of a tuple ca', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2006-12-10T16:28:53.637970', '2006-12-13T16:28:53.637970', 'Atoms can contain any cha') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The Galactic Empire is ne', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2014-08-20T10:28:56.330158', '2014-08-23T10:28:56.330158', 'In 1989 the building was ') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Make me a sandwich. The G', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2001-06-26T15:05:04.405512', '2001-06-29T15:05:04.405512', 'They are written as strin') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Tuples are containers for', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2014-02-22T16:55:47.212217', '2014-02-26T16:55:47.212217', 'Make me a sandwich. The s') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The syntax {D1,D2,...,Dn}', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-05-07T13:39:22.022464', '2012-05-09T13:39:22.022464', 'The sequential subset of ') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('I dont even care. Ports a', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2020-03-20T11:03:13.533509', '2020-03-27T11:03:13.533509', 'The arguments can be prim') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Ports are used to communi', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2005-08-17T15:39:28.681714', '2005-08-22T15:39:28.681714', 'They are written as strin') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you have any idea why ', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2011-01-03T15:16:31.526883', '2011-01-09T15:16:31.526883', 'Erlang is a general-purpo') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Make me a sandwich. In 19', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2008-06-18T12:54:17.666687', '2008-06-24T12:54:17.666687', 'Ports are created with th') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you have any idea why ', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2020-04-04T10:47:30.624845', '2020-04-11T10:47:30.624845', 'Ports are used to communi') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Type classes first appear', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-05-18T13:34:06.650422', '2013-05-22T13:34:06.650422', 'Ports are used to communi') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Erlang is known for its d', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2015-12-23T15:30:24.514450', '2015-12-29T15:30:24.514450', 'Erlang is known for its d') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Where are my pants? In 19', 'open') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2016-01-06T15:08:44.387648', '2016-01-10T15:08:44.387648', 'Haskell features a type s') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The arguments can be prim', 'closed') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2014-08-08T10:39:59.761997', '2014-08-14T10:39:59.761997', 'Tuples are containers for') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-01-12 10:33:39.449436', 'Erlang is ', 'The Galactic Empire is ne', 'In 1989 th') ;
INSERT INTO auth (login, password1, name) VALUES ('markhor2042@yahoo.com', 'YD2211OB46', 'Dionna') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3603, 536787, '1971-11-17', 'Elfreda', 'Byers', 'female', 'Laundry Staff') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (151, 975713, 97152, 3603, 536787, '+30237935023') ;
INSERT INTO auth (login, password1, name) VALUES ('vigors2006@gmail.com', 'HU6235NE10', 'Jack') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dana', 'Oliver', 76, 152, '2006-12-24', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-06-29 13:23:31.729005', 'Tuples are', 'Erlang is known for its d', 'Where are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (2, 41, 41) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-07-27 12:20:33.683057', 'I dont eve', 'Atoms are used within a p', 'Messages c') ;
INSERT INTO auth (login, password1, name) VALUES ('tribromophenol2019@gmail.com', 'TE6242BC25', 'Lili') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3925, 346754, '2014-05-22', 'Dorotha', 'Neal', 'female', 'Security Controller') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (153, 398817, 39307, 3925, 346754, '+83110845707') ;
INSERT INTO auth (login, password1, name) VALUES ('definitized1904@yahoo.com', 'VJ8106WB18', 'Roger') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Gary', 'Cherry', 88, 154, '2009-05-16', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2000-10-17 14:22:32.261082', 'She spent ', 'Erlang is known for its d', 'Where are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (4, 42, 42) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-10-04 13:24:23.969546', 'Haskell is', 'Atoms can contain any cha', 'Tuples are') ;
INSERT INTO auth (login, password1, name) VALUES ('dendrobatinae2064@outlook.com', 'RR2259CW75', 'Philip') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8610, 277193, '2013-01-09', 'Darnell', 'Adkins', 'female', 'Park Keeper') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (155, 977042, 78583, 8610, 277193, '+27981008963') ;
INSERT INTO auth (login, password1, name) VALUES ('sexillion1869@gmail.com', 'TA1817WT88', 'Ardell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Alysa', 'Huber', 53, 156, '1955-01-27', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-10-26 10:22:06.062862', 'Type class', 'Haskell features a type s', 'The Galact') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (6, 43, 43) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-09-26 10:56:03.931121', 'She spent ', 'It is also a garbage-coll', 'Erlang is ') ;
INSERT INTO auth (login, password1, name) VALUES ('berberine2010@yandex.com', 'SH0570TQ88', 'Cortez') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2447, 226575, '1973-08-16', 'Deedra', 'Burke', 'female', 'Tyre Technician') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (157, 090151, 69066, 2447, 226575, '+43457826006') ;
INSERT INTO auth (login, password1, name) VALUES ('beaucoup2037@yandex.com', 'ZX8161VS43', 'Grover') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Librada', 'Pratt', 88, 158, '1953-11-03', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-09-09 12:47:26.633311', 'Ports are ', 'It is also a garbage-coll', 'She spent ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (8, 44, 44) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-02-20 11:56:01.913939', 'Haskell is', 'Make me a sandwich. Ports', 'The argume') ;
INSERT INTO auth (login, password1, name) VALUES ('halbert2041@outlook.com', 'RV4390MD41', 'Esteban') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3755, 448320, '2005-11-09', 'Cristin', 'Zimmerman', 'female', 'Tanker Driver') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (159, 262691, 63789, 3755, 448320, '+48738007339') ;
INSERT INTO auth (login, password1, name) VALUES ('qqv1849@outlook.com', 'AC4444QF44', 'Olinda') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Fred', 'Ballard', 3, 160, '1962-06-29', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-11-16 12:51:06.357504', 'It is also', 'The arguments can be prim', 'Do you hav') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (10, 45, 45) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2006-07-26 13:48:59.317678', 'They are w', 'Type classes first appear', 'The syntax') ;
INSERT INTO auth (login, password1, name) VALUES ('dutuburi1960@gmail.com', 'LB7511JZ55', 'Carl') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2513, 248866, '1980-08-18', 'Arlinda', 'Bowen', 'male', 'Technical Engineer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (161, 314775, 78122, 2513, 248866, '+59678208066') ;
INSERT INTO auth (login, password1, name) VALUES ('abilities1824@yandex.com', 'IQ4810RD98', 'Sommer') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Albertine', 'Mcconnell', 33, 162, '2006-10-12', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-08-22 11:16:50.187989', 'In 1989 th', 'Erlang is known for its d', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (12, 46, 46) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-06-25 13:40:41.395766', 'Initially ', 'The arguments can be prim', 'The sequen') ;
INSERT INTO auth (login, password1, name) VALUES ('iglu1907@live.com', 'XM5940MG89', 'Christopher') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8123, 442841, '1952-09-05', 'Lanell', 'Greene', 'female', 'Party Planner') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (163, 673585, 90976, 8123, 442841, '+25497851967') ;
INSERT INTO auth (login, password1, name) VALUES ('coati1897@live.com', 'DS4395FJ88', 'Chung') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Yong', 'Scott', 39, 164, '2012-01-25', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-12-18 12:21:00.716868', 'Ports are ', 'Haskell features a type s', 'The sequen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (14, 47, 47) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-05-31 11:11:35.164834', 'Do you com', 'I dont even care. Do you ', 'Erlang is ') ;
INSERT INTO auth (login, password1, name) VALUES ('uterometer2065@yandex.com', 'HH0810GV37', 'Alvaro') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5660, 653132, '2017-02-07', 'Pasty', 'Blair', 'female', 'Gallery Owner') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (165, 467340, 21912, 5660, 653132, '+66776494080') ;
INSERT INTO auth (login, password1, name) VALUES ('dynamism2026@gmail.com', 'PR2129AX04', 'Simon') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Waneta', 'Le', 91, 166, '2010-03-02', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-10-29 16:22:55.624122', 'Type class', 'The Galactic Empire is ne', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (16, 48, 48) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-06-01 11:13:19.026033', 'He looked ', 'Initially composing light', 'Ports are ') ;
INSERT INTO auth (login, password1, name) VALUES ('piques1951@yandex.com', 'QB8161ZM73', 'Owen') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8116, 270052, '1982-01-04', 'Carmina', 'Galloway', 'female', 'Judge') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (167, 956450, 99935, 8116, 270052, '+21861789167') ;
INSERT INTO auth (login, password1, name) VALUES ('iatraliptics1981@gmail.com', 'GC9985ZI94', 'Violette') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kris', 'Sanford', 49, 168, '2010-09-26', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-10-18 12:50:45.595920', 'Make me a ', 'Any element of a tuple ca', 'Haskell is') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (18, 49, 49) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-12-20 16:51:57.730745', 'Make me a ', 'She spent her earliest ye', 'Do you hav') ;
INSERT INTO auth (login, password1, name) VALUES ('curate2051@live.com', 'AT5311DC84', 'Donn') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2237, 261065, '2000-05-22', 'Royal', 'Gamble', 'male', 'Clairvoyant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (169, 932116, 75856, 2237, 261065, '+87518453657') ;
INSERT INTO auth (login, password1, name) VALUES ('boden2065@yahoo.com', 'XE5659TG30', 'Shera') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Senaida', 'Barker', 96, 170, '2011-01-08', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-05-17 16:41:41.902203', 'Ports are ', 'Ports are used to communi', 'Ports are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (20, 50, 50) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-09-07 14:28:47.099270', 'Haskell fe', 'Make me a sandwich. The s', 'Do you hav') ;
INSERT INTO auth (login, password1, name) VALUES ('homologoumena2064@yahoo.com', 'MC0827ZM41', 'Isaura') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4303, 853131, '2002-02-15', 'Royal', 'Hartman', 'female', 'Local Government') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (171, 415062, 09304, 4303, 853131, '+15203671068') ;
INSERT INTO auth (login, password1, name) VALUES ('paludrin1952@gmail.com', 'HU5053NL90', 'Frank') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jonie', 'Benton', 12, 172, '1959-12-08', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2004-10-07 12:09:29.052482', 'Initially ', 'Messages can be sent to a', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (22, 51, 51) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-07-27 13:03:28.856446', 'The sequen', 'Haskell features a type s', 'Do you com') ;
INSERT INTO auth (login, password1, name) VALUES ('econometrics1822@live.com', 'DS8583QS19', 'Tennille') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3937, 594261, '1984-05-28', 'Harlan', 'Alexander', 'female', 'Marble Mason') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (173, 475095, 23974, 3937, 594261, '+59278169637') ;
INSERT INTO auth (login, password1, name) VALUES ('gombeen1838@outlook.com', 'DT4448IM55', 'Issac') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Zada', 'Weiss', 82, 174, '1973-03-31', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-01-07 10:06:17.804393', 'Do you com', 'Erlang is a general-purpo', 'Atoms are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (24, 52, 52) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2004-02-15 16:40:38.441206', 'They are w', 'Tuples are containers for', 'I dont eve') ;
INSERT INTO auth (login, password1, name) VALUES ('award2043@gmail.com', 'WS6995MW34', 'Nubia') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9317, 121221, '1996-01-01', 'Eldon', 'Blackburn', 'female', 'Childminder') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (175, 075752, 49021, 9317, 121221, '+80030531338') ;
INSERT INTO auth (login, password1, name) VALUES ('crumpler1850@outlook.com', 'GX8519NQ31', 'Daniel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Richie', 'Kennedy', 79, 176, '1955-02-09', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-11-03 13:22:50.329380', 'Atoms can ', 'Initially composing light', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (26, 53, 53) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-06-02 14:06:46.853981', 'Type class', 'Make me a sandwich. The s', 'Messages c') ;
INSERT INTO auth (login, password1, name) VALUES ('acana1963@outlook.com', 'UX4188FZ32', 'Bennett') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0586, 210993, '1963-08-29', 'Mario', 'Simmons', 'male', 'Hotel Worker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (177, 349694, 54262, 0586, 210993, '+99865074612') ;
INSERT INTO auth (login, password1, name) VALUES ('sixteenths1840@gmail.com', 'LQ3628JU70', 'Steven') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Keith', 'Serrano', 76, 178, '2018-01-23', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-05-11 16:20:27.450410', 'Erlang is ', 'Initially composing light', 'Ports are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (28, 54, 54) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-12-04 11:18:11.983188', 'Haskell is', 'The sequential subset of ', 'Atoms are ') ;
INSERT INTO auth (login, password1, name) VALUES ('ancient2012@outlook.com', 'VU3944GK01', 'Francisco') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4462, 099426, '1964-06-12', 'Pasquale', 'Valdez', 'male', 'Groundsman') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (179, 141389, 93110, 4462, 099426, '+49190262858') ;
INSERT INTO auth (login, password1, name) VALUES ('arrowy1845@outlook.com', 'ST9042ZT91', 'Milton') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Alona', 'Mcclure', 23, 180, '2014-07-15', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-02-18 13:51:52.331094', 'Tuples are', 'Atoms can contain any cha', 'He looked ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (30, 55, 55) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-06-18 12:26:00.088669', 'Haskell fe', 'Where are my pants? Do yo', 'The syntax') ;
INSERT INTO auth (login, password1, name) VALUES ('mazard1916@yandex.com', 'OL6830RJ80', 'Aron') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5253, 329146, '1950-08-11', 'Tomi', 'Cash', 'male', 'Roadworker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (181, 625773, 75660, 5253, 329146, '+72908039399') ;
INSERT INTO auth (login, password1, name) VALUES ('brindlish1806@gmail.com', 'VT1231BO49', 'Mendy') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Antonia', 'Wiley', 71, 182, '1977-02-06', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-05-15 16:19:41.654348', 'The Galact', 'Tuples are containers for', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (32, 56, 56) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-11-23 13:18:31.872579', 'Type class', 'Make me a sandwich. Haske', 'Make me a ') ;
INSERT INTO auth (login, password1, name) VALUES ('wyson1938@live.com', 'NU5353PF61', 'Darius') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8429, 447339, '1958-02-23', 'Sindy', 'Carrillo', 'male', 'Consultant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (183, 394972, 31340, 8429, 447339, '+52415386635') ;
INSERT INTO auth (login, password1, name) VALUES ('ameliorators1959@yandex.com', 'QZ3581UZ28', 'Colin') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Bree', 'Henry', 27, 184, '2011-10-06', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-04-27 14:36:47.082419', 'It is also', 'Make me a sandwich. It is', 'Messages c') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (34, 57, 57) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-05-03 16:23:15.289458', 'Type class', 'Ports are used to communi', 'They are w') ;
INSERT INTO auth (login, password1, name) VALUES ('snuffliness2051@live.com', 'HW3553XT43', 'Mikel') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2504, 779429, '1973-01-21', 'Mardell', 'Workman', 'female', 'Broadcaster') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (185, 078921, 65690, 2504, 779429, '+65276685813') ;
INSERT INTO auth (login, password1, name) VALUES ('christl1941@yandex.com', 'QE9728FA71', 'Maybell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Le', 'Mclean', 71, 186, '1957-10-10', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2011-03-22 12:55:55.767358', 'Its main i', 'He looked inquisitively a', 'Do you com') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (36, 58, 58) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-02-28 11:04:03.263439', 'The Galact', 'He looked inquisitively a', 'She spent ') ;
INSERT INTO auth (login, password1, name) VALUES ('unadoptive1807@yandex.com', 'XY9831CY68', 'Lieselotte') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0458, 014232, '1975-11-02', 'Bethel', 'Blanchard', 'male', 'Acoustic Engineer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (187, 223530, 17557, 0458, 014232, '+05763481224') ;
INSERT INTO auth (login, password1, name) VALUES ('cobbra1963@gmail.com', 'AX0006MT77', 'Zulema') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Raina', 'Bishop', 56, 188, '1978-10-06', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-11-11 15:30:18.026053', 'Make me a ', 'Its main implementation i', 'I dont eve') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (38, 59, 59) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2012-04-14 13:33:45.080166', 'The Galact', 'I dont even care. Erlang ', 'Do you com') ;
INSERT INTO auth (login, password1, name) VALUES ('classical1807@gmail.com', 'ZQ3240CN59', 'Mikaela') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8363, 202283, '2016-03-23', 'Ray', 'Noel', 'male', 'Project Co-ordinator') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (189, 070273, 44445, 8363, 202283, '+31826279183') ;
INSERT INTO auth (login, password1, name) VALUES ('huffily2050@gmail.com', 'BV2471OS09', 'Eulah') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Claretha', 'Avery', 75, 190, '1974-05-08', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-02-08 12:50:42.624852', 'Ports are ', 'Messages can be sent to a', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (40, 60, 60) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2011-01-08 10:25:40.010264', 'Messages c', 'She spent her earliest ye', 'It is also') ;
INSERT INTO auth (login, password1, name) VALUES ('scarlet2018@gmail.com', 'TL4823LU73', 'Nelson') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2113, 377835, '1958-06-30', 'Margrett', 'Mueller', 'female', 'Gilder') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (191, 641784, 97157, 2113, 377835, '+84951482108') ;
INSERT INTO auth (login, password1, name) VALUES ('travertine1984@gmail.com', 'HL8752IA99', 'Emory') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lurline', 'Herring', 17, 192, '1980-01-10', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2011-01-07 10:46:07.947275', 'Do you com', 'The sequential subset of ', 'Ports are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (42, 61, 61) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-11-06 15:52:14.049648', 'I dont eve', 'He looked inquisitively a', 'The argume') ;
INSERT INTO auth (login, password1, name) VALUES ('endocyemate1889@yandex.com', 'CQ9752YU16', 'Jolie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7907, 780677, '1951-04-12', 'Ed', 'Rivas', 'male', 'Janitor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (193, 321699, 90208, 7907, 780677, '+19819022092') ;
INSERT INTO auth (login, password1, name) VALUES ('skims1932@outlook.com', 'AO8227BG87', 'Shane') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Herb', 'Chaney', 95, 194, '2003-08-02', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2000-09-03 12:12:40.201824', 'The sequen', 'Do you have any idea why ', 'Make me a ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (44, 62, 62) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-12-21 15:06:04.716752', 'Do you com', 'Ports are used to communi', 'Ports are ') ;
INSERT INTO auth (login, password1, name) VALUES ('tandoori2054@yandex.com', 'NW6306AX47', 'Carroll') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6354, 658418, '1998-05-27', 'Jermaine', 'Horton', 'male', 'Loss Adjustor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (195, 467772, 89619, 6354, 658418, '+33287943107') ;
INSERT INTO auth (login, password1, name) VALUES ('adermia2020@yahoo.com', 'XS1472JR51', 'Angel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ed', 'Frost', 67, 196, '2016-03-20', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-06-25 10:47:33.092848', 'I dont eve', 'Where are my pants? Initi', 'Type class') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (46, 63, 63) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2000-08-17 16:24:44.530506', 'Messages c', 'Do you have any idea why ', 'Do you hav') ;
INSERT INTO auth (login, password1, name) VALUES ('educable2003@live.com', 'UG0791FD07', 'Pamula') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7969, 275449, '1994-03-15', 'Glendora', 'Zimmerman', 'male', 'Store Detective') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (197, 634452, 67985, 7969, 275449, '+99340789469') ;
INSERT INTO auth (login, password1, name) VALUES ('corydon1872@live.com', 'UB4553BS78', 'Edmund') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Carl', 'Oneill', 98, 198, '2013-03-03', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-08-02 15:49:14.920955', 'Ports are ', 'Erlang is a general-purpo', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (48, 64, 64) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-06-08 14:39:45.874244', 'Any elemen', 'Where are my pants? It is', 'I dont eve') ;
INSERT INTO auth (login, password1, name) VALUES ('artur1811@live.com', 'EU9320GN63', 'Jeremy') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3232, 892550, '2003-01-22', 'Brett', 'Maxwell', 'male', 'Thermal Insulator') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (199, 960166, 15010, 3232, 892550, '+39001964365') ;
INSERT INTO auth (login, password1, name) VALUES ('sociables1821@outlook.com', 'XP8487HV85', 'Garland') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kellee', 'Berry', 29, 200, '1987-10-09', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-10-20 13:04:12.036518', 'She spent ', 'Initially composing light', 'Tuples are') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (50, 65, 65) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-02-22 10:58:40.979292', 'Tuples are', 'The Galactic Empire is ne', 'Its main i') ;
INSERT INTO auth (login, password1, name) VALUES ('capozzi1848@yandex.com', 'SX5525MB59', 'Jadwiga') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6013, 012830, '1977-07-13', 'Russel', 'Clements', 'male', 'Branch Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (201, 273093, 31815, 6013, 012830, '+36595986592') ;
INSERT INTO auth (login, password1, name) VALUES ('unphrasableness1817@yandex.com', 'SN4680RE10', 'Alfredo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lasonya', 'Buck', 83, 202, '2014-03-13', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-03-17 15:52:53.020853', 'He looked ', 'He looked inquisitively a', 'It is also') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (52, 66, 66) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2011-10-22 14:13:13.536207', 'Make me a ', 'Its main implementation i', 'Haskell fe') ;
INSERT INTO auth (login, password1, name) VALUES ('dosser1929@yandex.com', 'WU8874BU77', 'Aubrey') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3570, 645352, '2018-06-29', 'Wiley', 'Warren', 'female', 'Pattern Maker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (203, 653266, 14785, 3570, 645352, '+78416371270') ;
INSERT INTO auth (login, password1, name) VALUES ('hydrothermal1897@yahoo.com', 'UR2876VU48', 'Samual') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dick', 'Klein', 44, 204, '1977-03-18', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-09-28 14:55:49.012031', 'Haskell fe', 'Erlang is known for its d', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (54, 67, 67) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-01-04 13:00:36.838186', 'I dont eve', 'Type classes first appear', 'She spent ') ;
INSERT INTO auth (login, password1, name) VALUES ('bobbee1869@gmail.com', 'HN3444ID99', 'Cole') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9859, 058213, '2012-10-28', 'Eliseo', 'Hatfield', 'female', 'Theatrical Agent') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (205, 610922, 88649, 9859, 058213, '+01703411779') ;
INSERT INTO auth (login, password1, name) VALUES ('refrustrated1915@yandex.com', 'KX1307CI16', 'Ulrike') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rupert', 'Blevins', 45, 206, '1957-03-02', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-07-15 12:40:58.952565', 'The argume', 'The syntax {D1,D2,...,Dn}', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (56, 68, 68) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-08-08 15:55:19.737813', 'I dont eve', 'Atoms can contain any cha', 'Type class') ;
INSERT INTO auth (login, password1, name) VALUES ('alans2057@outlook.com', 'DY6836FR40', 'Amee') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5741, 972625, '1958-02-06', 'Laurence', 'Sheppard', 'male', 'Marquee Erector') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (207, 346372, 23752, 5741, 972625, '+03677756557') ;
INSERT INTO auth (login, password1, name) VALUES ('airplay1930@live.com', 'VE0162PR07', 'Vicente') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Reed', 'Marquez', 18, 208, '1999-10-17', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-06-12 10:46:54.719053', 'Messages c', 'They are written as strin', 'The Galact') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (58, 69, 69) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-10-02 11:14:51.299862', 'They are w', 'Messages can be sent to a', 'She spent ') ;
INSERT INTO auth (login, password1, name) VALUES ('warthog1942@yandex.com', 'IQ1312YU60', 'Charley') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3901, 951287, '2017-05-04', 'Grady', 'Nielsen', 'male', 'Pattern Cutter') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (209, 075844, 61040, 3901, 951287, '+17769019753') ;
INSERT INTO auth (login, password1, name) VALUES ('coati2068@outlook.com', 'VD4484MI39', 'Julio') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Jermaine', 'Bernard', 84, 210, '1960-03-23', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-08-05 10:20:52.446546', 'He looked ', 'Erlang is a general-purpo', 'I dont eve') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (60, 70, 70) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-05-20 14:39:37.326713', 'Any elemen', 'Erlang is a general-purpo', 'Haskell fe') ;
INSERT INTO auth (login, password1, name) VALUES ('eland1891@yandex.com', 'DZ1395AO20', 'Pasquale') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7665, 100387, '1986-10-25', 'Allen', 'Robertson', 'female', 'Scrap Dealer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (211, 650760, 94249, 7665, 100387, '+68706303943') ;
INSERT INTO auth (login, password1, name) VALUES ('scissor1984@yandex.com', 'LF8094BS55', 'Carmine') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Yolande', 'Hudson', 42, 212, '2007-04-26', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2010-10-24 10:18:08.597542', 'Tuples are', 'Ports are created with th', 'Type class') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (62, 71, 71) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2019-03-18 15:30:39.797844', 'Initially ', 'Messages can be sent to a', 'Atoms are ') ;
INSERT INTO auth (login, password1, name) VALUES ('skellum1978@yandex.com', 'PQ1581LU27', 'Vincenzo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7887, 951021, '1993-04-04', 'Sean', 'Benson', 'female', 'Piano Tuner') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (213, 569256, 57179, 7887, 951021, '+39391699819') ;
INSERT INTO auth (login, password1, name) VALUES ('cycloids2031@yandex.com', 'FG5023GT39', 'Qiana') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Alonso', 'Hays', 91, 214, '1953-01-10', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2004-02-17 12:49:23.570199', 'Erlang is ', 'Haskell features a type s', 'They are w') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (64, 72, 72) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-04-08 10:49:29.029443', 'Its main i', 'Ports are created with th', 'She spent ') ;
INSERT INTO auth (login, password1, name) VALUES ('finch1903@yahoo.com', 'HT5138VR11', 'Pasquale') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3855, 084079, '2019-04-17', 'Gia', 'Shelton', 'male', 'Midwife') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (215, 442632, 36695, 3855, 084079, '+44832932995') ;
INSERT INTO auth (login, password1, name) VALUES ('disciplinarianism1825@outlook.com', 'SD2194DU79', 'Tod') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Georgeanna', 'Clements', 16, 216, '1968-09-19', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-06-19 10:50:13.862318', 'Atoms can ', 'Messages can be sent to a', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (66, 73, 73) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-07-23 16:24:51.109672', 'Haskell fe', 'Where are my pants? Erlan', 'Initially ') ;
INSERT INTO auth (login, password1, name) VALUES ('bayard1963@gmail.com', 'LV6232GD44', 'Kirby') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6654, 797019, '1986-05-29', 'Carolin', 'Lott', 'female', 'Mill Worker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (217, 560772, 86995, 6654, 797019, '+64735737514') ;
INSERT INTO auth (login, password1, name) VALUES ('belar1848@outlook.com', 'QK8046JF97', 'Esteban') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Takisha', 'Weaver', 14, 218, '1978-01-07', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2011-08-01 12:01:09.187548', 'Haskell fe', 'Ports are created with th', 'Type class') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (68, 74, 74) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-09-13 12:07:55.466334', 'Atoms can ', 'Initially composing light', 'Make me a ') ;
INSERT INTO auth (login, password1, name) VALUES ('twinflower1943@yahoo.com', 'MF6721OR03', 'Corazon') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4644, 785558, '1962-07-04', 'Katlyn', 'Walsh', 'female', 'Garden Designer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (219, 517885, 83102, 4644, 785558, '+56131253510') ;
INSERT INTO auth (login, password1, name) VALUES ('iguana1857@live.com', 'EZ7867IH86', 'Melvin') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Darren', 'Berger', 10, 220, '2009-07-18', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2017-07-25 10:45:46.651510', 'Atoms are ', 'She spent her earliest ye', 'The syntax') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (70, 75, 75) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2013-11-23 11:51:35.594803', 'Do you com', 'Initially composing light', 'He looked ') ;
INSERT INTO auth (login, password1, name) VALUES ('nebraskan2019@outlook.com', 'QR7562TK72', 'Marcelino') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5733, 091659, '2011-03-09', 'Carlee', 'Bauer', 'female', 'Horse Trainer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (221, 767663, 15162, 5733, 091659, '+94360738747') ;
INSERT INTO auth (login, password1, name) VALUES ('insulators1819@outlook.com', 'RF0473YS06', 'Margart') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Myrle', 'Combs', 13, 222, '1996-05-27', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2001-03-28 15:20:10.279543', 'Any elemen', 'Where are my pants? Its m', 'Tuples are') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (72, 76, 76) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-12-23 16:49:23.623088', 'Tuples are', 'The Galactic Empire is ne', 'The syntax') ;
INSERT INTO auth (login, password1, name) VALUES ('poetess2007@outlook.com', 'YS8492IY97', 'Faustina') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7364, 610495, '1966-01-21', 'Ka', 'Strickland', 'female', 'Executive') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (223, 115879, 91518, 7364, 610495, '+37768048035') ;
INSERT INTO auth (login, password1, name) VALUES ('euphonetic2068@live.com', 'FX7725KS77', 'Wilmer') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rueben', 'Dorsey', 2, 224, '1968-06-01', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-03-10 12:25:43.868359', 'Messages c', 'Atoms can contain any cha', 'In 1989 th') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (74, 77, 77) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-11-30 14:27:20.253311', 'Any elemen', 'The arguments can be prim', 'Make me a ') ;
INSERT INTO auth (login, password1, name) VALUES ('macroprism2059@outlook.com', 'RR9862JY74', 'Antonia') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3121, 649004, '1954-06-29', 'Isaias', 'Weber', 'female', 'Product Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (225, 857371, 69451, 3121, 649004, '+45039429333') ;
INSERT INTO auth (login, password1, name) VALUES ('brann1967@gmail.com', 'MJ1786HL25', 'Thi') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kim', 'Valencia', 66, 226, '1985-01-12', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2014-09-17 12:43:46.508891', 'The syntax', 'Make me a sandwich. Its m', 'Its main i') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (76, 78, 78) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2013-09-27 14:33:09.166380', 'Make me a ', 'Tuples are containers for', 'Erlang is ') ;
INSERT INTO auth (login, password1, name) VALUES ('nitrosify1988@yahoo.com', 'QK4526TV36', 'Pete') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8310, 562015, '1974-01-29', 'Isaiah', 'Harris', 'male', 'Meat Inspector') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (227, 807023, 87502, 8310, 562015, '+05418963508') ;
INSERT INTO auth (login, password1, name) VALUES ('girlies1846@live.com', 'WS9262XB37', 'Gerardo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Raphael', 'Bradley', 72, 228, '1988-08-14', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2018-11-17 12:14:15.079244', 'The argume', 'Atoms can contain any cha', 'Any elemen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (78, 79, 79) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-11-21 15:24:40.425500', 'In 1989 th', 'The sequential subset of ', 'Tuples are') ;
INSERT INTO auth (login, password1, name) VALUES ('expone1859@outlook.com', 'NL1874JW66', 'Dionna') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5042, 698766, '2001-09-21', 'Erasmo', 'Moran', 'male', 'Adjustor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (229, 047230, 55487, 5042, 698766, '+40184996320') ;
INSERT INTO auth (login, password1, name) VALUES ('furbished1937@outlook.com', 'LK5024UL51', 'Porsha') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Omer', 'Pope', 61, 230, '1952-11-22', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2011-07-29 15:51:40.006496', 'Haskell is', 'Haskell is a standardized', 'Ports are ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (80, 80, 80) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-04-22 15:37:59.127701', 'Where are ', 'The Galactic Empire is ne', 'Initially ') ;
INSERT INTO auth (login, password1, name) VALUES ('improve1977@yandex.com', 'UC9321PW54', 'Seth') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9623, 936891, '1989-03-21', 'Elmo', 'Freeman', 'male', 'Investment Strategist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (231, 985040, 80752, 9623, 936891, '+64515411613') ;
INSERT INTO auth (login, password1, name) VALUES ('corena2010@yahoo.com', 'UQ1393EA33', 'Kym') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Heike', 'Ochoa', 93, 232, '1960-12-05', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-05-12 12:18:24.690685', 'In 1989 th', 'Do you come here often? T', 'The argume') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (82, 81, 81) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-02-01 11:04:12.731028', 'Do you com', 'It is also a garbage-coll', 'Its main i') ;
INSERT INTO auth (login, password1, name) VALUES ('creamier1901@gmail.com', 'XY1759HS47', 'Liberty') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2025, 863045, '1962-10-05', 'Millard', 'Richard', 'male', 'Consultant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (233, 357770, 54275, 2025, 863045, '+13139991549') ;
INSERT INTO auth (login, password1, name) VALUES ('polled2028@live.com', 'PJ1803KO89', 'Corliss') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Donny', 'Swanson', 63, 234, '2002-01-27', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-07-19 13:38:14.736888', 'Erlang is ', 'Ports are used to communi', 'Atoms can ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (84, 82, 82) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2000-12-02 13:50:48.157378', 'I dont eve', 'Where are my pants? The G', 'The sequen') ;
INSERT INTO auth (login, password1, name) VALUES ('santalol1855@yandex.com', 'IP4717UT61', 'Jessika') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3301, 350354, '2011-09-18', 'Reginia', 'Rivas', 'female', 'Mortician') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (235, 889664, 28606, 3301, 350354, '+65550852389') ;
INSERT INTO auth (login, password1, name) VALUES ('unsearchable1886@gmail.com', 'WJ9981QM15', 'Randell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Stephen', 'Woods', 74, 236, '2008-07-18', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2008-11-19 13:18:01.869193', 'Haskell fe', 'He looked inquisitively a', 'Do you com') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (86, 83, 83) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2011-10-21 11:32:26.781252', 'Where are ', 'Any element of a tuple ca', 'Where are ') ;
INSERT INTO auth (login, password1, name) VALUES ('sundayism1917@outlook.com', 'MR7670VY44', 'Horace') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6816, 916261, '2006-06-12', 'Albert', 'Albert', 'male', 'Researcher') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (237, 419429, 71950, 6816, 916261, '+49023745065') ;
INSERT INTO auth (login, password1, name) VALUES ('blisters1874@gmail.com', 'UQ9977LO95', 'Jeanmarie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Christian', 'Delaney', 92, 238, '1985-11-05', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2005-02-20 11:03:58.162249', 'The sequen', 'The sequential subset of ', 'Initially ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (88, 84, 84) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-05-02 14:46:32.703366', 'In 1989 th', 'Initially composing light', 'Atoms can ') ;
INSERT INTO auth (login, password1, name) VALUES ('polyparies2002@yandex.com', 'LN4177ID51', 'Stacy') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4955, 040394, '1971-05-13', 'Chung', 'Stein', 'male', 'Ledger Clerk') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (239, 330570, 07300, 4955, 040394, '+07530007411') ;
INSERT INTO auth (login, password1, name) VALUES ('cadaster1970@yandex.com', 'IO2596LJ30', 'Lashaunda') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Hassan', 'Sutton', 77, 240, '2014-08-08', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2013-06-28 13:34:15.001317', 'The syntax', 'Make me a sandwich. Messa', 'Initially ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (90, 85, 85) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2016-01-12 13:12:20.493421', 'I dont eve', 'Any element of a tuple ca', 'Where are ') ;
INSERT INTO auth (login, password1, name) VALUES ('dinny1870@outlook.com', 'WR0362YE38', 'Laurena') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9540, 324757, '1971-03-09', 'Nicolasa', 'Lowery', 'female', 'Presser') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (241, 950917, 20520, 9540, 324757, '+31604480318') ;
INSERT INTO auth (login, password1, name) VALUES ('toner2006@live.com', 'MX5374SO39', 'Jarred') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Theola', 'Figueroa', 93, 242, '1969-07-08', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2003-01-21 12:17:43.462297', 'She spent ', 'Ports are used to communi', 'Erlang is ') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (92, 86, 86) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2013-07-25 13:46:22.904952', 'Its main i', 'Atoms can contain any cha', 'Atoms can ') ;
INSERT INTO auth (login, password1, name) VALUES ('bossman1858@gmail.com', 'IF2201KW30', 'Keenan') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7228, 920004, '1963-06-20', 'Ressie', 'Franklin', 'male', 'Cabinet Maker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (243, 397506, 82641, 7228, 920004, '+06358256975') ;
INSERT INTO auth (login, password1, name) VALUES ('artaba1823@yahoo.com', 'MZ3325QT50', 'Dacia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Maurice', 'Mendoza', 76, 244, '1951-11-15', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2020-01-01 12:28:46.448901', 'Atoms are ', 'The sequential subset of ', 'Any elemen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (94, 87, 87) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2004-04-18 12:13:56.059063', 'Type class', 'Do you come here often? T', 'The argume') ;
INSERT INTO auth (login, password1, name) VALUES ('veining2051@outlook.com', 'ZE4948XN78', 'Arlena') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0435, 029808, '1994-01-08', 'Rocky', 'Day', 'male', 'Investment Strategist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (245, 601525, 02634, 0435, 029808, '+84101579349') ;
INSERT INTO auth (login, password1, name) VALUES ('aqueduct2044@gmail.com', 'NK1660RD91', 'Norah') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Isaura', 'Morgan', 79, 246, '1980-08-16', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2002-10-01 10:17:32.803842', 'Do you hav', 'Do you come here often? P', 'The sequen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (96, 88, 88) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2015-09-15 14:41:48.186696', 'Make me a ', 'The arguments can be prim', 'Haskell is') ;
INSERT INTO auth (login, password1, name) VALUES ('alair2020@yahoo.com', 'US1152SP32', 'Dannie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9560, 298064, '2015-09-25', 'Kasey', 'Paul', 'male', 'Farmer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (247, 329512, 19869, 9560, 298064, '+33396162062') ;
INSERT INTO auth (login, password1, name) VALUES ('saola1812@yandex.com', 'GJ3907FN40', 'Tim') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Angila', 'Owen', 25, 248, '1951-11-12', 'doctor', 'female') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2006-11-18 12:36:37.223208', 'Ports are ', 'Do you have any idea why ', 'The syntax') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (98, 89, 89) ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2007-09-04 15:36:35.749881', 'In 1989 th', 'Its main implementation i', 'In 1989 th') ;
INSERT INTO auth (login, password1, name) VALUES ('cavish1805@outlook.com', 'PZ5902ZZ83', 'Francis') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9289, 286667, '1989-02-25', 'Rochell', 'Case', 'male', 'Vehicle Body Worker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (249, 826676, 19299, 9289, 286667, '+63926071557') ;
INSERT INTO auth (login, password1, name) VALUES ('holocryptic1909@gmail.com', 'CG7451LF69', 'Chase') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Corrin', 'Cole', 61, 250, '2019-10-04', 'doctor', 'male') ;
INSERT INTO appointment (occurrence_date, diagnosis, description, reason_to_create) VALUES ('2009-03-14 16:30:14.642924', 'She spent ', 'Atoms can contain any cha', 'Any elemen') ;
INSERT INTO appointment_patient_doctor_relation (appointment_id, patient_id, doctor_id) VALUES (100, 90, 90) ;
INSERT INTO auth (login, password1, name) VALUES ('capozzi1873@live.com', 'HR4334WL86', 'Kelle') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dung', 'White', 50, 251, '1970-12-07', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('chegre1920@outlook.com', 'QU6035OJ90', 'Vannessa') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Christia', 'Gill', 98, 252, '1986-04-22', 'nurse', 'female') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (91, 92) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Tuples are containers for', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('dollop1938@yandex.com', 'OO7607PW59', 'Thresa') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (9815, 647392, '2016-06-15', 'Julian', 'Velazquez', 'male', 'Florist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (253, 726454, 11390, 9815, 647392, '+17056010044') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (31, 91) ;
INSERT INTO auth (login, password1, name) VALUES ('prohibitionary2069@yahoo.com', 'FB7332TA88', 'Ken') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6413, 360004, '2014-07-16', 'Klara', 'Berry', 'female', 'Payroll Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (254, 165984, 83182, 6413, 360004, '+40293477659') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Initially composing light', '2020-06-13 16:40:40.900131', 'The sequential subset of ') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (92, 11) ;
INSERT INTO auth (login, password1, name) VALUES ('externity1858@yandex.com', 'MU4433IB64', 'Elvie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5852, 555462, '1985-03-04', 'Spencer', 'Mcmillan', 'male', 'Garda') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (255, 778762, 28135, 5852, 555462, '+21265336030') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('97551', '2001-01-09 10:52:40.053116', 'The arguments can be prim') ;
INSERT INTO auth (login, password1, name) VALUES ('inaccessibility1858@outlook.com', 'PR0326JF80', 'Karleen') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Brad', 'Grant', 38, 256, '2008-07-02', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (93, 93, 51) ;
INSERT INTO auth (login, password1, name) VALUES ('orchichorea1830@outlook.com', 'TZ0500SX64', 'Tashia') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5861, 154100, '1957-12-09', 'Alfonso', 'Guerrero', 'male', 'Navigator') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (257, 471213, 50519, 5861, 154100, '+52080964815') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2020-07-03T12:34:31.687422', '2020-07-07T12:34:31.687422', 'They are written as strin') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (94, 31) ;
INSERT INTO auth (login, password1, name) VALUES ('hometown1849@outlook.com', 'ZE3466FZ88', 'Howard') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Riva', 'Pennington', 14, 258, '1950-06-23', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('decil1811@yahoo.com', 'FQ8059ZZ19', 'Gavin') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('William', 'Casey', 88, 259, '2015-03-27', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (94, 95) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Initially composing light', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('mustered1993@live.com', 'WW3148BI02', 'Ammie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6393, 108851, '2011-05-23', 'Anamaria', 'Perkins', 'female', 'Pattern Maker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (260, 112445, 10924, 6393, 108851, '+46347091841') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (32, 95) ;
INSERT INTO auth (login, password1, name) VALUES ('socked1994@outlook.com', 'TA1053HD69', 'Delana') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3543, 040772, '1975-07-04', 'Marcene', 'Patterson', 'female', 'Fork Lift Truck Driver') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (261, 177490, 63171, 3543, 040772, '+70752794237') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('He looked inquisitively a', '2004-04-23 12:47:06.459187', 'Any element of a tuple ca') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (96, 12) ;
INSERT INTO auth (login, password1, name) VALUES ('attune1827@gmail.com', 'XV5216CU26', 'Brigida') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6083, 927534, '1982-12-07', 'Aleen', 'Lamb', 'male', 'Packaging') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (262, 686979, 71206, 6083, 927534, '+35311519730') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('43880', '2006-09-23 15:52:17.127055', 'Do you have any idea why ') ;
INSERT INTO auth (login, password1, name) VALUES ('blotlessness1923@yandex.com', 'FV9031PZ27', 'Maybell') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Babette', 'Banks', 64, 263, '2016-03-06', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (96, 97, 52) ;
INSERT INTO auth (login, password1, name) VALUES ('iguana2007@yahoo.com', 'OQ7584RP08', 'Deandrea') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0928, 830808, '1998-03-13', 'Akilah', 'Beasley', 'female', 'Radio Director') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (264, 091023, 40973, 0928, 830808, '+35151701648') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2002-07-25T10:21:37.517550', '2002-07-29T10:21:37.517550', 'Tuples are containers for') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (98, 32) ;
INSERT INTO auth (login, password1, name) VALUES ('outplodding2042@yandex.com', 'LW4131JN52', 'Omega') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Hong', 'Brown', 100, 265, '1971-06-06', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('chazans2054@yandex.com', 'GC5205BA23', 'Taina') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Garrett', 'Cox', 51, 266, '1997-08-16', 'nurse', 'female') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (97, 98) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms can contain any cha', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('sandgoby2050@yandex.com', 'CI7262FM04', 'Consuela') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6408, 605439, '1964-06-03', 'Tashia', 'Estes', 'female', 'Cleric') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (267, 548334, 81655, 6408, 605439, '+93705689423') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (33, 99) ;
INSERT INTO auth (login, password1, name) VALUES ('aqueduct1982@gmail.com', 'KQ7068XR07', 'Ernie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2896, 707338, '2012-08-04', 'Rick', 'Browning', 'male', 'Bus Company') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (268, 350691, 14383, 2896, 707338, '+58667921910') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Atoms are used within a p', '2013-12-06 14:21:26.171613', 'Atoms can contain any cha') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (100, 13) ;
INSERT INTO auth (login, password1, name) VALUES ('seapoose2042@yandex.com', 'ZM2095CS02', 'Hayden') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1588, 178614, '2001-06-02', 'Sharilyn', 'Mclean', 'female', 'Business Consultant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (269, 348395, 72452, 1588, 178614, '+45340965777') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('60453', '2003-08-24 16:56:29.117911', 'Atoms can contain any cha') ;
INSERT INTO auth (login, password1, name) VALUES ('cherly1868@live.com', 'JG3068QY77', 'Ashley') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Sharika', 'Blankenship', 36, 270, '2004-12-20', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (99, 101, 53) ;
INSERT INTO auth (login, password1, name) VALUES ('seiser1815@live.com', 'OV8148ZL20', 'Lilliana') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8657, 566946, '2018-05-14', 'Jeremy', 'Melendez', 'female', 'Porter') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (271, 375053, 16682, 8657, 566946, '+57078320933') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2003-03-22T13:19:06.561682', '2003-03-28T13:19:06.561682', 'Do you come here often? W') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (102, 33) ;
INSERT INTO auth (login, password1, name) VALUES ('mochy1927@live.com', 'FV8054WO81', 'Marcelino') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Drucilla', 'Pickett', 13, 272, '2017-05-22', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('rolfers1892@gmail.com', 'BA5749BT87', 'Ira') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kareem', 'Haney', 18, 273, '1988-01-17', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (100, 101) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Ports are created with th', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('lallans1963@live.com', 'OO1330IF10', 'Avelina') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1564, 980950, '2000-12-24', 'Danial', 'Key', 'female', 'Foster Parent') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (274, 364729, 40306, 1564, 980950, '+34536777587') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (34, 103) ;
INSERT INTO auth (login, password1, name) VALUES ('aubert1990@gmail.com', 'OU9997PR28', 'Arlie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0796, 925014, '1958-06-29', 'Andreas', 'Woods', 'female', 'Childminder') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (275, 227749, 22703, 0796, 925014, '+33446244955') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('The arguments can be prim', '2020-03-09 15:08:52.152967', 'She spent her earliest ye') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (104, 14) ;
INSERT INTO auth (login, password1, name) VALUES ('nonincriminating1844@outlook.com', 'AV1655FP89', 'Xiao') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4705, 120570, '1957-01-16', 'Stefany', 'Goodwin', 'female', 'Claims Assessor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (276, 517559, 31090, 4705, 120570, '+71839172453') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('87931', '2013-01-23 13:34:01.111931', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('algedi1894@yandex.com', 'XR8207YV93', 'Terisa') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Mike', 'Weaver', 77, 277, '2000-03-30', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (102, 105, 54) ;
INSERT INTO auth (login, password1, name) VALUES ('toking1968@gmail.com', 'TY8250XI21', 'Lovetta') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3805, 675603, '2006-01-24', 'Marcell', 'Woods', 'male', 'Trinity House Pilot') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (278, 255608, 69257, 3805, 675603, '+71645919404') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2007-09-26T15:47:24.641703', '2007-10-02T15:47:24.641703', 'It is also a garbage-coll') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (106, 34) ;
INSERT INTO auth (login, password1, name) VALUES ('together2041@outlook.com', 'XD2201HE09', 'Brandon') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Clinton', 'Wagner', 97, 279, '1991-05-05', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('cebus1966@yahoo.com', 'HC9101IR65', 'Yi') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Alejandro', 'Frederick', 17, 280, '1999-06-06', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (103, 104) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('In 1989 the building was ', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('barriere1889@yandex.com', 'TH4926MG39', 'Fletcher') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8456, 746460, '1955-07-05', 'Brent', 'Sears', 'female', 'Blind Assembler') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (281, 162390, 46157, 8456, 746460, '+85171622066') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (35, 107) ;
INSERT INTO auth (login, password1, name) VALUES ('periostosis1933@yandex.com', 'TX8565IW93', 'Eddy') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2548, 882024, '1959-09-13', 'Yee', 'Tucker', 'male', 'Signalman') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (282, 767936, 02529, 2548, 882024, '+76056111376') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Erlang is known for its d', '2009-01-16 12:11:21.651732', 'The sequential subset of ') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (108, 15) ;
INSERT INTO auth (login, password1, name) VALUES ('redundancies1814@live.com', 'LH1911XC78', 'Reiko') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6789, 598975, '2018-02-03', 'Mahalia', 'Horton', 'male', 'Systems Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (283, 256117, 30393, 6789, 598975, '+81771183314') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('16515', '2002-11-13 13:35:02.193605', 'Make me a sandwich. Erlan') ;
INSERT INTO auth (login, password1, name) VALUES ('incompletion2027@yandex.com', 'MF1780OL84', 'Demetrius') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Marco', 'Marquez', 92, 284, '1952-06-14', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (105, 109, 55) ;
INSERT INTO auth (login, password1, name) VALUES ('folkmotes1892@gmail.com', 'UH4800OW44', 'Luciano') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1397, 189293, '1999-08-01', 'Tasia', 'Grimes', 'female', 'Tree Surgeon') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (285, 459362, 43596, 1397, 189293, '+34650269219') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2015-02-22T15:38:31.728225', '2015-02-25T15:38:31.728225', 'Haskell is a standardized') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (110, 35) ;
INSERT INTO auth (login, password1, name) VALUES ('unaffectionate1894@live.com', 'MJ8529PW88', 'Edra') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Annabell', 'Buckner', 90, 286, '1991-02-22', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('calamite1868@outlook.com', 'PO8650CC67', 'Kerry') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Carlee', 'Hines', 10, 287, '1978-11-13', 'nurse', 'female') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (106, 107) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Erlang is a general-purpo', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('bannet1896@outlook.com', 'DE8410WN02', 'Eduardo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3825, 601375, '1994-06-22', 'See', 'Conner', 'male', 'Gambler') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (288, 538605, 92672, 3825, 601375, '+47434447344') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (36, 111) ;
INSERT INTO auth (login, password1, name) VALUES ('carnations2015@gmail.com', 'JL1765YY89', 'Tonie') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2211, 085534, '1989-08-13', 'Marvin', 'Campos', 'male', 'Artexer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (289, 134502, 31599, 2211, 085534, '+69968625732') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Any element of a tuple ca', '2014-06-09 15:10:17.707868', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (112, 16) ;
INSERT INTO auth (login, password1, name) VALUES ('unfrequentable2028@outlook.com', 'BL1457PD99', 'Justin') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0524, 857962, '2015-12-13', 'Chanell', 'Hickman', 'male', 'Technical Editor') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (290, 420223, 26483, 0524, 857962, '+09312784814') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('29487', '2009-04-05 13:45:40.450944', 'The arguments can be prim') ;
INSERT INTO auth (login, password1, name) VALUES ('sclera1810@live.com', 'JK3709TS50', 'Antone') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lindsay', 'Dodson', 58, 291, '2011-03-10', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (108, 113, 56) ;
INSERT INTO auth (login, password1, name) VALUES ('cowhand1943@outlook.com', 'KZ5720AF05', 'Assunta') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2089, 362345, '1975-05-30', 'Elenora', 'Osborne', 'male', 'Violin Maker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (292, 983951, 07024, 2089, 362345, '+08429041456') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2011-06-10T13:58:23.164747', '2011-06-12T13:58:23.164747', 'Its main implementation i') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (114, 36) ;
INSERT INTO auth (login, password1, name) VALUES ('telegrams1923@gmail.com', 'VV5775IL78', 'Odis') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Bennett', 'Nixon', 32, 293, '1970-06-23', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('aucan1844@yahoo.com', 'TO8422QY00', 'Kevin') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Manual', 'Wheeler', 14, 294, '2010-12-10', 'nurse', 'female') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (109, 110) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you have any idea why ', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('deadlocked1887@live.com', 'LN4629GB43', 'Blake') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1302, 778105, '2019-03-11', 'Violette', 'Hensley', 'female', 'Ledger Clerk') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (295, 532546, 71974, 1302, 778105, '+85305434040') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (37, 115) ;
INSERT INTO auth (login, password1, name) VALUES ('delphinite1998@yandex.com', 'JL2749QR08', 'Coreen') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (5234, 186041, '2006-02-01', 'Serafina', 'Austin', 'male', 'Marine Geologist') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (296, 544657, 41856, 5234, 186041, '+20848926171') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('In 1989 the building was ', '2013-10-11 14:30:55.497497', 'Tuples are containers for') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (116, 17) ;
INSERT INTO auth (login, password1, name) VALUES ('bellhop1992@yandex.com', 'CR5139UP28', 'Vashti') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7093, 580911, '2004-07-28', 'Raymond', 'Peters', 'male', 'Oil Rig Crew') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (297, 881605, 97028, 7093, 580911, '+45653597061') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('71621', '2017-03-04 14:33:25.605562', 'Erlang is a general-purpo') ;
INSERT INTO auth (login, password1, name) VALUES ('absent2040@gmail.com', 'GI8257ZW42', 'Dewey') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Tory', 'Oliver', 32, 298, '1990-01-10', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (111, 117, 57) ;
INSERT INTO auth (login, password1, name) VALUES ('intertrigo2070@outlook.com', 'YS3365TN42', 'Angelo') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8235, 057551, '1993-01-26', 'Lucien', 'Armstrong', 'male', 'Patrolman') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (299, 401247, 69731, 8235, 057551, '+54105099440') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2007-06-11T10:05:40.285036', '2007-06-15T10:05:40.285036', 'She spent her earliest ye') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (118, 37) ;
INSERT INTO auth (login, password1, name) VALUES ('angriness2017@yahoo.com', 'WD1879KV41', 'Malcolm') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Micha', 'Gilbert', 13, 300, '1988-01-29', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('reservery1862@gmail.com', 'HW7054AQ71', 'Kizzie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Lasandra', 'Douglas', 9, 301, '2002-07-22', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (112, 113) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('myalgic2021@yahoo.com', 'IE0247JS21', 'Stacee') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1783, 583884, '2018-10-02', 'Brynn', 'Marshall', 'male', 'Quality Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (302, 628511, 43450, 1783, 583884, '+09789021354') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (38, 119) ;
INSERT INTO auth (login, password1, name) VALUES ('silentest1834@outlook.com', 'LK5994PL11', 'Octavio') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (2467, 186946, '1998-05-05', 'Terrell', 'Mejia', 'female', 'Branch Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (303, 174941, 24773, 2467, 186946, '+79791791099') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Where are my pants? The G', '2004-09-12 10:46:44.566549', 'The arguments can be prim') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (120, 18) ;
INSERT INTO auth (login, password1, name) VALUES ('acanth2018@yahoo.com', 'HB7643RY39', 'Latoyia') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7742, 967418, '2012-01-14', 'Jennefer', 'Foster', 'male', 'Orchestral') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (304, 636621, 68942, 7742, 967418, '+20331105502') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('83825', '2001-01-30 11:06:52.642303', 'Tuples are containers for') ;
INSERT INTO auth (login, password1, name) VALUES ('pianograph2020@yandex.com', 'RV0241AR99', 'Vertie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Chere', 'Kline', 62, 305, '2011-06-05', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (114, 121, 58) ;
INSERT INTO auth (login, password1, name) VALUES ('drainage2030@yahoo.com', 'ER1528LY74', 'Eddy') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7602, 701218, '2002-12-13', 'Versie', 'Lloyd', 'female', 'Medical Practitioner') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (306, 462169, 05963, 7602, 701218, '+90929821737') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2016-11-16T12:38:24.086700', '2016-11-22T12:38:24.086700', 'Make me a sandwich. Tuple') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (122, 38) ;
INSERT INTO auth (login, password1, name) VALUES ('calctufa1847@gmail.com', 'CA5800KY30', 'Nicky') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ivana', 'Murray', 63, 307, '2018-01-16', 'doctor', 'female') ;
INSERT INTO auth (login, password1, name) VALUES ('dryopians1856@gmail.com', 'LA3582EI84', 'Sheridan') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Kory', 'Barron', 66, 308, '1954-10-05', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (115, 116) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Its main implementation i', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('unjewelled1879@outlook.com', 'HN8983PO68', 'Brinda') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0933, 590503, '1994-07-12', 'Tyrell', 'Branch', 'male', 'IT Consultant') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (309, 288372, 65897, 0933, 590503, '+54261423532') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (39, 123) ;
INSERT INTO auth (login, password1, name) VALUES ('gregariousness1949@live.com', 'HA6003JV39', 'Anneliese') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (7823, 621225, '1960-01-20', 'Kurtis', 'Leach', 'male', 'Violin Maker') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (310, 415573, 98328, 7823, 621225, '+09538703557') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Ports are created with th', '2015-10-08 16:50:27.785191', 'She spent her earliest ye') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (124, 19) ;
INSERT INTO auth (login, password1, name) VALUES ('merrily2044@yandex.com', 'VC0037SU47', 'Emiko') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (1996, 578160, '1989-07-05', 'Erik', 'Knowles', 'female', 'Blinds Installer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (311, 673635, 17279, 1996, 578160, '+52732453002') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('39635', '2010-10-25 14:35:40.577940', 'In 1989 the building was ') ;
INSERT INTO auth (login, password1, name) VALUES ('satirically1803@live.com', 'QZ3456HP39', 'Mckinley') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Trent', 'Harrison', 81, 312, '2006-06-13', 'administrator', 'female') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (117, 125, 59) ;
INSERT INTO auth (login, password1, name) VALUES ('tonlet1943@yandex.com', 'UX2333VZ70', 'Otis') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (0055, 692102, '1956-03-30', 'Britni', 'Trujillo', 'female', 'Turkey Farmer') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (313, 462099, 19454, 0055, 692102, '+84842824607') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2014-11-21T10:05:51.751232', '2014-11-25T10:05:51.751232', 'I dont even care. The Gal') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (126, 39) ;
INSERT INTO auth (login, password1, name) VALUES ('antically2048@yahoo.com', 'GQ5536NF32', 'Nancie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Bud', 'Stark', 22, 314, '1969-04-14', 'doctor', 'male') ;
INSERT INTO auth (login, password1, name) VALUES ('anybodies1876@yahoo.com', 'NU8614BW92', 'Stuart') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Evan', 'Bray', 31, 315, '2000-01-23', 'nurse', 'male') ;
INSERT INTO doctor_nurse_relation (doctor_id, nurse_id) VALUES (118, 119) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Tuples are containers for', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('sextur1823@live.com', 'CM7442YE38', 'Shawana') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (6357, 201602, '2018-04-17', 'Refugio', 'Sandoval', 'female', 'Sales Director') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (316, 300430, 90461, 6357, 201602, '+21264296386') ;
INSERT INTO notification_patient_relation (notification_id, patient_id) VALUES (40, 127) ;
INSERT INTO auth (login, password1, name) VALUES ('kalimbas1964@gmail.com', 'WF1523UA85', 'Dante') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (3944, 726402, '1982-09-04', 'Piper', 'Woods', 'female', 'Homecare Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (317, 111362, 04022, 3944, 726402, '+91483920036') ;
INSERT INTO complain (theme, creation_date, complain_text) VALUES ('Atoms can contain any cha', '2007-10-14 16:26:25.239616', 'I dont even care. She spe') ;
INSERT INTO patient_complain_relation (patient_id, complain_id) VALUES (128, 20) ;
INSERT INTO auth (login, password1, name) VALUES ('disheart1958@yahoo.com', 'UE8975TX75', 'Hilma') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (4836, 500984, '2007-05-09', 'Carolyne', 'Bush', 'female', 'Quality Manager') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (318, 217096, 45703, 4836, 500984, '+31941719042') ;
INSERT INTO invoice (amount, date_of_creation, reason) VALUES ('39343', '2005-02-12 16:53:43.113125', 'Erlang is a general-purpo') ;
INSERT INTO auth (login, password1, name) VALUES ('escalader1949@live.com', 'XL2909SU45', 'Grisel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Versie', 'Saunders', 58, 319, '1980-08-23', 'administrator', 'male') ;
INSERT INTO patient_invoice_staff_relation (staff_id, patient_id, invoice_id) VALUES (120, 129, 60) ;
INSERT INTO auth (login, password1, name) VALUES ('chlorozincate2026@live.com', 'ZT7452DY26', 'Walton') ;
INSERT INTO passport (seria, number, birth, f_name, l_name, gender, address) VALUES (8712, 563997, '2007-05-26', 'Masako', 'Madden', 'male', 'Assistant Teacher') ;
INSERT INTO patient (auth_id, bank_account_id, insurance_policy_id, passport_seria, passport_number, phone_num) VALUES (320, 266042, 71074, 8712, 563997, '+23633998551') ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-04-18T12:38:48.285336', '2013-04-21T12:38:48.285336', 'They are written as strin') ;
INSERT INTO patient_ticket_relation (patient_id, ticket_id) VALUES (130, 40) ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The arguments can be prim', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('rickstand1964@gmail.com', 'IT5579CY45', 'Romelia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Gema', 'Norton', 72, 321, '2017-07-23', 'nurse', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (41, 121) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2014-04-30T10:08:00.402690', '2014-05-03T10:08:00.402690', 'It is also a garbage-coll') ;
INSERT INTO auth (login, password1, name) VALUES ('brags1813@yahoo.com', 'TJ6965ZB68', 'Christinia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Maybell', 'Maddox', 67, 322, '2012-09-24', 'security', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (122, 41, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Its main implementation i', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('articulate1923@yahoo.com', 'SA6557QH01', 'Sebrina') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Nicky', 'Simmons', 94, 323, '2018-11-27', 'nurse', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (42, 123) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-11-09T11:59:01.001855', '2019-11-12T11:59:01.001855', 'Erlang is a general-purpo') ;
INSERT INTO auth (login, password1, name) VALUES ('increaseful1813@yahoo.com', 'IZ5515JE36', 'Clay') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Rodrigo', 'Perkins', 42, 324, '1950-01-13', 'doctor', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (124, 42, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Haskell features a type s', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('durango1899@live.com', 'UF3725EO58', 'Alix') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Annita', 'Farley', 6, 325, '2018-07-19', 'nurse', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (43, 125) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2003-09-18T13:11:27.046513', '2003-09-21T13:11:27.046513', 'Its main implementation i') ;
INSERT INTO auth (login, password1, name) VALUES ('allergy1852@live.com', 'AJ1266KG91', 'Digna') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Alla', 'Stanton', 25, 326, '1991-11-14', 'doctor', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (126, 43, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms can contain any cha', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('fly1968@live.com', 'TT6310BI36', 'Lonny') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Scott', 'Berry', 34, 327, '1950-11-19', 'administrator', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (44, 127) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2016-12-19T16:03:24.112178', '2016-12-23T16:03:24.112178', 'The syntax {D1,D2,...,Dn}') ;
INSERT INTO auth (login, password1, name) VALUES ('lease1818@outlook.com', 'NF7616TE54', 'Rich') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Josef', 'Sweet', 19, 328, '1983-07-22', 'doctor', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (128, 44, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Erlang is known for its d', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('embay1944@yandex.com', 'VC6399LH88', 'Marlana') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Alayna', 'Day', 9, 329, '1958-06-25', 'doctor', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (45, 129) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2017-08-05T14:36:26.777694', '2017-08-12T14:36:26.777694', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('obvention2000@gmail.com', 'YH5602AM15', 'Samuel') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Loyd', 'Rosales', 71, 330, '1970-12-01', 'nurse', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (130, 45, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms can contain any cha', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('gripy2021@yandex.com', 'KT7952ID59', 'Deangelo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Mitchel', 'Dodson', 48, 331, '1975-01-30', 'nurse', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (46, 131) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-11-17T15:43:17.779294', '2013-11-23T15:43:17.779294', 'Do you have any idea why ') ;
INSERT INTO auth (login, password1, name) VALUES ('minima2051@yahoo.com', 'NJ8628TZ56', 'Olinda') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Alejandrina', 'Blanchard', 94, 332, '1993-05-21', 'administrator', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (132, 46, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('She spent her earliest ye', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('hydroscopicity2040@yahoo.com', 'NU3278AS91', 'Sol') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Carie', 'Stanton', 5, 333, '1972-09-30', 'administrator', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (47, 133) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-07-11T10:12:33.547671', '2012-07-17T10:12:33.547671', 'Initially composing light') ;
INSERT INTO auth (login, password1, name) VALUES ('incarnate1896@gmail.com', 'DX0400AW97', 'Eleni') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Mikki', 'Mcgowan', 70, 334, '1957-01-04', 'IT_administrator', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (134, 47, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The syntax {D1,D2,...,Dn}', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('electrodes1847@outlook.com', 'ZC4678YW50', 'Yang') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Emanuel', 'Vaughn', 78, 335, '1950-08-22', 'security', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (48, 135) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-12-25T15:12:47.084763', '2012-12-31T15:12:47.084763', 'Haskell is a standardized') ;
INSERT INTO auth (login, password1, name) VALUES ('atop1851@yandex.com', 'RN9962TE09', 'Nicolas') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Pandora', 'Beasley', 18, 336, '1956-02-11', 'nurse', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (136, 48, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Ports are used to communi', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('cyborgs1945@outlook.com', 'WK3710YG44', 'Un') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Charley', 'Kirkland', 26, 337, '1999-11-29', 'nurse', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (49, 137) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2019-04-18T13:28:30.189848', '2019-04-20T13:28:30.189848', 'Do you come here often? H') ;
INSERT INTO auth (login, password1, name) VALUES ('dawing1963@yandex.com', 'BC0213KR69', 'Shannon') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dusty', 'Perkins', 23, 338, '1996-06-21', 'doctor', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (138, 49, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Where are my pants? Ports', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('bernice1806@outlook.com', 'HW9491ZI09', 'Felicidad') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Georgeann', 'Pittman', 37, 339, '1986-07-27', 'nurse', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (50, 139) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2003-10-14T12:18:13.159830', '2003-10-19T12:18:13.159830', 'The sequential subset of ') ;
INSERT INTO auth (login, password1, name) VALUES ('casuariidae1824@gmail.com', 'DP1734QH74', 'Lashaunda') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Charlyn', 'Gaines', 38, 340, '2008-10-01', 'security', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (140, 50, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Type classes first appear', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('contraptious1930@yandex.com', 'EJ7914HI04', 'Lindsay') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Drema', 'Floyd', 24, 341, '2014-07-31', 'nurse', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (51, 141) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-03-17T12:31:05.916557', '2012-03-24T12:31:05.916557', 'Do you come here often? E') ;
INSERT INTO auth (login, password1, name) VALUES ('ineye2041@yahoo.com', 'EE4211KF83', 'Aleen') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Donny', 'Pace', 80, 342, '1977-08-10', 'doctor', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (142, 51, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Atoms are used within a p', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('cremone2023@live.com', 'TY8638AC35', 'Damion') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Suellen', 'Marks', 38, 343, '2007-12-20', 'security', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (52, 143) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2011-04-09T10:57:29.777368', '2011-04-16T10:57:29.777368', 'They are written as strin') ;
INSERT INTO auth (login, password1, name) VALUES ('bewitching1831@live.com', 'TO5252CY39', 'Moses') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Denisha', 'Hull', 58, 344, '1955-12-20', 'security', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (144, 52, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Its main implementation i', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('synascidian1865@live.com', 'DQ4027TI55', 'Domenic') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Alica', 'Doyle', 60, 345, '1999-09-02', 'administrator', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (53, 145) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-02-14T14:59:27.781673', '2013-02-20T14:59:27.781673', 'Type classes first appear') ;
INSERT INTO auth (login, password1, name) VALUES ('kibbutz2028@live.com', 'HJ0285VP91', 'Claude') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Shala', 'Jimenez', 94, 346, '1991-07-09', 'administrator', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (146, 53, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Tuples are containers for', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('giggled2027@live.com', 'WI1419RM79', 'Kirk') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Dacia', 'Eaton', 2, 347, '1953-02-06', 'administrator', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (54, 147) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2009-09-05T11:33:01.143021', '2009-09-07T11:33:01.143021', 'Erlang is a general-purpo') ;
INSERT INTO auth (login, password1, name) VALUES ('equvalent1943@outlook.com', 'GY2181UT23', 'Camie') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ria', 'Chase', 59, 348, '1995-02-23', 'nurse', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (148, 54, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('They are written as strin', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('ermey1892@outlook.com', 'ZZ9009JF28', 'Obdulia') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Avril', 'Bowen', 79, 349, '2011-04-03', 'IT_administrator', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (55, 149) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2012-07-12T12:32:42.803337', '2012-07-15T12:32:42.803337', 'I dont even care. Its mai') ;
INSERT INTO auth (login, password1, name) VALUES ('rail1848@outlook.com', 'TF6502IC11', 'Andres') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Latrisha', 'Lopez', 73, 350, '1999-02-13', 'security', 'female') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (150, 55, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Do you have any idea why ', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('blais2063@live.com', 'CU6588AG15', 'Arnulfo') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Inocencia', 'Key', 76, 351, '1969-05-14', 'IT_administrator', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (56, 151) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2001-08-17T15:37:22.452011', '2001-08-24T15:37:22.452011', 'Atoms are used within a p') ;
INSERT INTO auth (login, password1, name) VALUES ('dullhead1897@outlook.com', 'BQ0315JQ88', 'Donald') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Carolyne', 'Conway', 71, 352, '2009-09-28', 'IT_administrator', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (152, 56, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Messages can be sent to a', 'closed') ;
INSERT INTO auth (login, password1, name) VALUES ('abstinent2061@yahoo.com', 'FT3115RE39', 'Joya') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Fidela', 'Carpenter', 62, 353, '1960-11-20', 'IT_administrator', 'male') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (57, 153) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2006-03-20T14:50:30.641687', '2006-03-23T14:50:30.641687', 'It is also a garbage-coll') ;
INSERT INTO auth (login, password1, name) VALUES ('starlessly1962@gmail.com', 'WB8322TO64', 'Carey') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Hector', 'Petersen', 48, 354, '1964-07-10', 'nurse', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (154, 57, 'closed') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('Its main implementation i', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('falls1957@yahoo.com', 'NE2043JI14', 'Sindy') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Odell', 'Carson', 36, 355, '2001-04-06', 'nurse', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (58, 155) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2000-01-05T13:56:46.442474', '2000-01-10T13:56:46.442474', 'The arguments can be prim') ;
INSERT INTO auth (login, password1, name) VALUES ('alidia2062@live.com', 'ZS9127XL62', 'Vance') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Marielle', 'Durham', 99, 356, '2019-06-09', 'doctor', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (156, 58, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('It is also a garbage-coll', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('vaucheriaceous1983@yandex.com', 'YI3232BJ66', 'Heide') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ehtel', 'Potter', 46, 357, '1951-03-27', 'doctor', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (59, 157) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2016-08-25T11:21:19.512885', '2016-08-30T11:21:19.512885', 'The sequential subset of ') ;
INSERT INTO auth (login, password1, name) VALUES ('davey2005@gmail.com', 'KZ4491YN20', 'Crystle') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Ron', 'Mcfarland', 41, 358, '2017-02-03', 'doctor', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (158, 59, 'open') ;
INSERT INTO notification (notification_text, notification_status) VALUES ('The Galactic Empire is ne', 'open') ;
INSERT INTO auth (login, password1, name) VALUES ('misleadingly1896@yandex.com', 'SP2943DY23', 'Roselee') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Corey', 'Cabrera', 36, 359, '1993-02-15', 'nurse', 'female') ;
INSERT INTO notification_staff_relation (notification_id, staff_id) VALUES (60, 159) ;
INSERT INTO ticket (creation_date, closing_date, ticket_text) VALUES ('2013-09-28T15:45:28.426905', '2013-09-30T15:45:28.426905', 'Any element of a tuple ca') ;
INSERT INTO auth (login, password1, name) VALUES ('impala1839@outlook.com', 'AN1005ZV71', 'Collin') ;
INSERT INTO staff (first_name, last_name, room, auth_id, birthday, position, gender) VALUES ('Pete', 'Benton', 17, 360, '2014-06-25', 'nurse', 'male') ;
INSERT INTO staff_ticket_relation (staff_id, ticket_id, ticket_status) VALUES (160, 60, 'open') ;