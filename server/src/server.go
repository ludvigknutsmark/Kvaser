package main

import (
	"net/http"
	"log"
)

func index(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Do. Or do not. There is no try."))
}

func main() {
	http.HandleFunc("/", index)
	http.ListenAndServe(":80")
}
