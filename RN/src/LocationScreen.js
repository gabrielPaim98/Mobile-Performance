import React, { useState, useEffect } from "react";
import { View, Text, Button } from "react-native";
import * as Location from "expo-location";

const LocationScreen = (props) => {
  const [time, setTime] = useState("");
  const [location, setLocation] = useState("");

  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Text>Tempo decorrido: {time}</Text>
      <View style={{ height: 20 }} />
      <Button
        title="Localização"
        onPress={async () => {
          let { status } = await Location.requestForegroundPermissionsAsync();
          if (status !== "granted") {
            setLocation("Permission to access location was denied");
            return;
          }

          let startTime = Date.now();
          let l = await Location.getCurrentPositionAsync({});
          let endTime = Date.now();
          let time = endTime - startTime;
          setTime(time + " ms");
          setLocation(
            l.coords.latitude.toString() + ", " + l.coords.longitude.toString()
          );
        }}
      />
      <View style={{ height: 20 }} />
      <Text>Localização: {location}</Text>
    </View>
  );
};
export default LocationScreen;
