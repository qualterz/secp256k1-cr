@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs libsecp256k1 2> /dev/null|| printf %s '-lsecp256k1'`")]
lib LibSecp256k1
  fun context_preallocated_clone = secp256k1_context_preallocated_clone(ctx : Secp256k1Context, prealloc : Void*) : Secp256k1Context
  fun context_preallocated_clone_size = secp256k1_context_preallocated_clone_size(ctx : Secp256k1Context) : LibC::SizeT
  fun context_preallocated_create = secp256k1_context_preallocated_create(prealloc : Void*, flags : LibC::UInt) : Secp256k1Context
  fun context_preallocated_destroy = secp256k1_context_preallocated_destroy(ctx : Secp256k1Context)
  fun context_preallocated_size = secp256k1_context_preallocated_size(flags : LibC::UInt) : LibC::SizeT
end
