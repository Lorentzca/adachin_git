package config

import (
)

type HttpConfigSlice struct {
    Http []HttpConfig
}

type HttpConfig struct {
    Name string
    Host string
    Path string
    Proto string
    Domain string
}

func HttpTargets() []HttpConfig {
    return []HttpConfig{
        HttpConfig{Name: "adachin-server", Host: "adachin.server-on.net", Path: "/", Proto: "http", Domain: "adachin.server-on.net"},
    }
}

