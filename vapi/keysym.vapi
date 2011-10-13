/* keysym.vapi generated by valac 0.13.1, do not modify. */

[CCode (cprefix = "NeoLayoutViewer", lower_case_cprefix = "neo_layout_viewer_")]
namespace NeoLayoutViewer {
	[CCode (cheader_filename = "main.h")]
	public class KeyEventBox : Gtk.EventBox {
		public KeyEventBox (NeoLayoutViewer.NeoWindow winMain, int width, int height, ref uint[] keysym);
		public KeyEventBox.freeArea (NeoLayoutViewer.NeoWindow winMain, int width, int height);
		public KeyEventBox.modifier (NeoLayoutViewer.NeoWindow winMain, int width, int height, int modifier_index);
		public KeyEventBox.modifier2 (NeoLayoutViewer.NeoWindow winMain, int width, int height, int modifier_index);
		public override void size_request (out Gtk.Requisition requisition);
	}
	[CCode (cheader_filename = "main.h")]
	public class KeyOverlay : Gtk.VBox {
		public Gee.HashMap<int,NeoLayoutViewer.KeyEventBox> keyBoxes;
		public Gee.HashMap<int,NeoLayoutViewer.ArrayBox> keysyms;
		public KeyOverlay (NeoLayoutViewer.NeoWindow winMain);
		public void generateKeyevents ();
		public Gee.HashMap<int,NeoLayoutViewer.ArrayBox> generateKeysyms ();
	}
	[CCode (cheader_filename = "main.h")]
	public class KeybindingManager : GLib.Object {
		[CCode (cheader_filename = "main.h")]
		public delegate void KeybindingHandlerFunc (Gdk.Event event);
		public KeybindingManager (NeoLayoutViewer.NeoWindow neo_win);
		public void bind (string accelerator, NeoLayoutViewer.KeybindingManager.KeybindingHandlerFunc handler);
		public void bind2 (int keycode, string accelerator, int ebene, NeoLayoutViewer.KeybindingManager.KeybindingHandlerFunc handler);
		public Gdk.FilterReturn event_filter (Gdk.XEvent gdk_xevent, Gdk.Event gdk_event);
		public void unbind (string accelerator);
		public void unbind2 (int keycode);
	}
	[CCode (cheader_filename = "main.h")]
	public class NeoWindow : Gtk.Window {
		public int[] MODIFIER_MASK;
		public int[] NEO_MODIFIER_MASK;
		public int[] active_modifier;
		public Gee.HashMap<string,string> config;
		public int ebene;
		public int numblock_width;
		public Gtk.Label status;
		public NeoWindow (string sebene, Gee.HashMap<string,string> config);
		public void external_key_press (int iet1, int modifier_mask);
		public void external_key_release (int iet1, int modifier_mask);
		public Gdk.Pixbuf getIcon ();
		public void get_size2 (out int width, out int height);
		public override void hide_all ();
		public void load_image_buffer ();
		public void numkeypad_move (int pos);
		public Gdk.Pixbuf open_image (int ebene);
		public Gdk.Pixbuf open_image_str (string bildpfad);
		public void redraw ();
		public override void show_all ();
		public bool toggle ();
	}
	[CCode (cheader_filename = "main.h")]
	public static int main (string[] args);
}
