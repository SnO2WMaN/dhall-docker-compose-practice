let service = ./service.dhall

let volume = ./volume.dhall

let network = ./network.dhall

let ComposeConfig
    : Type
    = { version : Text
      , services : Optional service.Services
      , volumes : Optional volume.Volumes
      , networks : Optional network.Networks
      }

in  { ComposeConfig =
      { Type = ComposeConfig
      , default =
        { version = "3.9"
        , services = None service.Services
        , volumes = None volume.Volumes
        , networks = None network.Networks
        }
      }
    }
