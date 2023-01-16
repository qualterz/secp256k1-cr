require "../lib_secp256k1"
require "./util"

module Secp256k1
  class XOnlyPublicKey
    @wrapped_context : LibSecp256k1::Secp256k1Context
    @wrapped_xonly_public_key : LibSecp256k1::Secp256k1XonlyPubkey

    def initialize(@wrapped_context, @wrapped_xonly_public_key)
    end

    def bytes : Bytes
      @wrapped_xonly_public_key.data.to_slice
    end
  end
end
