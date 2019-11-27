select * from staff
inner join (
    select distinct doctor_id
    from appointment_patient_doctor_relation apdr1
    inner join (
        select id
        from appointment app
        where occurrence_date IN (
            select occurrence_date
            from appointment
                     left join patient p
                               on p.phone_num = '1234556'
                     left join appointment_patient_doctor_relation apdr2
                               on appointment.id = apdr2.appointment_id and
                                  apdr2.patient_id = p.id
            order by occurrence_date DESC
            limit 1
        )
    ) appointments on apdr1.appointment_id = appointments.id
) doctor_ids on doctor_ids.doctor_id = staff.id
where staff.position = 'doctor' and (
    staff.first_name similar to '(M|L)%' and not staff.last_name similar to '(M|L)%'
    or
    not staff.first_name similar to '(M|L)%' and staff.last_name similar to '(M|L)%'
)

