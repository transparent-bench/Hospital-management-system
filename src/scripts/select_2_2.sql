SELECT A.staff_id, A.count, count(A.count) as appointments9_10
FROM (SELECT first_name, last_name, staff.id as staff_id, count(appointment_id), occurrence_date
        FROM staff
            INNER JOIN appointment_patient_doctor_relation
                ON staff.id = appointment_patient_doctor_relation.doctor_id
            INNER JOIN appointment
                ON appointment.id = appointment_patient_doctor_relation.appointment_id
        where occurrence_date between  current_date - interval '1 year' AND current_date
        GROUP BY staff.id, occurrence_date) as A
where cast(A.occurrence_date as time) between '{}:00' and '{}:00'
GROUP by A.staff_id, a.first_name, a.last_name, a.count;

