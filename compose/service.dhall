let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type.dhall

let Port
    : Type
    = < Short : Text | Long : { published : Natural, target : Natural } >

let Volume
    : Type
    = < Short : Text | Long : { type : Text, source : Text, target : Text } >

let Service
    : Type
    = { image : Text
      , command : Optional Text
      , ports : Optional (List Port)
      , volumes : Optional (List Volume)
      }

let Services
    : Type
    = Map Text Service

in  { Service =
      { Type = Service
      , default =
        { ports = None (List Port)
        , command = None Text
        , volumes = None (List Volume)
        }
      }
    , ServicePort = Port
    , ServiceVolume = Volume
    , Services
    }
