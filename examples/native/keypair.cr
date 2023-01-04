require "../shared"

def create_keypair(context)
  keypair = LibSecp256k1.Secp256k1Keypair.new

  loop {
    status = LibSecp256k1.secp256k1_keypair_create(
      context,
      pointerof(keypair),
      randomness
    )

    break if status == 1
  }

  return keypair
end
