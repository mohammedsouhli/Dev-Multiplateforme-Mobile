package com.example.meteo

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.ListView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import org.json.JSONObject
import java.net.URLEncoder

class MainActivity : AppCompatActivity() {

    private lateinit var editTextVille: EditText
    private lateinit var btnRechercher: Button
    private lateinit var listViewMeteo: ListView
    private lateinit var adapter: MeteoListAdapter
    private lateinit var queue: RequestQueue
    private val data = mutableListOf<MeteoItem>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        editTextVille = findViewById(R.id.editTextVille)
        btnRechercher = findViewById(R.id.btnRechercher)
        listViewMeteo = findViewById(R.id.listViewMeteo)
        queue = Volley.newRequestQueue(this)

        adapter = MeteoListAdapter(this, data)
        listViewMeteo.adapter = adapter

        btnRechercher.setOnClickListener {
            val ville = editTextVille.text.toString().trim()
            if (ville.isEmpty()) {
                Toast.makeText(this, getString(R.string.erreur_ville_vide), Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
            rechercherVille(ville)
        }
    }

    private fun rechercherVille(ville: String) {
        val geoUrl = "https://geocoding-api.open-meteo.com/v1/search?name=" +
                URLEncoder.encode(ville, "UTF-8") + "&count=1&language=fr&format=json"

        val geoRequest = StringRequest(Request.Method.GET, geoUrl, { response ->
            val results = JSONObject(response).optJSONArray("results")
            if (results == null || results.length() == 0) {
                Toast.makeText(this, getString(R.string.erreur_ville_introuvable), Toast.LENGTH_SHORT).show()
            } else {
                val first = results.getJSONObject(0)
                fetchForecast(first.getDouble("latitude"), first.getDouble("longitude"))
            }
        }, {
            Toast.makeText(this, getString(R.string.erreur_connexion), Toast.LENGTH_SHORT).show()
        })
        queue.add(geoRequest)
    }

    private fun fetchForecast(latitude: Double, longitude: Double) {
        val url = "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude" +
                "&daily=temperature_2m_max,temperature_2m_min" +
                "&hourly=relative_humidity_2m,surface_pressure" +
                "&timezone=auto&forecast_days=5"

        val request = StringRequest(Request.Method.GET, url, { response ->
            val json = JSONObject(response)

            val daily = json.getJSONObject("daily")
            val dailyTime = daily.getJSONArray("time")
            val tempMaxArr = daily.getJSONArray("temperature_2m_max")
            val tempMinArr = daily.getJSONArray("temperature_2m_min")

            val hourly = json.getJSONObject("hourly")
            val hourlyTime = hourly.getJSONArray("time")
            val humidityArr = hourly.getJSONArray("relative_humidity_2m")
            val pressureArr = hourly.getJSONArray("surface_pressure")

            data.clear()
            for (i in 0 until dailyTime.length()) {
                val day = dailyTime.getString(i)
                val noonKey = "${day}T12:00"

                var pressure = 0.0
                var humidite = 0
                for (h in 0 until hourlyTime.length()) {
                    if (hourlyTime.getString(h) == noonKey) {
                        pressure = pressureArr.getDouble(h)
                        humidite = humidityArr.getInt(h)
                        break
                    }
                }

                data.add(
                    MeteoItem(
                        date = day,
                        tempMax = tempMaxArr.getDouble(i),
                        tempMin = tempMinArr.getDouble(i),
                        pressure = pressure,
                        humidite = humidite
                    )
                )
            }
            adapter.notifyDataSetChanged()
        }, {
            Toast.makeText(this, getString(R.string.erreur_connexion), Toast.LENGTH_SHORT).show()
        })
        queue.add(request)
    }
}
