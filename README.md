# Develop Node applications without installing Node

Lightweight Dev-Container-Like solution for local Node development with simple scripts.

You do not need to install Node.JS on your computer. Instead, run Node applications in a Docker container using convenient wrapper scripts.

## Requirements

* Docker
* Docker Compose

## Setup

1. Ensure the scripts are executable:
```bash
chmod +x npm npx npm-stop-dev
```

2. (Optional) Add the current directory to your `$PATH` for easier access:
```bash
export PATH="$PWD:$PATH"
```

## Usage

### Using npm

Instead of installing Node locally and running commands like:
```bash
npm create vite@latest
```

Use the provided `npm` script to run npm inside a Docker container:
```bash
./npm create vite@latest
```

### Using npx

Run any npm package directly without global installation:
```bash
./npx create-react-app my-app
./npx eslint src/
```

### Common Examples

```bash
# Create a new project
./npm create vite@latest my-project

# Install dependencies
./npm install

# Run development server
./npm run dev

# Run build
./npm run build

# Use ESLint
./npx eslint src/

# Use Prettier
./npx prettier --write src/
```

## How It Works

- The scripts check if a Docker container is already running
- If not, the container is started in the background with `docker compose up -d`
- Your current directory is mounted as `/src` inside the container
- Files created by npm will have correct ownership (not root-owned)
- Port 3000 is exposed for development servers
- Node environment is set to `development`

## Stopping the Container

When you're done developing, stop the container:
```bash
./npm-stop-dev
```

This stops the background container but keeps it available for quick restart.

## Cleaning Up

To completely remove the container:
```bash
docker compose down
```

To remove the container and all volumes:
```bash
docker compose down -v
```

## Troubleshooting

**"Permission denied" error when running scripts:**
```bash
chmod +x npm npx npm-stop-dev
```

**Container fails to start:**
- Ensure Docker daemon is running
- Check Docker compose version: `docker compose --version` (requires Docker Compose V2)

**Files created inside container have wrong permissions:**
- The setup uses `user: "${UID}:${GID}"` to ensure correct ownership
- If issues persist, try: `docker compose down && rm .env`

**Node modules taking too much disk space:**
- Node modules are stored in your local directory (mounted in container)
- Use `.dockerignore` or `.gitignore` to exclude them if needed

## Container Details

- **Base Image:** Node 24 LTS (slim variant)
- **Working Directory:** `/src` (mounted from your local directory)
- **Environment:** `NODE_ENV=development`
- **Port Mapping:** 3000:3000 (for dev servers)