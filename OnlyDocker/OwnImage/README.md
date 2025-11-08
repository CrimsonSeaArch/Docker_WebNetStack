# **Project 01 - Flask Backend mini app**

*Build an easy python webservice with **flask** and **docker***

## structure

```
OwnImage/
├─ app.py
├─ Dockerfile
├─ requirements.txt

```

## concept

1. **Dockerfile** build *docker image* from image *python:3.12-slim*
2. We provide docker image with **flask** from requirements.txt by **COPY**
3. We **RUN** *pip install --no-cache-dir -r requirements.txt* to init **flask**
4. We provide docker image with **app.py** by **COPY** to communicate with **flask**
5. We start webService with **CMD** 
6. *PortMapping*: Localhost listens on e.g.: port **8080**; App listens on port e.g.: **8000**


## Start WebService

````
*bash/ zsh*

docker build -t flaskimg .
docker run --name /yourName/ -d -p 8080:8000 flaskimg
curl http://localhost:8080

```