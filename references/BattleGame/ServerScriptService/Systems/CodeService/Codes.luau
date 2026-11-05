-- ServerScriptService > Systems > CodeService > Codes   (ModuleScript, server only)
--
-- Every code players can redeem in the Store (bottom of the Items tab). Upper/lower case doesn't
-- matter. Each code can give any mix of:
--   Gold     = 500
--   Spins    = 1                       emote spins
--   Items    = { "ColaBomb", "Sniper" } item ids from ItemConfig, brought by a seagull
--   Expires  = "2026-12-31"            optional: last day it works (UTC)
-- To retire a code early, delete it or give it a past Expires date.

return {
	RELEASE = { Gold = 500 },
}
