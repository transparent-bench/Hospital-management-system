from pathlib import Path

from src.scripts.executors.base import BaseExecutor

TIMESLOTS = (('10:00', '11:00'),
             ('11:00', '12:00'),
             ('12:00', '13:00'),
             ('13:00', '14:00'),
             ('14:00', '15:00'),
             ('15:00', '16:00'),
             ('16:00', '17:00'))


class Select2Executor(BaseExecutor):
    file_name = Path(__file__).parent.parent / "select_2.sql"

    index = '2'

    def fetch(self, *options, **kwargs) -> list:
        results = []
        appointments = {}
        for time_from, time_until in TIMESLOTS:
            data = super().fetch(time_from, time_until, *options, **kwargs)
            for staff_id, n_app in data:
                if staff_id in map(int, appointments.keys()):
                    appointments[str(staff_id)][time_from] = n_app
                else:
                    appointments[str(staff_id)] = {time_from: n_app}

        for doctor_id, app_data in appointments.items():
            data_for_current_doctor = [int(doctor_id), ]
            import operator
            timeslot_starts = list(map(operator.itemgetter(0), TIMESLOTS))
            for start in timeslot_starts:
                # add total number of appointments
                data_for_current_doctor.append(app_data.get(start, 0))
            for start in timeslot_starts:
                # add average number of appointments
                data_for_current_doctor.append(app_data.get(start, 0) / 50)

            results.append(tuple(data_for_current_doctor))

        return results


if __name__ == '__main__':
    print(Select2Executor().fetch())
