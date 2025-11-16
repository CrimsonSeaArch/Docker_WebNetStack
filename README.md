# Docker_WebNetStack

## structure
```
Docker_WebNetStack
├── DockerCompose
│   ├── front-backend-network
│   │   ├── backend
│   │   │   ├── Dockerfile
│   │   │   ├── main.py
│   │   │   └── requirements.txt
│   │   ├── docker-compose.yml
│   │   ├── frontend
│   │   │   ├── Dockerfile
│   │   │   ├── index.html
│   │   │   └── nginx.conf
│   │   └── README.md
│   └── MySQL+Adminer
│       ├── compose.yml
│       └── README.md
├── DockerK8s
│   ├── app.py
│   ├── Dockerfile
│   ├── k8s
│   │   ├── config.yaml
│   │   ├── deployment.yaml
│   │   ├── ingress.yaml
│   │   ├── namespace.yaml
│   │   └── service.yaml
│   └── requirements.txt
├── DockerOnly
│   ├── OwnImage
│   │   ├── app.py
│   │   ├── Dockerfile
│   │   ├── README.md
│   │   └── requirements.txt
│   ├── pull-existing-image
│   │   ├── run-nginx.sh
│   │   └── website
│   │       ├── index.html
│   │       └── pexels-earano-2127969.jpg
│   └── Terraform_Docker
│       ├── backend
│       │   ├── app
│       │   │   └── main.py
│       │   ├── Dockerfile
│       │   └── requirements.txt
│       ├── frontend
│       │   ├── Dockerfile
│       │   ├── nginx.conf
│       │   └── site
│       │       └── index.html
│       ├── main.tf
│       ├── output.tf
│       ├── provider.tf
│       ├── README.md
│       └── variables.tf
├── Docker_Shell_Control_Scipt
│   ├── docker-control.sh
│   └── README.md
└── README.md
└── .gitignore


```