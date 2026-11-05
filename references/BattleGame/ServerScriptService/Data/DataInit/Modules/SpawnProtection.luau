local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local SpawnProtection = {}

function SpawnProtection.new(ArenaMatch)
	-- Every spawn starts as the plain StarterCharacter rig and the avatar only goes on a moment later
	-- (after the data loads, on the first spawn). Like JS, the rig shows straight away but covered in a
	-- solid white glow; once the avatar is on, the glow thins to a pulsing outline (spawn protection)
	-- and pops off after 5 s, or when they move, M1 or hit someone. DamageHandler skips anyone with the
	-- SpawnProtected tag. The client's SpawnEffect does the camera and the ring when the glow appears.
	local PROTECT_TIME = 5
	local Covers = setmetatable({}, { __mode = "k" }) -- [character] = its SpawnGlow, until it's dressed

	local SpawnGlow

	local function CoverUntilDressed(character: Model)
		local Glow = Instance.new("Highlight")
		Glow.Name = "SpawnGlow"
		Glow.FillColor = Color3.new(1, 1, 1)
		Glow.OutlineColor = Color3.new(1, 1, 1)
		Glow.FillTransparency = 0
		Glow.OutlineTransparency = 0
		Glow.DepthMode = Enum.HighlightDepthMode.Occluded
		Glow.Parent = character
		if not ArenaMatch then -- the arena has its own spawn protection
			character:AddTag("SpawnProtected")
		end
		Covers[character] = Glow
		task.delay(15, function()
			if Covers[character] == Glow then -- the avatar never loaded: uncover the rig anyway
				SpawnGlow(character)
			end
		end)
	end

	-- flares bright for a moment, then pops off
	local function PopGlow(character: Model, Glow: Highlight)
		character:RemoveTag("SpawnProtected")
		character:SetAttribute("EndSpawnGlow", nil)
		Glow.FillTransparency = 0.3
		task.delay(0.08, function()
			TweenService:Create(Glow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
		end)
		Debris:AddItem(Glow, 0.5)
	end

	-- the avatar is on: the cover thins out to the pulsing glow, and protection runs from here
	function SpawnGlow(character: Model)
		local Glow = Covers[character]
		Covers[character] = nil
		if not Glow or not Glow.Parent then return end

		local Humanoid = character:FindFirstChildOfClass("Humanoid")
		local Root = character:FindFirstChild("HumanoidRootPart")
		if ArenaMatch or not Humanoid or not Root or Humanoid.Health <= 0 then
			PopGlow(character, Glow)
			return
		end

		local Pulse
		local Reveal = TweenService:Create(Glow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FillTransparency = 0.85 })
		Reveal.Completed:Once(function(State)
			if State == Enum.PlaybackState.Completed then
				Pulse = TweenService:Create(Glow, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { FillTransparency = 0.6 })
				Pulse:Play()
			end
		end)
		Reveal:Play()

		local Ended = false
		local Connections = {}
		local function End()
			if Ended then return end
			Ended = true
			for _, Connection in Connections do
				Connection:Disconnect()
			end
			Reveal:Cancel()
			if Pulse then
				Pulse:Cancel()
			end
			PopGlow(character, Glow)
		end
		table.insert(Connections, character.ChildAdded:Connect(function(Child)
			if Child.Name == "M1ing" then
				End()
			end
		end))
		table.insert(Connections, character:GetAttributeChangedSignal("EndSpawnGlow"):Connect(End)) -- DamageHandler

		task.spawn(function()
			local Started = os.clock()
			while not Ended and character.Parent and os.clock() - Started < PROTECT_TIME do
				local Speed = (Root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
				if Humanoid.MoveDirection.Magnitude > 0.1 or Speed > 3 then
					End()
				end
				task.wait(0.1)
			end
			End()
		end)
	end

	return {
		CoverUntilDressed = CoverUntilDressed,
		SpawnGlow = SpawnGlow,
	}
end

return SpawnProtection