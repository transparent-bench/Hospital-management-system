from datetime import datetime
from typing import Dict, Union, Optional

from mimesis import Datetime, Generic, Person

from src.utils.database import Database

p = Person("en")
g = Generic("en")
d = Datetime()

print(g.random.custom_code(mask="####"))
print(g.random.custom_code(mask="######"))
print(p.name())
print(p.last_name())
print(p.password(length=10))
print(p.email())
print(d.date(start=1900))

db = Database()
db.open(
        dbname="hospital_management_system",
        user="postgres",
        password="",
        host="localhost",
    )


def create_auth() -> Dict[str, str]:
    keys = "login", "password1", "name"
    values = (
        p.email(),
        g.random.custom_code(mask="@@####@@##"),
        p.name(),
    )
    auth = dict(zip(keys, values))
    auth['id'] = db.write("auth", "login, password1, name", "'{}', '{}', '{}'".format(*values), is_print=True)

    return auth


def create_passport() -> Dict[str, Union[str, int, datetime]]:
    # todo: make return id as in create_auth
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
        "seria, number, birth, f_name, l_name, gender, address",
        "{}, {}, '{}', '{}', '{}', '{}', '{}'".format(*passport.values()),
    )

    return passport


def create_staff(auth_id, position) -> Dict[str, Union[str, datetime, int]]:
    # todo: make return id as in create_auth
    gender = g.random.choice(["male", "female"])

    keys = (
        "first_name",
        "last_name",
        "room",
        "auth_id",
        "birthday",
        "position",
        "gender",
    )
    values = (
        p.name(),
        p.surname(),
        g.random.randint(1, 100),
        auth_id,
        d.date(start=1900),
        position,
        gender,
    )

    db.write(
        "staff",
        "first_name, last_name, room, auth_id, birthday, position, gender",
        "'{}', '{}', {}, {}, '{}', '{}', '{}'".format(*values),
    )

    return dict(zip(keys, values))


def create_doctor(auth_id: Optional[int] = None):
    if not auth_id:
        auth_id = create_auth().get('id')

    return create_staff(auth_id, "doctor")


def create_patient():
    auth_id = create_auth().get('id')
    passport = create_passport()
    db.write(
        "patient",
        "auth_id, passport_seria", "passport_number",
        "{}, {}, {}".format(
            auth_id, passport['seria'], passport['number']
        )
    )

def main():
    for _ in range(100):
        create_auth()

    for _ in range(100):
        create_passport()

    auth_ids = [auth_id for auth_id, in db.get("auth", "id")]
    for _ in range(100):
        auth_id = g.random.choice(auth_ids)
        auth_ids.remove(auth_id)
        position = g.random.choice(
            ["doctor", "administrator", "nurse", "security", "IT-administrator"]
        )
        create_staff(auth_id, position)

    query = "select id from staff s where s.position = 'security'"
    staff_ids = [staff_id for staff_id, in db.query(query)]
    for _ in range(100):
        staff_id = g.random.choice(staff_ids)
        staff_ids.remove(staff_id)
        db.write(
            "camera",
            "name, location, staff_id",
            "'{}', '{}', {}".format(
                p.name(), (g.random.randint(0, 180), g.random.randint(0, 180)), staff_id
            ),
        )


if __name__ == '__main__':
    main()

