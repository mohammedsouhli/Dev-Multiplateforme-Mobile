package com.example.meteo

data class MeteoItem(
    val date: String,
    val tempMax: Double,
    val tempMin: Double,
    val pressure: Double,
    val humidite: Int
)
