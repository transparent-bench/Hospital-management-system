from generation import create_doctor, create_appointment_patient_doctor_relation


def populate():
    doctors = []
    for _ in range(30):
        doctors.append(create_doctor())
    for d in doctors:
        for _ in range(100):
            create_appointment_patient_doctor_relation(doctor=d, start_year=2017)


def main():
    populate()


if __name__ == '__main__':
    populate()
