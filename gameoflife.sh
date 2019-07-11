#!/usr/bin/env bash

## Voting (smoothing) variation of the game of life.

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
    local left_i=`left_or_above $i $width`
    local right_i=`right_or_below $i $width`
    local below_j=`right_or_below $j $height`
    local above_j=`left_or_above $j $height`
    echo `expr ${world[$left_i,$j]} + ${world[$right_i,$j]} + ${world[$i,$below_j]} + ${world[$i,$above_j]} + ${world[$i,$j]}`
}

# check for arguments
if [ $# -eq 2 ]; then
    height=$1;
    width=$2;
else
    echo "Input integers to specify height and width. Using defaults."
    height=10;
    width=10;
fi

echo height is $height and width is $width
echo "(Expect the program to be very slow even for moderately large values of height and width)."

declare -A world
# backquoting is command substitution
for i in `seq $height`; do
    for j in `seq $width`; do
        world[$i,$j]=$(( RANDOM % 2))
    done
done

echo "Press enter to see next board. ctrl-c to quit."
while read -e; do
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
            if [ `neighbor_sum` -gt 2 ]; then
                world[$i,$j]=1;
            else
                world[$i,$j]=0;
            fi
        done
    done
done
