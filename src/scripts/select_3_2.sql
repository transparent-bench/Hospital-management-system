select id from patient
inner join (
    select r.patient_id, count(a.id) as week_count
    from appointment a
             inner join appointment_patient_doctor_relation r on a.id = r.appointment_id
             inner join (
        select p.id, p2.f_name, p2.l_name, count(a.id)
        from appointment_patient_doctor_relation
                 INNER JOIN appointment a on appointment_patient_doctor_relation.appointment_id = a.id
                 INNER JOIN patient p on appointment_patient_doctor_relation.patient_id = p.id
                 INNER JOIN passport p2 on p.passport_seria = p2.seria and p.passport_number = p2.number
        where occurrence_date between current_date - interval '1 month' AND current_date
        GROUP BY p.id, p2.f_name, p2.l_name) as t
                        on t.id = r.patient_id
    where occurrence_date between current_date - interval '1 week' AND current_date - interval '0 week'
    group by r.patient_id
    having count(a.id)>=2
) as good_patients
on id = good_patients.patient_id;
