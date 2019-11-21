insert into auth(login, password1, name) VALUES('egorka', 1234, 'Egor');
insert into auth(login, password1, name) VALUES ('alinochka', 456, 'Alina');
insert into auth(login, password1, name) VALUES ('kamal', 798, 'Kamil');
insert into auth(login, password1, name) VALUES ('marinochka', 3867, 'Marina');

insert into passport(seria, number, birth, f_name, l_name, gender, address)
    VALUES (1234, 567890, '1999-10-15', 'Kamil', 'Rizatdinov', 'male', 'Universitetskaya-1');

insert into patient(bank_account_id, auth_id, phone_num, insurance_policy_id, passport_seria, passport_number)
    VALUES (Null, 3, 1234556, 173875, 1234, 567890);


insert into appointment(occurence_date, diagnosis, description, reason_to_create)
    VALUES ('2019-10-03', 'obesity', 'he is too fat', 'make him smaller');
insert into appointment(occurence_date, diagnosis, description, reason_to_create)
    VALUES ('2019-10-03', 'Stress', 'description', 'reason');
insert into appointment(occurence_date, diagnosis, description, reason_to_create)
    VALUES ('2019-10-03', 'obesity', 'he is too fat', 'make him smaller');
insert into appointment(occurence_date, diagnosis, description, reason_to_create)
    VALUES ('2019-9-03', 'old obesity', 'he is too fat', 'make him smaller');


insert into staff(first_name, last_name, auth_id, birthday, position, gender) -- ok
    VALUES ('Mazarello', 'Cool last name', 1,  '2001-01-16', 'doctor', 'male');
insert into staff(first_name, last_name, birthday, position, gender) -- ok
    VALUES ('First name', 'Lazaro', '2001-01-16', 'doctor', 'male');
insert into staff(first_name, last_name, birthday, position, gender) -- not ok
    VALUES ('Lazarello', 'M Last name', '2001-01-16', 'doctor', 'male');

insert into staff(first_name, last_name, birthday, position, gender) -- not ok
    VALUES ('Wrong doctor', 'M Last name', '2001-01-16', 'doctor', 'male');


insert into appointment_patient_doctor_relation(appointment_id, patient_id, doctor_id)
    VALUES (1, 1, 1);
insert into appointment_patient_doctor_relation(appointment_id, patient_id, doctor_id)
    VALUES (2, 1, 2);
insert into appointment_patient_doctor_relation(appointment_id, patient_id, doctor_id)
    VALUES (3, 1, 3);
insert into appointment_patient_doctor_relation(appointment_id, patient_id, doctor_id)
    VALUES (4, 1, 4);
