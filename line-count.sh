i=0
for file in $(\find . -maxdepth 1 -type f); do
	while IFS= read -r line; do
		# echo $line
		if [[ $line == *http* ]]; then
			i=$(expr $i + 1)
		fi
​
	done <$file
	repoid=${file%%_*}
	slicerepoid=${repoid:2}
	filename=${file#*/}
	# line=echo wc -l "${file}"
	line=$(echo $(sed '/^$/d' $file | wc -l))
	echo "${slicerepoid},${filename},${i},${line}" >>test2.csv
	i=0
done