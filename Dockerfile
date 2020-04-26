FROM maven:3.5.2

LABEL maintainer="Srikar"

ENV workspace_dir="" jar_path=${workspace_dir}/target/*.jar

WORKDIR /tmp/

COPY ${jar_path} ./