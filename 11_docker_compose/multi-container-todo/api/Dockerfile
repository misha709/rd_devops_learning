FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /app

COPY ./api/Api.csproj ./
RUN dotnet restore

COPY ./api .
RUN dotnet publish -c Release -o /app/output

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
EXPOSE 8080

COPY --from=build /app/output .

ENTRYPOINT [ "dotnet", "Api.dll" ]