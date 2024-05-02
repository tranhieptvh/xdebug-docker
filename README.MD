## Installing and Using Xdebug with Docker

### Step 1: Select version xdebug (2|3)
- ./docker/Dockerfile
- ./docker/php/xdebug.ini

### Step 2: Configure Virtual Host

#### 2.1. Change params in ./docker/nginx/default.conf

#### 2.2. Add a virtual host entry to your hosts file:

```bash
sudo nano /etc/hosts
```

Add row:
```
127.0.0.1   xdebug-docker.local
```

### Step 3: Build & Run Docker

```bash
make build
make up
```

### Step 4: Config PHPStorm

#### 4.1. Add Server

- File -> Settings -> PHP -> Servers -> Add
   - Server name: `xdebug-docker` (or any other name)
   - Host name: `xdebug-docker.local` (domain in /etc/hosts)
   - Check "Use path mapping"
   - Enter `Absolute path on the server`: /var/www/html (folder mounted - /server)

#### 4.2. Config debugger

- Run -> Edit Configurations -> Add -> PHP Remote Debug
- Check "Filter debug connection by IDE key"
- Server:  `xdebug-docker`
- IDE key: `PHPSTORM`
- OK

