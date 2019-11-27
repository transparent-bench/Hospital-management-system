from src.utils.generation import create_patient, create_appointment, create_appointment_patient_doctor_relation, get_datetime


def populate():
    is_print = True
    patient = create_patient(is_print=is_print)

    some_date = get_datetime(start_year=2019)
    some_date.replace(month=11, day=27)

    for _ in range(10):
        create_appointment_patient_doctor_relation(patient=patient,
                                                   appointment=create_appointment(occurrence_date=some_date),
                                                   start_year=2018, is_print=is_print)

    print(f"Patient={patient}")


if __name__ == '__main__':
    populate()
