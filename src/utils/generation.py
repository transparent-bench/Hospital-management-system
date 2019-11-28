from datetime import datetime, timedelta
from enum import Enum, auto
from typing import Dict, Optional, Tuple, Union

from mimesis import Datetime, Generic, Person, Text

from src import config
from src.utils.database import Database


p = Person("en")
g = Generic("en")
t = Text("en")
d = Datetime()


db = Database()


def get_text(length: int = 25) -> str:
    return t.text(length).replace("'", "")[:length]


def get_name() -> str:
    return p.name().replace("'", "")


def get_surname() -> str:
    return p.surname().replace("'", "")


def get_datetime(start_hour: int = 9, end_hour: int = 17, start_year: int = 2000, end_year: int = 2020,) -> datetime:
    while True:
        new_datetime = d.datetime(start=start_year, end=end_year)
        if start_hour < new_datetime.hour < end_hour:
            return new_datetime


def get_login_auth():
    all_known_logins = db.query("SELECT login from auth;")
    import operator

    all_known_logins = set(map(operator.itemgetter(0), all_known_logins))
    new_login = p.email()
    while new_login in all_known_logins:
        new_login = p.email()
    return new_login


def create_auth(is_print: bool = False) -> Dict[str, str]:
    auth = {
        "login": get_login_auth(),
        "password1": g.random.custom_code(mask="@@####@@##"),
        "name": get_name(),
    }

    auth["id"] = db.write("auth", ", ".join(auth.keys()), "'{}', '{}', '{}'".format(*auth.values()), is_print=is_print)

    return auth


def create_passport(is_print: bool = False,) -> Dict[str, Union[str, int, datetime]]:
    passport = {
        "seria": g.random.custom_code(mask="####"),
        "number": g.random.custom_code(mask="######"),
        "birth": d.date(start=1950),
        "f_name": get_name(),
        "l_name": get_surname(),
        "gender": p.random.choice(["male", "female"]),
        "address": p.occupation(),
    }
    db.write(
        "passport",
        ", ".join(passport.keys()),
        "{}, {}, '{}', '{}', '{}', '{}', '{}'".format(*passport.values()),
        pk="seria, number",
        is_print=is_print,
    )

    return passport


class StaffPositionEnum(Enum):
    doctor = auto()
    administrator = auto()
    nurse = auto()
    security = auto()
    IT_administrator = auto()


class NotificationStatusEnum(Enum):
    open = auto()
    closed = auto()


def create_staff(
    position: Union[str, StaffPositionEnum], auth_id: Optional[int] = None, is_print: bool = False,
) -> Dict[str, Union[str, datetime, int]]:
    if not auth_id:
        auth_id = create_auth(is_print=is_print)["id"]

    if isinstance(position, StaffPositionEnum):
        position = position.name

    # todo: make return id as in create_auth
    gender = g.random.choice(["male", "female"])

    staff = {
        "first_name": get_name(),
        "last_name": get_surname(),
        "room": g.random.randint(1, 100),
        "auth_id": auth_id,
        "birthday": d.date(start=1950),
        "position": position,
        "gender": gender,
    }

    staff["id"] = db.write(
        "staff",
        ", ".join(staff.keys()),
        "'{}', '{}', {}, {}, '{}', '{}', '{}'".format(*staff.values()),
        is_print=is_print,
    )

    return staff


def create_staff_with_random_position(is_print: bool = False) -> dict:
    return create_staff(g.random.choice(list(StaffPositionEnum)).name, is_print=is_print)


def create_camera(
    staff_id: Optional[int] = None, is_print: bool = False
) -> Dict[str, Union[str, Tuple[int, int], int]]:
    if not staff_id:
        staff_id = create_staff(StaffPositionEnum.security, is_print=is_print)["id"]

    camera = {
        "name": get_name(),
        "location": (g.random.randint(0, 180), g.random.randint(0, 180)),
        "staff_id": staff_id,
    }

    camera["id"] = db.write(
        "camera", ", ".join(camera.keys()), "'{}', '{}', {}".format(*camera.values()), is_print=is_print,
    )

    return camera


def create_complain(is_print: bool = False,) -> Dict[str, Union[str, datetime, int]]:
    complain = {
        "theme": get_text(),
        "creation_date": get_datetime(),
        "complain_text": get_text(),
    }

    complain["id"] = db.write(
        "complain", ", ".join(complain.keys()), "'{}', '{}', '{}'".format(*complain.values()), is_print=is_print,
    )

    return complain


