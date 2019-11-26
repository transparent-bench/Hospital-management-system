select patient_id, f_name,  count(appointment_id)
from appointment_patient_doctor_relation
    INNER JOIN appointment on appointment.id = appointment_patient_doctor_relation.appointment_id
    INNER JOIN patient on patient_id = patient.id
    inner join passport on passport_number = passport.number
where occurence_date > current_date - interval '3 year'  and extract(YEAR from age(birth)) >= 50
group by patient_id, f_name;

select patient_id, f_name,  extract(YEAR from age(birth)), count(appointment_id)
from appointment_patient_doctor_relation
    INNER JOIN appointment on appointment.id = appointment_patient_doctor_relation.appointment_id
    INNER JOIN patient on patient_id = patient.id
    INNER JOIN passport on passport_number = passport.number
where occurence_date > current_date - interval '3 year'
group by patient_id, f_name, extract(YEAR from age(birth));