package main

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/patrickz98/KickerKingServer/src/simple"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"math/rand"
	"time"
)

var testUsers = map[string]string{
	"bf196376-3256-4add-97df-17e0fa14bbc0": "Patrick",
	"bf196376-3256-4add-97df-17e0fa14bbc1": "Sönke",
	"bf196376-3256-4add-97df-17e0fa14bbc2": "Thorben",
	"bf196376-3256-4add-97df-17e0fa14bbc3": "Vlad",
	"bf196376-3256-4add-97df-17e0fa14bbc4": "Daniel",
}

type User struct {
	Uuid string
	Nick string
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

type GamePost struct {
	Creator string
	Game    Game
}

type MongoPendingGame struct {
	ConfirmationId string
	Creator        string
	Created        time.Time
	Participants   []string
	Game           Game
}

type PostResponseGame struct {
	Success        bool
	Error          string
	GameId         string
	ConfirmationId string
	TTL            time.Time
}

func randomUser(count int) []User {

	users := make([]User, count)

	for inx := 0; inx < count; inx++ {
		id := simple.NewId(15)

		user := User{
			Uuid: id,
			Nick: id,
		}

		users[inx] = user
	}

	return users
}

func randomGame() Game {

	game := Game{
		GameId:       simple.Uuid(),
		TableId:      simple.Uuid(),
		Date:         time.Now(),
		WinnerIds:    []string{simple.Uuid()},
		LooserIds:    []string{simple.Uuid()},
		LooserPoints: rand.Intn(10),
		WinnerPoints: 10,
	}

	return game
}

func createTestUsers() []User {

	users := make([]User, 0)

	for uuid, name := range testUsers {

		user := User{
			Uuid: uuid,
			Nick: name,
		}

		users = append(users, user)
	}

	return users
}

func createRandomGames(users []User, count int) []Game {

	games := make([]Game, count)

	for inx := 0; inx < count; inx++ {

		game := Game{
			GameId:       simple.Uuid(),
			TableId:      "12345678",
			Date:         time.Now(),
			WinnerIds:    []string{users[rand.Intn(len(users))].Uuid},
			LooserIds:    []string{users[rand.Intn(len(users))].Uuid},
			LooserPoints: rand.Intn(10),
			WinnerPoints: 10,
		}

		games[inx] = game
	}

	return games
}

func main() {

	fmt.Println("Hello")

	fmt.Println(randomUser(4))

	game := randomGame()
	bytes, err := json.MarshalIndent(game, "", "    ")
	simple.Err(err)

	fmt.Println(string(bytes))

	clientOptions := options.Client().ApplyURI("mongodb://localhost:27017")

	client, err := mongo.Connect(context.Background(), clientOptions)
	simple.Err(err)

	// usersCollection := client.Database("kicker").Collection("user")
	users := createTestUsers()

	// for _, user := range users {
	//
	// 	res, err := usersCollection.InsertOne(context.Background(), user)
	// 	simple.Err(err)
	// 	id := res.InsertedID
	// 	fmt.Println(id)
	// }

	collection := client.Database("kicker").Collection("games")
	err = collection.Drop(context.Background())
	simple.Err(err)

	xxx := time.Now().Add(time.Second * 10)

	expireAt := bson.D{{"date", 1}}
	expireAfterSeconds := options.Index()
	expireAfterSeconds.SetExpireAfterSeconds(10)

	indexModel := mongo.IndexModel{
		Keys:    expireAt,
		Options: expireAfterSeconds,
	}

	_, err = collection.Indexes().CreateOne(context.Background(), indexModel)
	simple.Err(err)

	games := createRandomGames(users, 10)
	for _, game := range games {

		res, err := collection.InsertOne(context.Background(), game)
		simple.Err(err)
		id := res.InsertedID
		fmt.Println(id)
	}

	// res, err := collection.InsertOne(context.Background(), game)
	// simple.Err(err)
	//
	// id := res.InsertedID
	//
	// fmt.Println(id)

	err = client.Disconnect(context.Background())
	simple.Err(err)

	fmt.Println("Connection to MongoDB closed.")
}
