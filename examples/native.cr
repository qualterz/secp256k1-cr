require "./native/*"

require "openssl"

context = create_context

secret_key, public_key, serialized_public_key = create_ec_keys context
another_secret_key, another_public_key, another_serialized_public_key = create_ec_keys context

shared_secret = create_ecdh_shared_secret context, another_public_key, secret_key
another_shared_secret = create_ecdh_shared_secret context, public_key, another_secret_key

message = OpenSSL::Digest.new("SHA256").update("Hello, crypto!").final

puts "SHA256 Hash Message Hex: #{message.hexstring}"

signature, serialized_signature = create_ecdsa_signature context, message, secret_key
signature_verification_status = verify_ecdsa_signature context, signature, message, public_key

destroy_context context
