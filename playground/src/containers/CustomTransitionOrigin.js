const React = require('react');
const { Component } = require('react');

const { View, Text, Button, Image, TouchableOpacity } = require('react-native');

const Navigation = require('react-native-navigation');
const CustomTransitionDestination = require('./CustomTransitionDestination')

// let testCompon = new CustomTransitionDestination()
// class SyncExample extends Component {
//   render() {
//     return (
//      testCompon.render()
//     );
//   }
// }
// Navigation.SyncRegistry.registerComponent('SyncExample', () => SyncExample, ['name', 'greeting']);

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
        <TouchableOpacity activeOpacity={0.5} style={styles.gyroImage} onPress={this.onClickNavigationIcon}>
          <View>
              <Navigation.SharedElement elementId={"5432333"}>
                <Image style={styles.gyroImage} source={require('../../img/Icon-87.png')} />
              </Navigation.SharedElement>
              <Navigation.SharedElement elementId={"5432332"}>
                  <Text style={{height: 50, width: 100, backgroundColor:'red'}}>{'HELLOOOOOO'}</Text>
              </Navigation.SharedElement> 
          </View>
        </TouchableOpacity>
       
      </View>
    );
  }
  onClickNavigationIcon() {
      Navigation.push( this.props.containerId, {
          name: 'navigation.playground.CustomTransitionDestination',
          transition: {
            transitions: [{type:"sharedElement", fromId: "5432333", toId: "5432335", interactivePop: true},
                          {type:"sharedElement", fromId: "5432332", toId: "5432336"}],
            duration: 0.4
          }
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

