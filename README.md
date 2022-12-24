# secp256k1

Crystal bindings for the Bitcoin Core implementation of [secp256k1](https://github.com/bitcoin-core/secp256k1) library.

## Prerequisites

Applications that using these bindings must have access to the installed `libsecp256k1` library.

Since these bindings are designed for the Bitcoin Core implementation, there is no guarantee of working with others.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     secp256k1:
       github: qualterz/secp256k1.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "secp256k1"
```

- Native bindings. See [native examples](/examples/native/).
- Crystal wrapper. See [wrapper examples](/examples/wrapper.cr).

## Documentation

In case of using native bindings, original [examples](https://github.com/bitcoin-core/secp256k1/tree/master/examples) and [documentation](https://github.com/bitcoin-core/secp256k1/blob/master/README.md) can be used for reference.

Deprecated library functions will not be wrapped, so if there is need to use them, they can be used natively.

## Development

The bindings are generated automatically by executing `make generate_lib` shell command.

The [libgen](https://github.com/olbat/libgen) is used as a bindings generator.

## Contributing

1. Fork it (<https://github.com/qualterz/secp256k1.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [qualterz](https://github.com/your-github-user) - creator and maintainer
