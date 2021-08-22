The following dockerfile repository has been created for version 0.18.18 with information https://pocketnet.app/help?page=node

Run:
```
sudo mkdir /pocket
sudo docker build -t pocket:latest .
sudo docker run -dit -p 58080:58080 -p 51413:51413 -v /pocket:/data --name pocket pocket:latest
sudo docker logs pocket -f
```

Cleanup:
```
sudo docker rm pocket -f
sudo rm -rf /pocket/*
```
