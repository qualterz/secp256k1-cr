require "../shared"

def create_keypair(context)
  keypair = LibSecp256k1::Secp256k1Keypair.new

  loop {
    status = LibSecp256k1.secp256k1_keypair_create(
      context,
      pointerof(keypair),
      randomness
    )

    break if status == 1
  }

  puts "Keypair Raw: #{keypair.data.to_slice.hexstring}"

  return keypair
end

def create_xonly_public_key(context, keypair)
  public_key = LibSecp256k1::Secp256k1XonlyPubkey.new

  if LibSecp256k1.secp256k1_keypair_xonly_pub(
       context,
       pointerof(public_key),
       nil,
       pointerof(keypair)
     ) == 0
    abort "Failed to create XOnly public key"
  end

  puts "XOnly Public Key Raw: #{public_key.data.to_slice.hexstring}"

  return public_key
end
