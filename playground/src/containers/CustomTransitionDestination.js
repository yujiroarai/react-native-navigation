const React = require('react');
const { Component } = require('react');

const { View, TouchableOpacity, Image, Text, Button } = require('react-native');

const Navigation = require('react-native-navigation');

class CustomTransitionDestination extends Component {
  constructor(props) {
    super(props);
  }

  static get navigationOptions() {
    return {
      title: 'ye babyyyyyy',
      topBarTextFontFamily: 'HelveticaNeue-Italic',
      customTransition: true
    };
  }
  render() {
    return (
      <View style={styles.root}>
        <Navigation.SharedElement tag={5432335}>
          <Text>{"Hello!!!!"} </Text>
        </Navigation.SharedElement>
        <Text style={styles.h1}>{`Custom Transition Screen`}</Text>
      </View>
    );
  }
}
module.exports = CustomTransitionDestination;

const styles = {
  root: {
    flexGrow: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5fcff'
  },
  h1: {
    fontSize: 24,
    textAlign: 'center',
    margin: 10
  },
  footer: {
    fontSize: 10,
    color: '#888',
    marginTop: 10
  }
};
