# Temel imaj olarak .NET SDK kullan
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Çalışma dizinini ayarla
WORKDIR /app

# Proje dosyalarını kopyala
COPY *.csproj ./
RUN dotnet restore

# Uygulama dosyalarını kopyala
COPY . ./
RUN dotnet publish -c Release -o out

# Çalıştırılabilir imaj oluştur
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Uygulamayı başlat
ENTRYPOINT ["dotnet", "demo-mvc.dll"]