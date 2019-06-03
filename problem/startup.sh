tool=../bin/DesignEasy
license=../bin/license
declare -a bench=("amp" "amp3" "bjt" "classE" "mos3" "mosfet" "tristateio")
for i in "${bench[@]}"
do
	echo "cp $tool $i/de"
	echo "cp $license $i"
	cp $tool $i
	cp $license $i
	rm -r $i/runtime
done

