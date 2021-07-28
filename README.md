# docker-ghcup
`aniketd/ghcup` on Docker Hub

Reusable `GHCup` image, with `cabal-install` and `haskell-langauge-server`.

Just mount your project directory with something like

```shellsession
$ docker run --rm -it --net host \
    --env-file ./.env \
    --name ghcup \
    -v `pwd`:/workdir \
    -v ~/.cabal:/root/.cabal \
    -w /workdir \
    aniketd/ghcup bash
```

and you are set -- especially on hosts like NixOS, where it is hard to get `GHCup`
to play well.

-----

P.S.:

This will always be up-to-date on Docker Hub.

```shellsession
docker pull aniketd/ghcup:latest
```
