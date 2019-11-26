SELECT first_name, last_name, staff.id as staff_id, count(appointment_id)
FROM staff
    INNER JOIN appointment_patient_doctor_relation
        ON staff.id = appointment_patient_doctor_relation.doctor_id
    INNER JOIN appointment
        ON appointment.id = appointment_patient_doctor_relation.appointment_id
where occurrence_date between  current_date - interval '1 year' AND current_date
GROUP BY staff.id;

SELECT A.first_name, A.last_name, A.staff_id, A.count, count(A.count) as appointments9_10
FROM (SELECT first_name, last_name, staff.id as staff_id, count(appointment_id), occurrence_date
        FROM staff
            INNER JOIN appointment_patient_doctor_relation
                ON staff.id = appointment_patient_doctor_relation.doctor_id
            INNER JOIN appointment
                ON appointment.id = appointment_patient_doctor_relation.appointment_id
        where occurrence_date between  current_date - interval '1 year' AND current_date
        GROUP BY staff.id, occurrence_date) as A
where cast(A.occurrence_date as time) between '10:00:00' and '15:00:00'
GROUP by A.staff_id, a.first_name, a.last_name, a.count;


-- SELECT appointment_patient_doctor_relation.id as appointment_id, staff.first_name as doctor_firs, staff.last_name as doctor_second, occurrence_date
--        FROM appointment_patient_doctor_relation
-- INNER JOIN staff
--     on appointment_patient_doctor_relation.doctor_id = staff.id
-- INNER JOIN patient
--     on appointment_patient_doctor_relation.patient_id = patient.id
-- INNER JOIN appointment a on appointment_patient_doctor_relation.appointment_id = a.id
-- Where occurrence_date between current_date - interval '1 year' AND current_date