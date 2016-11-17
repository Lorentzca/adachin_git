package main
import (
    "log"
    "net/http"
)
func main() {
    http.Handle("/", http.FileServer(http.Dir("index")))
    err := http.ListenAndServe(":8080", nil)
    if err != nil {
        log.Fatal("ListenAndServe: ", err)
    }
}
