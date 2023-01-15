require "./shared"

context = Secp256k1::Context.new
keypair = context.generate_keypair

puts "Keypair hex: #{keypair.bytes.hexstring}"

keypair_secret_key = keypair.secret_key_bytes

puts "Keypair secret key: #{keypair_secret_key.hexstring}"