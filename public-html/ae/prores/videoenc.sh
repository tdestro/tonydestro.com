#!/bin/bash    
### MP4 ###
# PASS 1 AND 2
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y                    -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y                    -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 2 ../mp4/Men.mp4
# PASS 1 AND 2
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=1280:720 -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=1280:720 -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 2 ../mp4/Men1280x720.mp4
# PASS 1 AND 2
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=980:550  -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=980:550  -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 2 ../mp4/Men980x550.mp4

## THEORA
# PASS 1 AND 2
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y                    -vcodec libtheora -an -b:v 800k -threads 0 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y                    -vcodec libtheora -an -b:v 800k -threads 0 -pass 2 ../mp4/Men.ogv
# PASS 1 AND 2
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=1280:720 -vcodec libtheora -an -b:v 800k -threads 0 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=1280:720 -vcodec libtheora -an -b:v 800k -threads 0 -pass 2 ../mp4/Men1280x720.ogv
# PASS 1 AND 2
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=980:550  -vcodec libtheora -an -b:v 800k -threads 0 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=980:550  -vcodec libtheora -an -b:v 800k -threads 0 -pass 2 ../mp4/Men980x550.ogv



## WEBM
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y                    -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y                    -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 ../mp4/Men.webm
# PASS 1 AND 2
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=1280:720 -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=1280:720 -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 ../mp4/Men1280x720.webm
# PASS 1 AND 2
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=980:550  -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 1 -f rawvideo /dev/null
ffmpeg -i /Library/WebServer/Documents/prores/FLEX_DENIM_FINAL_rev07082015.mov -y -vf scale=980:550  -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 ../mp4/Men980x550.webm

### MP4 ###
# PASS 1 AND 2
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y                    -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y                    -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 2 ../mp4/Women.mp4
# PASS 1 AND 2
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=1280:720 -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=1280:720 -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 2 ../mp4/Women1280x720.mp4
# PASS 1 AND 2
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=980:550  -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=980:550  -vcodec libx264 -an -pix_fmt yuv420p -b:v 800k -preset veryslow -profile:v high -level 4.1 -movflags +faststart -threads 0 -pass 2 ../mp4/Women980x550.mp4

## THEORA
# PASS 1 AND 2
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y                    -vcodec libtheora -an -b:v 800k -threads 0 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y                    -vcodec libtheora -an -b:v 800k -threads 0 -pass 2 ../mp4/Women.ogv
# PASS 1 AND 2
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=1280:720 -vcodec libtheora -an -b:v 800k -threads 0 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=1280:720 -vcodec libtheora -an -b:v 800k -threads 0 -pass 2 ../mp4/Women1280x720.ogv
# PASS 1 AND 2
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=980:550  -vcodec libtheora -an -b:v 800k -threads 0 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=980:550  -vcodec libtheora -an -b:v 800k -threads 0 -pass 2 ../mp4/Women980x550.ogv

## WEBM

#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y                    -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y                    -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 ../mp4/Women.webm

#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=1280:720 -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=1280:720 -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 ../mp4/Women1280x720.webm

#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=980:550  -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 1 -f rawvideo /dev/null
#ffmpeg -i /Library/WebServer/Documents/prores/DenimX_PRORES4444_DELIVERY.mov -y -vf scale=980:550  -vcodec libvpx-vp9 -an -b:v 800k -threads 1 -speed 1 -g 9999 -aq-mode 0 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 ../mp4/Women980x550.webm
