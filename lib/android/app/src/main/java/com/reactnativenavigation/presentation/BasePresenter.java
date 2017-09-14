package com.reactnativenavigation.presentation;

import com.reactnativenavigation.parse.NavigationOptions;
import com.reactnativenavigation.viewcontrollers.ViewController;

/**
 * Created by romanko on 9/14/17.
 */

public abstract class BasePresenter<T extends ViewController> {

	protected T controller;

	public abstract void applyOptions(NavigationOptions options);

	public BasePresenter(T controller) {
		this.controller = controller;
	}
}
