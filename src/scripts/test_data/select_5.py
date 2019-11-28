from src.utils.generation import (
    create_appointment_patient_doctor_relation,
    create_doctor,
)


def populate(is_print=False):
    doctors1 = []
    for _ in range(10):
        doctors1.append(create_doctor(is_print=is_print))

    for d in doctors1:
        for _ in range(300):
            create_appointment_patient_doctor_relation(doctor=d, start_year=2009, is_print=is_print)


def main():
    populate()


if __name__ == "__main__":
    populate()
