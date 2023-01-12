require "../lib_secp256k1"
require "./util"

module Secp256k1
  class Keypair
    enum CreationResult
      Invalid = 0
      Valid   = 1
    end

    SECRET_KEY_SIZE = 32
  end

  class Keypair
    @inner_keypair : LibSecp256k1::Secp256k1Keypair

    def initialize
      @inner_keypair = LibSecp256k1::Secp256k1Keypair.new
    end

    def initialize(@inner_keypair)
    end

    def data : Bytes
      @inner_keypair.data.to_slice
    end
  end

  class Context
    def generate_keypair
      inner_keypair = LibSecp256k1::Secp256k1Keypair.new

      loop {
        result = LibSecp256k1.secp256k1_keypair_create(
          @inner_context,
          pointerof(inner_keypair),
          Util.random_bytes(Keypair::SECRET_KEY_SIZE)
        )

        break if result == Keypair::CreationResult::Valid.value
      }

      Keypair.new(inner_keypair)
    end
  end
end
