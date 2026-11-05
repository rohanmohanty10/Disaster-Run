--Services
local Debris = game:GetService('Debris')
local TS = game:GetService('TweenService')
local SvSt = game:GetService('ServerStorage')

--Assets
local Assets = SvSt.Assets
local Animations = Assets.Animations

--Module
local module = {}
module.Timers = {} -- [StunFolder] = expiry thread

--Variables
local StunsTags = {
	'CantPunch',
	'CantDash',
	'CantSideDash',
	'CantBlock',
	'CantThrowable'
}

--Functions
local function TriggerTags(Character: Model, State: boolean)
	if not Character then return end
	for _, Tag in ipairs(StunsTags) do
		if State then
			Character:AddTag(Tag)
		else
			Character:RemoveTag(Tag)
		end
	end
end

-- Recompute stunned state from the set of live stun folders.
-- Character is stunned while AT LEAST ONE folder exists.
local function refresh(Character: Model)
	if not Character or not Character.Parent then return end

	local anyStun = false
	for _, f in Character:GetChildren() do
		if f:IsA("Folder") and f.Name == "Stunned" then
			anyStun = true
			break
		end
	end

	if anyStun then
		Character:AddTag('Stunned')
		Character:SetAttribute("Stunned", true)
		TriggerTags(Character, true)
	else
		Character:RemoveTag('Stunned')
		Character:SetAttribute("Stunned", nil)
		TriggerTags(Character, false)
	end
end

local function destroyStun(Stunned: Folder)
	local timer = module.Timers[Stunned]
	if timer then
		pcall(task.cancel, timer)
		module.Timers[Stunned] = nil
	end
	if Stunned.Parent then
		Stunned:Destroy()
	end
end

--Module Functions
function module:Stun(Character: Model, Duration, IgnoreImmunity, WalkSpeed: number, JumpPower: number, DestroyImmunity: boolean, IgnoreThrowable: boolean): Folder
	Duration = Duration or -1
	WalkSpeed = WalkSpeed or 0
	JumpPower = JumpPower or 0

	if not Character or not Character.Parent then return end
	local Player = game.Players:GetPlayerFromCharacter(Character)

	if (Player and Player.Commands.NoStun.Value == true) or (workspace.Configuration.NoStun.Value == true) or (not IgnoreImmunity and Character:HasTag('StunImmunity')) or (Duration ~= -1 and Duration < 0) then return end

	local Humanoid: Humanoid = Character.Humanoid

	if Character:FindFirstChild("ThrowablePart") and not IgnoreThrowable then
		local ThrowablePart: MeshPart = Character.ThrowablePart
		if not ThrowablePart:GetAttribute("BeingThrowed") then
			local ThrowableWeld = ThrowablePart:FindFirstChildOfClass("Weld")
			if ThrowableWeld then
				ThrowableWeld:Destroy()
			end
			ThrowablePart.CanCollide = true
			ThrowablePart.Parent = workspace.Thrown
			Debris:AddItem(ThrowablePart, 5)
			for _, v in Humanoid.Animator:GetPlayingAnimationTracks() do
				if v.Animation == Animations.Throwables.Pickup or v.Animation == Animations.Throwables.Idle or v.Animation == Animations.Throwables.Throw then
					v:Stop()
				end
			end
		end
	end

	-- NEW: additive, never destroys other stuns
	local Stunned = Instance.new("Folder")
	Stunned.Name = "Stunned"
	Stunned:SetAttribute("WalkSpeed", WalkSpeed)
	Stunned:SetAttribute("JumpPower", JumpPower)
	if DestroyImmunity then
		Stunned:AddTag('DestroyImmunity')
	end

	Stunned.Destroying:Once(function()
		local timer = module.Timers[Stunned]
		if timer then
			pcall(task.cancel, timer)
			module.Timers[Stunned] = nil
		end
		-- Destroying fires while still parented; recompute after removal
		task.defer(refresh, Character)
	end)

	Stunned.Parent = Character
	refresh(Character)

	-- A timed stun's expiry removes ONLY its own folder
	if Duration > 0 then
		module.Timers[Stunned] = task.delay(Duration, function()
			module.Timers[Stunned] = nil
			if Stunned.Parent then
				Stunned:Destroy()
			end
		end)
	end

	return Stunned
end

function module:RemoveAllStuns(Character: Model, IgnoreImmunity: boolean?)
	for _, Stunned in Character:GetChildren() do
		if Stunned:IsA("Folder") and Stunned.Name == "Stunned" and (IgnoreImmunity == true or not Stunned:HasTag('DestroyImmunity')) then
			destroyStun(Stunned)
		end
	end
	refresh(Character)
end

function module:Unstun(Character: Model, StunObject: Folder)
	if not Character or not Character:FindFirstChild('Humanoid') or Character.Humanoid.Health <= 0 or Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead then return end

	if StunObject then
		destroyStun(StunObject)      -- removes only this handle; refresh via Destroying
	else
		module:RemoveAllStuns(Character, true)  -- explicit blanket clear
	end
end

function module:IsStunned(Character: Model)
	return Character:FindFirstChild('Stunned') ~= nil or Character:HasTag('Stunned') or Character:GetAttribute("Stunned") == true
end

return module