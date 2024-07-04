# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./ci_cd/ci_cd.csproj" --disable-parallel
RUN dotnet publish "./ci_cd/ci_cd.csproj" -c release -o /app --no-restore

# Publish stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app .

EXPOSE 5272
ENTRYPOINT ["dotnet", "ci_cd.dll"]
