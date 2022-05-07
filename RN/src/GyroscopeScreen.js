import React, { useState, useEffect } from "react";
import { View, Text, Button } from "react-native";
import { Gyroscope } from "expo-sensors";

const GyroscopeScreen = (props) => {
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

          Gyroscope.addListener((gyroData) => {
            if (!hasData) {
              let endTime = Date.now();
              let time = endTime - startTime;
              setTime(time + " ms");
              setData(
                "x: " +
                  gyroData.x +
                  "," +
                  "y: " +
                  gyroData.y +
                  "," +
                  "z: " +
                  gyroData.z
              );
              hasData = true;
            }
          });
        }}
      />
      <View style={{ height: 20 }} />
      <Text>Giroscopio: {data}</Text>
    </View>
  );
};

export default GyroscopeScreen;
