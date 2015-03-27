if command -v boot2docker >/dev/null 2>&1; then
  docker() {
    if [ -z "$DOCKER_HOST" ]; then
      `boot2docker shellinit`
    fi

    command docker "$@"
  }
fi
