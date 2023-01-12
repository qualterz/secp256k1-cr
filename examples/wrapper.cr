require "./shared"

context = Secp256k1::Context.new
keypair = context.generate_keypair

puts "Keypair hex: #{keypair.data.hexstring}"