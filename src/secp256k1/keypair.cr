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
    @internal_context : LibSecp256k1::Secp256k1Context
    @internal_keypair : LibSecp256k1::Secp256k1Keypair

    def initialize(@internal_context, @internal_keypair)
    end

    def bytes : Bytes
      @internal_keypair.data.to_slice
    end

    def secret_key_bytes : Bytes
      Bytes.new(SECRET_KEY_SIZE).tap { |bytes|
        LibSecp256k1.secp256k1_keypair_sec(
          @internal_context,
          bytes,
          pointerof(@internal_keypair)
        )
      }
    end
  end

  class Context
    def generate_keypair
      internal_keypair = LibSecp256k1::Secp256k1Keypair.new

      loop {
        result = LibSecp256k1.secp256k1_keypair_create(
          @internal_context,
          pointerof(internal_keypair),
          Util.random_bytes(Keypair::SECRET_KEY_SIZE)
        )

        break if result == Keypair::CreationResult::Valid.value
      }

      Keypair.new(@internal_context, internal_keypair)
    end
  end
end
