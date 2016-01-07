if command -v docker-machine >/dev/null 2>&1; then
  docker() {
    if [ -z "$DOCKER_HOST" ]; then
      eval "$(docker-machine env default)"
    fi

    command docker "$@"
  }
fi
