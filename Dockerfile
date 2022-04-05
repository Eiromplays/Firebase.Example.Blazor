FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Firebase.Realtime.BlazorServer.Example/Firebase.Realtime.BlazorServer.Example.csproj", "Firebase.Realtime.BlazorServer.Example/"]
RUN dotnet restore "Firebase.Realtime.BlazorServer.Example/Firebase.Realtime.BlazorServer.Example.csproj"
COPY . .
WORKDIR "/src/Firebase.Realtime.BlazorServer.Example"
RUN dotnet build "Firebase.Realtime.BlazorServer.Example.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Firebase.Realtime.BlazorServer.Example.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Firebase.Realtime.BlazorServer.Example.dll"]
