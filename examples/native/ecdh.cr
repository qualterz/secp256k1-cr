require "../shared"

require "./ec"

context = LibSecp256k1.secp256k1_context_create(LibSecp256k1::SECP256K1_CONTEXT_NONE)

unless LibSecp256k1.secp256k1_context_randomize(context, randomness)
  abort "Failed to randomize context"
end

def create_shared_secret(context, public_key, secret_key)
  shared_secret = Bytes.new(32)

  unless LibSecp256k1.secp256k1_ecdh(
           context,
           shared_secret,
           pointerof(public_key),
           secret_key,
           nil, nil
         )
    abort "Failed to create shared secret"
  end

  puts "Shared Secret: #{shared_secret.hexstring}"

  return shared_secret
end

LibSecp256k1.secp256k1_context_destroy context
