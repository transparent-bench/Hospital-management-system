from datetime import datetime
from enum import Enum, auto
from typing import Dict, Union, Optional, Tuple


from mimesis import Datetime, Generic, Person

from src.utils.database import Database

p = Person("en")
g = Generic("en")
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
        "birth": d.date(start=1900),
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
        "birthday": d.date(start=1900),
        "position": position,
        "gender": gender,
    }

    staff["id"] = db.write(
        "staff",
        ", ".join(staff.keys()),
        "'{}', '{}', {}, {}, '{}', '{}', '{}'".format(*staff.values()),
    )

    return staff


def create_camera(staff_id: Optional[int] = None) -> Dict[str, Union[str, Tuple[int, int], int]]:
    if not staff_id:
        staff_id = create_staff(StaffPositionEnum.security)['id']

    camera = {
        "name": p.name(),
        "location": (g.random.randint(0, 180), g.random.randint(0, 180)),
        "staff_id": staff_id,
    }

    db.write(
        "camera",
        ", ".join(camera.keys()),
        "'{}', '{}', {}".format(*camera.values()),
    )

    return camera


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



def main():
    pass


if __name__ == '__main__':
    main()

