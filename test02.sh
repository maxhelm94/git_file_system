#!/bin/dash
#POSIX sh

# test if girt-add removes a file in the working directory
# if it was deleted in the index

touch special_name
echo line1 > special_name
touch own_result

./girt-init >> own_result
./girt-add special_name 
./girt-rm --cached special_name
./girt-add special_name
ls | grep "special name" | wc -l >> own_result

rm -rf .girt


touch special_name
echo line1 > special_name
touch reference_sol

2041 girt-init >> reference_sol
2041 girt-add special_name 
2041 girt-rm --cached special_name
2041 girt-add special_name
ls | grep "special name" | wc -l >> reference_sol

rm special_name
rm -rf .girt

DIFF=$(diff own_result reference_sol)

rm reference_sol own_result

if [ "$DIFF" = "" ]
then
    echo "Success! The tested implementation produces the same result as the reference solution"
else
    echo "$DIFF"
fi