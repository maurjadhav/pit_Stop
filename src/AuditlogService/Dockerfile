FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy necessary files and restore as distinct layer
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
RUN dotnet publish -c Release  AuditlogService.csproj -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Start
ENTRYPOINT ["dotnet"]
CMD [ "Pitstop.AuditlogService.dll" ]