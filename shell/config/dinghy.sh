if command -v docker-machine >/dev/null 2>&1; then
  docker() {
    if [ -z "$DOCKER_HOST" ]; then
      eval "$(dinghy shellinit)"
    fi

    command docker "$@"
  }

  docker-compose() {
    if [ -z "$DOCKER_HOST" ]; then
      eval "$(dinghy shellinit)"
    fi

    command docker-compose "$@"
  }
fi
