package com.example.dv2579


import android.os.AsyncTask
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*
import okhttp3.OkHttpClient
import okhttp3.Request
import java.io.BufferedInputStream
import java.io.BufferedReader
import java.io.IOException
import java.io.InputStreamReader


class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        //sslPinning(textView2).execute()
        val btn = findViewById(R.id.button3) as Button
        btn.setOnClickListener{
            sslPinning(textView2).execute()
        }
    }

    class sslPinning(textView: TextView) : AsyncTask<Unit, Unit, String>() {

        val TextView: TextView? = textView


        override fun doInBackground(vararg params: Unit?): String? {
            try {
                val url: String = "https://kvaser.xyz"
                val client = OkHttpClient()
                val request = Request.Builder()
                    .url(url)
                    .build()
                val response = client.newCall(request).execute()
                val responseText = response.body!!.string()
                return responseText
            } catch (e: IOException) {
                return "Error"
            }
        }

        override fun onPostExecute(result: String?) {
            super.onPostExecute(result)

            TextView?.text = result

        }
    }

}