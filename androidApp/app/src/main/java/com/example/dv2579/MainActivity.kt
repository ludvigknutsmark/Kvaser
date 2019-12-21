package com.example.dv2579

import android.os.AsyncTask
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*
import org.json.JSONObject
import java.io.BufferedInputStream
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import javax.net.ssl.HttpsURLConnection

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        GetWeatherTask(textView10).execute()
    }

    class GetWeatherTask(textView: TextView) : AsyncTask<Unit, Unit, String>() {

        val innerTextView: TextView? = textView

        override fun doInBackground(vararg params: Unit?): String? {
            val url = URL("https://collinstuart.github.io/posts.json")
            val httpsClient = url.openConnection() as HttpsURLConnection
            if (httpsClient.responseCode == HttpsURLConnection.HTTP_OK) {
                try {
                    val stream = BufferedInputStream(httpsClient.inputStream)
                    val data: String = readStream(inputStream = stream)
                    return data
                } catch (e: Exception) {
                    e.printStackTrace()
                } finally {
                    httpsClient.disconnect()
                }
            } else {
                println("ERROR ${httpsClient.responseCode}")
            }
            return null
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