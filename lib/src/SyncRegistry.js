const _ = require('lodash');
const React = require('react');
/// valid for react-native 44
const ReactNative = require('react-native/Libraries/Renderer/src/renderers/native/ReactNative.js');
const NativeModules = require('react-native').NativeModules;
const UIManager = NativeModules.UIManager;
const RCCSyncRegistry = NativeModules.RCCSyncRegistry;

const origCreateView = UIManager.createView;
const origSetChildren = UIManager.setChildren;

class SyncRegistry {
   static registerComponent(registeredName, componentGenerator, propNames) {

    const Template = componentGenerator();
    const props = {};
    for (const propName of propNames) {
      props[propName] = `__${propName}__`;
    }
    const recipe = [];
    prepareRecipeBySwizzlingUiManager(recipe);
    const rendered = ReactNative.render(<Template {...props} />, 1);
    restoreUiManager();
    RCCSyncRegistry.registerRecipe(registeredName, props, recipe);
  }
}

function prepareRecipeBySwizzlingUiManager(recipe) {
  UIManager.createView = (...args) => {
    recipe.push({ cmd: 'createView', args });
  }
  UIManager.setChildren = (...args) => {
    recipe.push({ cmd: 'setChildren', args });
  }
}

function restoreUiManager() {
  UIManager.createView = origCreateView;
  UIManager.setChildren = origSetChildren;
}

module.exports = SyncRegistry;
