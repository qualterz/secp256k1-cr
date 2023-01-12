module Secp256k1
  module Util
    extend self

    def random_bytes(size)
      bytes = Bytes.new(size)
      Random::Secure.random_bytes(bytes)
      return bytes
    end
  end
end
