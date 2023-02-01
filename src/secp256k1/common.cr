module Secp256k1
  class Error < Exception
  end

  enum Result
    Wrong   = 0
    Correct = 1
  end
end
