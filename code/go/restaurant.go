package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)

// A little utility that simulates performing a task for a random duration.
// For example, calling do(10, "Remy", "is cooking") will compute a random
// number of milliseconds between 5000 and 10000, log "Remy is cooking",
// and sleep the current goroutine for that much time.
func do(seconds int, action ...any) {
	log.Println(action...)
	randomMillis := 500*seconds + rand.Intn(500*seconds)
	time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}

// An order for a meal is placed by a customer and is taken by a cook.
// When the meal is finished, the cook will send the finished meal through
// the reply channel. Each order has a unique id, safely incremented using
// an atomic counter.
type Order struct {
	id        int64
	customer  string
	reply     chan *Order
	preparedBy string
}

// Global atomic counter for order IDs
var nextOrderID atomic.Uint64

// NewOrder creates a new order with a unique ID
func NewOrder(customer string) *Order {
	id := nextOrderID.Add(1)
	return &Order{
		id:       int64(id),
		customer: customer,
		reply:    make(chan *Order),
	}
}

// The waiter is represented by a buffered channel of orders. The waiter will
// take orders from customers and send them to the cook. The cook will then
// send the prepared meal back through the order's reply channel. To simulate
// a waiter being busy, the waiter channel has a buffer capacity of 3 orders.
var waiter = make(chan *Order, 3)

// A cook spends their time fetching orders from the order channel,
// cooking the requested meal, and sending the meal back through the
// order's reply channel. The cook function is designed to be run on a
// goroutine.
func cook(name string) {
	log.Println(name, "starting work")
	for order := range waiter {
		do(10, name, "cooking order", order.id, "for", order.customer)
		order.preparedBy = name
		// Sending the cooked order back to the customer
		order.reply <- order
	}
}

// A customer eats five meals and then goes home. Each time they enter the
// restaurant, they place an order with the waiter. If the waiter is too
// busy, the customer will wait for 7 seconds before abandoning the order.
// If the order does get placed, then they will wait as long as necessary
// for the meal to be cooked and delivered.
func customer(name string, wg *sync.WaitGroup) {
	defer wg.Done()
	
	for mealsEaten := 0; mealsEaten < 5; {
		order := NewOrder(name)
		log.Println(name, "placed order", order.id)

		// Use select with timeout to try to give the order to the waiter
		select {
		case waiter <- order:
			// Order was accepted by the waiter
			// Wait for the meal to be cooked and delivered
			meal := <-order.reply
			// Eat for up to 2 seconds
			do(2, name, "eating cooked order", meal.id,
				"prepared by", meal.preparedBy)
			mealsEaten++
		case <-time.After(7 * time.Second):
			// Waiter was too busy, abandon the order
			do(5, name, "waiting too long, abandoning order", order.id)
		}
	}
	log.Println(name, "going home")
}

func main() {
	customers := []string{
		"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai"}

	var wg sync.WaitGroup

	// Start the three cooks
	go cook("Remy")
	go cook("Colette")
	go cook("Linguini")

	// Start all customers
	for _, customerName := range customers {
		wg.Add(1)
		go customer(customerName, &wg)
	}

	// Wait for all customers to finish
	wg.Wait()

	// Close the waiter channel to signal cooks to stop
	close(waiter)

	log.Println("Restaurant closing")
}
