package main

import (
	"fmt"
	"math/rand"
	"time"
)

type User struct {
	Nick string
	Uuid string
}

type Game struct {
	GameId       string
	TableId      string
	Date         time.Time
	WinnerIds    []string
	LooserIds    []string
	LooserPoints int
	WinnerPoints int
}

func newId(length int) string {

	rand.Seed(time.Now().UnixNano())

	var letterRunes = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")

	bytes := make([]rune, length)

	for inx := range bytes {
		bytes[ inx ] = letterRunes[ rand.Intn(len(letterRunes)) ]
	}

	return string(bytes)
}

func randomUser(count int) []User {

	users := make([]User, count)

	for inx := 0; inx < count; inx++ {
		id := newId(8)

		user := User{
			Nick: "Nick-" + id,
			Uuid: id,
		}

		users[ inx ] = user
	}

	return users
}

func main() {

	fmt.Println("Hello")

	fmt.Println(randomUser(4))

	// client, err := mongo.Connect(context.Background(), options.Client().ApplyURI("mongodb://localhost:27017"))
	// simple.Err(err)
	//
	// collection := client.Database("kicker").Collection("user")
	//
	//
	// res, err := collection.InsertOne(context.Background(), patrick)
	// id := res.InsertedID
	//
	// fmt.Println(id)
	// fmt.Println(patrick)
}
