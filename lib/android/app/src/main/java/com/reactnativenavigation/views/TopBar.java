package com.reactnativenavigation.views;

import android.app.Activity;
import android.support.annotation.Nullable;
import android.support.annotation.Size;
import android.support.design.widget.AppBarLayout;
import android.support.v7.widget.Toolbar;
import android.support.annotation.ColorInt;
import android.widget.TextView;

import java.lang.reflect.Field;

public class TopBar extends AppBarLayout {
	private final Toolbar titleBar;

	public TopBar(final Activity context) {
		super(context);
		titleBar = new Toolbar(context);
		addView(titleBar);
	}

	public void setTitle(String title) {
		titleBar.setTitle(title);
	}

	public String getTitle() {
		return titleBar.getTitle() != null ? titleBar.getTitle().toString() : "";
	}

	public void setTitleTextColor(@ColorInt int color) {
		titleBar.setTitleTextColor(color);
	}

	public void setTitleTextSize(int textSize) {
		TextView titleTextView = getTitleTextView();
		if (titleTextView != null) {
			titleTextView.setTextSize(textSize);
		}
	}

	public Toolbar getToolbar() {
		return titleBar;
	}

	@Nullable
	private TextView getTitleTextView() {
		try {
			Class<?> toolbarClass = Toolbar.class;
			Field titleTextViewField = toolbarClass.getDeclaredField("mTitleTextView");
			titleTextViewField.setAccessible(true);

			return (TextView) titleTextViewField.get(titleBar);
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return null;
	}
}
