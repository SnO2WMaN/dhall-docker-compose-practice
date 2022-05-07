let service = ./service.dhall

let volume = ./volume.dhall

let network = ./network.dhall

let compose = ./compose.dhall

in  service // volume // network // compose
