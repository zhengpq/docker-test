# # syntax=docker/dockerfile:1

# # Comments are provided throughout this file to help you get started.
# # If you need more help, visit the Dockerfile reference guide at
# # https://docs.docker.com/go/dockerfile-reference/

# ARG NODE_VERSION=18.15.0

# FROM node:${NODE_VERSION}-alpine

# # Use production node environment by default.
# ENV NODE_ENV production


# WORKDIR .

# CMD npm install

# # Download dependencies as a separate step to take advantage of Docker's caching.
# # Leverage a cache mount to /root/.npm to speed up subsequent builds.
# # Leverage a bind mounts to package.json and package-lock.json to avoid having to copy them into
# # into this layer.
# # RUN --mount=type=bind,source=package.json,target=package.json \
# #     --mount=type=bind,source=package-lock.json,target=package-lock.json \
# #     --mount=type=cache,target=/root/.npm \
# #     npm ci --omit=dev

# # Run the application as a non-root user.
# USER node

# # Copy the rest of the source files into the image.
# # COPY . .

# # Expose the port that the application listens on.
# EXPOSE 8000

# # Run the application.
# CMD npm run dev

FROM node:18.15.0

EXPOSE 8001

# 先安装npm依赖，因为源代码变更很频繁
COPY package.json /
# COPY package-lock.json /
RUN npm install

# 安装 PM2
RUN npm install pm2 -g

COPY . /

# 设置环境变量
ARG APP_PORT
ENV APP_PORT=$app_port

#CMD ["node", "main.js"]
CMD ["pm2-runtime", "./ecosystem.config.js", "--env production"]