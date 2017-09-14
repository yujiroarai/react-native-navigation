package com.reactnativenavigation.viewcontrollers;

import android.app.Activity;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;

import com.reactnativenavigation.presentation.BasePresenter;
import com.reactnativenavigation.utils.CompatUtils;
import com.reactnativenavigation.utils.StringUtils;

public abstract class ViewController<T extends BasePresenter> implements ViewTreeObserver.OnGlobalLayoutListener {

	private final Activity activity;
	private final String id;
	protected T presenter;

	private View view;
	private StackController parentStackController;
	private boolean isShown = false;

	public ViewController(Activity activity, String id) {
		this.activity = activity;
		this.id = id;
		presenter = initPresenter();
	}

	protected abstract T initPresenter();

	@NonNull
	protected abstract View createView();

	public void ensureViewIsCreated() {
		getView();
	}

	public boolean handleBack() {
		return false;
	}

	public Activity getActivity() {
		return activity;
	}

	@Nullable
	public StackController getParentStackController() {
		return parentStackController;
	}

	void setParentStackController(final StackController parentStackController) {
		this.parentStackController = parentStackController;
	}

	@NonNull
	public View getView() {
		if (view == null) {
			view = createView();
			view.setId(CompatUtils.generateViewId());
			view.getViewTreeObserver().addOnGlobalLayoutListener(this);
		}
		return view;
	}

	public String getId() {
		return id;
	}

	public boolean isSameId(final String id) {
		return StringUtils.isEqual(this.id, id);
	}

	@Nullable
	public ViewController findControllerById(String id) {
		return isSameId(id) ? this : null;
	}

	public void onViewAppeared() {
		//
	}

	public void onViewDisappear() {
		//
	}

	public void destroy() {
		if (isShown) {
			isShown = false;
			onViewDisappear();
		}
		if (view != null) {
			view.getViewTreeObserver().removeOnGlobalLayoutListener(this);
			if (view.getParent() instanceof ViewGroup) {
				((ViewGroup) view.getParent()).removeView(view);
			}
			view = null;
		}
	}

	@Override
	public void onGlobalLayout() {
		if (!isShown && isViewShown()) {
			isShown = true;
			onViewAppeared();
		} else if (isShown && !isViewShown()) {
			isShown = false;
			onViewDisappear();
		}
	}

	protected boolean isViewShown() {
		return getView().isShown();
	}

	public T getPresenter() {
		return presenter;
	}
}
