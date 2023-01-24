#!/bin/dash
#POSIX sh

# test if -n flag is working appropriately; the -n flag only prints any output
# with the p command; our test script should therefore not print anything

touch own_result

seq 1 50 | ./speed.pl -n '10d' >> own_implementation
seq 100 499 | ./speed.pl -n '300q' >> own_implementation
seq 500 1000 | ./speed.pl -n 's/1/2/g' >> own_implementation



touch reference_sol

seq 1 50 | 2041 speed -n '10d' >> reference_sol
seq 100 499 | 2041 speed -n '300q' >> reference_sol
seq 500 1000 |2041 speed -n 's/1/2/g' >> reference_sol




DIFF=$(diff own_implementation reference_sol)

rm reference_sol own_result

if [ "$DIFF" = "" ]
then
    echo "Success! The tested implementation produces the same result as the reference solution"
else
    echo "$DIFF\n"
    if [ grep -P "(\d+)" own_result ]
    then
        echo "test should not print any digits"
    fi
fi
