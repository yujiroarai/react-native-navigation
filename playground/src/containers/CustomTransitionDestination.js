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
      backButtonTransition: "custom"
    };
  }
  pop() {
    Navigation.pop(this.props.containerId, {transition: {
            transitions: [{type:"sharedElement", fromId: "5432335", toId: "5432333"},
                          {type:"sharedElement", fromId: "5432336", toId: "5432332"}],
            duration: 0.4
          }});
  }
  render() {
    return (
      <View style={styles.root}>
           <TouchableWithoutFeedback style={styles.gyroImage} onPress={this.pop}> 
            <View>
                <Navigation.SharedElement  elementId={"5432335"}>
                  <Image source={require('../../img/Icon-87.png')} />
                </Navigation.SharedElement>  
                <Navigation.SharedElement elementId={"5432336"}>
                  <Text style={{ width:100, height:50, backgroundColor:'red'}}>{'HELLOOOOOO'}</Text>
                </Navigation.SharedElement> 
            </View>
           </TouchableWithoutFeedback> 
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
