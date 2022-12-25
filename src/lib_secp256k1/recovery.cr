@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs libsecp256k1 2> /dev/null|| printf %s '-lsecp256k1'`")]
lib LibSecp256k1
  fun secp256k1_ecdsa_recover(ctx : Secp256k1Context, pubkey : Secp256k1Pubkey*, sig : Secp256k1EcdsaRecoverableSignature*, msghash32 : UInt8*) : LibC::Int
  fun secp256k1_ecdsa_recoverable_signature_convert(ctx : Secp256k1Context, sig : Secp256k1EcdsaSignature*, sigin : Secp256k1EcdsaRecoverableSignature*) : LibC::Int
  fun secp256k1_ecdsa_recoverable_signature_parse_compact(ctx : Secp256k1Context, sig : Secp256k1EcdsaRecoverableSignature*, input64 : UInt8*, recid : LibC::Int) : LibC::Int
  fun secp256k1_ecdsa_recoverable_signature_serialize_compact(ctx : Secp256k1Context, output64 : UInt8*, recid : LibC::Int*, sig : Secp256k1EcdsaRecoverableSignature*) : LibC::Int
  fun secp256k1_ecdsa_sign_recoverable(ctx : Secp256k1Context, sig : Secp256k1EcdsaRecoverableSignature*, msghash32 : UInt8*, seckey : UInt8*, noncefp : Secp256k1NonceFunction, ndata : Void*) : LibC::Int

  struct Secp256k1EcdsaRecoverableSignature
    data : UInt8[65]
  end
end
