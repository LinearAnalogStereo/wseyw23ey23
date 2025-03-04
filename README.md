onion site docker 


wget https://raw.githubusercontent.com/LinearAnalogStereo/wseyw23ey23/refs/heads/main/Dockerfile -O Dockerfile && docker build -t onion-site . && docker run -d -p 80:80 -p 9050:9050 --name onion-site-container onion-site && docker logs -f onion-site-container
