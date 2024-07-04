# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS base
WORKDIR /app

# Publish stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS publish
WORKDIR /app
COPY --from=base /app/ci_cd/obj/Docker/publish /app/publish

# Final stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
EXPOSE 5272
ENTRYPOINT ["dotnet", "ci_cd.dll"]
