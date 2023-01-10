require "../lib_secp256k1"

module Secp256k1
  class Context
    inner_context : LibSecp256k1::Secp256k1Context

    def initialize
      @inner_context = LibSecp256k1.secp256k1_context_create(LibSecp256k1::SECP256K1_CONTEXT_NONE)

      randomness = Random.new.random_bytes(32)

      unless LibSecp256k1.secp256k1_context_randomize(@inner_context, randomness) == 1
        raise "Failed to randomize context"
      end
    end

    def finalize
      LibSecp256k1.secp256k1_context_destroy @inner_context
    end
  end
end
