from src.utils.generation import (
    create_appointment_patient_doctor_relation,
    create_doctor,
)


def populate(is_print=False):
    doctors = []
    for _ in range(30):
        doctors.append(create_doctor(is_print=is_print))
    for d in doctors:
        for _ in range(100):
            create_appointment_patient_doctor_relation(doctor=d, start_year=2017, is_print=is_print)


def main():
    populate(is_print=True)


if __name__ == "__main__":
    main()
