--!strict
-- Rotational event banners (GAME_PLAN.md Section 3B). Shared so the server's rolls and the
-- client's odds list agree. Pass `now` as Unix seconds: os.time() on the server,
-- workspace:GetServerTimeNow() on the client.

local Shared = script.Parent.Parent
local Kits = require(Shared.Data.Kits)
local GachaConfig = require(Shared.Config.GachaConfig)

local Banners = {}

function Banners.IsLive(banner: GachaConfig.Banner, now: number): boolean
	return banner.StartsAt <= now and now < banner.ExpiresAt
end

-- Live banners for a role, soonest-ending first.
function Banners.Active(role: string, now: number): { GachaConfig.Banner }
	local list = {}
	for _, banner in GachaConfig.Banners do
		if banner.Role == role and Banners.IsLive(banner, now) then
			table.insert(list, banner)
		end
	end
	table.sort(list, function(a, b)
		return a.ExpiresAt < b.ExpiresAt
	end)
	return list
end

-- Can this kit be rolled right now? Normal kits always; event kits only during a live banner
-- that lists them.
function Banners.IsRollable(role: string, kitId: string, now: number): boolean
	local kit = Kits.Get(role :: any, kitId)
	if not kit then
		return false
	end
	if not kit.Event then
		return true
	end
	for _, banner in Banners.Active(role, now) do
		if table.find(banner.Kits, kitId) then
			return true
		end
	end
	return false
end

-- The Secret the Lucky Secret pity guarantees while a banner runs, or nil.
function Banners.FeaturedSecret(role: string, now: number): string?
	for _, banner in Banners.Active(role, now) do
		local featured = banner.FeaturedSecret
		if featured then
			local kit = Kits.Get(role :: any, featured)
			if kit and kit.Rarity == "Secret" then
				return featured
			end
		end
	end
	return nil
end

return Banners
