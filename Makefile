docker.up:
	docker-compose up -d

docker.up.build:
	docker-compose up --build -d 

docker.down:
	docker-compose down

docker.exec.miner:
	docker exec -it miner /bin/bash

docker.exec.node1:
	docker exec -it node1 /bin/bash

docker.exec.node2:
	docker exec -it node2 /bin/bash
