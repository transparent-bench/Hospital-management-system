from src.utils.generation import (
    create_appointment_patient_doctor_relation,
    create_patient,
)


def populate(is_print=False):
    patients = []
    for _ in range(10):
        patients.append(create_patient(is_print=is_print))

    for p in patients:
        for _ in range(100):
            create_appointment_patient_doctor_relation(patient=p, start_year=2019, end_year=2019, is_print=is_print)
    return True


def main():
    populate(is_print=True)


if __name__ == "__main__":
    main()
