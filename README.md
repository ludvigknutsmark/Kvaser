# Kvaser

Automatic tool for Certificate unpinning on Android applications. Complete with an example app.

## What is Certificate-pinning?
Certificate pinning or SSL-pinning is a technique applications uses to prevent MITM-attacks for HTTPS traffic between the application and server. Certificate pinning means that the servers certificate is "hardcoded" on the device in such a way that if the HTTPS certificate from the server does not match the hardcoded value the connection fails. 


Certificate unpinning is an attack in which the certificate pinning is bypassed and the HTTPS traffic can be intercepted.

## Prerequistes

- Rootable Android device. Emulated or physical. Examples uses a emulated Pixel 2 with Android 7.0 Nougat (x86 Google API image)

- Android device with proxy settings pointing to Burp Suite proxy

- Running instance of Burp Suite

## Running Kvaser
Running with our example app.
```
adb install app-release.apk
pip3 install -r requirements.txt
python3 kvaser.py --gadget com.example.dv2579 --proxy 127.0.0.1:8080
```
Press connect on the example application and wait a few seconds for Burp Suite to intercept the connection.
