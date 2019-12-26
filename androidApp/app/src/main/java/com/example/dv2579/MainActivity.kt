package com.example.dv2579


import android.os.AsyncTask
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*
import org.json.JSONObject
import java.io.BufferedInputStream
import java.io.BufferedReader
import java.io.InputStreamReader
import okhttp3.CertificatePinner
import okhttp3.OkHttpClient
import okhttp3.Request



class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        sslPinning(textView2).execute()
    }

    class sslPinning(textView: TextView) : AsyncTask<Unit, Unit, String>() {

        val innerTextView: TextView? = textView

        override fun doInBackground(vararg params: Unit?): String? {
            val hostname = "kvaser.xyz"
            try {
                val certificatePinner = CertificatePinner.Builder()
                    .add(hostname, "sha256/+zERkoqFM5BPm1nzxUO7ksOwIfAoixzis/h+hHkXEJM=")
                    .build()
                val client: OkHttpClient = OkHttpClient.Builder()
                    .certificatePinner(certificatePinner)
                    .build()

                val request: Request = Request.Builder()
                    .url("https://$hostname")
                    .build()
                while(true){
                    client.newCall(request).execute()
                    Thread.sleep(5000)
                }

            }
            catch (e: Exception){
                return """{"error": "SSL pinning failed"}"""
            }
            return """{"success": "SSL pinning done!"}"""

        }

        fun readStream(inputStream: BufferedInputStream): String {
            val bufferedReader = BufferedReader(InputStreamReader(inputStream))
            val stringBuilder = StringBuilder()
            bufferedReader.forEachLine { stringBuilder.append(it) }
            return stringBuilder.toString()
        }

        override fun onPostExecute(result: String?) {
            super.onPostExecute(result)

            innerTextView?.text = JSONObject(result).toString()

            /**
             * ... Work with the weather data
             */

        }
    }

}