-- ReplicatedStorage > Modules > UpdateLog   (ModuleScript)
--
-- What the Update Log shows (the newspaper button at the top right, UpdateLogClient).
-- Newest update first. Add a new update by copying the block at the top. Each update has:
--   Version  shown in the list, e.g. "1.1"
--   Date     any text, e.g. "Nov 1, 2026"
--   Title    a short name for the update
--   Notes    the changes, one line each. A line starting with "#" is a small heading.

return {
	{
		Version = "1.0",
		Date = "Nov 1, 2026",
		Title = "Servers, Store and more",
		Notes = {
			"# New",
			"Servers menu: join public servers, create a free private server, or join one with its key",
			"This server's region and key are shown at the top right",
			"Weapons and the Marine Supply Crate can be bought with Robux, and gifted to friends",
			"Settings and the admin panel are one menu",
			"Update Log (you're reading it)",
			"# Changes",
			"Emotes is a tab of the Cosmetics menu",
			"The Store opens on Items",
			"New top bar look, with a button to hide it",
		},
	},
}
