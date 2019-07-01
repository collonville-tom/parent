docker pull collonvtom/maven:latest
docker run -it --rm -v repomaven:/repolocal -v $(pwd):/maven_work_dir --name mvn collonvtom/maven:latest
