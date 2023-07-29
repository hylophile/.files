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
    return datetime.strptime(
        datetime.now().strftime("%H:%M"), "%H:%M"
    ) - datetime.strptime(get_stamp(), "%H:%M")


def get_output():
    diff = datetime.min + get_diff()
    minutes = (diff.hour * 60) + diff.minute
    # css_class = "" if minutes < 60 else "warn"
    # return json.dumps({"text": datetime.strftime(diff, "%H:%M"), "class": css_class})
    timestr = datetime.strftime(diff, "%H:%M")
    if minutes < 60:
        return f"  {timestr}  "
    else:
        return "%{T6}%{B#ff5555}%{F#282a36} " + timestr + " "


if len(sys.argv) > 1:
    arg = sys.argv[1]
    if arg == "reset":
        write_stamp()
    elif arg == "diff":
        try:
            print(get_output())
        except:
            write_stamp()
            print(get_output())
