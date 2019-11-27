from src.scripts.executors.base import BaseExecutor

TIMESLOTS = (('9:00', '10:00'),
             ('10:00', '11:00'),
             ('12:00', '13:00'),
             ('14:00', '15:00'),
             ('16:00', '17:00'))


class Select21Executor(BaseExecutor):
    file_name = '../select_2.sql'

    def fetch(self) -> list:
        results = []
        appointments = {}
        for time_from, time_until in TIMESLOTS:
            data = super().fetch(time_from, time_until)
            for staff_id, n_app in data:
                if staff_id in map(int, appointments.keys()):
                    appointments[str(staff_id)][time_from] = n_app
                else:
                    appointments[str(staff_id)] = {time_from: n_app}

        return appointments

if __name__ == '__main__':
    print(Select21Executor().fetch())
