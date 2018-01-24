mkdir lightftp-asan
#### MAGIC ####
# start LightFTP+ASan+safec
#### END MAGIC ####
jmeter -n -t ~/lightftp.jmx -l lightftp-asan.txt -e -o lightftp-asan
