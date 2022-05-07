/* eslint-disable prettier/prettier */
import * as React from 'react';
import {FlatList, StyleSheet, Image, Text, View} from 'react-native';
import data from '../MOCK_DATA.json';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 22,
    alignItems: 'center',
    alignSelf: 'stretch',
  },
  item: {
    padding: 16,
    fontSize: 18,
    height: 150,
    width: 150,
  },
  avatar: {
    height: 100,
    width: 100,
  },
});

function ListScreen() {
  return (
    <View style={styles.container}>
      <FlatList
        data={data}
        renderItem={({item}) => (
          <View style={styles.item}>
            <Image
              style={styles.avatar}
              source={{
                uri: item.image_url,
              }}
            />
            <Text style={styles.item}>{item.first_name}</Text>
          </View>
        )}
      />
    </View>
  );
}

export default ListScreen;
