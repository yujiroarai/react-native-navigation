const React = require('react');
const { Component } = require('react');

const { View, TouchableOpacity, TouchableWithoutFeedback, Image, Text, Button } = require('react-native');

const Navigation = require('react-native-navigation');

class CustomTransitionDestination extends Component {
  constructor(props) {
    super(props);
    this.pop = this.pop.bind(this);
  }

  static get navigationOptions() {
    return {
      title: 'ye babyyyyyy',
      topBarTextFontFamily: 'HelveticaNeue-Italic',
      backButtonTransition: 'custom'
    };
  }
  pop() {
    Navigation.pop(this.props.containerId, {transition: {
            transitions: [{type:"sharedElement", fromId: "customDestinationImage", toId: "image2"}],
            duration: 0.4
          }});
  }
  render() {
    return (
      <View style={styles.root}>   
        <View>
          <Navigation.SharedElement type={"image"} elementId={"customDestinationImage"}>
            <Image style={{width:200, height:200}} source={require('../../img/Icon-87.png')} />
          </Navigation.SharedElement>  
        </View>
        <TouchableOpacity onPress={this.pop}>
         <Text style={styles.h1}>{`Custom Transition Screen`}</Text>
        </TouchableOpacity>
        <Text style={styles.p}>{`Lorem ipsum dolor sit amet, consectetur adipiscing elit,
           sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
           Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
           nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit 
           in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
          cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum`}</Text>
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
    textAlign: 'left',
    margin: 10
  },
  p: {
    fontSize: 14,
    margin: 10,
    textAlign: 'left'
  },
  footer: {
    fontSize: 10,
    color: '#888',
    marginTop: 10
  }
};
