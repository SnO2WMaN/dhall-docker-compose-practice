let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type

let Network
    : Type
    = {}

let Networks = Map Text (Optional Network)

in  { Network = { Type = Network, default = {=} }, Networks }
