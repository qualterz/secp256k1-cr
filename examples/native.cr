require "./native/*"

context = create_context

first_secret_key, first_public_key, first_serialized_public_key = create_ec_keys context
second_secret_key, second_public_key, second_serialized_public_key = create_ec_keys context

first_shared_secret = create_shared_secret context, first_public_key, second_secret_key
second_shared_secret = create_shared_secret context, second_public_key, first_secret_key
