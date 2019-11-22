from src.utils.database import Database
from mimesis import Generic
from mimesis import Person
from mimesis import Datetime

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

with Database() as db:
    db.open(dbname='hospital_management_system',
            user='postgres',
            password='',
            host='localhost')



    for _ in range(100):
        db.write('auth',
                 'login, password1, name',
                 "'{}', '{}', '{}'".format(p.email(),
                                           g.random.custom_code(mask='@@####@@##'),
                                           p.name()))

    for _ in range(100):
        db.write('passport',
                 'seria, number, birth, f_name, l_name, gender, address',
                 "{}, {}, '{}', '{}', '{}', '{}', '{}'".format(g.random.custom_code(mask='####'),
                                                             g.random.custom_code(mask='######'),
                                                             d.date(start=1900),
                                                             p.name(),
                                                             p.surname(),
                                                             p.random.choice(['male', 'female']),
                                                             p.occupation()))

    auth_ids = [auth_id for auth_id, in db.get('auth', 'id')]
    for _ in range(100):
        auth_id = g.random.choice(auth_ids)
        auth_ids.remove(auth_id)
        position = g.random.choice(['doctor', 'administrator', 'nurse', 'security', 'IT-administrator'])
        gender = g.random.choice(['male', 'female'])

        db.write('staff',
                 'first_name, last_name, room, auth_id, birthday, position, gender',
                 "'{}', '{}', {}, {}, '{}', '{}', '{}'".format(p.name(),
                                                     p.surname(),
                                                     g.random.randint(1, 100),
                                                     auth_id,
                                                     d.date(start=1900),
                                                     position,
                                                     gender))

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