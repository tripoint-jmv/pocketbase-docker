# Build stage
FROM golang:1.21 AS build-backend

# Create app directory
RUN mkdir /app
ADD . /app
WORKDIR /app

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -o pb-build .

# Production image
FROM alpine:latest AS production
# Copy the binary from build-backend stage
COPY --from=build-backend /app/pb-build /app/pb-build
EXPOSE 8080
CMD ["/app/pb-build", "serve", "--http=0.0.0.0:8080"]
