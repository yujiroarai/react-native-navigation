const React = require('react');
const { Component } = require('react');

const { View, Text, Button, Image, TouchableOpacity, TouchableWithoutFeedback } = require('react-native');

const Navigation = require('react-native-navigation');
const CustomTransitionDestination = require('./CustomTransitionDestination')

let testCompon = new CustomTransitionDestination()
class SyncExample extends Component {
  render() {
    return (
     testCompon.render()
    );
  }
}
Navigation.SyncRegistry.registerComponent('SyncExample', () => SyncExample, ['name', 'greeting']);

class CustomTransitionOrigin extends Component {
  constructor(props) {
    super(props);
    this.onClickNavigationIcon = this.onClickNavigationIcon.bind(this);
  }
  static get navigationOptions() {
    return {

      topBarTextFontFamily: 'HelveticaNeue-Italic',

    };
  }
  render() {
    return (
      <View style={styles.root}>
        <Text style={styles.h1}>{`Custom Transition Screen`}</Text>
        <Navigation.SharedElement tag={5432333}>
        <TouchableOpacity activeOpacity={1} style={styles.gyroImage} onPress={this.onClickNavigationIcon}>
        <Text style={{backgroundColor: 'green'}}>{"Hello!!!!"} </Text>
        </TouchableOpacity>
        </Navigation.SharedElement>
      </View>
    );
  }
  onClickNavigationIcon() {
      Navigation.push( this.props.containerId, {
          name: 'navigation.playground.CustomTransitionDestination',
          transitionType: 'SharedElement',
          sharedElementTag: 5432333
      });
  }
}
module.exports = CustomTransitionOrigin;

const styles = {
  root: {
    flexGrow: 1,
    alignItems: 'center',
    backgroundColor: '#f5fcff'
  },
  h1: {
    fontSize: 24,
    textAlign: 'center',
    marginTop: 100
  },
  footer: {
    fontSize: 10,
    color: '#888',
    marginTop: 10
  },
gyroImage: {
    width: 100,
    height: 100
}
};

