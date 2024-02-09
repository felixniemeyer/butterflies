capture="capt0000.jpg"
cropped="cropped-and-resized.png"
targetdir="public/textures/bf"

echo 'capturing butterfly'
gphoto2 --capture-image-and-download

echo 'scaling and cropping'
convert -flip -flop -resize '1024x1024^' -gravity center -crop 1024x1024+0+0 $capture $cropped

last=`ls $targetdir | sed 's/\([0-9]\+\).*/\1/g' | sort -n | tail -1`
echo $last

nextnumber=`expr 1 + $last`
next=`printf "%05d" $nextnumber`
finalname="$targetdir/$next.png"

echo 'removing background'
rembg i -a $cropped "$finalname-bla"

mv "$finalname-bla" $finalname

rm $capture
rm $cropped

