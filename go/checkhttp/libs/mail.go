package main

import (
        "log"
        "net/smtp"

     config "checkhttp/config"
)

func main() {
        // Set up authentication information.
        auth := smtp.PlainAuth(
                "",
                "t.virus.1989@gmail.com", 
                "0817ryosan",
                "smtp.gmail.com",
        )
        // Connect to the server, authenticate, set the sender and recipient,
        // and send the email all in one step.
        err := smtp.SendMail(
                "smtp.gmail.com:587",
                auth,
                "送信アドレス", //foo@gmail.com
                []string{"受信アドレス"},
                []byte("This is the email body."),
        )
        if err != nil {
                log.Fatal(err)
        }
}
view raw
