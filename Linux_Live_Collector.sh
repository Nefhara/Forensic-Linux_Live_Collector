#!/bin/bash
##### Variable #####
#Output folder
dir_name="Output_Collector"
warning_color="\e[31m"
info_color="\e[32m"

#Progress Bar
function_step_number=0

total_length=40
total_steps=11

fill_character="█"
empty_character="░"

color_bar="\e[33m"
empty_color="\e[0m"

#Bash_history
BASE_HOME_DIR="/home"
bash_root_history_file="/root/.bash_history"
zsh_root_history_file="/root/.zsh_history"


##### Fonction actualisation #####
progress_bar() {
	current_step=$1
	
	progress_length=$((current_step * total_length / total_steps))
	percentage=$((current_step * 100 / total_steps))
	
	bar="["
	
	for ((i = 0; i < progress_length; i++)); do
        	bar+="${color_bar}$fill_character${empty_color}"
	done

	for ((i = progress_length; i < total_length; i++)); do
		bar+="$empty_character"
	done

	bar+="] $percentage%"
	echo -ne "\r$bar"
}


##### Fonction de travail #####
create_folder() {	
	if [ ! -d "$dir_name" ]; then
		mkdir "$dir_name"
		echo -e "${info_color}[INFO] New directory : $dir_name created${empty_color}"
	else
		echo -e "${warning_color}[WARNING] $dir_name directory already exist${empty_color}"
	fi
	
	sleep 1
}

user() {
	((function_step_number++))
	cp /etc/passwd "./$dir_name/passwd"
	sleep 1
	progress_bar $function_step_number
}

auth_log() {
	((function_step_number++))
	cat /var/log/auth.log > "./$dir_name/auth_log.txt"
	sleep 1
	progress_bar $function_step_number
}

modif_file() {
	((function_step_number++))
	find / -type f -exec ls -lt {} + > "./$dir_name/fichier_modifier.txt" 2>/dev/null
	sleep 1
	progress_bar $function_step_number
}

md5_sum() {
	((function_step_number++))
	find /var/log -type f -exec md5sum {} + > "./$dir_name/hash_fichier_log.txt" 2>/dev/null
	sleep 1
	progress_bar $function_step_number
}

proc() {
	((function_step_number++))
	ps aux > "./$dir_name/proc.txt"
	sleep 1
	progress_bar $function_step_number
}

network() {
	((function_step_number++))
	netstat -tuln > "./$dir_name/netstat.txt"
	sleep 1
	progress_bar $function_step_number
}

privesc() {
	((function_step_number++))
	find / -perm 4000 -type f > "./$dir_name/perm_4000_file.txt" 2>/dev/null
	sleep 1
	progress_bar $function_step_number
}

persitance() {
	((function_step_number++))
	cp /etc/crontab "./$dir_name/crontab"
	sleep 1
	progress_bar $function_step_number
}

docker_list() {
	((function_step_number++))
	docker ps > "./$dir_name/docker.txt"
	sleep 1
	progress_bar $function_step_number
}

bash_history() {	
	((function_step_number++))
	for user_dir in $BASE_HOME_DIR/*; do
		if [ -d "$user_dir" ]; then
			username=$(basename "$user_dir")
			bash_history_file="$user_dir/.bash_history"
			zsh_history_file="$user_dir/.zsh_history"
			
			
			if [ -f "$bash_history_file" ]; then
				cp $bash_history_file "./$dir_name/$username.BASH_HISTORY"
			fi
			
			if [ -f "$zsh_history_file" ]; then
				cp $zsh_history_file "./$dir_name/$username.ZSH_HISTORY"
			fi
		fi
	done

	cp $bash_root_history_file "./$dir_name/root.BASH_HISTORY"
	cp $zsh_root_history_file "./$dir_name/root.ZSH_HISTORY"
	
	sleep 1
	progress_bar $function_step_number
}

env_linux() {
	((function_step_number++))
	printenv > "./$dir_name/env.txt"
	sleep 1
	progress_bar $function_step_number
}


##### MAIN #####
create_folder

user
auth_log
modif_file
md5_sum
proc
network
privesc
persitance
docker_list
bash_history
env_linux
