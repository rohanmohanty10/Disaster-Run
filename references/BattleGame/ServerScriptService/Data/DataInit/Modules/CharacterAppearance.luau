local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local CharacterAppearance = {}

function CharacterAppearance.Apply(Player: Player, Character: Model, 	HumanoidDescription: HumanoidDescription?)
	if not Player or (typeof(Player) == "Instance" and Player.UserId <= 0) or not Character or not Character.Parent then return end

	local userId = typeof(Player) == "Instance" and Player.UserId or Player
	local Humanoid: Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild("Humanoid", 5)
	if not Humanoid then return end

	local PlayersModel = Players:GetCharacterAppearanceAsync(userId)
	HumanoidDescription = HumanoidDescription or Players:GetHumanoidDescriptionFromUserId(userId)

	if HumanoidDescription then
		Humanoid:ApplyDescriptionAsync(HumanoidDescription)
	end

	if PlayersModel then
		local Face = PlayersModel:FindFirstChild('face')
		if Face then
			Character.Head.face.Texture = Face.Texture
		end

		PlayersModel:Destroy()
	end


	for _, Accessory: Accessory in Character:GetChildren() do
		if Accessory:IsA("Accessory") then
			local Handle: BasePart = Accessory:FindFirstChild("Handle")
			if Handle and Handle:FindFirstChildOfClass("Weld") then
				local AccessoryWeld = Handle:FindFirstChildOfClass("Weld")

				local Weld = Instance.new("Weld")
				Weld.Name = "WeldConstraint"
				Weld.Part1 = AccessoryWeld.Part1
				Weld.Part0 = Handle
				Weld.C0 = Handle.CFrame:ToObjectSpace(AccessoryWeld.Part1.CFrame)
				Weld.Parent = Accessory

				AccessoryWeld:Destroy()

				Handle.CanCollide = false
				Handle.CanQuery = false
				Handle.CanTouch = false
				Handle.Massless = true
				Handle.CollisionGroup = "Players"

				Accessory.Name = "#ACCESSORY_" .. Accessory.Name
				Accessory.Parent = Character.FakeHead
			end
		end
	end

	local NewOutfitApplied = Instance.new("Configuration")
	NewOutfitApplied.Name = "NewHumanoidDescriptionApplied"
	NewOutfitApplied.Parent = Character
	Debris:AddItem(NewOutfitApplied, 5)
end

return CharacterAppearance