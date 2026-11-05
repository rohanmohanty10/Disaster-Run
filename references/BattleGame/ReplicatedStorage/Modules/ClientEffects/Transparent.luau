-- Transparent — fades a character out/in (ported from the Kage Arena MudWall
-- teleport vanish). Differences from the original: it takes the character
-- Model directly instead of a network id, it covers everything on the rig
-- (weapons/hair included, not just R6 body parts + accessories), and it
-- remembers each part's original transparency so restoring is exact instead
-- of forcing everything to 0.
--
-- Usage:
--   local Transparent = require(ReplicatedStorage.Modules.ClientEffects.Transparent)
--   Transparent({ Character = attacker, State = true,  TweenTime = 0.15 }) -- fade out
--   Transparent({ Character = attacker, State = false, TweenTime = 0.15 }) -- fade back in
--   Transparent({ Character = attacker, State = false })                   -- instant restore (cancel)

local TweenService = game:GetService("TweenService")

local STORED_ATTRIBUTE = "PreHideTransparency"

-- Never touched: the root is always invisible, and these are rig internals
-- (same skips as the reference).
local IGNORED_NAMES = {
	HumanoidRootPart = true,
	Collide = true,
	FakeHead = true,
}

return function(options: { Character: Model, State: boolean, TweenTime: number?, EasingStyle: Enum.EasingStyle?, EasingDirection: Enum.EasingDirection? })
	local character = options.Character
	if not character then
		return
	end

	local hide = options.State == true

	local tweenInfo = nil
	if options.TweenTime and options.TweenTime > 0 then
		tweenInfo = TweenInfo.new(
			options.TweenTime,
			options.EasingStyle or Enum.EasingStyle.Quad,
			options.EasingDirection or Enum.EasingDirection.Out
		)
	end

	for _, inst in character:GetDescendants() do
		if not (inst:IsA("BasePart") or inst:IsA("Decal") or inst:IsA("Texture")) then
			continue
		end
		if IGNORED_NAMES[inst.Name] then
			continue
		end

		local target
		if hide then
			-- Remember the real transparency once, so hiding twice doesn't
			-- overwrite the stored value with 1.
			if inst:GetAttribute(STORED_ATTRIBUTE) == nil then
				inst:SetAttribute(STORED_ATTRIBUTE, inst.Transparency)
			end
			target = 1
		else
			target = inst:GetAttribute(STORED_ATTRIBUTE)
			if target == nil then
				continue -- was never hidden
			end
			inst:SetAttribute(STORED_ATTRIBUTE, nil)
		end

		if tweenInfo then
			TweenService:Create(inst, tweenInfo, { Transparency = target }):Play()
		else
			inst.Transparency = target
		end
	end
end