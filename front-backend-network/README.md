# Project 03 - Front + Backend via Docker Compose

_We want to combine two container front and backend into one network_

- Frontend: **NGINX**, provides html file and works as reverse proxy
- backend: **FastAPI**, provides REST-Endpoint and handles API requests
- docker-network: **NAT** combines frontend and backend container
- docker compose: Orchestrates both container: _connection, ports, order_ 

## structure

````03-front-backend-network

├── backend/
│   ├── main.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── frontend/
│   ├── index.html
│   ├── nginx.conf
│   └── Dockerfile
│
└── docker-compose.yml

````

## concept - frontend

1. Docker creates image form _nginx:alpine_
2. **NGINX** provides static web page(_index.html_) and forwards/ reacts to backend

## concept - backend

1. Docker creates image from _python:3.12-slim_
2. Python imports **FastAPI** from _requ.txt_
3. **FastAPI** WebService provides API for request. 
4. Docker starts **FastAPI** (_main:app)
4. **main.py** issues _GET_ request (_@app.get("/hello"))_ to **FastAPI**

## concept - docker compose

1. combines both services (_frontend_, _backend_) into one script
2. Makes sure _frontend_ depends on _backend_

## start webService -expection-

### build-phase
- Docker compose starts backend image first, than frontend image 

### network
- Compose creates isolated network via NAT by _appnet_
- Both container use hostnames(_backend_, _frontend_) each.

### run container
- backend container runs **Uvicorn** on port 8000
- frontend container runs **NGINX** on port 80
- Port mapping: _host-port: 8081_ => _Container-port 80_

### communication
- browser => _localhost:8081_ => _NGINX_(frontend)
- NGINX => _/api/_ => _FASTAPI_(backend)
- backend => _JSON-Response_ => _NGINX_ => browser

`````
bash

docker compose up -d --build

curl http://localhost:8081/api/hello

````

## expected answer

````JSON

{
  "service": "backend",
  "message": "Hello from FastAPI"
}

````


