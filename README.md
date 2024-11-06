# MCODI
Michael's Containerized Developer Infrastructure 



# Build

docker build -t mcodi:latest .

# Run

docker run -p 8001:3000 -v ./codeworkspace:/codeworkspace mcodi:latest