## Aufgabe 1:
* Stelle eine Postgres-Datenbank im Docker Container bereit.

## Lösung:
### Linux / macOS:
* führe das Skript "run_postgres.sh" mit dem Parameter "init" aus.
* Das Skript befindet sich im module infrastructure im Verzeichnis DockerContainer.

### Windows:
* führe folgende Befehle aus:
```dockerfile
docker run --name postgres_training -p 5432:5432 -d -e POSTGRES_PASSWORD=training -e POSTGRES_USER=cinema  postgres:13.2    
mvn flyway:migrate im root Verzeichnis des flyway moduls.
```

### IntelliJ IDEA
* Pull image
    * Image name: postgres:13.2
* Create container
    * Set ports and environment variables
    * Start container

[//]:# (TODO: This is just a crude initial version.)
