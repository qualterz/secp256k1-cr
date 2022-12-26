@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs libsecp256k1 2> /dev/null|| printf %s '-lsecp256k1'`")]
lib LibSecp256k1
  $ecdh_hash_function_default : Secp256k1EcdhHashFunction
  $ecdh_hash_function_sha256 : Secp256k1EcdhHashFunction
  alias Secp256k1EcdhHashFunction = (UInt8*, UInt8*, UInt8*, Void* -> LibC::Int)
  fun ecdh = secp256k1_ecdh(ctx : Secp256k1Context, output : UInt8*, pubkey : Secp256k1Pubkey*, seckey : UInt8*, hashfp : Secp256k1EcdhHashFunction, data : Void*) : LibC::Int
end
