FROM elixir:1.5 AS build
COPY . /build
WORKDIR /build
ENV MIX_ENV=prod
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix release --env=prod

FROM debian:jessie-slim
WORKDIR /run
COPY --from=build /build/_build/prod/rel/my_app .
ENV REPLACE_OS_VARS=true
ENV NODE_NAME=my_app
ENTRYPOINT ["/run/bin/my_app", "foreground"]
