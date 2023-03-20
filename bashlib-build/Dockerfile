# give as a platform with a comfortable bash shell and of course, node
FROM node:16.18.1-bullseye

WORKDIR /work
# Use a known good tag of bashlib
RUN git clone https://github.com/SolidLabResearch/Bashlib.git --branch 0.2.4 bashlib
WORKDIR /work/bashlib
RUN npm install --unsafe-perm
RUN npm run build
RUN mkdir -p $HOME/.solid/
WORKDIR /scripts
CMD ["./set_perms.sh" , "&&", "sleep", "infinity"]