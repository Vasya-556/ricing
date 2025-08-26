import time
import os
import subprocess
import signal
import random
import sys
import threading

PROCESS = None
STOP_FLAG = False
SCRIPT_PATH = "/home/vasyl/.config/eww/scripts/"
MUSIC_PATH = "/home/vasyl/.config/eww/"
CONFIGS_PATH = "/home/vasyl/.config/eww/configs/"

def open_file(file_name: str, default_value: str):
    try:
        with open(file_name) as f:
            x = f.read().strip()

        if file_name == f"{CONFIGS_PATH}loop.txt":
            if x.isdigit():
                return x
            else:
                return default_value
            
        if len(x) == 5 and x[2] == ":" and x[:2].isdigit() and x[3:].isdigit():
            minutes = int(x[:2])
            seconds = int(x[3:])
            if 0 <= minutes <= 99 and 0 <= seconds <= 59:  
                return x
        
        return default_value

    except Exception:
        return default_value

def get_time():
    work_time = open_file(f"{CONFIGS_PATH}work_time.txt", "25:00")
    relax_time = open_file(f"{CONFIGS_PATH}relax_time.txt", "25:00")
    loop_count = open_file(f"{CONFIGS_PATH}loop.txt", "3")
    return work_time, relax_time, loop_count

def display(tm: int):
    minutes = tm // 60
    seconds = tm % 60
    time_str = f"{minutes:02d}:{seconds:02d}"
    subprocess.run(["eww", "update", f'time={time_str}'])

def convert_time_to_seconds(tm:str):
    tmp = tm.split(":")
    if len(tmp) != 2:
        return 0
    return int(tmp[0]) * 60 + int(tmp[1])

def timer(tm:int):
    while tm > 0:
        display(tm)
        time.sleep(1)
        tm-=1
    os.system('paplay /home/vasyl/.config/eww/scripts/beep.wav')

def play_random_song():
    global PROCESS, STOP_FLAG
    while not STOP_FLAG:
        all_files = []
        for root, dirs, files in os.walk(os.path.join(MUSIC_PATH, "music")):
            for f in files:
                if f not in ["full_audio.mp3", "title.txt"]:
                    full_path = os.path.join(root, f)
                    all_files.append(full_path)

        if not all_files:
            break

        l = len(all_files)
        n = random.randrange(0, l)
        try:
            PROCESS = subprocess.Popen(
                ["ffplay", "-nodisp", "-autoexit", "-loglevel", "quiet", {all_files[n]}],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
            )
            PROCESS.wait()
        except KeyboardInterrupt:
            if PROCESS:
                PROCESS.terminate()
            sys.exit(0)

def start_music_thread():
    global STOP_FLAG
    STOP_FLAG = False
    thread = threading.Thread(target=play_random_song, daemon=True)
    thread.start()
    return thread

def stop_music():
    global STOP_FLAG, PROCESS
    STOP_FLAG = True
    if PROCESS and PROCESS.poll() is None:
        PROCESS.terminate()

def signal_handler(sig, frame):
    global PROCESS
    if PROCESS:
        PROCESS.terminate()
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

def main():
    pomdoro_data_raw = get_time()
    # pomdoro_data_raw:
    # 0 - work time
    # 1 - relax time
    # 2 - loop count

    for i in range(int(pomdoro_data_raw[2])):
        pomdoro_label = f"work time {i + 1} of {pomdoro_data_raw[2]}"
        subprocess.run(["eww", "update", f"pomodoro_label={pomdoro_label}"])
        subprocess.run(["notify-send", "pomodoro", f"{pomdoro_label}"])
        music_thread = start_music_thread()
        tm = convert_time_to_seconds(pomdoro_data_raw[0])
        timer(tm)
        stop_music()

        pomdoro_label = f"relax {i + 1} of {pomdoro_data_raw[2]}"

        subprocess.run(["eww", "update", f"pomodoro_label={pomdoro_label}"])
        subprocess.run(["notify-send", "pomodoro", f"{pomdoro_label}"])
        music_thread = start_music_thread()
        tm = convert_time_to_seconds(pomdoro_data_raw[1])
        timer(tm)
        stop_music()

if __name__ == "__main__":
    main()