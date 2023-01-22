require "../lib_secp256k1"
require "./error"
require "./util"

module Secp256k1
  class PublicKey
    SECRET_KEY_SIZE = 32

    enum CreationResult
      Invalid = 0
      Valid   = 1
    end
  end

  class PublicKey
    @wrapped_context : LibSecp256k1::Secp256k1Context
    @wrapped_public_key : LibSecp256k1::Secp256k1Pubkey

    def initialize(@wrapped_context, @wrapped_public_key)
    end

    def bytes : Bytes
      @wrapped_public_key.data.to_slice
    end
  end

  class Context
    def public_key_create(secret_key : Bytes)
      wrapped_public_key_instance = LibSecp256k1::Secp256k1Pubkey.new

      result = LibSecp256k1.secp256k1_ec_pubkey_create(
        @wrapped_context,
        pointerof(wrapped_public_key_instance),
        secret_key
      )

      unless result == PublicKey::CreationResult::Valid.value
        raise Error.new "Secret key is invalid"
      end

      PublicKey.new(@wrapped_context, wrapped_public_key_instance)
    end
  end
end
