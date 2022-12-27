@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs libsecp256k1 2> /dev/null|| printf %s '-lsecp256k1'`")]
lib LibSecp256k1
  $secp256k1_context_no_precomp : Secp256k1Context
  $secp256k1_context_static : Secp256k1Context
  $secp256k1_nonce_function_default : Secp256k1NonceFunction
  $secp256k1_nonce_function_rfc6979 : Secp256k1NonceFunction
  SECP256K1_CONTEXT_DECLASSIFY           = SECP256K1_FLAGS_TYPE_CONTEXT | SECP256K1_FLAGS_BIT_CONTEXT_DECLASSIFY
  SECP256K1_CONTEXT_NONE                 = SECP256K1_FLAGS_TYPE_CONTEXT
  SECP256K1_CONTEXT_SIGN                 = SECP256K1_FLAGS_TYPE_CONTEXT | SECP256K1_FLAGS_BIT_CONTEXT_SIGN
  SECP256K1_CONTEXT_VERIFY               = SECP256K1_FLAGS_TYPE_CONTEXT | SECP256K1_FLAGS_BIT_CONTEXT_VERIFY
  SECP256K1_EC_COMPRESSED                = SECP256K1_FLAGS_TYPE_COMPRESSION | SECP256K1_FLAGS_BIT_COMPRESSION
  SECP256K1_EC_UNCOMPRESSED              = SECP256K1_FLAGS_TYPE_COMPRESSION
  SECP256K1_FLAGS_BIT_COMPRESSION        = 1 << 8
  SECP256K1_FLAGS_BIT_CONTEXT_DECLASSIFY = 1 << 10
  SECP256K1_FLAGS_BIT_CONTEXT_SIGN       = 1 << 9
  SECP256K1_FLAGS_BIT_CONTEXT_VERIFY     = 1 << 8
  SECP256K1_FLAGS_TYPE_COMPRESSION       = 1 << 1
  SECP256K1_FLAGS_TYPE_CONTEXT           = 1 << 0
  SECP256K1_FLAGS_TYPE_MASK              = (1 << 8) - 1
  SECP256K1_TAG_PUBKEY_EVEN              = 2
  SECP256K1_TAG_PUBKEY_HYBRID_EVEN       = 6
  SECP256K1_TAG_PUBKEY_HYBRID_ODD        = 7
  SECP256K1_TAG_PUBKEY_ODD               = 3
  SECP256K1_TAG_PUBKEY_UNCOMPRESSED      = 4
  alias Secp256k1ContextStruct = Void
  alias Secp256k1NonceFunction = (UInt8*, UInt8*, UInt8*, UInt8*, Void*, LibC::UInt -> LibC::Int)
  alias Secp256k1ScratchSpaceStruct = Void
  fun secp256k1_context_clone(ctx : Secp256k1Context) : Secp256k1Context
  fun secp256k1_context_create(flags : LibC::UInt) : Secp256k1Context
  fun secp256k1_context_destroy(ctx : Secp256k1Context)
  fun secp256k1_context_randomize(ctx : Secp256k1Context, seed32 : UInt8*) : LibC::Int
  fun secp256k1_context_set_error_callback(ctx : Secp256k1Context, fun : (LibC::Char*, Void* -> Void), data : Void*)
  fun secp256k1_context_set_illegal_callback(ctx : Secp256k1Context, fun : (LibC::Char*, Void* -> Void), data : Void*)
  fun secp256k1_ec_privkey_negate(ctx : Secp256k1Context, seckey : UInt8*) : LibC::Int
  fun secp256k1_ec_privkey_tweak_add(ctx : Secp256k1Context, seckey : UInt8*, tweak32 : UInt8*) : LibC::Int
  fun secp256k1_ec_privkey_tweak_mul(ctx : Secp256k1Context, seckey : UInt8*, tweak32 : UInt8*) : LibC::Int
  fun secp256k1_ec_pubkey_cmp(ctx : Secp256k1Context, pubkey1 : Secp256k1Pubkey*, pubkey2 : Secp256k1Pubkey*) : LibC::Int
  fun secp256k1_ec_pubkey_combine(ctx : Secp256k1Context, out : Secp256k1Pubkey*, ins : Secp256k1Pubkey**, n : LibC::SizeT) : LibC::Int
  fun secp256k1_ec_pubkey_create(ctx : Secp256k1Context, pubkey : Secp256k1Pubkey*, seckey : UInt8*) : LibC::Int
  fun secp256k1_ec_pubkey_negate(ctx : Secp256k1Context, pubkey : Secp256k1Pubkey*) : LibC::Int
  fun secp256k1_ec_pubkey_parse(ctx : Secp256k1Context, pubkey : Secp256k1Pubkey*, input : UInt8*, inputlen : LibC::SizeT) : LibC::Int
  fun secp256k1_ec_pubkey_serialize(ctx : Secp256k1Context, output : UInt8*, outputlen : LibC::SizeT*, pubkey : Secp256k1Pubkey*, flags : LibC::UInt) : LibC::Int
  fun secp256k1_ec_pubkey_tweak_add(ctx : Secp256k1Context, pubkey : Secp256k1Pubkey*, tweak32 : UInt8*) : LibC::Int
  fun secp256k1_ec_pubkey_tweak_mul(ctx : Secp256k1Context, pubkey : Secp256k1Pubkey*, tweak32 : UInt8*) : LibC::Int
  fun secp256k1_ec_seckey_negate(ctx : Secp256k1Context, seckey : UInt8*) : LibC::Int
  fun secp256k1_ec_seckey_tweak_add(ctx : Secp256k1Context, seckey : UInt8*, tweak32 : UInt8*) : LibC::Int
  fun secp256k1_ec_seckey_tweak_mul(ctx : Secp256k1Context, seckey : UInt8*, tweak32 : UInt8*) : LibC::Int
  fun secp256k1_ec_seckey_verify(ctx : Secp256k1Context, seckey : UInt8*) : LibC::Int
  fun secp256k1_ecdsa_sign(ctx : Secp256k1Context, sig : Secp256k1EcdsaSignature*, msghash32 : UInt8*, seckey : UInt8*, noncefp : Secp256k1NonceFunction, ndata : Void*) : LibC::Int
  fun secp256k1_ecdsa_signature_normalize(ctx : Secp256k1Context, sigout : Secp256k1EcdsaSignature*, sigin : Secp256k1EcdsaSignature*) : LibC::Int
  fun secp256k1_ecdsa_signature_parse_compact(ctx : Secp256k1Context, sig : Secp256k1EcdsaSignature*, input64 : UInt8*) : LibC::Int
  fun secp256k1_ecdsa_signature_parse_der(ctx : Secp256k1Context, sig : Secp256k1EcdsaSignature*, input : UInt8*, inputlen : LibC::SizeT) : LibC::Int
  fun secp256k1_ecdsa_signature_serialize_compact(ctx : Secp256k1Context, output64 : UInt8*, sig : Secp256k1EcdsaSignature*) : LibC::Int
  fun secp256k1_ecdsa_signature_serialize_der(ctx : Secp256k1Context, output : UInt8*, outputlen : LibC::SizeT*, sig : Secp256k1EcdsaSignature*) : LibC::Int
  fun secp256k1_ecdsa_verify(ctx : Secp256k1Context, sig : Secp256k1EcdsaSignature*, msghash32 : UInt8*, pubkey : Secp256k1Pubkey*) : LibC::Int
  fun secp256k1_keypair_create(ctx : Secp256k1Context, keypair : Secp256k1Keypair*, seckey : UInt8*) : LibC::Int
  fun secp256k1_keypair_pub(ctx : Secp256k1Context, pubkey : Secp256k1Pubkey*, keypair : Secp256k1Keypair*) : LibC::Int
  fun secp256k1_keypair_sec(ctx : Secp256k1Context, seckey : UInt8*, keypair : Secp256k1Keypair*) : LibC::Int
  fun secp256k1_keypair_xonly_pub(ctx : Secp256k1Context, pubkey : Secp256k1XonlyPubkey*, pk_parity : LibC::Int*, keypair : Secp256k1Keypair*) : LibC::Int
  fun secp256k1_keypair_xonly_tweak_add(ctx : Secp256k1Context, keypair : Secp256k1Keypair*, tweak32 : UInt8*) : LibC::Int
  fun secp256k1_scratch_space_create(ctx : Secp256k1Context, size : LibC::SizeT) : Secp256k1ScratchSpace
  fun secp256k1_scratch_space_destroy(ctx : Secp256k1Context, scratch : Secp256k1ScratchSpace)
  fun secp256k1_selftest
  fun secp256k1_tagged_sha256(ctx : Secp256k1Context, hash32 : UInt8*, tag : UInt8*, taglen : LibC::SizeT, msg : UInt8*, msglen : LibC::SizeT) : LibC::Int
  fun secp256k1_xonly_pubkey_cmp(ctx : Secp256k1Context, pk1 : Secp256k1XonlyPubkey*, pk2 : Secp256k1XonlyPubkey*) : LibC::Int
  fun secp256k1_xonly_pubkey_from_pubkey(ctx : Secp256k1Context, xonly_pubkey : Secp256k1XonlyPubkey*, pk_parity : LibC::Int*, pubkey : Secp256k1Pubkey*) : LibC::Int
  fun secp256k1_xonly_pubkey_parse(ctx : Secp256k1Context, pubkey : Secp256k1XonlyPubkey*, input32 : UInt8*) : LibC::Int
  fun secp256k1_xonly_pubkey_serialize(ctx : Secp256k1Context, output32 : UInt8*, pubkey : Secp256k1XonlyPubkey*) : LibC::Int
  fun secp256k1_xonly_pubkey_tweak_add(ctx : Secp256k1Context, output_pubkey : Secp256k1Pubkey*, internal_pubkey : Secp256k1XonlyPubkey*, tweak32 : UInt8*) : LibC::Int
  fun secp256k1_xonly_pubkey_tweak_add_check(ctx : Secp256k1Context, tweaked_pubkey32 : UInt8*, tweaked_pk_parity : LibC::Int, internal_pubkey : Secp256k1XonlyPubkey*, tweak32 : UInt8*) : LibC::Int

  struct Secp256k1EcdsaSignature
    data : UInt8[64]
  end

  struct Secp256k1Keypair
    data : UInt8[96]
  end

  struct Secp256k1Pubkey
    data : UInt8[64]
  end

  struct Secp256k1XonlyPubkey
    data : UInt8[64]
  end

  type Secp256k1Context = Void*
  type Secp256k1ScratchSpace = Void*
end

require "./ecdh.cr"
require "./preallocated.cr"
require "./recovery.cr"
require "./schnorrsig.cr"
