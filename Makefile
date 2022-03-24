.PHONY: run
run:
	@export DB_CONN_STRING=.db_conn && go run cmd/*.go

.PHONY: docker-build
docker-build:
	@docker build -t adv-service .

.PHONY: docker-run
docker-run:
	@docker run \
		--name adv-service \
		-d \
		--rm \
		-p 80:8080 \
		-v `pwd`/secret:/secret \
		adv-service

.PHONY: docker-stop
docker-stop:
	@docker stop adv-service

.PHONY: run-db
run-db:
	@docker run \
		-d \
		-v `pwd`/db:/docker-entrypoint-initdb.d/ \
		--rm \
		-p 5432:5432 \
		--name db \
		-e POSTGRES_DB=backend \
		-e POSTGRES_USER=postgres \
		-e POSTGRES_PASSWORD=postgres \
		postgres:12

.PHONY: docker-build-generator
docker-build-generator:
	@docker build -t generator -f Dockerfile.generator .

.PHONE: gen-proto
gen-proto: docker-build-generator
	@docker run -d --rm \
		-v `pwd`/api:/api \
		-v `pwd`/internal/pb:/pb \
		generator protoc \
		--go_out=. --go_opt=paths=source_relative \
    	--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		--grpc-gateway_out=. --grpc-gateway_opt=logtostderr=true --grpc-gateway_opt=paths=source_relative --grpc-gateway_opt=generate_unbound_methods=true \
		-I /usr/local/include/. \
    	-I /api/. api.proto

.PHONY: gen-swagger
gen-swagger:
	@docker run --rm -it  --user $(id -u):$(id -g) -e GOPATH=$$HOME/go:/go -v $$HOME:$$HOME -w `pwd` quay.io/goswagger/swagger generate server -f ./api/api.yaml -t ./internal --main-package=../../cmd
