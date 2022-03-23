# nix Flake for Blazegraph

## About


this flake provides some convinience methods
to interoperate and run the [Blazegraph™ DB](https://dumps.wikimedia.org/wikidatawiki/entities/latest-all.ttl.bz2)

start Blazegraph:

```
nix run github:bastiion/nix-blazegraph/main#startBlazegraph
```

bootstrap blazegraph with some data from `example.ttl`:


```
nix run github:bastiion/nix-blazegraph/main#bootstrapBlazegraph example.ttl
```

info about all flake targets:
```
nix flake show github:bastiion/nix-blazegraph/main
```


## Non nix environment

using docker assuming your data is in the current working directory under `data`:

```
docker run -ti -v nix:/nix/ -v $(pwd)/data:/data -w /data -p 9999:9999 johannesloetzsch/nix-flake nix run github:bastiion/nix-blazegraph#startBlazegraph
```

