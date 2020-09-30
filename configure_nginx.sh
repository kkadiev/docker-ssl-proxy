PORT=${PORT:-443}
TARGET_HOST=${TARGET_HOST:-proxyapp}
TARGET_PORT=${TARGET_PORT:-80}
TARGET_PATH=${TARGET_PATH:-.}

echo "Starting Proxy: $PORT"
echo "Target Docker Port: $TARGET_PORT"

cat nginx.conf.template | \
    sed "s|{{listenPort}}|$PORT|g" | \
    sed "s|{{targetHost}}|$TARGET_HOST|g" | \
    sed "s|{{targetPath}}|$TARGET_PATH|g" | \
    sed "s|{{targetPort}}|$TARGET_PORT|g" > /etc/nginx/nginx.conf

# Use exec so nginx can get signals directly
exec nginx
echo "Something Broke!"
