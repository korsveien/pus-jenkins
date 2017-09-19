TODO

- opprydning


Start med:
```
docker run -d --restart=always -p 80:8080 -v /var/run/docker.sock:/var/run/docker.sock docker.adeo.no:5000/bekkci/jenkins
```