def create_notification(is_print: bool = False) -> Dict[str, str]:
    notification = {
        "notification_text": get_text(),
        "notification_status": g.random.choice(list(NotificationStatusEnum)).name,
    }

    notification["id"] = db.write(
        "notification", ", ".join(notification.keys()), "'{}', '{}'".format(*notification.values()), is_print=is_print,
    )

    return notification


def create_doctor(auth_id: Optional[int] = None, is_print: bool = False) -> dict:
    return create_staff(StaffPositionEnum.doctor, auth_id, is_print=is_print)


def create_nurse(auth_id: Optional[int] = None, is_print: bool = False) -> dict:
    return create_staff(StaffPositionEnum.nurse, auth_id, is_print=is_print)


def create_patient(is_print: bool = False) -> dict:
    auth = create_auth(is_print=is_print)
    passport = create_passport(is_print=is_print)

    patient = {
        "auth_id": auth.get("id"),
        "bank_account_id": p.random.custom_code("######"),
        "insurance_policy_id": p.random.custom_code("#####"),
        "passport_seria": passport.get("seria"),
        "passport_number": passport.get("number"),
        "phone_num": p.random.custom_code("+###########"),
    }

    patient["id"] = db.write(
        "patient", ", ".join(patient.keys()), "{}, {}, {}, {}, {}, '{}'".format(*patient.values()), is_print=is_print,
    )
    return patient


def create_ticket(is_print: bool = False) -> dict:
    creation_date = get_datetime()
    closing_date = creation_date + timedelta(days=g.random.randint(2, 7))

    ticket = {
        "creation_date": creation_date.isoformat(),
        "closing_date": closing_date.isoformat(),
        "ticket_text": get_text(),
    }

    ticket["id"] = db.write(
        "ticket", ", ".join(ticket.keys()), "'{}', '{}', '{}'".format(*ticket.values()), is_print=is_print,
    )

    return ticket


def create_invoice(is_print: bool = False) -> dict:
    invoice = {
        "amount": g.random.randint(0, 100000),
        "date_of_creation": get_datetime(),
        "reason": get_text(),
    }

    invoice["id"] = db.write(
        "invoice", ", ".join(invoice.keys()), "'{}', '{}', '{}'".format(*invoice.values()), is_print=is_print,
    )

    return invoice


def create_appointment(
    start_year: int = 2000, end_year: int = 2020, occurrence_date=None, is_print: bool = False,
) -> dict:
    if not occurrence_date:
        occurrence_date = get_datetime(start_year=start_year, end_year=end_year)

    appointment = {
        "occurrence_date": occurrence_date,
        "diagnosis": get_text(10),
        "description": get_text(),
        "reason_to_create": get_text(10),
    }

    appointment["id"] = db.write(
        "appointment",
        ", ".join(appointment.keys()),
        "'{}', '{}', '{}', '{}'".format(*appointment.values()),
        is_print=is_print,
    )

    return appointment


class TicketStatusEnum(Enum):
    open = auto()
    closed = auto()


def create_staff_ticket_relation(is_print: bool = False) -> dict:
    ticket = create_ticket(is_print=is_print)
    staff = create_staff_with_random_position(is_print=is_print)
    ticket_status = g.random.choice(list(TicketStatusEnum)).name

    relation = {
        "staff_id": staff["id"],
        "ticket_id": ticket["id"],
        "ticket_status": ticket_status,
    }
    relation["id"] = db.write(
        "staff_ticket_relation",
        ", ".join(relation.keys()),
        "{}, {}, '{}'".format(*relation.values()),
        is_print=is_print,
    )
    return relation


def create_patient_ticket_relation(is_print: bool = False) -> dict:
    patient = create_patient(is_print=is_print)
    ticket = create_ticket(is_print=is_print)
    relation = {"patient_id": patient["id"], "ticket_id": ticket["id"]}
    relation["id"] = db.write(
        "patient_ticket_relation", ", ".join(relation.keys()), "{}, {}".format(*relation.values()), is_print=is_print,
    )

    return relation


def create_patient_complain_relation(is_print: bool = False) -> dict:
    patient = create_patient(is_print=is_print)
    complain = create_complain(is_print=is_print)
    relation = {"patient_id": patient["id"], "complain_id": complain["id"]}
    relation["id"] = db.write(
        "patient_complain_relation", ", ".join(relation.keys()), "{}, {}".format(*relation.values()), is_print=is_print,
    )

    return relation


