let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type.dhall

let Volume
    : Type
    = {}

let Volumes = Map Text (Optional Volume)

in  { Volume = { Type = Volume, default = {=} }, Volumes }
