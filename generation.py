from datetime import datetime, timedelta
from enum import Enum, auto
from typing import Dict, Union, Optional, Tuple

from mimesis import Datetime, Generic, Person, Text

from src.utils.database import Database

p = Person("en")
g = Generic("en")
t = Text("en")
d = Datetime()

db = Database()
db.open(
    dbname="hospital_management_system", user="postgres", password="", host="localhost",
)


def get_text(length: int = 25) -> str:
    return t.text(length).replace("'", "")[:length]


def create_auth(is_print: bool = False) -> Dict[str, str]:
    auth = {
        "login": p.email(),
        "password1": g.random.custom_code(mask="@@####@@##"),
        "name": p.name(),
    }

    auth["id"] = db.write(
        "auth",
        ", ".join(auth.keys()),
        "'{}', '{}', '{}'".format(*auth.values()),
        is_print=is_print,
    )

    return auth


def create_passport(is_print: bool = False) -> Dict[str, Union[str, int, datetime]]:
    passport = {
        "seria": g.random.custom_code(mask="####"),
        "number": g.random.custom_code(mask="######"),
        "birth": d.date(start=1950),
        "f_name": p.name(),
        "l_name": p.surname(),
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
    position: Union[str, StaffPositionEnum],
    auth_id: Optional[int] = None,
    is_print: bool = False,
) -> Dict[str, Union[str, datetime, int]]:
    if not auth_id:
        auth_id = create_auth()["id"]

    if isinstance(position, StaffPositionEnum):
        position = position.name

    # todo: make return id as in create_auth
    gender = g.random.choice(["male", "female"])

    staff = {
        "first_name": p.name(),
        "last_name": p.surname(),
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


def create_staff_with_random_position() -> dict:
    return create_staff(g.random.choice(list(StaffPositionEnum)).name)


def create_camera(
    staff_id: Optional[int] = None, is_print: bool = False
) -> Dict[str, Union[str, Tuple[int, int], int]]:
    if not staff_id:
        staff_id = create_staff(StaffPositionEnum.security)["id"]

    camera = {
        "name": p.name(),
        "location": (g.random.randint(0, 180), g.random.randint(0, 180)),
        "staff_id": staff_id,
    }

    camera["id"] = db.write(
        "camera",
        ", ".join(camera.keys()),
        "'{}', '{}', {}".format(*camera.values()),
        is_print=is_print,
    )

    return camera


def create_complain(is_print: bool = False) -> Dict[str, Union[str, datetime, int]]:
    complain = {
        "theme": get_text(),
        "creation_date": d.date(),
        "complain_text": get_text(),
    }

    complain["id"] = db.write(
        "complain",
        ", ".join(complain.keys()),
        "'{}', '{}', '{}'".format(*complain.values()),
        is_print=is_print,
    )

    return complain


def create_notification(is_print: bool = False) -> Dict[str, str]:
    notification = {
        "notification_text": get_text(),
        "notification_status": g.random.choice(list(NotificationStatusEnum)).name,
    }

    notification["id"] = db.write(
        "notification",
        ", ".join(notification.keys()),
        "'{}', '{}'".format(*notification.values()),
        is_print=is_print,
    )

    return notification


def create_doctor(auth_id: Optional[int] = None) -> dict:
    return create_staff(StaffPositionEnum.doctor, auth_id)


def create_nurse(auth_id: Optional[int] = None) -> dict:
    return create_staff(StaffPositionEnum.nurse, auth_id)


def create_patient(is_print: bool = False) -> dict:
    auth = create_auth()
    passport = create_passport()

    patient = {
        "auth_id": auth.get("id"),
        "bank_account_id": p.random.custom_code("######"),
        "insurance_policy_id": p.random.custom_code("#####"),
        "passport_seria": passport.get("seria"),
        "passport_number": passport.get("number"),
        "phone_num": p.random.custom_code("+###########"),
    }

    patient["id"] = db.write(
        "patient",
        ", ".join(patient.keys()),
        "{}, {}, {}, {}, {}, '{}'".format(*patient.values()),
        is_print=is_print,
    )
    return patient


def create_ticket(is_print: bool = False) -> dict:
    creation_date = d.date()
    closing_date = creation_date + timedelta(days=g.random.randint(2, 7))

    ticket = {
        "creation_date": creation_date.isoformat(),
        "closing_date": closing_date.isoformat(),
        "ticket_text": get_text(),
    }

    ticket["id"] = db.write(
        "ticket",
        ", ".join(ticket.keys()),
        "'{}', '{}', '{}'".format(*ticket.values()),
        is_print=is_print,
    )

    return ticket


def create_invoice(is_print: bool = False) -> dict:
    invoice = {
        "amount": g.random.randint(0, 100000),
        "date_of_creation": d.date(),
        "reason": get_text(),
    }

    invoice["id"] = db.write(
        "invoice",
        ", ".join(invoice.keys()),
        "'{}', '{}', '{}'".format(*invoice.values()),
        is_print=is_print,
    )

    return invoice


def create_appointment(is_print: bool = False) -> dict:
    appointment = {
        "occurrence_date": d.date(),
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
    ticket = create_ticket()
    staff = create_staff_with_random_position()
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
    patient = create_patient()
    ticket = create_ticket()
    relation = {"patient_id": patient["id"], "ticket_id": ticket["id"]}
    relation["id"] = db.write(
        "patient_ticket_relation",
        ", ".join(relation.keys()),
        "{}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_patient_complain_relation(is_print: bool = False) -> dict:
    patient = create_patient()
    complain = create_complain()
    relation = {"patient_id": patient["id"], "complain_id": complain["id"]}
    relation["id"] = db.write(
        "patient_complain_relation",
        ", ".join(relation.keys()),
        "{}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_appointment_patient_doctor_relation(is_print: bool = False) -> dict:
    patient = create_patient()
    doctor = create_doctor()
    appointment = create_appointment()

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
    doctor = create_doctor()
    nurse = create_nurse()
    relation = {"doctor_id": doctor["id"], "nurse_id": nurse["id"]}
    relation["id"] = db.write(
        "doctor_nurse_relation",
        ", ".join(relation.keys()),
        "{}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_notification_patient_relation(is_print: bool = False) -> dict:
    notification = create_notification()
    patient = create_patient()
    relation = {"notification_id": notification["id"], "patient_id": patient["id"]}
    relation["id"] = db.write(
        "notification_patient_relation",
        ", ".join(relation.keys()),
        "{}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_notification_staff_relation(is_print: bool = False) -> dict:
    notification = create_notification()
    staff = create_staff_with_random_position()
    relation = {"notification_id": notification["id"], "staff_id": staff["id"]}
    relation["id"] = db.write(
        "notification_staff_relation",
        ", ".join(relation.keys()),
        "{}, {}".format(*relation.values()),
        is_print=is_print,
    )

    return relation


def create_patient_invoice_staff_relation(is_print: bool = False) -> dict:
    patient = create_patient()
    invoice = create_invoice()
    administrator = create_staff(StaffPositionEnum.administrator)

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


def main():
    for _ in range(10):
        create_invoice()
    pass


if __name__ == "__main__":
    main()
