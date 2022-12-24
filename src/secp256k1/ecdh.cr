require "../lib_secp256k1"
require "./common"

module Secp256k1
  class PublicKey
    def ecdh(secret_key : Bytes) : Bytes
      Bytes.new(SECRET_KEY_SIZE).tap do |secret|
        if LibSecp256k1.secp256k1_ecdh(
             @wrapped_context,
             secret,
             pointerof(@wrapped_public_key),
             secret_key,
             nil, nil
           ) == Result::Wrong.value
          raise Error.new "Scalar is invalid (zero or overflow)"
        end
      end
    end
  end
end
