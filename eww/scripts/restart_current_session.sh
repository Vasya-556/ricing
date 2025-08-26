#!/usr/bin/env bash

bash -c /home/vasyl/.config/eww/scripts/end_pomodoro.sh & 
eww reload
bash -c /home/vasyl/.config/eww/scripts/start_pomodoro.sh &