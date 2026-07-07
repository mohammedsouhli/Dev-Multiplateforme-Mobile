package com.example.meteo

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.TextView

class MeteoListAdapter(context: Context, private val items: List<MeteoItem>) :
    ArrayAdapter<MeteoItem>(context, 0, items) {

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val view = convertView
            ?: LayoutInflater.from(context).inflate(R.layout.list_item_meteo, parent, false)

        val item = items[position]
        view.findViewById<TextView>(R.id.textViewDate).text = item.date
        view.findViewById<TextView>(R.id.textViewTempMinMax).text =
            "Min: ${item.tempMin}°C   Max: ${item.tempMax}°C"
        view.findViewById<TextView>(R.id.textViewPression).text =
            "Pression: ${item.pressure} hPa"
        view.findViewById<TextView>(R.id.textViewHumidite).text =
            "Humidité: ${item.humidite}%"

        return view
    }
}
