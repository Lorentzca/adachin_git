package main
 
import (
    "fmt"
    "strings"
    "net/http"
    "io"
    "io/ioutil"
    "bytes"
    "log"
    "net/smtp"
)
 
const (
    API_URL = "https://adachin.server-on.net/wordpress/" // API(サーバー)のURL
        EXPECTED_API_RETURN = "OK" // 成功時のAPIからの返答
    MAIL_TO = "t.virus.1989@gmail.com"  // 失敗した時に通知するメールアドレス
)
 
// APIへGETリクエストを送ってデータを取得
func request() (string) {
    resp, err := http.Get(API_URL)
    if (err != nil) {
        log.Fatal(err.Error())
    }
    defer resp.Body.Close()
    body, err := ioutil.ReadAll(resp.Body)
    if (err != nil) {
        log.Fatal(err.Error())
    }
    return strings.Trim(string(body), "\n") // 前後の余分な改行を削除しておく
}

// エラーが発生した場合にメールを送る
func sendMail(mes string) {
    c, err := smtp.Dial("localhost:25")
    if err != nil {
        log.Fatal(err)
    }
    c.Mail("root@localhost")
    c.Rcpt(MAIL_TO)
 
    wc, err := c.Data()
    if err != nil {
        log.Fatal(err)
    }
    defer wc.Close()
    buf := bytes.NewBufferString("To:" + MAIL_TO)
    buf.WriteString("\r\n")
    buf.WriteString("Server seems to be dead")
    buf.WriteString("\r\n")
    buf.WriteString(mes)
    if _, err = buf.WriteTo(wc); err != nil {
        log.Fatal(err)
    }
    c.Quit()
}
 
func main() {
    res := request()
    exp := EXPECTED_API_RETURN
 
    if res != pas {
        mes := "Your API seems to be dead."
        mes += "EXPECTED: " + exp + "\n"
        mes += "ACTUAL: " + res + "\n"
        sendMail(mes)
    }
}

