from src.utils.database import Database
from faker import Faker
import random

fake = Faker('en_US')
print(fake.past_date())

with Database() as db:
    db.open(dbname='hospital_management_system',
            user='postgres',
            password='',
            host='localhost')

    for _ in range(100):
        db.write('auth',
                 'login, password1, name',
                 "'{}', '{}', '{}'".format(fake.word(),
                                           fake.password(),
                                           fake.word()))

    for _ in range(100):
        db.write('passport',
                 'seria, number, birth, f_name, l_name, gender, address',
                 "{}, {}, '{}', '{}', '{}', '{}', '{}'".format(random.randint(1000, 9999),
                                                             random.randint(100000, 999999),
                                                             fake.past_date(),
                                                             fake.name().split()[0],
                                                             fake.name().split()[1],
                                                             random.choice(['male', 'female']),
                                                             fake.address()))

    for _ in range(100):
        db.write('staff',
                 'name, number, birth, f_name, l_name, gender, address',
                 "{}, {}, '{}', '{}', '{}', '{}', '{}'".format(random.randint(1000, 9999),
                                                             random.randint(100000, 999999),
                                                             fake.past_date(),
                                                             fake.name().split()[0],
                                                             fake.name().split()[1],
                                                             random.choice(['male', 'female']),
                                                             fake.address()))
