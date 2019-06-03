tool=../bin/nrun
tool_single=../bin/single
setting=../bin/setting.ini
de_ini=../bin/de.ini
cp $setting .
cp $de_ini .

declare -a bench=("amp" "amp3" "bjt" "classE" "branin" "mos3" "mosfet" "tristateio")
declare -a method=("dyn_2" "dyn_4" "dyn_8" "static_2" "static_4" "static_8")
for i in "${bench[@]}"
do
	if [ ! -d $i ]; then
		echo "mkdir $i"
		mkdir $i
	fi

	for m in "${method[@]}"
	do
		if [ ! -d $i/$m ]; then
			echo "mkdir $i/$m" 
			mkdir $i/$m
		fi		

		echo "cp $tool $i/$m/"
		cp $tool $i/$m

		if [ ! -d $i/$m/run.sh ]; then
			echo "touch $i/$m/run.sh"
			touch $i/$m/run.sh
			echo "write to run.sh"
			if [ $i = "dyn_2" ]; then
				echo "nohup mpirun -n 3 ./nrun " > run.sh
			elif [ $i = "dyn_4" ]; then
				echo "nohup mpirun -n 5 ./nrun " > run.sh
			elif [ $i = "dyn_8" ]; then
				echo "nohup mpirun -n 9 ./nrun " > run.sh
			elif [ $i = "static_2" ]; then
				echo "nohup mpirun -n 3 ./nrun " > run.sh
			elif [ $i = "static_4" ];	then
				echo "nohup mpirun -n 5 ./nrun " > run.sh
			elif [ $i = "static_8" ]; then
				echo "nohup mpirun -n 9 ./nrun " > run.sh
			elif [ $i = "origin" ]; then
				echo "./single" > run.sh
			fi
		fi

		cp setting.ini $i/$m
		cp de.ini $i/$m
	done
	
	# origin related
	if [ ! -d $i/origin ]; then
		echo "mkdir $i/origin"
		mkdir $i/origin
	fi
	echo "cp $tool_single $i/origin/"
	cp $tool_single $i/origin
	if [ ! -d $i/origin/run.sh ]; then
		touch $i/origin/run.sh
		echo "nohup single " > run.sh
	fi
	cp setting.ini $i/origin
	cp de.ini $i/origin
done

