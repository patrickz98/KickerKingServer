package simple

import (
	"encoding/base64"
	"log"
	"math/rand"
	"time"
)

func Err(err error) {

	if err != nil {
		panic(err)
	}
}

func NewId(length int) string {

	rand.Seed(time.Now().UnixNano())

	var letterRunes = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")

	bytes := make([]rune, length)

	for inx := range bytes {
		bytes[inx] = letterRunes[rand.Intn(len(letterRunes))]
	}

	return string(bytes)
}

func Uuid() string {

	rand.Seed(time.Now().UnixNano())

	bytes := make([]byte, 16)
	rand.Read(bytes)

	_, err := rand.Read(bytes)
	if err != nil {
		log.Fatal(err)
	}

	return base64.StdEncoding.EncodeToString(bytes)
}
