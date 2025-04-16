# Step 1: Build the Go app
FROM golang:1.24 AS base 

WORKDIR /app

COPY go.mod .
RUN go mod download

COPY . .

RUN go build -o main .

# Step 2: Use a lightweight distroless image for production
FROM gcr.io/distroless/base

WORKDIR /

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
