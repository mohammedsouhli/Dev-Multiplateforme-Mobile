package com.example.events

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val click: Button = findViewById(R.id.click)
        val longText: TextView = findViewById(R.id.longText)

        click.setOnClickListener {
            Toast.makeText(this, "Button click", Toast.LENGTH_SHORT).show()
            longText.text = "Simple Click On Button"
        }

        click.setOnLongClickListener {
            Toast.makeText(this, "Button Long click", Toast.LENGTH_SHORT).show()
            longText.text = "Long Click On Button"
            true
        }
    }
}
