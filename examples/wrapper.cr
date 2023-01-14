require "./shared"

context = Secp256k1::Context.new
keypair = context.generate_keypair

puts "Keypair hex: #{keypair.data.hexstring}"

keypair_secret_key = keypair.secret_key

puts "Keypair secret key: #{keypair_secret_key.hexstring}"