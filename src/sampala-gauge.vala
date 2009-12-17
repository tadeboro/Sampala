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

public class Sample.Gauge : DrawingArea
{
	/* Private fields */
	private int    width;
	private int    height;
	private double angle;

	/* Property backing fileds */
	private double _current_value;

	/* Properties */
	[Property(nick = "Background image", blurb = "Background image")]
	public ImageSurface background{ get; construct; }

	[Property(nick = "Needle", blurb = "Gauge needle image")]
	public ImageSurface needle{ get; construct; }

	[Property(nick = "Needle x offset", blurb = "Needle x offset")]
	public double needle_x_offset{ get; construct; default = 0; }

	[Property(nick = "Needle y offset", blurb = "Needle y offset")]
	public double needle_y_offset{ get; construct; default = 0; }

	[Property(nick = "Needle center x", blurb = "Needle center y")]
	public double needle_center_x{ get; construct; default = 0; }

	[Property(nick = "Neelde center y", blurb = "Needle center y")]
	public double needle_center_y{ get; construct; default = 0; }

	[Property(nick = "Minimal value", blurb = "Minimal value")]
	public double min_value{ get; construct; default = 0; }

	[Property(nick = "Maximal value", blurb = "Maximal value")]
	public double max_value{ get; construct; default = 90; }

	[Property(nick = "Current value", blurb = "Current value being displayed")]
	public double current_value
	{
		get{ return( _current_value ); }
		set{ update_current_value( value ); }
	}

	[Property(nick = "Minimal position", blurb = "Angle of minimal position")]
	public double min_angle{ get; construct; }

	[Property(nick = "Maximal position", blurb = "Angle at maximal value")]
	public double max_angle{ get; construct; default = GLib.Math.PI_2; }

	/* Constructor */
	public Gauge( ImageSurface background,
				  ImageSurface needle,
				  double       min_value = 0,
				  double       max_value = 90,
				  double       center_x = 0,
				  double       center_y = 0,
				  double       offset_x = 0,
				  double       offset_y = 0,
				  double       min_angle = 0,
				  double       max_angle = GLib.Math.PI_2 )
	{
		/* Instantiate new object using construction values */
		GLib.Object( background:      background,
					 needle:          needle,
					 min_value:       min_value,
					 max_value:       max_value,
					 needle_center_x: center_x,
					 needle_center_y: center_y,
					 needle_x_offset: offset_x,
					 needle_y_offset: offset_y,
					 min_angle:       min_angle,
					 max_angle:       max_angle );

		/* Get background image dimensions and set size request to match */
		width  = background.get_width();
		height = background.get_height();
		set_size_request( width, height );

		/* Update current value and calculate proper angle for it */
		current_value = min_value;
		update_current_value( min_value );
	}

	/* Expose handler */
	public override bool expose_event( Gdk.EventExpose event )
	{
		var cr = Gdk.cairo_create( event.window );

		cr.set_source_surface( background, 0, 0 );
		cr.paint();

		cr.translate( needle_center_x, needle_center_y );
		cr.rotate( angle );
		cr.set_source_surface( needle, - needle_x_offset, - needle_y_offset );
		cr.paint();

		return( true );
	}

	/* Private methods */
	private void update_current_value( double val )
	{
		double fraction;

		_current_value = val;
		fraction = val / ( max_value - min_value );
		angle = min_angle + ( max_angle - min_angle ) * fraction;

		/* Force redraw of gauge */
		queue_draw();
	}
}
