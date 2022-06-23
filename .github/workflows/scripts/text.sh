a=10
b=10



#Check whether they are equal
if [ $a == $b ]
then
echo "`expr $b / $a`"
fi



#Check whether they are not equal
if [ $a != $b ]
then
echo "a is not equal to b"
fi