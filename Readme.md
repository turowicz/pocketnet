sudo docker pull surveily.azurecr.io/cvat.net:latest
sudo docker run -dit -p 58080:58080 -p 51413:51413 -v /data:/data --name pocket surveily.azurecr.io/cvat.net:latest
sudo docker logs pocket -f