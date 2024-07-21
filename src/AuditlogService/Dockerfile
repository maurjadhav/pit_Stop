# building nop application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
#git cloning
RUN mkdir published
RUN dotnet publish  -c Release -o published/ AuditlogService.csproj

#building image for the container to run
FROM mcr.microsoft.com/dotnet/aspnet:8.0
LABEL author="practice"
LABEL description="Runs the nopCommerce application"
LABEL project="practice-nopCommerce"
# creating user and hom dir
RUN useradd -d /app -m -s /bin/bash dotnet
USER dotnet
WORKDIR /app
COPY --from=build --chown=dotnet:dotnet published/ /napp
ENTRYPOINT ["dotnet"]
CMD [ "Pitstop.AuditlogService.dll" ]