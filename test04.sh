#!/bin/dash
#POSIX sh

# test if the commit will happen despite an empty index
# the program should print "nothing to commit"

touch own_result

./girt-init >> own_result
./girt-commit -m "first commit" >> own_result

rm -rf .girt


touch reference_sol

2041 girt-init >> reference_sol
2041 girt-commit -m "first commit" >> reference_sol

rm -rf .girt

DIFF=$(diff own_result reference_sol)

rm reference_sol own_result

if [ "$DIFF" = "" ]
then
    echo "Success! The tested implementation produces the same result as the reference solution"
else
    echo "$DIFF"
fi
