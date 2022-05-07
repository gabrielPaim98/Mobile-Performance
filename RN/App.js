import * as React from "react";
import { Button, View, Text } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import ListScreen from "./src/ListScreen.js";
import GyroscopeScreen from "./src/GyroscopeScreen";
import AccelerometerScreen from "./src/AccelerometerScreen";
import LocationScreen from "./src/LocationScreen";

function HomeScreen({ navigation }) {
  return (
    <View
      style={{
        flex: 1,
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      <Button
        title="Listagem"
        onPress={() => navigation.navigate("Listagem")}
      />
      <View style={{ height: 20 }} />
      <Button
        title="Localização"
        onPress={() => navigation.navigate("Localização")}
      />
      <View style={{ height: 20 }} />
      <Button
        title="Acelerometro"
        onPress={() => navigation.navigate("Acelerometro")}
      />
      <View style={{ height: 20 }} />
      <Button
        title="Giroscopio"
        onPress={() => navigation.navigate("Giroscopio")}
      />
    </View>
  );
}

const Stack = createNativeStackNavigator();

function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Tcc_RN" component={HomeScreen} />
        <Stack.Screen name="Listagem" component={ListScreen} />
        <Stack.Screen name="Localização" component={LocationScreen} />
        <Stack.Screen name="Acelerometro" component={AccelerometerScreen} />
        <Stack.Screen name="Giroscopio" component={GyroscopeScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default App;
