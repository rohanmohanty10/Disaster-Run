--ServerScriptService/QOL/Dummies/Scripts/BlockScript
--
-- MODULESCRIPT. Driven by Dummies.server.luau via start(Dummy) -> cleanup.
-- See AttackScript for why dummy behaviour must not live inside the dummy.

local RNS = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local AnimationService = require(ServerStorage.SBGModules.AnimationService)
local Animations = ServerStorage.Assets.Animations

local BlockScript = {}

function BlockScript.start(Character: Model)
	local Humanoid: Humanoid = Character:FindFirstChild("Humanoid")
	if not Humanoid then
		return nil
	end

	local BlockConnection
	BlockConnection = RNS.Heartbeat:Connect(function()
		-- the dummy can now be destroyed out from under this loop
		if not Character.Parent or Humanoid.Health <= 0 then
			return
		end
		if Character:HasTag("CantBlock") or Character:HasTag("Blocking") or Character:HasTag("Stunned") then
			return
		end

		local Anim = Animations.Character.BlockIdle
		local BlockAnimTrack = AnimationService:getAnimationTrack(Character, Anim)
		if not BlockAnimTrack then
			return
		end

		-- Play BEFORE tagging. The old order tagged 'Blocking' unconditionally after
		-- calling playAnimation, so whenever playAnimation bailed (it returns nil while
		-- Ragdolled) the tag stuck with no Stopped event to ever clear it -- and the
		-- gate above reads that same tag, so the dummy never blocked again.
		local Played = AnimationService:playAnimation(Character, Anim)
		if not Played then
			return
		end

		Character:AddTag("Blocking")

		-- connected only once we know it's playing, so a failed start can't stack extra
		-- Stopped handlers on this cached track
		BlockAnimTrack.Stopped:Once(function()
			Character:RemoveTag("Blocking")
		end)
	end)

	return function()
		BlockConnection:Disconnect()
		Character:RemoveTag("Blocking")
	end
end

return BlockScript
