package main

import (
	"net/http"
	"log"
)

func index(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("HTTPS bitcheees"))
}

func main() {
	http.HandleFunc("/", index)
	err := http.ListenAndServeTLS(":443", "server.crt", "server.key", nil)
	if err != nil {
		log.Fatal("ListenAndServe", err)
	}
}
