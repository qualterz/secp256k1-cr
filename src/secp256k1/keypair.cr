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
    @wrapped_context : LibSecp256k1::Secp256k1Context
    @wrapped_keypair : LibSecp256k1::Secp256k1Keypair

    def initialize(@wrapped_context, @wrapped_keypair)
    end

    def bytes : Bytes
      @wrapped_keypair.data.to_slice
    end

    def secret_key_bytes : Bytes
      Bytes.new(SECRET_KEY_SIZE).tap { |bytes|
        LibSecp256k1.secp256k1_keypair_sec(
          @wrapped_context,
          bytes,
          pointerof(@wrapped_keypair)
        )
      }
    end
  end

  class Context
    def generate_keypair
      wrapped_keypair = LibSecp256k1::Secp256k1Keypair.new

      loop {
        result = LibSecp256k1.secp256k1_keypair_create(
          @wrapped_context,
          pointerof(wrapped_keypair),
          Util.random_bytes(Keypair::SECRET_KEY_SIZE)
        )

        break if result == Keypair::CreationResult::Valid.value
      }

      Keypair.new(@wrapped_context, wrapped_keypair)
    end
  end
end
