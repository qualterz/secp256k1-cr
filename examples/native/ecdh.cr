require "../shared"

context = LibSecp256k1.secp256k1_context_create(LibSecp256k1::SECP256K1_CONTEXT_NONE)

unless LibSecp256k1.secp256k1_context_randomize(context, randomness)
  abort "Failed to randomize context"
end

def create_keys(context)
  secret_key = loop {
    value = randomness
    verified = LibSecp256k1.secp256k1_ec_seckey_verify context, value
    break value if verified
  }

  puts "Secret Key: #{secret_key.hexstring}"

  public_key = LibSecp256k1::Secp256k1Pubkey.new

  unless LibSecp256k1.secp256k1_ec_pubkey_create(context, pointerof(public_key), secret_key)
    abort "Failed to create public key"
  end

  puts "Public Key Raw: #{public_key.data.to_slice.hexstring}"

  compressed_public_key = Bytes.new(33)
  size = compressed_public_key.size.to_u64

  unless LibSecp256k1.secp256k1_ec_pubkey_serialize(context, compressed_public_key, pointerof(size), pointerof(public_key), LibSecp256k1::SECP256K1_EC_COMPRESSED)
    abort "Failed to serialize public key"
  end

  puts "Public Key Serialized: #{compressed_public_key.hexstring}"

  return {secret_key, public_key, compressed_public_key}
end

first_secret_key, first_public_key, first_compressed_public_key = create_keys context
second_secret_key, second_public_key, second_compressed_public_key = create_keys context

def create_shared_secret(context, public_key, secret_key)
  shared_secret = Bytes.new(32)

  unless LibSecp256k1.secp256k1_ecdh(context, shared_secret, pointerof(public_key), secret_key, nil, nil)
    abort "Failed to create shared secret"
  end

  puts "Shared Secret: #{shared_secret.hexstring}"

  return shared_secret
end

first_shared_secret = create_shared_secret context, first_public_key, second_secret_key
second_shared_secret = create_shared_secret context, second_public_key, first_secret_key

LibSecp256k1.secp256k1_context_destroy context