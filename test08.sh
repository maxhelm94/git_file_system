#!/bin/dash
#POSIX sh

# we do a girt-commit with -a flag after doing a commit
# already. As no new files were added to the working directory
# and no files were updated, girt-commit should print "nothing to commit"
# despite looking at the file in the working directory

touch a
echo line1 > a
touch own_result

./girt-init >> own_result
./girt-add a >> own_result
./girt-commit -m "first commit" >> own_result
./girt-commit -a -m "second commit" >> own_result

rm -rf .girt


touch a
echo line1 > a
touch reference_sol

2041 girt-init >> reference_sol
2041 girt-add a >> reference_sol
2041 girt-commit -m "first commit" >> reference_sol
2041 girt-commit -a -m "second commit" >> reference_sol

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
