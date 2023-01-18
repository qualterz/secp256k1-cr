require "./shared"

context = Secp256k1::Context.new
keypair = context.generate_keypair

puts "Keypair hex: #{keypair.bytes.hexstring}"

keypair_secret_key = keypair.secret_key_bytes

puts "Keypair secret key: #{keypair_secret_key.hexstring}"

keypair_public_key = keypair.public_key.bytes

puts "Keypair public key: #{keypair_public_key.hexstring}"

keypair_xonly_public_key = keypair.xonly_public_key.bytes

puts "Keypair XOnly public key: #{keypair_xonly_public_key.hexstring}"