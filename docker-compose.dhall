let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type

let Port = { published : Natural }

let Service
    : Type
    = { image : Text }

let ComposeFile
    : Type
    = { version : Text, services : Map Text Service }

let NginxSerice
    : Service
    = { image = "nginx" }

in  { version = "3.9", services = toMap { nginx = NginxSerice } } : ComposeFile
