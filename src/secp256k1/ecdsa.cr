require "../lib_secp256k1"
require "./common"

module Secp256k1
  class Ecdsa
    @wrapped_context : LibSecp256k1::Secp256k1Context
    @wrapped_ecdsa : LibSecp256k1::Secp256k1EcdsaSignature

    def initialize(@wrapped_context, @wrapped_ecdsa)
    end

    def bytes : Bytes
      @wrapped_ecdsa.data.to_slice
    end

    def verify(message_hash : Bytes, public_key : PublicKey) : Bool
      LibSecp256k1.secp256k1_ecdsa_verify(
        @wrapped_context,
        pointerof(@wrapped_ecdsa),
        message_hash,
        pointerof(public_key.@wrapped_public_key)
      ) == Result::Correct.value
    end
  end

  class Keypair
    def ecdsa_sign(message_hash : Bytes) : Ecdsa
      if LibSecp256k1.secp256k1_ecdsa_sign(
           @wrapped_context,
           out ecdsa_out,
           message_hash,
           secret_key_bytes,
           nil, nil
         ) == Result::Wrong.value
        raise Error.new "Secret key is invalid"
      end

      Ecdsa.new(@wrapped_context, ecdsa_out)
    end

    def ecdsa_verify(ecdsa : Ecdsa, message_hash : Bytes)
      ecdsa.verify(message_hash, public_key)
    end
  end

  class PublicKey
    def ecdsa_verify(ecdsa : Ecdsa, message_hash : Bytes)
      ecdsa.verify(message_hash, self)
    end
  end
end
