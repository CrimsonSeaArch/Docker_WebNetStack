from fastapi import FastAPI
import os

app = FastAPI()
MESSAGE = os.getenv("MESSAGE", "Hello from Kubernetes via K3s!")

@app.get("/")
def root():
    return {"service": "hello-k8s", "message": MESSAGE}


