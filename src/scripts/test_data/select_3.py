from generation import create_patient, create_appointment_patient_doctor_relation, create_appointment
from datetime import datetime, timedelta


def populate_positive_testing():
    is_print = True
    patient = create_patient(is_print=is_print)
    base_datetime = datetime.today()
    datetimes_of_appointments = [base_datetime - timedelta(weeks=i) for i in range(0, 4)]
    appointments = []
    appointments.extend([create_appointment(occurence_date=occ_date, is_print=is_print) for occ_date in datetimes_of_appointments])
    appointments.extend([create_appointment(occurence_date=occ_date + timedelta(hours=-1), is_print=is_print) for occ_date in datetimes_of_appointments])

    for _appointment in appointments:
        create_appointment_patient_doctor_relation(patient=patient,
                                                   appointment=_appointment,
                                                   is_print=is_print)


def main():
    populate_positive_testing()


if __name__ == '__main__':
    main()
