select generate_series.generate_series as date_from, second_series.generate_series as date_until, patients.patient_id

from generate_series(current_date + interval '1 day' - interval '4 week', current_date + interval '1 day' - interval '1 week', interval '1 week')
inner join (
    select * from generate_series(current_date + interval '1 day' - interval '3 week', current_date + interval '1 day', interval '1 week')
    ) second_series
    on generate_series.generate_series = second_series.generate_series - interval '1 week'
inner join (
    select r.patient_id, a.occurrence_date, count(a.id) as week_count
        from appointment a
                 inner join appointment_patient_doctor_relation r on a.id = r.appointment_id
                 inner join (
                        select p.id, p2.f_name, p2.l_name, count(a.id)
                        from appointment_patient_doctor_relation
                        INNER JOIN appointment a on appointment_patient_doctor_relation.appointment_id = a.id
                        INNER JOIN patient p on appointment_patient_doctor_relation.patient_id = p.id
                        INNER JOIN passport p2 on p.passport_seria = p2.seria and p.passport_number = p2.number
                        where occurrence_date between current_date - interval '1 month' AND current_date
                        GROUP BY p.id, p2.f_name, p2.l_name
                     ) as t on t.id = r.patient_id
        group by r.patient_id, a.occurrence_date
    ) as patients
on patients.occurrence_date between generate_series.generate_series and second_series.generate_series;