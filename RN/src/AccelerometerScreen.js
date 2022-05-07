import React, { useState, useEffect } from "react";
import { View, Text, Button } from "react-native";
import { Accelerometer } from "expo-sensors";

const AccelerometerScreen = (props) => {
  const [time, setTime] = useState("");
  const [data, setData] = useState("");
  var hasData = false;

  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Text>Tempo decorrido: {time}</Text>
      <View style={{ height: 20 }} />
      <Button
        title="Acelerometro"
        onPress={async () => {
          hasData = false;
          let startTime = Date.now();

          Accelerometer.addListener((accelerometerData) => {
            if (!hasData) {
              let endTime = Date.now();
              let time = endTime - startTime;
              setTime(time + " ms");
              setData(
                "x: " +
                  accelerometerData.x +
                  "," +
                  "y: " +
                  accelerometerData.y +
                  "," +
                  "z: " +
                  accelerometerData.z
              );
              hasData = true;
            }
          });
        }}
      />
      <View style={{ height: 20 }} />
      <Text>Acelerometro: {data}</Text>
    </View>
  );
};

export default AccelerometerScreen;
