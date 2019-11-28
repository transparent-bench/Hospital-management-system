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