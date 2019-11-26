from generation import create_patient, create_appointment_patient_doctor_relation


def populate():
    patients = []
    for _ in range(15):
        patients.append(create_patient())
    for p in patients:
        for _ in range(100):
            create_appointment_patient_doctor_relation(patient=p, start_year=2019, end_year=2019)


def main():
    populate()


if __name__ == '__main__':
    populate()
