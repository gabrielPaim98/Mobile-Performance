package br.ucsal.tcc_android

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices

class LocationActivity : AppCompatActivity() {


    companion object {
        const val LOCATION_ID = 44;
    }

    private var startTime = 0L
    private var endTime = 0L

    private lateinit var timeTV: TextView
    private lateinit var timeOriginalText: String
    private lateinit var locationTV: TextView
    private lateinit var locationOriginalText: String
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var requestPermissionLauncher: ActivityResultLauncher<ActivityResultContracts>


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_location)

        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_BACKGROUND_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            Log.d("localiza", "pedindo permissão")
            val requestPermissionLauncher =
                registerForActivityResult(
                    ActivityResultContracts.RequestPermission()
                ) { isGranted: Boolean ->
                    if (isGranted) {
                        Log.d("localiza", "permissão garantida")
                    } else {
                        Log.d("localiza", "permissão não garantida")
                    }
                }

            requestPermissionLauncher.launch("Input test")

            return
        }

        locationTV = findViewById(R.id.location_tv)
        locationOriginalText = locationTV.text.toString()

        timeTV = findViewById(R.id.ellapsed_time_tv)
        timeOriginalText = timeTV.text.toString()

        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        findViewById<Button>(R.id.location_button).setOnClickListener {
            startTime = System.currentTimeMillis()
            ActivityCompat.requestPermissions(
                this, arrayOf(
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
                    Manifest.permission.ACCESS_BACKGROUND_LOCATION
                ), LOCATION_ID
            )
            locationTV.text = locationOriginalText
            timeTV.text = timeOriginalText
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        Log.d("Localiza", "recived request permission result with code: $requestCode")
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            Log.d("localiza", "permision not granted")
            return
        }
        fusedLocationClient.lastLocation.addOnSuccessListener { location ->
            endTime = System.currentTimeMillis()
            if (location != null) {
                locationTV.incrementText("${location.latitude}, ${location.longitude}")
                timeTV.incrementText("${endTime - startTime} ms")
            } else {
                locationTV.incrementText("erro ao buscar localização")
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.d("Localiza", "recived activity result with code: $requestCode")
    }
}