# MCODI
Michael's Containerized Developer Infrastructure 



# Build

docker build -t europe-west3-docker.pkg.dev/md13playground/midietz-container-repo/mcodi:latest .

# Push 
docker push europe-west3-docker.pkg.dev/md13playground/midietz-container-repo/mcodi:latest

# Run

docker run -p 8001:3000 -v ./codeworkspace:/codeworkspace europe-west3-docker.pkg.dev/md13playground/midietz-container-repo/mcodi:latest