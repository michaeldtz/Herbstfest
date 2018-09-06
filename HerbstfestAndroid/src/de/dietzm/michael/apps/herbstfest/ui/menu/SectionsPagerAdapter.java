package de.dietzm.michael.apps.herbstfest.ui.menu;

import java.util.Locale;

import de.dietzm.michael.apps.herbstfest.R;
import de.dietzm.michael.apps.herbstfest.R.string;
import de.dietzm.michael.apps.herbstfest.ui.MainActivity;
import de.dietzm.michael.apps.herbstfest.ui.PlaceholderFragment;

import android.app.Fragment;
import android.app.FragmentManager;
import android.support.v13.app.FragmentPagerAdapter;

/**
 * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
 * one of the sections/tabs/pages.
 */
public class SectionsPagerAdapter extends FragmentPagerAdapter {

	/**
	 * 
	 */
	private final MainActivity mainActivity;

	public SectionsPagerAdapter(MainActivity mainActivity, FragmentManager fm) {
		super(fm);
		this.mainActivity = mainActivity;
	}

	@Override
	public Fragment getItem(int position) {
		// getItem is called to instantiate the fragment for the given page.
		// Return a PlaceholderFragment (defined as a static inner class
		// below).
		return PlaceholderFragment.newInstance(position + 1);
	}

	@Override
	public int getCount() {
		// Show 3 total pages.
		return 3;
	}

	@Override
	public CharSequence getPageTitle(int position) {
		Locale l = Locale.getDefault();
		switch (position) {
		case 0:
			return this.mainActivity.getString(R.string.title_section1).toUpperCase(l);
		case 1:
			return this.mainActivity.getString(R.string.title_section2).toUpperCase(l);
		case 2:
			return this.mainActivity.getString(R.string.title_section3).toUpperCase(l);
		}
		return null;
	}
}