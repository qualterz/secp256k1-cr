@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs libsecp256k1 2> /dev/null|| printf %s '-lsecp256k1'`")]
lib LibSecp256k1
  SECP256K1_TAG_PUBKEY_EVEN         = 2
  SECP256K1_TAG_PUBKEY_HYBRID_EVEN  = 6
  SECP256K1_TAG_PUBKEY_HYBRID_ODD   = 7
  SECP256K1_TAG_PUBKEY_ODD          = 3
  SECP256K1_TAG_PUBKEY_UNCOMPRESSED = 4
end
