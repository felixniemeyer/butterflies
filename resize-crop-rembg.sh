convert -resize '1024x1024^' -gravity center -crop 1024x1024+0+0 IMG_4370.jpg out2.png
time rembg i -a out2.png final2.png
