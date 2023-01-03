require "./native/*"

context = create_context

secret_key, public_key, serialized_public_key = create_ec_keys context
another_secret_key, another_public_key, another_serialized_public_key = create_ec_keys context

shared_secret = create_ecdh_shared_secret context, another_public_key, secret_key
another_shared_secret = create_ecdh_shared_secret context, public_key, another_secret_key

destroy_context context