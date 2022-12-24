require "../lib_secp256k1"
require "./common"

module Secp256k1
  class PublicKey
    SERIALIZED_SIZE            = 65_u64
    SERIALIZED_COMPRESSED_SIZE = 33_u64
  end

  class PublicKey
    @wrapped_context : LibSecp256k1::Secp256k1Context
    @wrapped_public_key : LibSecp256k1::Secp256k1Pubkey

    def initialize(@wrapped_context, @wrapped_public_key)
    end

    def bytes : Bytes
      @wrapped_public_key.data.to_slice
    end

    def serialize : Bytes
      serialize(
        SERIALIZED_SIZE,
        LibSecp256k1::SECP256K1_EC_UNCOMPRESSED
      )
    end

    def serialize_compressed : Bytes
      serialize(
        SERIALIZED_COMPRESSED_SIZE,
        LibSecp256k1::SECP256K1_EC_COMPRESSED
      )
    end

    private def serialize(size, flags) : Bytes
      Bytes.new(size).tap { |bytes|
        LibSecp256k1.secp256k1_ec_pubkey_serialize(
          @wrapped_context,
          bytes,
          pointerof(size),
          pointerof(@wrapped_public_key),
          flags
        )
      }
    end

    def combine(public_keys : Array(PublicKey)) : PublicKey
      public_key_pointers = public_keys.map { |public_key|
        pointerof(public_key.@wrapped_public_key)
      }

      if LibSecp256k1.secp256k1_ec_pubkey_combine(
           @wrapped_context,
           out public_key_out,
           public_key_pointers.to_unsafe,
           public_key_pointers.size
         ) == Result::Wrong.value
        raise Error.new "Public key combination sum is invalid"
      end

      PublicKey.new(@wrapped_context, public_key_out)
    end
  end

  class Context
    def public_key_create(secret_key : Bytes) : PublicKey
      if LibSecp256k1.secp256k1_ec_pubkey_create(
           @wrapped_context,
           out public_key_out,
           secret_key
         ) == Result::Wrong.value
        raise Error.new "Secret key is invalid"
      end

      PublicKey.new(@wrapped_context, public_key_out)
    end

    def public_key_parse(public_key : Bytes) : PublicKey
      if LibSecp256k1.secp256k1_ec_pubkey_parse(
           @wrapped_context,
           out public_key_out,
           public_key,
           public_key.size
         ) == Result::Wrong.value
        raise Error.new "Public key is invalid"
      end

      PublicKey.new(@wrapped_context, public_key_out)
    end
  end
end
