SELECT staff.id, staff.first_name, staff.last_name, count(*) as appointment_count
FROM staff
    INNER JOIN appointment_patient_doctor_relation apdr on staff.id = apdr.doctor_id
    INNER JOIN appointment a on apdr.appointment_id = a.id
WHERE occurrence_date between current_date - interval '1 year' and current_date - interval '0 year'
GROUP BY staff.id, staff.first_name, staff.last_name
HAVING count(*) >= 5;