up:
	docker-compose up -d

up_build:
	docker-compose up --build -d 

down:
	docker-compose down

miner:
	docker exec -it miner /bin/bash

node1:
	docker exec -it node1 /bin/bash

node2:
	docker exec -it node2 /bin/bash
