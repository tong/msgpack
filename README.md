# msgpack

json<->msgpack

## Build

```sh
haxe build.hxml
cc -O3 -std=c11 -msse2 -mfpmath=sse -I out out/main.c -o msgpack -lhl
```

## Usage

    Usage: msgpack <file.json|file.msgpack>

