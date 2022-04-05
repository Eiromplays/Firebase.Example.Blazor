FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Firebase.Realtime.Blazor.Example.csproj", "./"]
RUN dotnet restore "Firebase.Realtime.Blazor.Example.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "Firebase.Realtime.Blazor.Example.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Firebase.Realtime.Blazor.Example.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Firebase.Realtime.Blazor.Example.dll"]
