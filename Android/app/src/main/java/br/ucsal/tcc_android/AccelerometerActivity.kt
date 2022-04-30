package br.ucsal.tcc_android

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class AccelerometerActivity : AppCompatActivity() {

    private var startTime = 0L
    private var endTime = 0L

    private lateinit var timeTV: TextView
    private lateinit var timeOriginalText: String
    private lateinit var accelerometerTV: TextView
    private lateinit var accelerometerOriginalText: String

    private val linearAcceleration = mutableListOf(0F, 0F, 0F)
    private val gravity = mutableListOf(0F, 0F, 0F)
    private var hasData = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_accelerometer)

        timeTV = findViewById(R.id.ellapsed_time_tv)
        timeOriginalText = timeTV.text.toString()

        accelerometerTV = findViewById(R.id.accelerometer_tv)
        accelerometerOriginalText = accelerometerTV.text.toString()

        findViewById<Button>(R.id.accelerometer_button).setOnClickListener {
            hasData = false

            startTime = System.currentTimeMillis()
            timeTV.text = timeOriginalText
            accelerometerTV.text = accelerometerOriginalText

            val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
            val sensor: Sensor? = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

            val eventListener = object : SensorEventListener {
                override fun onSensorChanged(event: SensorEvent?) {
                    if (hasData || event == null || event.sensor.type != Sensor.TYPE_ACCELEROMETER || event.values.isEmpty()) {
                        return
                    }
                    // In this example, alpha is calculated as t / (t + dT),
                    // where t is the low-pass filter's time-constant and
                    // dT is the event delivery rate.

                    val alpha = 0.8f

                    // Isolate the force of gravity with the low-pass filter.
                    gravity[0] = alpha * gravity[0] + (1 - alpha) * event.values[0]
                    gravity[1] = alpha * gravity[1] + (1 - alpha) * event.values[1]
                    gravity[2] = alpha * gravity[2] + (1 - alpha) * event.values[2]

                    // Remove the gravity contribution with the high-pass filter.
                    linearAcceleration[0] = event.values[0] - gravity[0]
                    linearAcceleration[1] = event.values[1] - gravity[1]
                    linearAcceleration[2] = event.values[2] - gravity[2]


                    endTime = System.currentTimeMillis()
                    accelerometerTV.incrementText("x: ${linearAcceleration[0]}, y: ${linearAcceleration[1]}, z: ${linearAcceleration[2]}")
                    timeTV.incrementText("${endTime - startTime} ms")

                    hasData = true
                }

                override fun onAccuracyChanged(p0: Sensor?, p1: Int) {
                }
            }

            sensor?.also {
                sensorManager.registerListener(
                    eventListener,
                    sensor,
                    SensorManager.SENSOR_DELAY_NORMAL
                )
            }
        }
    }
}