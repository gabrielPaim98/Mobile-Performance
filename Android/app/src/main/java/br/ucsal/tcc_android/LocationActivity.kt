package br.ucsal.tcc_android

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.Looper
import android.util.Log
import android.widget.Button
import android.widget.TextView
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.*

class LocationActivity : AppCompatActivity() {
    
    private var startTime = 0L
    private var endTime = 0L

    private lateinit var timeTV: TextView
    private lateinit var timeOriginalText: String
    private lateinit var locationTV: TextView
    private lateinit var locationOriginalText: String
    private lateinit var fusedLocationClient: FusedLocationProviderClient

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_location)

        locationTV = findViewById(R.id.location_tv)
        locationOriginalText = locationTV.text.toString()

        timeTV = findViewById(R.id.ellapsed_time_tv)
        timeOriginalText = timeTV.text.toString()

        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        findViewById<Button>(R.id.location_button).setOnClickListener {
            startTime = System.currentTimeMillis()

            if (ActivityCompat.checkSelfPermission(
                    this,
                    Manifest.permission.ACCESS_FINE_LOCATION
                ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                    this,
                    Manifest.permission.ACCESS_COARSE_LOCATION
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                return@setOnClickListener
            }
            fusedLocationClient.requestLocationUpdates(
                LocationRequest.create().setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY),
                object : LocationCallback() {
                    override fun onLocationResult(locationResult: LocationResult?) {
                        locationResult ?: return
                        val location = locationResult.lastLocation

                        endTime = System.currentTimeMillis()
                        locationTV.incrementText("${location.latitude}, ${location.longitude}")
                        timeTV.incrementText("${endTime - startTime} ms")
                    }
                },
                Looper.getMainLooper()
            )

            locationTV.text = locationOriginalText
            timeTV.text = timeOriginalText
        }
    }
}