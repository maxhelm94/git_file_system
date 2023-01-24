#!/bin/dash
#POSIX sh

# test if the -a command of commit works
# as for the second commit the file was updated,
# girt-commit should update the file and do a new
# commit

touch a
echo line1 > a
touch own_result

./girt-init >> own_result
./girt-add a >> own_result
./girt-commit -m "first commit" >> own_result
echo line2 >> a
./girt-commit -a -m "second commit" >> own_result
./girt-show 1:a >> own_result

rm -rf .girt


touch a
echo line1 > a
touch reference_sol

2041 girt-init >> reference_sol
2041 girt-add a >> reference_sol
2041 girt-commit -m "first commit" >> reference_sol
echo line2 >> a
2041 girt-commit -a -m "second commit" >> reference_sol
2041 girt-show 1:a >> reference_sol

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
