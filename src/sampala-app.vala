/*
** Copyright (C) 2009 Tadej Borovšak <tadeboro@gmail.com>
**
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 2 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

using Gtk;
using Cairo;

public class Sample.App : Window
{
	private Gauge gauge;
	private bool  direction;

	public App()
	{
		ImageSurface back,
					 needle;
		string       path;

		set_title( _("Sample Vala application") );
		set_default_size( 300, 200 );
		this.destroy.connect( Gtk.main_quit );

		path = GLib.Path.build_filename( Config.PKGDATADIR, "images",
										 "gauge.png", null );
		back = new ImageSurface.from_png( path );

		path = GLib.Path.build_filename( Config.PKGDATADIR, "images",
										 "needle.png", null );
		needle = new ImageSurface.from_png( path );

		gauge = new Gauge( back, needle, 0, 100, 70, 231,
						   - 44, 7, 0, - Math.PI_2 );
		gauge.show();
		add( gauge );

		/* Install timeout to move gauge a bit */
		direction = true;
		Timeout.add( 50, move_gauge );
	}

	/* Helper functions */
	private bool move_gauge()
	{
		double tmp;

		tmp = gauge.current_value;
		if( ( tmp + 1 ) > 100 )
			direction = false;
		else if( ( tmp - 1 ) < 0 )
			direction = true;

		gauge.current_value = tmp + ( direction ? 1 : - 1 );

		return( true );
	}
}