def create_appointment_patient_doctor_relation(
    patient: dict = None,
    doctor: dict = None,
    appointment: dict = None,
    start_year: int = 2000,
    end_year: int = 2020,
    is_print: bool = False,
) -> dict:
    if patient is None:
        patient = create_patient(is_print=is_print)
    if doctor is None:
        doctor = create_doctor(is_print=is_print)
    if appointment is None:
        appointment = create_appointment(start_year=start_year, end_year=end_year, is_print=is_print)

    relation = {
        "appointment_id": appointment["id"],
        "patient_id": patient["id"],
        "doctor_id": doctor["id"],
    }

    relation["id"] = db.write(
        "appointment_patient_doctor_relation",
        ", ".join(relation.keys()),
        "{}, {}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_doctor_nurse_relation(is_print: bool = False) -> dict:
    doctor = create_doctor(is_print=is_print)
    nurse = create_nurse(is_print=is_print)
    relation = {"doctor_id": doctor["id"], "nurse_id": nurse["id"]}
    relation["id"] = db.write(
        "doctor_nurse_relation", ", ".join(relation.keys()), "{}, {}".format(*relation.values()), is_print=is_print,
    )

    return relation


def create_notification_patient_relation(is_print: bool = False) -> dict:
    notification = create_notification(is_print=is_print)
    patient = create_patient(is_print=is_print)
    relation = {
        "notification_id": notification["id"],
        "patient_id": patient["id"],
    }
    relation["id"] = db.write(
        "notification_patient_relation",
        ", ".join(relation.keys()),
        "{}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_notification_staff_relation(is_print: bool = False) -> dict:
    notification = create_notification(is_print=is_print)
    staff = create_staff_with_random_position(is_print=is_print)
    relation = {"notification_id": notification["id"], "staff_id": staff["id"]}
    relation["id"] = db.write(
        "notification_staff_relation",
        ", ".join(relation.keys()),
        "{}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_patient_invoice_staff_relation(is_print: bool = False) -> dict:
    patient = create_patient(is_print=is_print)
    invoice = create_invoice(is_print=is_print)
    administrator = create_staff(StaffPositionEnum.administrator, is_print=is_print)

    relation = {
        "staff_id": administrator["id"],
        "patient_id": patient["id"],
        "invoice_id": invoice["id"],
    }

    relation["id"] = db.write(
        "patient_invoice_staff_relation",
        ", ".join(relation.keys()),
        "{}, {}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_population(is_print: bool = True):
    import src.scripts.test_data.select_1 as select_1
    import src.scripts.test_data.select_2 as select_2
    import src.scripts.test_data.select_3 as select_3
    import src.scripts.test_data.select_4 as select_4
    import src.scripts.test_data.select_5 as select_5
    # for _ in range(70):
    #     create_auth(is_print=is_print)
    # for _ in range(10):
    #     create_doctor(is_print=is_print)
    #     create_nurse(is_print=is_print)
    #     create_staff_with_random_position(is_print=is_print)
    #     create_invoice(is_print=is_print)
    #     create_complain(is_print=is_print)
    #     create_camera(is_print=is_print)
    # for _ in range(40):
    #     create_passport(is_print=is_print)
    #     create_patient(is_print=is_print)
    #     create_invoice(is_print=is_print)
    # for _ in range(30):
    #     create_notification(is_print=is_print)
    #     create_ticket(is_print=is_print)
    # for _ in range(50):
    #     create_appointment(is_print=is_print)
    #     create_appointment_patient_doctor_relation(is_print=is_print)
    # for _ in range(10):
    #     create_doctor_nurse_relation(is_print=is_print)
    #     create_notification_patient_relation(is_print=is_print)
    #     create_patient_complain_relation(is_print=is_print)
    #     create_patient_invoice_staff_relation(is_print=is_print)
    #     create_patient_ticket_relation(is_print=is_print)
    # for _ in range(20):
    #     create_notification_staff_relation(is_print=is_print)
    #     create_staff_ticket_relation(is_print=is_print)
    db._check_if_opened()

    select_1.populate()
    select_2.populate()
    select_3.populate()
    select_4.populate()
    select_5.populate()


def main():
    create_population()


if __name__ == "__main__":
    main()
