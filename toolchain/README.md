# Happy OS toolchain

## Cross compiler

Run `./build-cross.sh`. You will be asked for a destination directory. The default will work in most cases.

You should end up with a collection of utilities prefixed with `x86_64-elf-`. The tools include:

- `gcc`
- `gas`
- `ld`
- `objdump`

and more.

## Bochs

If you plan to use bochs for debugging, the `./build-bochs.sh` script will assist you.
