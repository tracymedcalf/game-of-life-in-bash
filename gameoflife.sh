#!/usr/bin/env bash

#right(i : Int) : Int { return if ((i + 1) % w == 0) {i + 1 - w } else { i + 1 } }
#left(i : Int) : Int { return if (i % w == 0) { i + w - 1 } else { i - 1 } }
#above (i : Int) : Int { return if (i < w) { i + lastRow1stCol } else { i - w } }
#below (i : Int) : Int { return if (i >= lastRow1stCol) { i - lastRow1stCol } else { i } }

# gives i value for right when $2 is width
# gives j value for below when $2 is height
right_or_below () {
    if [ $1 -eq $2 ]; then
        echo 1
    else
        echo `expr $1 + 1`
    fi
}

left_or_above () {
    if [ $1 -eq 1 ]; then
        echo $2
    else
        echo `expr $1 - 1`
    fi
}

neighbor_sum() {
    local _left_i=`left_or_above $i $width`
    local _right_i=`right_or_below $i $width`
    local _below_j=`right_or_below $j $height`
    local _above_j=`left_or_above $j $height`
    echo `expr ${world[$_left_i,$j]} + ${world[$_right_i,$j]} + ${world[$i,$_below_j]} + ${world[$i,$_above_j]} + ${world[$i,$j]}`
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
    # print the world
    for i in `seq $height`; do
        for j in `seq $width`; do
            printf "%2s" ${world[$i,$j]}
        done
        echo ""
    done
    # set the world
    for i in `seq $height`; do
        for j in `seq $width`; do
            if [ `neighbor_sum` -gt "2" ]; then
                world[$i,$j]=1;
            else
                world[$i,$j]=0;
            fi
        done
    done
done
