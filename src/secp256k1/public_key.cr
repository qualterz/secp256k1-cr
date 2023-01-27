require "../lib_secp256k1"
require "./error"

module Secp256k1
  class PublicKey
    SECRET_KEY_SIZE = 32

    PUBLIC_KEY_SERIALIZED_SIZE            = 65_u64
    PUBLIC_KEY_SERIALIZED_COMPRESSED_SIZE = 33_u64

    enum CreationResult
      Invalid = 0
      Valid   = 1
    end

    enum ParseResult
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

    def serialize
      serialize(
        PUBLIC_KEY_SERIALIZED_SIZE,
        LibSecp256k1::SECP256K1_EC_UNCOMPRESSED
      )
    end

    def serialize_compressed
      serialize(
        PUBLIC_KEY_SERIALIZED_COMPRESSED_SIZE,
        LibSecp256k1::SECP256K1_EC_COMPRESSED
      )
    end

    def serialize(size, flags)
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

    def public_key_parse(public_key : Bytes)
      wrapped_public_key_instance = LibSecp256k1::Secp256k1Pubkey.new

      result = LibSecp256k1.secp256k1_ec_pubkey_parse(
        @wrapped_context,
        pointerof(wrapped_public_key_instance),
        public_key,
        public_key.size
      )

      unless result == PublicKey::ParseResult::Valid.value
        raise Error.new "Public key is invalid"
      end

      PublicKey.new(@wrapped_context, wrapped_public_key_instance)
    end
  end
end
