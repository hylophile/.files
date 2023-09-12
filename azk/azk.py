#!/usr/bin/env python3

from datetime import date, timedelta, datetime
import csv

# import subprocess
import sys
import os
from pathlib import Path

fields = ["type", "time"]
# today = datetime.now().strftime("%Y-%m-%d")

start = "strt"
stop = "stop"

log_dir = Path.home() / "azk" / "log"


def date_to_file(date: date):
    s = date.strftime("%Y-%m-%d")
    return log_dir / f"{s}.csv"


def write_stamp(date: date):
    file = date_to_file(date)
    if not file.exists():
        file.touch()
        # with open(file, "w") as csvfile:
        #     csv.writer(csvfile).writerow(fields)

    now = datetime.now().strftime("%H:%M:%S")
    with open(file, "a") as csvfile:
        new_state = get_other_state_type(date)
        csv.writer(csvfile).writerow([new_state, now])


def get_state_type(date: date):
    file = date_to_file(date)
    with open(file, "r") as csvfile:
        try:
            final_line = csvfile.readlines()[-1]
            first_word = final_line.split(",")[0]
            if first_word == "type":
                return stop
            else:
                return first_word
        except:
            return stop


def get_other_state_type(date: date):
    state = get_state_type(date)
    if state == start:
        return stop
    else:
        return start


def get_work_time(date: date):
    with open(date_to_file(date), "r") as csvfile:
        reader = csv.DictReader(csvfile, fieldnames=fields)
        rows = list(reader)
        if rows[-1]["type"] == start:
            raise Exception("not stopped yet")

        first_start = datetime.strptime(rows[0]["time"], "%H:%M:%S")
        # last_stop = rows[-1]["time"]
        # print(first_start, last_stop)

        delta_work = timedelta()

        for i, row in enumerate(rows):
            if row["type"] == stop:
                continue
            started_at = datetime.strptime(rows[i]["time"], "%H:%M:%S")
            stopped_at = datetime.strptime(rows[i + 1]["time"], "%H:%M:%S")
            delta = stopped_at - started_at
            delta_work += delta

        return round_to_15(first_start), delta_work


def round_to_15(tm):
    tm += timedelta(minutes=7, seconds=30)
    tm -= timedelta(
        minutes=tm.minute % 15, seconds=tm.second, microseconds=tm.microsecond
    )
    return tm


def get_pauses(dt):
    if dt.hour >= 6 and dt.minute >= 0:
        return timedelta(hours=1)
    if dt.hour >= 9 and dt.minute >= 0:
        return timedelta(hours=2)
    return timedelta()


def get_azk_string(date: datetime):
    rounded_first_start, delta_work = get_work_time(date)

    date_str = date.strftime("%Y-%m-%d")
    print(f"worked for {delta_work} hours on {date_str}.")

    pauses = get_pauses(round_to_15(datetime.min + delta_work))

    start_time = rounded_first_start
    end_time = round_to_15(start_time + delta_work)

    if pauses.total_seconds() > 0:
        end_time += pauses

    azk_string = f"{azk_format(start_time)}\t{azk_format(end_time)}"

    if pauses.total_seconds() > 0:
        azk_string += f"\t\t{azk_format(datetime.min + pauses)}"

    return azk_string


def azk_format(dt: datetime):
    return dt.strftime("%H:%M:%S")


if len(sys.argv) > 1:
    if len(sys.argv) > 2:
        date = datetime.strptime(sys.argv[2], "%Y-%m-%d")
    else:
        date = datetime.now()

    arg = sys.argv[1]
    if arg == "stamp":
        write_stamp(date)
    elif arg == "azk":
        azk_str = get_azk_string(date)
        # os.system(f'echo -e "{azk_str}" | xclip -selection c -i')
        os.system(f'echo -e "{azk_str}" | wl-copy')
        print(f'copied "{azk_str}" to clipboard.')
