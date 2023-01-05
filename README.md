# secp256k1

Bindings for Bitcoin Core implementation of [secp256k1](https://github.com/bitcoin-core/secp256k1) library.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     secp256k1:
       github: qualterz/secp256k1-cr
   ```

2. Run `shards install`

3. Ensure that secp256k1 library is installed on system

## Usage

```crystal
require "secp256k1"
```

- Native bindings. See [native examples](/examples/native/).
- Crystal wrapper. See [wrapper examples](/examples/wrapper).

## Documentation

In case of using native bindings, original examples and documentation can be used for reference.

## Development

The bindings are generated automatically by executing `make generate_lib` shell command.

## Contributing

1. Fork it (<https://github.com/qualterz/secp256k1-cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [qualterz](https://github.com/your-github-user) - creator and maintainer
