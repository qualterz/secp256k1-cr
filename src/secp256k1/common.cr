module Secp256k1
  SECRET_KEY_SIZE = 32

  enum Result
    Wrong   = 0
    Correct = 1
  end

  class Error < Exception
  end
end
