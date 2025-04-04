# Temel imaj olarak .NET SDK kullan
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Çalışma dizinini ayarla
WORKDIR /app

# Proje dosyalarını kopyala
COPY . .

RUN dotnet publish -c Release --property:PublishDir=/out
# RUN dotnet publish -c Release -o /out
# Çalıştırılabilir imaj oluştur
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out .

# Uygulamayı başlat
ENTRYPOINT ["dotnet", "demo-mvc.dll"]