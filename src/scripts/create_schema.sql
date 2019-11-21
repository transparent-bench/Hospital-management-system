CREATE TYPE gender_type AS ENUM ('male', 'female');
CREATE TYPE staff_position_type AS ENUM('doctor', 'administrator', 'nurse', 'security', 'IT-administrator');
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
  phone_num int,
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
  occurence_date timestamp(0),
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

-- patient_compaint_relation
CREATE SEQUENCE IF NOT EXISTS patient_compaint_relation_seq;

CREATE TABLE IF NOT EXISTS patient_compaint_relation(
  id int DEFAULT NEXTVAL ('patient_compaint_relation_seq'),
  patient_id int,
  FOREIGN KEY (patient_id) REFERENCES patient(id),
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
  patient_id int,
  ticket_id int,
  ticket_status ticket_status_type,
  FOREIGN KEY (patient_id) REFERENCES patient(id),
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

