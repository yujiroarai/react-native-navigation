package com.reactnativenavigation.utils;

import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Typeface;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TypefaceLoader {
	private static final Map<String, Typeface> typefaceCache = new HashMap<>();

	public Typeface getTypeFace(Context context, String fontFamilyName) {
		if (fontFamilyName == null) {
			return null;
		}
		if (typefaceCache.containsKey(fontFamilyName)) {
			return typefaceCache.get(fontFamilyName);
		}
		Typeface result = load(context, fontFamilyName);
		typefaceCache.put(fontFamilyName, result);
		return result;
	}

	private Typeface load(Context context, String fontFamilyName) {
		int style = Typeface.NORMAL;
		try {
			if (context != null) {
				AssetManager assets = context.getAssets();
				List<String> fonts = Arrays.asList(assets.list("fonts"));
				if (fonts.contains(fontFamilyName + ".ttf")) {
					return Typeface.createFromAsset(assets, "fonts/" + fontFamilyName + ".ttf");
				}

				if (fonts.contains(fontFamilyName + ".otf")) {
					return Typeface.createFromAsset(assets, "fonts/" + fontFamilyName + ".otf");
				}
			}

			if (fontFamilyName.toLowerCase().contains("bold")) {
				style = Typeface.BOLD;
			} else if (fontFamilyName.toLowerCase().contains("italic")) {
				style = Typeface.ITALIC;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return Typeface.create(fontFamilyName, style);
	}
}

