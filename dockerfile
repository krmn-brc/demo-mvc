# Temel imaj olarak .NET SDK kullan
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

# Çalışma dizinini ayarla
WORKDIR /app

# Proje dosyalarını kopyala
COPY . .

RUN dotnet publish -c Release --property:PublishDir=/out
# RUN dotnet publish -c Release -o /out
# Çalıştırılabilir imaj oluştur
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /out .

# Uygulamayı başlat
ENTRYPOINT ["dotnet", "demo-mvc.dll"]