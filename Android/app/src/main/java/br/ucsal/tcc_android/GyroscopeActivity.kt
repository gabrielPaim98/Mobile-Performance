package br.ucsal.tcc_android

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.util.Half.EPSILON
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import kotlin.math.cos
import kotlin.math.sin
import kotlin.math.sqrt

class GyroscopeActivity : AppCompatActivity() {

    private var startTime = 0L
    private var endTime = 0L

    private lateinit var timeTV: TextView
    private lateinit var timeOriginalText: String
    private lateinit var gyroscopeTV: TextView
    private lateinit var gyroscopeOriginalText: String

    private val currentRotation = mutableListOf(1F, 1F, 1F)
    private var hasData = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_gyroscope)

        timeTV = findViewById(R.id.ellapsed_time_tv)
        timeOriginalText = timeTV.text.toString()

        gyroscopeTV = findViewById(R.id.gyroscope_tv)
        gyroscopeOriginalText = gyroscopeTV.text.toString()

        findViewById<Button>(R.id.gyroscope_button).setOnClickListener {
            hasData = false

            startTime = System.currentTimeMillis()
            timeTV.text = timeOriginalText
            gyroscopeTV.text = gyroscopeOriginalText

            val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
            val sensor: Sensor? = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE)

            val eventListener = object : SensorEventListener {
                // Create a constant to convert nanoseconds to seconds.
                private val NS2S = 1.0f / 1000000000.0f
                private val deltaRotationVector = FloatArray(4) { 0f }
                private var timestamp: Float = 0f

                override fun onSensorChanged(event: SensorEvent?) {
                    if (hasData) return

                    // This timestep's delta rotation to be multiplied by the current rotation
                    // after computing it from the gyro sample data.
                    if (timestamp != 0f && event != null) {
                        val dT = (event.timestamp - timestamp) * NS2S
                        // Axis of the rotation sample, not normalized yet.
                        var axisX: Float = event.values[0]
                        var axisY: Float = event.values[1]
                        var axisZ: Float = event.values[2]

                        // Calculate the angular speed of the sample
                        val omegaMagnitude: Float =
                            sqrt(axisX * axisX + axisY * axisY + axisZ * axisZ)

                        // Normalize the rotation vector if it's big enough to get the axis
                        // (that is, EPSILON should represent your maximum allowable margin of error)
                        if (omegaMagnitude > EPSILON) {
                            axisX /= omegaMagnitude
                            axisY /= omegaMagnitude
                            axisZ /= omegaMagnitude
                        }

                        // Integrate around this axis with the angular speed by the timestep
                        // in order to get a delta rotation from this sample over the timestep
                        // We will convert this axis-angle representation of the delta rotation
                        // into a quaternion before turning it into the rotation matrix.
                        val thetaOverTwo: Float = omegaMagnitude * dT / 2.0f
                        val sinThetaOverTwo: Float = sin(thetaOverTwo)
                        val cosThetaOverTwo: Float = cos(thetaOverTwo)
                        deltaRotationVector[0] = sinThetaOverTwo * axisX
                        deltaRotationVector[1] = sinThetaOverTwo * axisY
                        deltaRotationVector[2] = sinThetaOverTwo * axisZ
                        deltaRotationVector[3] = cosThetaOverTwo
                    }
                    timestamp = event?.timestamp?.toFloat() ?: 0f
                    val deltaRotationMatrix = FloatArray(9) { 0f }
                    SensorManager.getRotationMatrixFromVector(
                        deltaRotationMatrix,
                        deltaRotationVector
                    )
                    // User code should concatenate the delta rotation we computed with the current rotation
                    // in order to get the updated rotation.
                    // rotationCurrent = rotationCurrent * deltaRotationMatrix;

                    currentRotation[0] = deltaRotationMatrix[0]
                    currentRotation[1] = deltaRotationMatrix[1]
                    currentRotation[2] = deltaRotationMatrix[2]

                    endTime = System.currentTimeMillis()
                    gyroscopeTV.incrementText("x: ${currentRotation[0]}, y: ${currentRotation[1]}, z: ${currentRotation[2]}")
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