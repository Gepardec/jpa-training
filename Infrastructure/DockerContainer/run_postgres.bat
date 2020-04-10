docker run --name postgres_training -p 5432:5432 -d -e POSTGRES_PASSWORD=training -e POSTGRES_USER=hogarama  postgres:11.7
# docker stop postgres_training
# docker start postgres_training