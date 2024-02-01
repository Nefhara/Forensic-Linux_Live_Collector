# Forensic-Linux_Live_Collector
Automated collection tasks as part of linux live analysis.

# -How to launch it
This is a standard bash script, you need to run it with root account.

  `.\Linux_live_collector.sh`

  ![ALT](/Referentiel/launch_1.png)

  ![ALT](/Referentiel/launch_2.png)

# -Functions
  - **create_folder** : create a working directory for the output.
  - **user** : list all system users.
  - **auth_log** : retrieve the contents of /var/auth.log file.
  - **modif_file** : lists all system files by modification date.
  - **md5_sum** : MD5 hash of each /var/log files.
  - **proc** : list all processes in memory.
  - **network** : list network connections.
  - **privesc** : lists incorrectly assigned rights on certain files.
  - **persistance** : retrieve the contents of /etc/crontab.
  - **docker_list** : list the working dockers.
  - **bash_history** : retrieve the command history of each system user.
  - **env_linux** : retrieve the current user's environment variables.

# -To do list
  - Add banner and help information.
  - Create a menu with the function choice to launch.
  - Recovery of wtmp, btmp, syslog and message log files.
  - Adding advanced forensic fonctionality within a docker. 



