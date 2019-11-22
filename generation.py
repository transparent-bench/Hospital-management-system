from datetime import datetime
from typing import Dict, Union

from mimesis import Datetime, Generic, Person

from src.utils.database import Database

p = Person('en')
g = Generic('en')
d = Datetime()

print(g.random.custom_code(mask='####'))
print(g.random.custom_code(mask='######'))
print(p.name())
print(p.last_name())
print(p.password(length=10))
print(p.email())
print(d.date(start=1900))


def create_auth() -> Dict[str, str]:
    login, password1, name = p.email(), g.random.custom_code(mask='@@####@@##'), p.name()
    db.write('auth',
             'login, password1, name',
             "'{}', '{}', '{}'".format(login, password1, name))

    return {
        "login": login, "password1": password1, "name": name
    }


def create_passport() -> Dict[str, Union[str, int, datetime]]:
    passport = {
        "seria": g.random.custom_code(mask='####'),
        "number": g.random.custom_code(mask='######'),
        "birth": d.date(start=1900),
        "f_name": p.name(),
        "l_name": p.surname(),
        "gender": p.random.choice(['male', 'female']),
        "address": p.occupation(),
    }
    db.write('passport',
             'seria, number, birth, f_name, l_name, gender, address',
             "{}, {}, '{}', '{}', '{}', '{}', '{}'".format(*passport.values()))

    return passport


def create_staff(auth_id, position, gender):
    keys = ('first_name', 'last_name', 'room', 'auth_id', 'birthday', 'position', 'gender')
    values = (p.name(),
              p.surname(),
               g.random.randint(1, 100),
               auth_id,
               d.date(start=1900),
               position,
               gender)

    db.write('staff',
             'first_name, last_name, room, auth_id, birthday, position, gender',
             "'{}', '{}', {}, {}, '{}', '{}', '{}'".format(*values))

    return dict(zip(keys, values))

with Database() as db:
    db.open(dbname='hospital_management_system',
            user='postgres',
            password='',
            host='localhost')

    for _ in range(100):
        create_auth()

    for _ in range(100):
        create_passport()

    auth_ids = [auth_id for auth_id, in db.get('auth', 'id')]
    for _ in range(100):
        auth_id = g.random.choice(auth_ids)
        auth_ids.remove(auth_id)
        position = g.random.choice(['doctor', 'administrator', 'nurse', 'security', 'IT-administrator'])
        gender = g.random.choice(['male', 'female'])
        create_staff(auth_id, position, gender)


    query = "select id from staff s where s.position = 'security'"
    staff_ids = [staff_id for staff_id, in db.query(query)]
    for _ in range(100):
        staff_id = g.random.choice(staff_ids)
        staff_ids.remove(staff_id)
        db.write('camera',
                 'name, location, staff_id',
                 "'{}', '{}', {}".format(p.name(),
                                         (g.random.randint(0, 180), g.random.randint(0, 180)),
                                         staff_id))
