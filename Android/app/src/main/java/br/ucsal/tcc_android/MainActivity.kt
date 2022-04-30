package br.ucsal.tcc_android

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<Button>(R.id.listagem_bt).setOnClickListener {
            startActivity(
                Intent(
                    this,
                    ListActivity::class.java
                )
            )
        }

        findViewById<Button>(R.id.location_bt).setOnClickListener {
            startActivity(
                Intent(
                    this,
                    LocationActivity::class.java
                )
            )
        }

        findViewById<Button>(R.id.accelerometer_bt).setOnClickListener {
            startActivity(
                Intent(
                    this,
                    AccelerometerActivity::class.java
                )
            )
        }

        findViewById<Button>(R.id.gyroscope_bt).setOnClickListener {
            startActivity(
                Intent(
                    this,
                    GyroscopeActivity::class.java
                )
            )
        }
    }
}


fun TextView.incrementText(newText: String) {
    val oldText = this.text
    this.text = "$oldText $newText"
}
