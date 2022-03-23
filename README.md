# nix Flake for Blazegraph

## About


this flake provides some convinience methods
to interoperate and run the [Blazegraph™ DB](https://dumps.wikimedia.org/wikidatawiki/entities/latest-all.ttl.bz2)

start Blazegraph:

```
nix run github.com:bastiion/nix-blazegraph.git#startBlazegraph
```

bootstrap blazegraph with some data from `example.ttl`:


```
nix run github.com:bastiion/nix-blazegraph.git#bootstrapBlazegraph example.ttl
```

## Non nix environment

using docker:

```
docker run -ti -v ./:/nix/ -p 9999:9999 johannesloetzsch/nix-flake nix run github.com:bastiion/nix-blazegraph.git
```
