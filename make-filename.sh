targetdir="public/textures/bf"

last=`ls $targetdir | sed 's/\([0-9]\+\).*/\1/g' | sort -n | tail -1`
echo $last

nextnumber=`expr 1 + $last`
next=`printf "%05d" $nextnumber`
echo "$targetdir/$next.png"

