--counted who and how much visited last month
select p.id, p2.f_name, p2.l_name, count(a.id) as last_month_count
from appointment_patient_doctor_relation
INNER JOIN appointment a on appointment_patient_doctor_relation.appointment_id = a.id
INNER JOIN patient p on appointment_patient_doctor_relation.patient_id = p.id
INNER JOIN passport p2 on p.passport_seria = p2.seria and p.passport_number = p2.number
where occurrence_date between current_date - interval '1 month' AND current_date
GROUP BY p.id, p2.f_name, p2.l_name
