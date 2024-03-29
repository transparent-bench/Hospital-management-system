from datetime import datetime, timedelta

from src.utils.generation import (
    create_appointment,
    create_appointment_patient_doctor_relation,
    create_patient,
)


def populate(is_print=False):
    patient = create_patient(is_print=is_print)
    base_datetime = datetime.today()
    datetimes_of_appointments = [base_datetime - timedelta(weeks=i) for i in range(0, 4)]
    appointments = []
    appointments.extend(
        [create_appointment(occurrence_date=occ_date, is_print=is_print) for occ_date in datetimes_of_appointments]
    )
    appointments.extend(
        [
            create_appointment(occurrence_date=occ_date + timedelta(hours=-1), is_print=is_print,)
            for occ_date in datetimes_of_appointments
        ]
    )

    for _appointment in appointments:
        create_appointment_patient_doctor_relation(patient=patient, appointment=_appointment, is_print=is_print)
    return True


def main():
    populate()


if __name__ == "__main__":
    main()
