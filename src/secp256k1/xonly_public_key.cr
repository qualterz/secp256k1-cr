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

    def serialize : Bytes
      Bytes.new(SERIALZIED_SIZE).tap do |bytes|
        LibSecp256k1.secp256k1_xonly_pubkey_serialize(
          @wrapped_context,
          bytes,
          pointerof(@wrapped_xonly_public_key)
        )
      end
    end
  end

  class Context
    def xonly_public_key_parse(xonly_public_key : Bytes) : XOnlyPublicKey
      if LibSecp256k1.secp256k1_xonly_pubkey_parse(
        @wrapped_context,
        out xonly_public_key_out,
        xonly_public_key
      ) == Result::Wrong.value
        raise Error.new "Public key could not be parsed or invalid"
      end

      XOnlyPublicKey.new(@wrapped_context, xonly_public_key_out)
    end
  end
end
