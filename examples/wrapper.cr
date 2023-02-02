require "./shared"
require "openssl"

context = Secp256k1::Context.new Random.new(1337)
keypair = context.keypair_generate

puts "Keypair hex: #{keypair.bytes.hexstring}"

keypair_secret_key = keypair.secret_key_bytes

puts "Keypair secret key: #{keypair_secret_key.hexstring}"

keypair_public_key = keypair.public_key.bytes

puts "Keypair public key: #{keypair_public_key.hexstring}"

keypair_xonly_public_key = keypair.xonly_public_key.bytes

puts "XOnly public key: #{keypair_xonly_public_key.hexstring}"

xonly_public_key_serialized = keypair.xonly_public_key.serialize

puts "XOnly public key serialized: #{xonly_public_key_serialized.hexstring}"

xonly_public_key_parsed = context.xonly_public_key_parse xonly_public_key_serialized

puts "XOnly public key parsed: #{xonly_public_key_parsed.bytes.hexstring}"

message_hash = OpenSSL::Digest.new("SHA256").update("Hello, crypto!").final
signature_bytes = keypair.schnorr_sign(message_hash)

puts "Schnorr signature: #{signature_bytes.hexstring}"

signature_verified = keypair.schnorr_verify(signature_bytes, message_hash)

puts "Schnorr signature verification: #{signature_verified}"

public_key_serialized = keypair.public_key.serialize

puts "Public key serialized: #{public_key_serialized.hexstring}"
puts "Public key serialized and compressed: #{keypair.public_key.serialize_compressed.hexstring}"

public_key_parsed = context.public_key_parse(public_key_serialized)

puts "Public key parsed: #{public_key_parsed.bytes.hexstring}"

public_key_another = context.keypair_generate.public_key

puts "Public key another: #{public_key_another.bytes.hexstring}"

public_keys = Array.new(4) { |index|
  context.keypair_generate.public_key.tap { |public_key|
    puts "Public key #{index}: #{public_key.bytes.hexstring}"
  }
}

public_key = public_key_another.combine(public_keys)

puts "Public key combined: #{public_key.bytes.hexstring}"

shared_secret = public_key_another.ecdh keypair.secret_key_bytes

puts "Shared secret: #{shared_secret.hexstring}"

ecdsa = keypair.ecdsa_sign(message_hash)

puts "Ecdsa signature: #{ecdsa.bytes.hexstring}"

ecdsa_verified = keypair.ecdsa_verify ecdsa, message_hash

puts "Ecdsa signature verification: #{ecdsa_verified}"