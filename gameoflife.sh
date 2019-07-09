#!/usr/bin/env bash

#right(i : Int) : Int { return if ((i + 1) % w == 0) {i + 1 - w } else { i + 1 } }
#left(i : Int) : Int { return if (i % w == 0) { i + w - 1 } else { i - 1 } }
#above (i : Int) : Int { return if (i < w) { i + lastRow1stCol } else { i - w } }
#below (i : Int) : Int { return if (i >= lastRow1stCol) { i - lastRow1stCol } else { i } }

right () {
    if [ $1 -eq $width ]; then
        echo $width
    else
        echo $1
    fi
}


#neighborsIndices(i : Int) : IntArray {
#    val right = right(i)
#    val left = left(i)
#    val above = above(i)
#    val below = below(i)
#	return intArrayOf(right, left, below, above, i, left(below), right(below), left(above), right(above))
#}

# check for arguments
if [ -n $1 ] && [ -n $2 ]; then
    height=$1;
    width=$2;
else
    echo "Input integers to specify height and width. Using defaults."
    height=20;
    width=20;
fi

echo height is $height and width is $width

declare -A world
# backquoting is command substitution
for i in `seq $height`; do
    for j in `seq $width`; do
        world[$i,$j]=$(( RANDOM % 2))
    done
done

echo "Press enter to see next board. ctrl-c to quit."
while [ "" = "$( read -e )" ]; do
    for i in `seq $height`; do
        for j in `seq $width`; do
            world[$i,$j]=$( right $j )
        done
    done
    for i in `seq $height`; do
        for j in `seq $width`; do
            printf "%2s" ${world[$i,$j]}
        done
        echo ""
    done
done
