Backend for Static Form
=======================

Receive informations from static HTML form, and then send e-mail.

* Available on Heroku
* I18n

## ENV for Configuration

### FORMS

(Required) Pairs of the form and mail destination. JSON format.
Ex:`{"http://example.com/form1": ["mail1@example.com"], "http://example.com/form2": ["mail2@example.com", "mail3@example.com"]}`

### SPAM_FILTER

(Optional) RegExp.
Ex:`(spam message|spam-.*?\.example\.com)`

### MAIL_FROM

(Optional) Sender e-mail address. (Defalut: `no-replay@example.com`)

### SMTP Settings

* SMTP_HOST
* SMTP_PORTS
* SMTP_AUTHENTICATION
* SMTP_USERNAME
* SMTP_PASSWORD
* SMTP_DOMAIN
* SMTP_ENABLE_STARTTLS_AUTO

## Trial

```
DELIVERY_METHOD="test" \
FORMS='{"http://localhost:9393/sample.html": ["support@example.com"]}' \
bundle exec shotgun
```

Browse sample form.

```
http://localhost:9393/sample.html
```

## Author

[Tatsuya Miyamae (BitArts, Inc.)](http://bitarts.jp/)

## Licence

The MIT License (MIT)

Copyright (c) 2014 BitArts, Inc. and Tatsuya Miyamae

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
