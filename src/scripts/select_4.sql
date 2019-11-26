SELECT sum(a.total)
FROM (
    SELECT count(*) as appointment_count,
    CASE
        WHEN current_date-p.birth >= interval '50 year' AND count(*) >= 3 THEN 500*count(*)
        WHEN current_date-p.birth >= interval '50 year' AND count(*) < 3 THEN 400*count(*)
        WHEN current_date-p.birth < interval '50 year' AND count(*) >= 3 THEN 250*count(*)
        WHEN current_date-p.birth < interval '50 year' AND count(*) < 3 THEN 200*count(*)
    END as total
    FROM patient
    INNER JOIN passport p on patient.passport_seria = p.seria and patient.passport_number = p.number
    INNER JOIN appointment_patient_doctor_relation apdr on patient.id = apdr.patient_id
    INNER JOIN appointment a on apdr.appointment_id = a.id
    WHERE current_date - a.occurrence_date < interval '1 month'
    GROUP BY patient.id, p.f_name, p.birth) as a;


-- select patient_id, f_name,  count(appointment_id)
-- from appointment_patient_doctor_relation
--     INNER JOIN appointment on appointment.id = appointment_patient_doctor_relation.appointment_id
--     INNER JOIN patient on patient_id = patient.id
--     inner join passport on passport_number = passport.number
-- where occurence_date > current_date - interval '3 year'  and extract(YEAR from age(birth)) >= 50
-- group by patient_id, f_name;
--
-- select patient_id, f_name,  extract(YEAR from age(birth)), count(appointment_id)
-- from appointment_patient_doctor_relation
--     INNER JOIN appointment on appointment.id = appointment_patient_doctor_relation.appointment_id
--     INNER JOIN patient on patient_id = patient.id
--     INNER JOIN passport on passport_number = passport.number
-- where occurence_date > current_date - interval '3 year'
-- group by patient_id, f_name, extract(YEAR from age(birth));