SELECT staff.id as doctor_id, count(appointment_id)
FROM staff
    INNER JOIN appointment_patient_doctor_relation
        ON staff.id = appointment_patient_doctor_relation.doctor_id
    INNER JOIN appointment
        ON appointment.id = appointment_patient_doctor_relation.appointment_id
where occurrence_date between current_date - interval '1 year' AND current_date
GROUP BY staff.id;