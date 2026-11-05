--!strict
-- Admin panel settings. Admins can equip any kit instantly, give spins and run test tools.
-- Who counts as an admin (checked on the server):
--   * anyone in Studio
--   * the game's creator (or the group owner, for group games)
--   * the user ids listed in Admins below

local AdminConfig = {}

AdminConfig.Admins = {
	-- 123456789, -- add teammates' user ids here
} :: { number }

AdminConfig.ToggleKey = Enum.KeyCode.F2

-- Kits that are fully built (gameplay + their own effects). Shown first, marked in the panel.
AdminConfig.CompletedKits = {
	God = { "ThunderGod", "GravityLord" },
	Runner = {},
} :: { [string]: { string } }

return AdminConfig
