let Compose = ./compose/package.dhall

let nginxService =
      Compose.Service::{
      , image = "nginx"
      , ports = Some
        [ Compose.ServicePort.Long { published = 8080, target = 80 } ]
      , volumes = Some
        [ Compose.ServiceVolume.Short "nginx_log:/var/log/nginx"
        , Compose.ServiceVolume.Long
            { type = "bind"
            , source = "./configs/nginx/nginx.conf"
            , target = "/etc/nginx/nginx.conf"
            }
        ]
      }

let promtailService =
      Compose.Service::{
      , image = "grafana/promtail:2.5.0"
      , command = Some "-config.file=/etc/promtail/config.yaml"
      , volumes = Some
        [ Compose.ServiceVolume.Short "nginx_log:/var/log/nginx"
        , Compose.ServiceVolume.Long
            { type = "bind"
            , source = "./configs/promtail/config.yaml"
            , target = "/etc/promtail/config.yaml"
            }
        ]
      }


let lokiService =
      Compose.Service::{
      , image = "grafana/loki:2.5.0"
      , command = Some "-config.file=/etc/loki/config.yaml"
      , volumes = Some
        [ Compose.ServiceVolume.Long
            { type = "bind"
            , source = "./configs/loki/config.yaml"
            , target = "/etc/loki/config.yaml"
            }
        ]
      }

let grafanaService =
      Compose.Service::{
      , image = "grafana/grafana:latest"
      , ports = Some
        [ Compose.ServicePort.Long { published = 3000, target = 3000 } ]
      }

let services
    : Compose.Services
    = toMap
        { nginx = nginxService
        , promtail = promtailService
        , loki = lokiService
        , grafana = grafanaService
        }

let volumes
    : Compose.Networks
    = toMap { nginx_log = Some {=} }

let networks
    : Compose.Networks
    = toMap { test = Some {=} }

in  Compose.ComposeConfig::{
    , version = "3.9"
    , services = Some services
    , volumes = Some volumes
    , networks = Some networks
    }
