# -------------------------
# Stage 1: Dependencies
# -------------------------
FROM node:18-alpine AS deps
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# -------------------------
# Stage 2: Build
# -------------------------
FROM node:18-alpine AS build
WORKDIR /app

# Copy dependencies from deps stage
COPY --from=deps /app/node_modules ./node_modules

# Copy the rest of the frontend code
COPY . ./

# Copy .env file if exists
#COPY .env .env

# Build React app
RUN npm run build

# -------------------------
# Stage 3: Runtime
# -------------------------
FROM nginx:alpine AS runtime

# Copy built files to Nginx
COPY --from=build /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (you can map to 3000 externally if needed)
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
