FROM node:8
WORKDIR /usr/src/app
COPY . .
#COPY package*.json ./
RUN npm install
#RUN npm audit
#RUN npm audit fix 
EXPOSE 3023
CMD [ "npm", "start" ]
