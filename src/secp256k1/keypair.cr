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
    class Error < Exception
    end
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

    def public_key
      wrapped_public_key_instance = LibSecp256k1::Secp256k1Pubkey.new

      LibSecp256k1.secp256k1_keypair_pub(
        @wrapped_context,
        pointerof(wrapped_public_key_instance),
        pointerof(@wrapped_keypair)
      )

      PublicKey.new(@wrapped_context, wrapped_public_key_instance)
    end
  end

  class Context
    def keypair_from(bytes : Bytes)
      wrapped_keypair_instance = LibSecp256k1::Secp256k1Keypair.new

      result = LibSecp256k1.secp256k1_keypair_create(
        @wrapped_context,
        pointerof(wrapped_keypair_instance),
        bytes
      )

      unless result == Keypair::CreationResult::Valid.value
        raise Keypair::Error.new "Secret key is invalid"
      end

      Keypair.new(@wrapped_context, wrapped_keypair_instance)
    end

    def generate_keypair
      secret_key = Util.random_bytes(Keypair::SECRET_KEY_SIZE)

      begin
        return keypair_from secret_key
      rescue
        raise Keypair::Error.new "Failed to generate keypair"
      end
    end
  end
end
