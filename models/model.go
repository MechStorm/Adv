package models

import "github.com/google/uuid"

type AdvCompany struct {
	ID    uuid.UUID `json: "id_com"`
	Title string    `json: "title_com"`
	Descr string    `json: "description_com"`
}

type Advertisement struct {
	ID    uuid.UUID `json: "id_adv"`
	Cpm   string    `json: "cpm"`
	Title string    `json: "title_adv"`
	Descr string    `json: "description_adv"`
}
