from generation import create_doctor, create_appointment_patient_doctor_relation, create_patient


def populate():
    doctors1 = []
    doctors2 = []
    for _ in range(10):
        doctors1.append(create_doctor())
    for _ in range(20):
        doctors2.append(create_doctor())

    for d in doctors1:
        for _ in range(150):
            create_appointment_patient_doctor_relation(doctor=d, start_year=2005)

    for d in doctors2:
        for _ in range(30):
            create_appointment_patient_doctor_relation(doctor=d, start_year=2005)


def main():
    populate()


if __name__ == '__main__':
    populate()
