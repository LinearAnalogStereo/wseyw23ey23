onion site docker 


wget https://github.com/LinearAnalogStereo/wseyw23ey23/blob/main/Dockerfile -O Dockerfile && docker build -t onion-site . && docker run -d -p 80:80 -p 9050:9050 --name onion-site-container onion-site && docker logs -f onion-site-container
