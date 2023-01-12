require "../lib_secp256k1"

module Secp256k1
  enum ContextType
    None

    def into_flag
      case self
      when ContextType::None
        LibSecp256k1::SECP256K1_CONTEXT_NONE
      else
        LibSecp256k1::SECP256K1_CONTEXT_NONE
      end
    end
  end

  class Context
    @inner_context : LibSecp256k1::Secp256k1Context

    def initialize
      @inner_context = LibSecp256k1.secp256k1_context_create(ContextType::None.into_flag)

      unless LibSecp256k1.secp256k1_context_randomize(@inner_context, randomness(32)) == 1
        raise "Failed to randomize context"
      end
    end

    def finalize
      LibSecp256k1.secp256k1_context_destroy @inner_context
    end

    private def randomness(size)
      randomness = Bytes.new(size)
      Random::Secure.random_bytes(randomness)
      return randomness
    end
  end
end
