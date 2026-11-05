-- StarterPlayer > StarterPlayerScripts > SpawnEffect   (LocalScript, client)
--
-- What you see when someone spawns (DataInit gives their character a white SpawnGlow):
--   everyone   the uppercut/downslam ring bursts out at their feet
--   you        your camera starts wide and settles in, the screen fades in from a light
--              grey, and a light shake (follows the Camera Shake setting)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

-- the same ring the uppercut and downslam use (Replication's "Ring" client task)
local function Ring(Character: Model)
	local Root = Character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not Root or not shared.repfire then
		return
	end

	-- at their feet, on the ground under them (they can spawn a little above it)
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = { Character, workspace.CurrentCamera }
	local Hit = workspace:Raycast(Root.Position, Vector3.new(0, -10, 0), Params)
	local Feet = if Hit then Hit.Position + Vector3.new(0, 0.3, 0) else Root.Position - Vector3.new(0, 2.7, 0)

	shared.repfire("Ring", {
		FirstProps = { Size = Vector3.new(0.6, 0.6, 0.6), Transparency = 0 },
		CF = CFrame.new(Feet) * Root.CFrame.Rotation,
		TN_Info = { Time = 0.25, Style = "Quad", Direction = "Out" },
		FinalProps = { Size = Vector3.new(12, 0.6, 12), Transparency = 1 },
	})
end

local function Camera()
	local CurrentCamera = workspace.CurrentCamera

	local Tint = Instance.new("ColorCorrectionEffect")
	Tint.Name = "SpawnTint"
	Tint.TintColor = Color3.fromRGB(150, 150, 150)
	Tint.Parent = Lighting
	TweenService:Create(Tint, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TintColor = Color3.new(1, 1, 1) }):Play()
	task.delay(0.4, Tint.Destroy, Tint)

	CurrentCamera.FieldOfView = 85
	TweenService:Create(CurrentCamera, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { FieldOfView = 70 }):Play()

	if shared.addshake then -- the character's Client script
		shared.addshake(0.8)
	end
end

local function Watch(Character: Model, Mine: boolean)
	local Glow = Character:WaitForChild("SpawnGlow", 20) :: Highlight?
	if not Glow then
		return
	end
	Ring(Character)
	if Mine then
		Camera()
	end
end

local function PlayerAdded(Other: Player)
	local Mine = Other == Player
	if Other.Character then
		task.spawn(Watch, Other.Character, Mine)
	end
	Other.CharacterAdded:Connect(function(Character)
		Watch(Character, Mine)
	end)
end

for _, Other in Players:GetPlayers() do
	PlayerAdded(Other)
end
Players.PlayerAdded:Connect(PlayerAdded)
