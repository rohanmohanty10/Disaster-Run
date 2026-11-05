--!strict
-- Tells the server's movement checks (MovementService) that a character is about to move faster
-- than it could on its own: a knockback, a dash, a ragdoll fling or a server teleport.
-- It only sets character attributes, so any script can call it without requiring services.
--
--   MoveGrace.Grant(character, 0.8)          -- skip speed checks for 0.8s
--   MoveGrace.Teleport(character, cframe)    -- move it, and don't count the jump

local MoveGrace = {}

local ATTRIBUTE = "MoveGraceUntil"

local function now(): number
	return workspace:GetServerTimeNow()
end

function MoveGrace.Grant(character: Model, seconds: number)
	local current = character:GetAttribute(ATTRIBUTE)
	local untilTime = now() + math.max(seconds, 0)
	if type(current) == "number" and current > untilTime then
		return
	end
	character:SetAttribute(ATTRIBUTE, untilTime)
end

function MoveGrace.Active(character: Model): boolean
	local current = character:GetAttribute(ATTRIBUTE)
	return type(current) == "number" and current > now()
end

-- Server-side teleport that the movement checks accept as legitimate.
function MoveGrace.Teleport(character: Model, cframe: CFrame)
	MoveGrace.Grant(character, 1)
	character:SetAttribute("TeleportedAt", now())
	character:PivotTo(cframe)
end

return MoveGrace
