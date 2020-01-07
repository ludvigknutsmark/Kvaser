import requests
from pathlib import Path
import logging
import os
from adbutils import adb
import subprocess
import frida
import lzma
import urllib.request
import time
import sys

PROXY_ADDRESS = "127.0.0.1"
PROXY_PORT = "8080"
PATH = os.path.split(os.path.abspath(__file__))[0]
PROCESS_NAME = "com.example.dv2579"

def main():
    download_cert(f"http://{PROXY_ADDRESS}:{PROXY_PORT}/cert")
    device = select_device()
    check_if_root(device)
    install_frida(device)
    check_proxy(device)
    install_app(device)
    exploit(device)
    
    clean(device)
    


def download_cert(url):
    try:
        subprocess.check_output(f"wget {url} -O ./tmp/cert-der.crt", shell=True)
        logging.info(f"Burpsuite found on http://{PROXY_ADDRESS}:{PROXY_PORT}/cert. Downloading certificate to {PATH}/tmp/cert-der.crt")
    except:
        logging.critical(f"Burpsuite could not be found on http://{PROXY_ADDRESS}:{PROXY_PORT}/cert. Exiting...")
        clean()
    try:
        subprocess.check_output(f"adb push ./tmp/cert-der.crt /data/local/tmp/cert-der.crt", shell=True)
        logging.info("Certificate pushed to device")
    except:
        logging.critical("Could not push certificate to device. Exiting...")
        clean()
    

def select_device():
    device_idx = 0
    if len(adb.devices()) > 1:
        logging.info("More than one devices found.")
        for idx, val in enumerate(adb.devices()):
            print("\t",idx, val.serial)
        device_idx = int(input("Select which device to connect to: "))
    return adb.devices()[device_idx]

def check_if_root(device):
    try: 
        subprocess.check_output(f"adb -s {device.serial} shell su 0 ls", shell=True)
        logging.info("Device is rooted.")
    except:
        logging.critical("Device NOT rooted. Exiting...")
        clean(device)

def install_frida(device):
    try:
        logging.info(f"Downloading frida-server to {PATH}/tmp/frida-server")
        url = "https://github.com/frida/frida/releases/download/12.5.6/frida-server-12.5.6-android-x86.xz"
        r = requests.get(url)
        with open('./tmp/frida-server.xz', 'wb') as f: f.write(r.content)
        logging.info("Pushing frida-server to device")
        os.system("unxz ./tmp/frida-server.xz")
        os.system(f"adb -s {device.serial} push ./tmp/frida-server /data/local/tmp")
        device.shell("su 0 chmod 755 /data/local/tmp/frida-server")
        os.system(f"adb -s {device.serial} shell su 0 /data/local/tmp/frida-server &")
        time.sleep(3)
        subprocess.check_output("frida-ps -U", shell=True)
        logging.info("Frida-server started successfully")
    except:
        logging.critical("Something went wrong when trying to install frida-server. Exiting...")
        clean(device)
    
def check_proxy(device):
    '''Vet inte om vi ska ha detta'''
    pass

def install_app(device):
    try:
        device.install("app-release.apk")
        subprocess.check_output(f"adb shell pm list packages -f | grep {PROCESS_NAME}", shell=True)
        logging.info("App successfully installed")
    except:
        logging.critical("Something went wrong when trying to install app")

def exploit(device):
    try:
        device = frida.get_usb_device()
        logging.info("Device connected with Frida successfully")
    except:
        logging.critical("Frida could not connect to device. Exiting...")
        clean(device)
    try:
        process = device.spawn([PROCESS_NAME])
        logging.info(f"Successfully spawned process: {PROCESS_NAME} PID: {process}")
    except:
        logging.critical(f"Could not spawn process {PROCESS_NAME} Exiting...")
        clean(device)
    try:
        attached_process = device.attach(process)
        logging.info(f"Frida attached to process: {PROCESS_NAME}")
    except:
        logging.critical(f"Frida could not attach to process. Exiting...")
        clean(device)
    try:
        payload = attached_process.create_script(FRIDA_CODE)
        logging.info("Successfully sent payload to device. Running payload...")
        payload.load()
        
    except:
        logging.critical("Could not send payload. Exiting...")
        clean(device)
    try:
        sys.stdin.read()
    except KeyboardInterrupt:
        pass
    

def clean(device = None):
    logging.info("\nCleaning up and rebooting android device")
    os.system("rm -rf ./tmp")
    if device:
        os.system(f"adb -s {device.serial} reboot")
    exit(1)

FRIDA_CODE = """
setTimeout(function(){
    Java.perform(function (){
    	console.log("");
	    console.log("[.] Cert Pinning Bypass/Re-Pinning");

	    var CertificateFactory = Java.use("java.security.cert.CertificateFactory");
	    var FileInputStream = Java.use("java.io.FileInputStream");
	    var BufferedInputStream = Java.use("java.io.BufferedInputStream");
	    var X509Certificate = Java.use("java.security.cert.X509Certificate");
	    var KeyStore = Java.use("java.security.KeyStore");
	    var TrustManagerFactory = Java.use("javax.net.ssl.TrustManagerFactory");
	    var SSLContext = Java.use("javax.net.ssl.SSLContext");

	    // Load CAs from an InputStream
	    console.log("[+] Loading our CA...")
	    var cf = CertificateFactory.getInstance("X.509");
	    
	    try {
	    	var fileInputStream = FileInputStream.$new("/data/local/tmp/cert-der.crt");
	    }
	    catch(err) {
	    	console.log("[o] " + err);
	    }
	    
	    var bufferedInputStream = BufferedInputStream.$new(fileInputStream);
	  	var ca = cf.generateCertificate(bufferedInputStream);
	    bufferedInputStream.close();

		var certInfo = Java.cast(ca, X509Certificate);
	    console.log("[o] Our CA Info: " + certInfo.getSubjectDN());

	    // Create a KeyStore containing our trusted CAs
	    console.log("[+] Creating a KeyStore for our CA...");
	    var keyStoreType = KeyStore.getDefaultType();
	    var keyStore = KeyStore.getInstance(keyStoreType);
	    keyStore.load(null, null);
	    keyStore.setCertificateEntry("ca", ca);
	    
	    // Create a TrustManager that trusts the CAs in our KeyStore
	    console.log("[+] Creating a TrustManager that trusts the CA in our KeyStore...");
	    var tmfAlgorithm = TrustManagerFactory.getDefaultAlgorithm();
	    var tmf = TrustManagerFactory.getInstance(tmfAlgorithm);
	    tmf.init(keyStore);
	    console.log("[+] Our TrustManager is ready...");

	    console.log("[+] Hijacking SSLContext methods now...")
	    console.log("[-] Waiting for the app to invoke SSLContext.init()...")

	   	SSLContext.init.overload("[Ljavax.net.ssl.KeyManager;", "[Ljavax.net.ssl.TrustManager;", "java.security.SecureRandom").implementation = function(a,b,c) {
	   		console.log("[o] App invoked javax.net.ssl.SSLContext.init...");
	   		SSLContext.init.overload("[Ljavax.net.ssl.KeyManager;", "[Ljavax.net.ssl.TrustManager;", "java.security.SecureRandom").call(this, a, tmf.getTrustManagers(), c);
	   		console.log("[+] SSLContext initialized with our custom TrustManager!");
	   	}
    });
},0);
"""

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    Path("./tmp").mkdir(parents=True, exist_ok=True)
    main()
    
