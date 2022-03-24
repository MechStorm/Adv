package config

import (
	"github.com/caarlos0/env/v6"
)

type Config struct {
	GRPCPort     int    `env:"GRPC_PORT" envDefault:"9090"`
	Port         int    `env:"PORT" envDefault:"8080"`
	DBConnString string `env:"DB_CONN_STRING, notEmpty, unset, file"`
}

func New() (*Config, error) {
	cfg := &Config{}
	err := env.Parse(cfg)
	if err != nil {
		return nil, err
	}
	return cfg, nil
}
