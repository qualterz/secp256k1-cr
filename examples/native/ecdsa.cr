require "../shared"

def create_ecdsa_signature(context, message, secret_key)
  signature = LibSecp256k1::Secp256k1EcdsaSignature.new

  unless LibSecp256k1.secp256k1_ecdsa_sign(
           context,
           pointerof(signature),
           message,
           secret_key,
           nil,
           nil
         )
    abort "Failed to create ECDSA signature"
  end

  puts "ECDSA Signature Raw: #{signature.data.to_slice.hexstring}"

  serialized_signature = Bytes.new(64)

  unless LibSecp256k1.secp256k1_ecdsa_signature_serialize_compact(
           context,
           serialized_signature,
           pointerof(signature)
         )
    abort "Failed to serialize ECDSA signature"
  end

  puts "ECDSA Signature Serialized: #{serialized_signature.hexstring}"

  return {signature, serialized_signature}
end

def verify_ecdsa_signature(context, signature, message, public_key)
  unless LibSecp256k1.secp256k1_ecdsa_verify(
           context,
           pointerof(signature),
           message,
           pointerof(public_key)
         )
    puts "ECDSA Signature Verification Failed"

    return false
  end

  puts "ECDSA Signature Verified"
  
  return true
end
