import csv
import random

# ROOMS and STATES definition
room_list = ["Living_Room", "Kitchen", "Bedroom", "Playroom", "Bathroom"]
device_list = ["Lamp", "AC", "Faucet", "Speaker", "TV"]
device_state = ["ON", "OFF"]

# DEVICES FEATURE definition
lamp_color = ["Green", "Blue", "Violet", "Purple", "Red"]

rowlist = []

for i in range(100):
    start_time = random.randrange(15, 21) if (
        random.randrange(0, 2) == 1) else random.randrange(5, 11)
    end_time = start_time + random.randrange(1, 3)
    no_rooms = random.randrange(1, 5)
    room_names = ""
    for i in range(no_rooms):
        # Generate Random Room
        new_room = room_list[random.randrange(0, 5)]
        # Check if new room already exists
        if (new_room not in room_names):
            room_names += new_room + " "
            no_devices = random.randrange(1, 5)
            device_names = ""
            for i in range(no_devices):
                # Generate Random Device
                new_device = device_list[random.randrange(0, 5)]
                # Check if new device already exists
                if (new_device not in device_names):
                    device_names += new_device + " "
                    device_info = ""
                    state = device_state[random.randrange(0, 2)]
                    device_info += state + " "
                    if (state == "ON"):
                        if (new_device == "Lamp"):
                            # Adds the color and brightness to device info
                            device_info += lamp_color[random.randrange(0, 5)] + " "
                            device_info += str(random.randrange(30, 101)) + "%"
                        elif (new_device == "AC"):
                            # Adds the temperature
                            device_info += str(random.randrange(16, 27)) + "°C"
                        elif (new_device == "Speaker" or new_device == "TV"):
                            # Adds the volume
                            device_info += str(random.randrange(30, 101)) + "%"
                        elif (new_device == "Faucet"):
                            # Adds the amount of water to be dispensed
                            device_info += str(random.randrange(4, 21)) + "oz"
                        device_names += device_info + " "
                    else:
                        device_names += device_info
            # To avoid space at the end
            device_names = device_names.strip()
            # Delimiter to split the columns later
            room_names += device_names + "-"

    # Cleaning room_names string
    room_names = room_names.strip()
    room_names = room_names.split('-')
    room_names.pop()
    
    # Appending table contents
    row = [str(start_time), str(end_time)]
    for i in range(len(room_names)):
        row.append(room_names[i])
    rowlist.append(row)

# Appending table header
header = ["start_time", "end_time"]
for i in range(5):
    header.append("routine_info_"+str(i+1))
rowlist.insert(0, header)


with open('routines.csv', 'w', newline='', encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerows(rowlist)
