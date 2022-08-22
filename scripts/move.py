#!/usr/bin/env python3

from datetime import date, timedelta, datetime
import csv
import subprocess
import sys
from pathlib import Path
import json
stamp = Path.home() / "scripts" / "stamp"


def write_stamp():
    now = datetime.now().strftime("%H:%M")
    with open(stamp, "w") as file:
        file.write(now)


def get_stamp():
    with open(stamp, "r") as file:
        return file.read().strip()


def get_diff():
   return datetime.strptime(datetime.now().strftime("%H:%M"),"%H:%M")  - datetime.strptime(get_stamp(), "%H:%M")

def get_output():
    diff = datetime.min + get_diff()
    minutes = (diff.hour * 60) + diff.minute
    css_class = "" if minutes < 60 else "warn"
    return json.dumps({'text': datetime.strftime(diff,"%H:%M"), 'class': css_class})
# def get_work_time(date=today):
#     with open(date_to_file(date), "r") as csvfile:
#         reader = csv.DictReader(csvfile, fieldnames=fields)
#         rows = list(reader)[1:]
#         if rows[-1]["type"] == start:
#             raise Exception("not stopped yet")

#         first_start = datetime.strptime(rows[0]["time"], "%H:%M:%S")
#         # last_stop = rows[-1]["time"]
#         # print(first_start, last_stop)

#         delta_work = timedelta()

#         for i, row in enumerate(rows):
#             if row["type"] == stop:
#                 continue
#             started_at = datetime.strptime(rows[i]["time"], "%H:%M:%S")
#             stopped_at = datetime.strptime(rows[i + 1]["time"], "%H:%M:%S")
#             delta = stopped_at - started_at
#             delta_work += delta

#         return round_to_15(first_start), delta_work


# def date_to_file(str):
#     return log_dir / f"{str}.csv"


# def round_to_15(tm):
#     tm += timedelta(minutes=7, seconds=30)
#     tm -= timedelta(
#         minutes=tm.minute % 15, seconds=tm.second, microseconds=tm.microsecond
#     )
#     return tm


# def get_pauses(dt):
#     if dt.hour >= 6 and dt.minute >= 0:
#         return timedelta(hours=1)
#     if dt.hour >= 9 and dt.minute >= 0:
#         return timedelta(hours=2)
#     return timedelta()


# def get_azk_string(date=today):
#     rounded_first_start, delta_work = get_work_time(date)

#     print(f"worked for {delta_work} hours today.")

#     pauses = get_pauses(round_to_15(datetime.min + delta_work))

#     start_time = rounded_first_start
#     end_time = round_to_15(start_time + delta_work)

#     if pauses.total_seconds() > 0:
#         end_time += pauses

#     azk_string = f"{azk_format(start_time)}\t{azk_format(end_time)}"

#     if pauses.total_seconds() > 0:
#         azk_string += f"\t\t{azk_format(datetime.min + pauses)}"

#     return azk_string


# def azk_format(dt: datetime):
#     return dt.strftime("%H:%M:%S")


if len(sys.argv) > 1:
    arg = sys.argv[1]
    if arg == "reset":
        write_stamp()
    elif arg == "diff":
        print(get_output())
