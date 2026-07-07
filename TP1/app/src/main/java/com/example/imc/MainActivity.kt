package com.example.imc

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val poidsInput: EditText = findViewById(R.id.poidsInput)
        val tailleInput: EditText = findViewById(R.id.tailleInput)
        val btnCalculer: Button = findViewById(R.id.btnCalculer)
        val textViewResult: TextView = findViewById(R.id.textViewResult)
        val textViewCategorie: TextView = findViewById(R.id.textViewCategorie)
        val imageViewCategorie: ImageView = findViewById(R.id.imageViewCategorie)

        btnCalculer.setOnClickListener {
            val poids = poidsInput.text.toString().toDoubleOrNull()
            val tailleCm = tailleInput.text.toString().toDoubleOrNull()

            if (poids == null || tailleCm == null || poids <= 0 || tailleCm <= 0) {
                textViewResult.text = getString(R.string.erreur_saisie)
                textViewCategorie.text = ""
                imageViewCategorie.setImageDrawable(null)
                return@setOnClickListener
            }

            val tailleM = tailleCm / 100
            val imc = poids / (tailleM * tailleM)

            val (categorie, image) = when {
                imc < 18.5 -> getString(R.string.cat_maigreur) to R.drawable.cat_maigre
                imc < 25.0 -> getString(R.string.cat_normal) to R.drawable.cat_normal
                imc < 30.0 -> getString(R.string.cat_surpoids) to R.drawable.cat_surpoids
                imc < 35.0 -> getString(R.string.cat_obese) to R.drawable.cat_obese
                else -> getString(R.string.cat_obese_severe) to R.drawable.cat_obese_severe
            }

            textViewResult.text = getString(R.string.resultat_imc, imc)
            textViewCategorie.text = categorie
            imageViewCategorie.setImageResource(image)
        }
    }
}
