@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs libsecp256k1 2> /dev/null|| printf %s '-lsecp256k1'`")]
lib LibSecp256k1
  $secp256k1_nonce_function_bip340 : Secp256k1NonceFunctionHardened
  alias Secp256k1NonceFunctionHardened = (UInt8*, UInt8*, LibC::SizeT, UInt8*, UInt8*, UInt8*, LibC::SizeT, Void* -> LibC::Int)
  fun secp256k1_schnorrsig_sign(ctx : Secp256k1Context, sig64 : UInt8*, msg32 : UInt8*, keypair : Secp256k1Keypair*, aux_rand32 : UInt8*) : LibC::Int
  fun secp256k1_schnorrsig_sign32(ctx : Secp256k1Context, sig64 : UInt8*, msg32 : UInt8*, keypair : Secp256k1Keypair*, aux_rand32 : UInt8*) : LibC::Int
  fun secp256k1_schnorrsig_sign_custom(ctx : Secp256k1Context, sig64 : UInt8*, msg : UInt8*, msglen : LibC::SizeT, keypair : Secp256k1Keypair*, extraparams : Secp256k1SchnorrsigExtraparams*) : LibC::Int
  fun secp256k1_schnorrsig_verify(ctx : Secp256k1Context, sig64 : UInt8*, msg : UInt8*, msglen : LibC::SizeT, pubkey : Secp256k1XonlyPubkey*) : LibC::Int

  struct Secp256k1SchnorrsigExtraparams
    magic : UInt8[4]
    noncefp : Secp256k1NonceFunctionHardened
    ndata : Void*
  end
end
