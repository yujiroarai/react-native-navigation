package com.reactnativenavigation.presentation;

import com.reactnativenavigation.parse.NavigationOptions;
import com.reactnativenavigation.viewcontrollers.ContainerViewController;

/**
 * Created by romanko on 9/14/17.
 */

public class ContainerViewControllerPresenter extends BasePresenter<ContainerViewController> {

	public ContainerViewControllerPresenter(ContainerViewController controller) {
		super(controller);
	}

	@Override
	public void applyOptions(NavigationOptions options) {
		if (controller.getParentStackController() != null) {
			controller.getParentStackController().getPresenter().applyOptions(options);
		}
	}
}
