# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Restore and build
COPY app/* /app/
RUN dotnet restore /app
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "PaymentAPI.dll"]