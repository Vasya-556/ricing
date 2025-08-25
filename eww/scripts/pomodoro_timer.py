import time
import os
import subprocess

IS_WORKING_TIME = False

def get_time():
    try:
        result = []
        with open("time.txt") as f:
            x = f.read().split('\n')
            result = x
        return result
    except:
        exit()

def open_file(file_name: str, default_value: str):
    try:
        with open(file_name) as f:
            x = f.read()
            return x
    except:
        return default_value

def get_time2():
    work_time = open_file("work_time.txt", "25:00")
    relax_time = open_file("relax_time.txt", "25:00")
    loop_count = open_file("loop.txt", "3")
    return work_time, relax_time, loop_count

def display(tm: int):
    minutes = tm // 60
    seconds = tm % 60
    time_str = f"{minutes:02d}:{seconds:02d}"
    subprocess.run(["eww", "update", f'time={time_str}'])
    # print(f"{minutes:02d}:{seconds:02d}", end="\r")

def convert_time_to_seconds(tm:str):
    tmp = tm.split(":")
    return int(tmp[0]) * 60 + int(tmp[1])

def timer(tm:int):
    while tm > 0:
        display(tm)
        time.sleep(1)
        tm-=1
    
    os.system('paplay music/beep.wav')

def main():
    global IS_WORKING_TIME
    pomdoro_data_raw = get_time2()
    for i in range(int(pomdoro_data_raw[2])):
        # print("Loop: ", i + 1)
        for j in range(2):
            if IS_WORKING_TIME: 
                pomdoro_label = "relax"
            else: 
                pomdoro_label = "work time" 
            subprocess.run(["eww", "update", f"pomodoro_label={pomdoro_label}"])
            IS_WORKING_TIME = not IS_WORKING_TIME
            # print("Timer: ", pomdoro_data_raw[j])
            tm = convert_time_to_seconds(pomdoro_data_raw[j])
            timer(tm)


if __name__ == "__main__":
    main()