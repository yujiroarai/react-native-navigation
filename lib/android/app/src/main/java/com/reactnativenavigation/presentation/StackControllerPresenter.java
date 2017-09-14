package com.reactnativenavigation.presentation;

import com.reactnativenavigation.parse.NavigationOptions;
import com.reactnativenavigation.viewcontrollers.StackController;

/**
 * Created by romanko on 9/14/17.
 */

public class StackControllerPresenter extends BasePresenter<StackController> {

	@Override
	public void applyOptions(NavigationOptions options) {
		controller.getTopBar().setTitle(options.title);
		controller.getTopBar().setBackgroundColor(options.topBarBackgroundColor);
		controller.getTopBar().setTitleTextColor(options.topBarTextColor);
		controller.getTopBar().setTitleFontSize(options.topBarTextFontSize);
	}

	public StackControllerPresenter(StackController controller) {
		super(controller);
	}

}
