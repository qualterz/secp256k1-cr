require "../lib_secp256k1"

module Secp256k1
  class XOnlyPublicKey
    SERIALZIED_SIZE = 32
  end

  class XOnlyPublicKey
    @wrapped_context : LibSecp256k1::Secp256k1Context
    @wrapped_xonly_public_key : LibSecp256k1::Secp256k1XonlyPubkey

    def initialize(@wrapped_context, @wrapped_xonly_public_key)
    end

    def bytes : Bytes
      @wrapped_xonly_public_key.data.to_slice
    end

    def serialize
      Bytes.new(SERIALZIED_SIZE).tap do |bytes|
        LibSecp256k1.secp256k1_xonly_pubkey_serialize(
          @wrapped_context,
          bytes,
          pointerof(@wrapped_xonly_public_key)
        )
      end
    end
  end
end
