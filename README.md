# Pocketbase Docker Deployment Guide

## Table of Contents

1. [Introduction](#introduction)
2. [Dockerfile Explained](#dockerfile-explained)
3. [Docker Compose Explained](#docker-compose-explained)
4. [Running the Application](#running-the-application)
5. [Conclusion](#conclusion)

## Introduction

Docker provides a simple and effective way to package and distribute software across different environments. This README explains how to set up and run the Pocketbase application using Docker.

## Dockerfile Explained

The Dockerfile is a multi-stage build file:

### Build Stage (`build-backend`):

- **Base Image**: We start with the `golang:1.21` image, providing a Go development environment.
- **App Directory**: A directory `/app` in the image is created for the source code.
- **Binary Compilation**: The Go code is compiled into a binary called `pb-build`. It's statically compiled, ensuring it runs on the lightweight Alpine base without external dependencies.

### Production Stage (`production`):

- **Base Image**: We switch to the `alpine:latest` image for a lightweight and secure container.
- **Copying the Binary**: The compiled `pb-build` binary is copied from the build-backend stage.
- **CMD Instruction**: The default command runs the application and exposes it on port 8080.

## Docker Compose Explained

Docker Compose allows us to define multi-container Docker applications for the Pocketbase app:

- **Service Name**: The service is named `pocketbase-app`.
- **Container Name**: The container is explicitly named `pocketbase-app`.
- **Build Context**: The current directory (`.`) is the build context, using the specified Dockerfile.
- **Port Mapping**: Port 8080 of the host machine is mapped to port 8080 of the container.
- **Volume Mount**: A local directory named `data` is mounted to `/pb_data` inside the container, ensuring data persistence.

## Running the Application

1. Install Docker and Docker Compose.
2. Navigate to the directory with the Dockerfile and docker-compose.yml.
3. Execute:
   ```bash
   docker-compose up
   ```
   After a few moments, the Pocketbase app should be accessible at http://localhost:8080.

## Conclusion

With Docker and Docker Compose, deploying the Pocketbase application becomes a streamlined process, ensuring consistent behavior across various environments. This setup provides an easy-to-understand and replicable deployment procedure for the Pocketbase app.
