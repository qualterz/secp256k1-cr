require "../lib_secp256k1"
require "./util"

module Secp256k1
  class Context
    enum Type
      None

      def into_flag
        case self
        when Type::None
          LibSecp256k1::SECP256K1_CONTEXT_NONE
        else
          raise "Unsupported context type."
        end
      end
    end

    enum RandomizationResult
      Error   = 0
      Success = 1
    end

    RANDOM_SEED_SIZE = 32
  end

  class Context
    @internal_context : LibSecp256k1::Secp256k1Context

    def initialize
      @internal_context = LibSecp256k1.secp256k1_context_create(Type::None.into_flag)

      result = LibSecp256k1.secp256k1_context_randomize(
        @internal_context,
        Util.random_bytes(RANDOM_SEED_SIZE)
      )

      unless result == RandomizationResult::Success.value
        raise "Failed to randomize context."
      end
    end

    def finalize
      LibSecp256k1.secp256k1_context_destroy @internal_context
    end
  end
end
