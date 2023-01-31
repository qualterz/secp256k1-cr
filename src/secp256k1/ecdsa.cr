require "../lib_secp256k1"
require "./types"

module Secp256k1
  class Ecdsa
    @wrapped_ecdsa : LibSecp256k1::Secp256k1EcdsaSignature

    def initialize(@wrapped_ecdsa)
    end

    def bytes : Bytes
      @wrapped_ecdsa.data.to_slice
    end
  end

  class Keypair
    def ecdsa_sign(message : Bytes) : Ecdsa
      if LibSecp256k1.secp256k1_ecdsa_sign(
        @wrapped_context,
        out ecdsa_out,
        message,
        secret_key_bytes,
        nil, nil
      ) == Result::Wrong.value
        raise Error.new "Failed to create ECDSA signature"
      end

      Ecdsa.new(ecdsa_out)
    end
  end
end
