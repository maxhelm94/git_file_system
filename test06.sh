#!/bin/dash
#POSIX sh

# test girt-show if you try to print a file that does not exist
# and to access a commit that does not exist 

touch a
echo line1 > a
touch own_result

./girt-init >> own_result
./girt-add a >> own_result
./girt-commit -m "first commit" >> own_result
./girt-show 0:a >> own_result
./girt-show 1:a 1>> own_result 2>/dev/null 
./girt-show 0:b 1>> own_result 2>/dev/null 

rm -rf .girt


touch a
echo line1 > a
touch reference_sol

2041 girt-init >> reference_sol
2041 girt-add a >> reference_sol
2041 girt-commit -m "first commit" >> reference_sol
2041 girt-show 0:a >> reference_sol
2041 girt-show 1:a 1>> reference_sol 2>/dev/null 
2041 girt-show 0:b 1>> reference_sol 2>/dev/null 

rm a
rm -rf .girt

DIFF=$(diff own_result reference_sol)

rm reference_sol own_result

if [ "$DIFF" = "" ]
then
    echo "Success! The tested implementation produces the same result as the reference solution"
else
    echo "$DIFF"
fi
