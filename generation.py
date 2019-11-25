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
        dbname="hospital_management_system",
        user="postgres",
        password="",
        host="localhost",
)


def create_auth() -> Dict[str, str]:
    auth = {
        "login": p.email(),
        "password1": g.random.custom_code(mask="@@####@@##"),
        "name": p.name()
    }

    auth['id'] = db.write("auth", ", ".join(auth.keys()), "'{}', '{}', '{}'".format(*auth.values()))

    return auth


def create_passport() -> Dict[str, Union[str, int, datetime]]:
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
        pk='seria, number'
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


def create_staff(position: Union[str, StaffPositionEnum], auth_id: Optional[int] = None) -> Dict[str, Union[str, datetime, int]]:
    if not auth_id:
        auth_id = create_auth()['id']

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
    )

    return staff


def create_staff_with_random_position():
    return create_staff(g.random.choice(list(StaffPositionEnum)).name)


def create_camera(staff_id: Optional[int] = None) -> Dict[str, Union[str, Tuple[int, int], int]]:
    if not staff_id:
        staff_id = create_staff(StaffPositionEnum.security)['id']

    camera = {
        "name": p.name(),
        "location": (g.random.randint(0, 180), g.random.randint(0, 180)),
        "staff_id": staff_id,
    }

    camera["id"] = db.write(
        "camera",
        ", ".join(camera.keys()),
        "'{}', '{}', {}".format(*camera.values()),
    )

    return camera


def create_complain() -> Dict[str, Union[str, datetime, int]]:
    complain = {
        "theme": t.word(),
        "creation_date": d.date(),
        "complain_text": t.word(),
    }

    complain["id"] = db.write(
        "complain",
        ", ".join(complain.keys()),
        "'{}', '{}', '{}'".format(*complain.values()),
    )

    return complain


def create_notification() -> Dict[str, Union[str]]:
    notification = {
        "notification_text": t.word(),
        "notification_status": g.random.choice(list(NotificationStatusEnum)).name,
    }

    notification["id"] = db.write(
        "notification",
        ", ".join(notification.keys()),
        "'{}', '{}'".format(*notification.values()),
    )

    return notification


def create_doctor(auth_id: Optional[int] = None):
    return create_staff(StaffPositionEnum.doctor, auth_id)


def create_patient():
    auth = create_auth()
    passport = create_passport()

    patient = {
        "auth_id": auth.get('id'),
        "bank_account_id": p.random.custom_code("######"),
        "insurance_policy_id": p.random.custom_code("#####"),
        "passport_seria": passport.get("seria"),
        "passport_number": passport.get("number"),
        "phone_num": p.random.custom_code("+###########"),
    }

    patient['id'] = db.write(
        "patient",
        ", ".join(patient.keys()),
        "{}, {}, {}, {}, {}, '{}'".format(
            *patient.values()
        )
    )
    return patient


def create_ticket():
    creation_date = d.date()
    closing_date = creation_date + timedelta(days=g.random.randint(2, 7))

    ticket = {
        "creation_date": creation_date.isoformat(),
        "closing_date": closing_date.isoformat(),
        "ticket_text": t.sentence(),
    }

    ticket['id'] = db.write(
        "ticket",
        ", ".join(ticket.keys()),
        "'{}', '{}', '{}'".format(*ticket.values())
    )

    return ticket


class TicketStatusEnum(Enum):
    open = auto()
    closed = auto()


def create_staff_ticket_relation():
    ticket = create_ticket()
    staff = create_staff_with_random_position()
    ticket_status = g.random.choice(list(TicketStatusEnum)).name

    relation = {
        "staff_id": staff['id'],
        "ticket_id": ticket['id'],
        "ticket_status": ticket_status
    }
    relation['id'] = db.write(
        "staff_ticket_relation",
        ", ".join(relation.keys()),
        "{}, {}, '{}'".format(*relation.values())
    )
    return relation


def main():
    for _ in range(10):
        create_notification()
    pass


if __name__ == '__main__':
    main()

