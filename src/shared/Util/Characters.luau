--!strict
-- Character helpers shared by combat code on both sides.
-- A character's role is the "Role" attribute ("Runner" / "God") on its Player,
-- or on the character model itself for NPCs and test dummies.

local Players = game:GetService("Players")

local Characters = {}

function Characters.GetHumanoid(character: Model): Humanoid?
	return character:FindFirstChildOfClass("Humanoid")
end

function Characters.GetRoot(character: Model): BasePart?
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = humanoid and humanoid.RootPart or character:FindFirstChild("HumanoidRootPart")
	return if root and root:IsA("BasePart") then root else nil
end

function Characters.IsAlive(character: Model?): boolean
	if not character or not character.Parent then
		return false
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	return humanoid ~= nil and humanoid.Health > 0 and humanoid:GetState() ~= Enum.HumanoidStateType.Dead
end

function Characters.GetPlayer(character: Model): Player?
	return Players:GetPlayerFromCharacter(character)
end

function Characters.GetRole(character: Model): string?
	local player = Players:GetPlayerFromCharacter(character)
	local role = if player then player:GetAttribute("Role") else character:GetAttribute("Role")
	return if type(role) == "string" then role else nil
end

-- The character model that owns a part (a limb, an accessory handle, a hitbox part).
function Characters.FromPart(part: Instance): Model?
	local model = part:FindFirstAncestorOfClass("Model")
	while model do
		if model:FindFirstChildOfClass("Humanoid") then
			return model
		end
		model = model:FindFirstAncestorOfClass("Model")
	end
	return nil
end

-- Accepts a Player or a character Model and returns the character.
function Characters.Resolve(subject: Player | Model | nil): Model?
	if subject == nil then
		return nil
	end
	if subject:IsA("Player") then
		return (subject :: Player).Character
	end
	return subject :: Model
end

return Characters
