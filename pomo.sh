#!/bin/bash
#
# Minimalistic_Pomodoro_Timer
#
# Based on the SU answer found here: https://superuser.com/questions/224265/pomodoro-timer-for-linux/669811#669811
#
# Tested in Ubuntu 16.04 and Arch
pomodorotime () {
  notify-send "Time to Work" "Focus" -u critical -a 'Pomodoro' -i $HOME/Downloads/logo.png
}

shortbreaktime () {
  notify-send "Short Break Time" -u critical -a 'Pomodoro' -i $HOME/Downloads/logo.png
  # uncomment line below to lock your screen during the short break (needs to install xtrlock for your distribution)
  sleep 5 && /usr/lib/xscreensaver/gluqlo -root  & sleep 300 && pkill gluqlo
}

longbreaktime () {
  notify-send "Long Break Time" "Take a Rest" -u critical -a 'Pomodoro' -i $HOME/Downloads/logo.png
  # sleep 5 && /usr/lib/xscreensaver/gluqlo -root  & sleep 900 && pkill gluqlo
}


case "$1" in
    'start')
            echo "Starting Pomodoro"
            counter=0
            while true; do
                now=`date +"%H:%M"`
                pomodorotime
                counter=$((counter+1))
                echo "Pomodoro number: $counter started at: $now"
                sleep 1500 && shortbreaktime #25 mins
                sleep 60 && pomodorotime
                now=`date +"%H:%M"`
                counter=$((counter+1))
                echo "Pomodoro number: $counter started at: $now"
                sleep 1500 && shortbreaktime
                sleep 60 && pomodorotime
                now=`date +"%H:%M"`
                counter=$((counter+1))
                echo "Pomodoro number: $counter started at: $now"
                sleep 1500 && shortbreaktime
                sleep 60 && pomodorotime
                now=`date +"%H:%M"`
                counter=$((counter+1))
                echo "Pomodoro number: $counter started at: $now"
                sleep 1500 && longbreaktime
                echo "Long break time"
                sleep 900
            done
            ;;
    'pomo')
            pomodorotime
            sleep 1500 && shortbreaktime
            ;;
    'sb')
            sleep 300 && pomodorotime
            ;;
    'lb')
            sleep 900 && pomodorotime
            ;;
    *)
            echo
            echo "Usage: $0 { start | pomo | sb | lb }"
            echo
            exit 1
            ;;
esac


exit 0
