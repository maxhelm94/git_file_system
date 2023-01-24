#!/bin/dash
#POSIX sh

# test various error messages if girt wasn't initialized with
# girt-init; therefore all programs should produce error messages

touch own_result

./girt-add a 1>> own_result 2>/dev/null 
./girt-commit -m "first commit" 1>> own_result 2>/dev/null 
./girt-rm a 1>> own_result 2>/dev/null 
./girt-show :a 1>> own_result 2>/dev/null 
./girt-log 1>> own_result 2>/dev/null 

rm -rf .girt


touch reference_sol

2041 girt-add a 1>> reference_sol 2>/dev/null 
2041 girt-commit -m "first commit" 1>> reference_sol 2>/dev/null 
2041 girt-rm a 1>> reference_sol 2>/dev/null 
2041 girt-show :a 1>> reference_sol 2>/dev/null 
2041 girt-log 1>> reference_sol 2>/dev/null 

rm -rf .girt

DIFF=$(diff own_result reference_sol)

rm reference_sol own_result

if [ "$DIFF" = "" ]
then
    echo "Success! The tested implementation produces the same result as the reference solution"
else
    echo "$DIFF"
fi
