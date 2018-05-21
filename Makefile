all: redis

redis:
	docker build -t redis:3.2.8 .
