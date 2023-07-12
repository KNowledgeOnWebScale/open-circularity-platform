# give as a platform with a comfortable bash shell and of course, node
FROM node:16.18.1-bullseye

WORKDIR /work
# Use a known good tag of bashlib (here it is a fork, because of https://github.com/SolidLabResearch/Bashlib/issues/55)
RUN git clone https://github.com/mvanbrab/Bashlib.git --branch workaround_55 bashlib
WORKDIR /work/bashlib
RUN npm install --unsafe-perm
RUN npm run build
RUN mkdir -p $HOME/.solid/
WORKDIR /scripts
COPY scripts .
# If needed, override next CMD in your docker-compose.yml (https://docs.docker.com/compose/compose-file/05-services/#command)
CMD ["./default-command.sh"]
