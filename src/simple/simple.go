package simple

import (
	"log"
)

func Err(err error) {

	if err != nil {
		log.Fatal(err)
	}
}