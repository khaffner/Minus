from gpiozero import Button
import time
from datetime import datetime
import os

print("Declaring function")


def log_presence(name):
    # Log which button is pressed, in a way that a script can easily look up which button is currently pressed.
    print(name)  # Just for debuggings sake
    now = datetime.now()
    date = now.strftime("%Y-%m-%d")
    time = now.strftime("%H:%M:%S")
    # where to write button logs. A folder for each day.
    folder = "/logs/presence/{}/".format(date)
    folderexists = os.path.exists(folder)
    if not folderexists:
        os.makedirs(folder)  # If folder does not exist, create it.
    path = "{}/{}.log".format(folder, name)  # Log path
    content = "{} {}".format(date, time)  # What to log. Just the timestamp.
    logfile = open(path, 'a')
    logfile.write(content)
    logfile.write('\n')
    logfile.close()


print("Setting up buttons")
# https://gpiozero.readthedocs.io/en/stable/recipes.html
buttonKevin = Button(17)
buttonHeidi = Button(27)
buttonDennis = Button(22)
buttonJulie = Button(23)

print("Starting loop")
while True:
    if buttonKevin.is_pressed:
        log_presence("Kevin")
    if buttonHeidi.is_pressed:
        log_presence("Heidi")
    if buttonDennis.is_pressed:
        log_presence("Dennis")
    if buttonJulie.is_pressed:
        log_presence("Julie")
    time.sleep(60)
