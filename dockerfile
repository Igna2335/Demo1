# Etapa 1: Construir la aplicación
FROM node:18-alpine AS build

# Establecer directorio de trabajo
WORKDIR /app

# Copiar los archivos package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar todo el proyecto
COPY . .

# Construir la aplicación para producción
RUN npm run build

# Etapa 2: Servir la aplicación
FROM nginx:alpine

# Copiar los archivos generados de la carpeta 'build' a Nginx
COPY --from=build /app/.next /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Arrancar Nginx
CMD ["nginx", "-g", "daemon off;"]
