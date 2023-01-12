module Secp256k1
  module Util
    extend self

    def random_bytes(size)
      Bytes.new(size).tap { |bytes|
        Random::Secure.random_bytes(bytes)
      }
    end
  end
end
