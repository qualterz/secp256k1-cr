require "./lib_secp256k1"
require "./secp256k1/*"

module Secp256k1
  VERSION = "0.1.0"

  class Error < Exception
  end
end