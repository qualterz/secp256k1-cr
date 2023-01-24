require "../lib_secp256k1"
require "./error"

module Secp256k1
  class Schnorr
    MESSAGE_SIZE              = 32
    SIGNATURE_SIZE            = 64
    AUXILIARY_RANDOMNESS_SIZE = 32

    enum SignResult
      Failure = 0
      Success = 1
    end

    enum VerificationResult
      Incorrect = 0
      Correct   = 1
    end
  end

  class Keypair
    def schnorr_sign(message : Bytes, auxiliary_randomness : Bytes) : Bytes
      signature = Bytes.new(Schnorr::SIGNATURE_SIZE)

      result = LibSecp256k1.secp256k1_schnorrsig_sign32(
        @wrapped_context,
        signature,
        message,
        pointerof(@wrapped_keypair),
        auxiliary_randomness
      )

      unless result == Schnorr::SignResult::Success.value
        raise Error.new "Failed to create Schnorr signature"
      end

      signature
    end

    def schnorr_sign(message : Bytes) : Bytes
      schnorr_sign message, @random.random_bytes(Schnorr::AUXILIARY_RANDOMNESS_SIZE)
    end
  end

  class XOnlyPublicKey
    def schnorr_verify(signature : Bytes, message : Bytes) : Bool
      result = LibSecp256k1.secp256k1_schnorrsig_verify(
        @wrapped_context,
        signature,
        message,
        message.size,
        pointerof(@wrapped_xonly_public_key)
      )

      result == Schnorr::VerificationResult::Correct.value
    end

    def schnorr_verify(signature : Bytes)
      result = LibSecp256k1.secp256k1_schnorrsig_verify(
        @wrapped_context,
        signature,
        nil,
        0,
        pointerof(@wrapped_xonly_public_key)
      )

      result == Schnorr::VerificationResult::Correct.value
    end
  end
end
