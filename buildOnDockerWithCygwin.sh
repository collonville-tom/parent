docker pull collonvtom/maven-osgi-dev:3.6.1-jdk-11-slim
docker run -it --rm -v repomaven:/repolocal -v $(cygpath -w $(pwd)):/maven_work_dir --name mvn collonvtom/maven-osgi-dev:3.6.1-jdk-11-slim
