#!/bin/bash
a="("
b=","
c=")"
learnedrate="(60, 60, 60, 60, 60, 60, 60, 60, 60, 60)"
learnedrate=${learnedrate/$a/}
learnedrate=${learnedrate/$c/}
learnedrate=${learnedrate//$b/}
arr=($learnedrate)
echo $learnedrate
echo $arr
echo ${arr[2]}
echo ${arr[@]}
