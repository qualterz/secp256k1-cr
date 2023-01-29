require "../lib_secp256k1"

module Secp256k1
  class Context
    RANDOM_SEED_SIZE = 32
  end

  class Context
    @wrapped_context : LibSecp256k1::Secp256k1Context

    @random : Random

    def initialize(@wrapped_context, @random)
    end

    def initialize(@random)
      @wrapped_context = LibSecp256k1.secp256k1_context_create(LibSecp256k1::SECP256K1_CONTEXT_NONE)

      result = LibSecp256k1.secp256k1_context_randomize(
        @wrapped_context,
        @random.random_bytes(RANDOM_SEED_SIZE)
      )

      if result == Result::Wrong.value
        raise Error.new "Failed to randomize context"
      end
    end

    def finalize
      LibSecp256k1.secp256k1_context_destroy @wrapped_context
    end
  end
end
