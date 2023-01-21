require "./shared"
require "openssl"

context = Secp256k1::Context.new
keypair = context.generate_keypair

puts "Keypair hex: #{keypair.bytes.hexstring}"

keypair_secret_key = keypair.secret_key_bytes

puts "Keypair secret key: #{keypair_secret_key.hexstring}"

keypair_public_key = keypair.public_key.bytes

puts "Keypair public key: #{keypair_public_key.hexstring}"

keypair_xonly_public_key = keypair.xonly_public_key.bytes

puts "Keypair XOnly public key: #{keypair_xonly_public_key.hexstring}"

message_to_sign = OpenSSL::Digest.new("SHA256").update("Hello, crypto!").final
signature_bytes = keypair.schnorr_sign(message_to_sign)

puts "Schnorr signature: #{signature_bytes.hexstring}"