-- ReplicatedStorage > Modules > ClientEffects > ItemEffects   (ModuleScript, client)
--
-- Visuals for the items and the seagull delivery. ItemService fires these to every client with
-- ClientEffects:FireAllClients("ItemEffects", { SkillType = ..., ... }).
--
-- Optional extras (anything missing is skipped):
--   ReplicatedStorage > Assets > Sounds > Items > SniperFire, SniperBolt, ScopeIn, ScopeOut,
--       BulletHit, GunBreak, ColaFuse, ColaExplode, SeagullCaw, PackageLand   (Sounds)
--   ReplicatedStorage > Assets > Items > FX > ColaExplosion   (a Part/Model of ParticleEmitters;
--       it's emitted on top of the built-in blast)
--   ReplicatedStorage > Assets > Items > Package   (your own package model for the seagull)
--   Sounds BombExplode, DenDenRing   (Muggy Ball / Buster Call)

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local ItemConfig = require(ReplicatedStorage.Modules.ItemConfig)

local ItemModels = ReplicatedStorage.Assets.Items
local SoundsFolder = ReplicatedStorage.Assets.Sounds:FindFirstChild("Items")
local EffectsFolder = ReplicatedStorage.Assets:FindFirstChild("Effects")
local EffectItems = EffectsFolder and EffectsFolder:FindFirstChild("Items") -- Assets > Effects > Items > Buggyball etc.

local MAX_DISTANCE = 400 -- effects farther than this from the camera are skipped

local function Visuals(): Instance
	local World = workspace:FindFirstChild("World")
	return World and World:FindFirstChild("Visuals") or workspace
end

local function Near(Position: Vector3): boolean
	local Camera = workspace.CurrentCamera
	return not Camera or (Position - Camera.CFrame.Position).Magnitude < MAX_DISTANCE
end

local function Sound(Name: string, Where: Instance)
	local Template = SoundsFolder and SoundsFolder:FindFirstChild(Name)
	if not (Template and Template:IsA("Sound")) then
		return
	end
	local Copy = Template:Clone()
	Copy.Parent = Where
	Copy:Play()
	Debris:AddItem(Copy, Copy.TimeLength + 1)
end

-- a sound at a spot in the world
local function SoundAt(Name: string, Position: Vector3)
	local Holder = Instance.new("Attachment")
	Holder.WorldPosition = Position
	Holder.Parent = workspace.Terrain
	Sound(Name, Holder)
	Debris:AddItem(Holder, 6)
end

local function Bit(Props: { [string]: any }): BasePart
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.CastShadow = false
	Part.Material = Enum.Material.Neon
	for Key, Value in Props do
		Part[Key] = Value
	end
	Part.Parent = Props.Parent or Visuals()
	return Part
end

-- pieces that fly out of a spot and shrink away
local function Shards(Position: Vector3, Count: number, Color: Color3, Speed: number)
	for _ = 1, Count do
		local Piece = Instance.new("Part")
		Piece.Size = Vector3.one * math.random(15, 45) / 100
		Piece.Color = Color
		Piece.Material = Enum.Material.SmoothPlastic
		Piece.CanCollide = false
		Piece.CanQuery = false
		Piece.CanTouch = false
		Piece.CFrame = CFrame.new(Position) * CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)
		Piece.AssemblyLinearVelocity = Vector3.new(math.random(-100, 100), math.random(20, 100), math.random(-100, 100)) / 100 * Speed
		Piece.AssemblyAngularVelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
		Piece.Parent = Visuals()
		TweenService:Create(Piece, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.6), { Size = Vector3.zero }):Play()
		Debris:AddItem(Piece, 1.5)
	end
end

local function Flash(Target: Instance, Color: Color3, Time: number)
	local Glow = Instance.new("Highlight")
	Glow.FillColor = Color
	Glow.FillTransparency = 0.1
	Glow.OutlineTransparency = 1
	Glow.DepthMode = Enum.HighlightDepthMode.Occluded
	Glow.Parent = Target
	TweenService:Create(Glow, TweenInfo.new(Time), { FillTransparency = 1 }):Play()
	Debris:AddItem(Glow, Time + 0.05)
end

local function Muzzle(Character: Model?): BasePart?
	local Held = Character and Character:FindFirstChild("HeldItem")
	return Held and Held:IsA("Model") and Held.PrimaryPart or nil
end

------------------------------------------------------------------------
local Bullets: { [number]: { Part: BasePart, Connection: RBXScriptConnection } } = {}

local function EndBullet(Id: number)
	local Bullet = Bullets[Id]
	if Bullet then
		Bullets[Id] = nil
		Bullet.Connection:Disconnect()
		Bullet.Part:Destroy()
	end
end

local Effects = {}

-- The seagull flies in, lets go of the package over the drop spot, and flies off.
-- Its position comes from the server clock, so every player sees it drop at the same moment.
function Effects.Seagull(Data)
	local Delivery = ItemConfig.Delivery
	local Template = ItemModels:FindFirstChild(Delivery.Model)
	if not Template or not (Near(Data.Drop) or Near(Data.From)) then
		return
	end
	local Gull = Template:Clone()
	for _, Part in Gull:GetDescendants() do
		if Part:IsA("BasePart") then
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
		end
	end
	Gull.Parent = Visuals()

	local Controller = Gull:FindFirstChildOfClass("AnimationController")
	local FlyAnimation = Gull:FindFirstChild("Flying")
	if Controller and FlyAnimation and FlyAnimation:IsA("Animation") then
		local Animator = Controller:FindFirstChildOfClass("Animator") or Instance.new("Animator", Controller)
		local Track = Animator:LoadAnimation(FlyAnimation)
		Track.Looped = true
		Track:Play(0)
	end

	-- the package it carries; swapped for the server's real one when it lets go
	local PackageTemplate = ItemModels:FindFirstChild("Package")
	local Carried: PVInstance
	if PackageTemplate then
		Carried = PackageTemplate:Clone()
		for _, Part in Carried:GetDescendants() do
			if Part:IsA("BasePart") then
				Part.Anchored = true
				Part.CanCollide = false
			end
		end
		Carried.Parent = Visuals()
	else
		Carried = Bit({ Size = Vector3.new(2.6, 2.2, 2.6), Material = Enum.Material.WoodPlanks, Color = Color3.fromRGB(150, 108, 66) })
	end

	local Across = Vector3.new(Data.To.X - Data.From.X, 0, Data.To.Z - Data.From.Z).Unit
	local Turn = CFrame.Angles(0, math.rad(Delivery.ModelYaw), 0)
	local Total = Data.ArriveTime + Data.LeaveTime
	local Cawed = false
	local Connection
	Connection = RunService.RenderStepped:Connect(function()
		local T = workspace:GetServerTimeNow() - Data.StartAt
		if T >= Total or not Gull.Parent then
			Connection:Disconnect()
			Gull:Destroy()
			if Carried.Parent then
				Carried:Destroy()
			end
			return
		end
		local Position, Tilt
		if T < Data.ArriveTime then
			local A = math.max(T, 0) / Data.ArriveTime
			Position = Data.From:Lerp(Data.Drop, 1 - (1 - A) ^ 2) -- slows down as it reaches the drop
			Tilt = -0.15 * (1 - A)
		else
			local A = (T - Data.ArriveTime) / Data.LeaveTime
			Position = Data.Drop:Lerp(Data.To, A * A) -- speeds back up as it leaves
			Tilt = 0.25 * A
			if Carried.Parent then
				Carried:Destroy()
			end
		end
		Position += Vector3.yAxis * math.sin(T * 6) * 0.6 -- wing-beat bob
		local Body = CFrame.lookAlong(Position, Across) * CFrame.Angles(Tilt, 0, 0)
		Gull:PivotTo(Body * Turn)
		if Carried.Parent then
			Carried:PivotTo(CFrame.new(Position - Vector3.yAxis * 3) * Body.Rotation)
		end
		if not Cawed and T > 0 then
			Cawed = true
			Sound("SeagullCaw", Gull.PrimaryPart or Gull:FindFirstChildWhichIsA("BasePart", true))
		end
	end)
end

function Effects.PackageLand(Data)
	if not Near(Data.Position) then
		return
	end
	SoundAt("PackageLand", Data.Position)
	local Ring = Bit({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.2, 2, 2),
		CFrame = CFrame.new(Data.Position - Vector3.yAxis) * CFrame.Angles(0, 0, math.pi / 2),
		Color = Color3.fromRGB(230, 215, 190),
		Transparency = 0.3,
		Material = Enum.Material.SmoothPlastic,
	})
	TweenService:Create(Ring, TweenInfo.new(0.5, Enum.EasingStyle.Quad), { Size = Vector3.new(0.2, 10, 10), Transparency = 1 }):Play()
	Debris:AddItem(Ring, 0.55)
end

function Effects.Scope(Data)
	local Root = Data.Character and Data.Character:FindFirstChild("HumanoidRootPart")
	if Root then
		Sound(if Data.On then "ScopeIn" else "ScopeOut", Root)
	end
end

function Effects.SniperFire(Data)
	local Gun = Muzzle(Data.Character)
	local From = Data.Muzzle
	if Gun then
		local Size = Gun.Size
		From = (Gun.CFrame * CFrame.new(0, 0, -math.max(Size.X, Size.Y, Size.Z) / 2)).Position
		Sound("SniperFire", Gun)
		local Light = Instance.new("PointLight")
		Light.Color = Color3.fromRGB(255, 200, 120)
		Light.Brightness = 15
		Light.Range = 16
		Light.Parent = Gun
		TweenService:Create(Light, TweenInfo.new(0.6), { Brightness = 0 }):Play()
		Debris:AddItem(Light, 0.65)
	end
	if not Near(From) then
		return
	end
	local Spark = Bit({ Shape = Enum.PartType.Ball, Size = Vector3.one * 1.4, CFrame = CFrame.new(From), Color = Color3.fromRGB(255, 220, 150) })
	TweenService:Create(Spark, TweenInfo.new(0.12), { Size = Vector3.one * 2.6, Transparency = 1 }):Play()
	Debris:AddItem(Spark, 0.15)

	-- the tracer flies along the same line, at the same speed, as the server's bullet
	local Direction: Vector3 = Data.Direction
	local Tracer = Bit({ Size = Vector3.new(0.12, 0.12, 7), Color = Color3.fromRGB(255, 236, 190) })
	local Started = os.clock()
	local Connection = RunService.RenderStepped:Connect(function()
		local Distance = (os.clock() - Started) * Data.Speed
		if Distance > ItemConfig.Items.Sniper.Range then
			EndBullet(Data.Id)
			return
		end
		Tracer.CFrame = CFrame.lookAlong(From + Direction * Distance, Direction)
	end)
	Bullets[Data.Id] = { Part = Tracer, Connection = Connection }
	Tracer.CFrame = CFrame.lookAlong(From, Direction)
end

function Effects.BulletEnd(Data)
	EndBullet(Data.Id)
	if not Near(Data.Position) then
		return
	end
	if Data.Victim then
		Flash(Data.Victim, Color3.new(1, 1, 1), 0.25)
		SoundAt("BulletHit", Data.Position)
		Shards(Data.Position, 6, Color3.fromRGB(255, 230, 170), 25)
	else
		Shards(Data.Position, 5, Color3.fromRGB(120, 110, 100), 18)
	end
end

function Effects.SniperBolt(Data)
	local Gun = Muzzle(Data.Character)
	if not Gun or not Near(Gun.Position) then
		return
	end
	Sound("SniperBolt", Gun)
	task.wait(0.1)
	local Casing = Instance.new("Part")
	Casing.Size = Vector3.new(0.12, 0.12, 0.35)
	Casing.Material = Enum.Material.Metal
	Casing.Color = Color3.fromRGB(210, 170, 70)
	Casing.CanCollide = false
	Casing.CanQuery = false
	Casing.CanTouch = false
	Casing.CFrame = Gun.CFrame
	Casing.AssemblyLinearVelocity = Gun.CFrame.RightVector * 14 + Vector3.yAxis * 12
	Casing.AssemblyAngularVelocity = Vector3.new(20, 5, 10)
	Casing.Parent = Visuals()
	Debris:AddItem(Casing, 1.5)
end

-- the sniper's last shot: it breaks apart in your hands
function Effects.ItemBreak(Data)
	if not Near(Data.Position) then
		return
	end
	SoundAt("GunBreak", Data.Position)
	Shards(Data.Position, 10, Color3.fromRGB(35, 35, 35), 40)
end

-- the thrown bomb blinks white faster and faster until it goes off
function Effects.ColaFuse(Data)
	local Bomb: Model? = Data.Bomb
	if not Bomb or not Bomb.Parent then
		return
	end
	Sound("ColaFuse", Bomb.PrimaryPart or Bomb)
	local Glow = Instance.new("Highlight")
	Glow.FillColor = Color3.new(1, 1, 1)
	Glow.FillTransparency = 1
	Glow.OutlineTransparency = 1
	Glow.DepthMode = Enum.HighlightDepthMode.Occluded
	Glow.Parent = Bomb
	local Ends = os.clock() + Data.Fuse
	task.wait(0.25)
	while Bomb.Parent and os.clock() < Ends do
		local Left = Ends - os.clock()
		local Beat = if Left > 1.2 then 0.25 else 0.1
		TweenService:Create(Glow, TweenInfo.new(Beat), { FillTransparency = 0.2 }):Play()
		task.wait(Beat)
		TweenService:Create(Glow, TweenInfo.new(Beat), { FillTransparency = 1 }):Play()
		task.wait(Beat)
	end
end

function Effects.ColaExplode(Data)
	local Position: Vector3 = Data.Position
	if not Near(Position) then
		return
	end
	SoundAt("ColaExplode", Position)
	local Radius = Data.Radius
	local Core = Bit({ Shape = Enum.PartType.Ball, Size = Vector3.one * 3, CFrame = CFrame.new(Position), Color = Color3.fromRGB(255, 190, 90) })
	local Foam = Bit({
		Shape = Enum.PartType.Ball,
		Size = Vector3.one * 2,
		CFrame = CFrame.new(Position),
		Color = Color3.fromRGB(110, 60, 30), -- cola
		Material = Enum.Material.SmoothPlastic,
		Transparency = 0.2,
	})
	local Light = Instance.new("PointLight")
	Light.Color = Color3.fromRGB(255, 170, 80)
	Light.Brightness = 12
	Light.Range = Radius * 2.5
	Light.Parent = Core
	TweenService:Create(Core, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { Size = Vector3.one * Radius * 1.3, Transparency = 1 }):Play()
	TweenService:Create(Foam, TweenInfo.new(0.55, Enum.EasingStyle.Quint), { Size = Vector3.one * Radius * 1.7, Transparency = 1 }):Play()
	TweenService:Create(Light, TweenInfo.new(0.6), { Brightness = 0 }):Play()
	Debris:AddItem(Core, 0.65)
	Debris:AddItem(Foam, 0.6)
	Shards(Position, 14, Color3.fromRGB(120, 66, 34), 70)

	local Extra = ItemModels:FindFirstChild("FX") and ItemModels.FX:FindFirstChild("ColaExplosion")
	if Extra then
		local Copy = Extra:Clone()
		if Copy:IsA("BasePart") then
			Copy.Anchored = true
			Copy.CanCollide = false
			Copy.Position = Position
		elseif Copy:IsA("Model") then
			Copy:PivotTo(CFrame.new(Position))
		end
		Copy.Parent = Visuals()
		EffectUtilities.Emit(Copy)
		EffectUtilities.Debris(Copy, 5)
	end
end

------------------------------------------------------------------------
-- Muggy Ball and Buster Call
------------------------------------------------------------------------
local BLINK_BEAT = 0.1 -- seconds per flash, like the revive bombs
local BOMB_PINK = Color3.fromRGB(255, 25, 160) -- the Muggy Ball's dot (Portal Asylum's revive bombs)

-- Assets > Effects > Items > <Name> > explosion, emitted the way its attributes say
-- (EmitCount / EmitDelay / EmitDuration). Amount scales every EmitCount; Scale makes the whole
-- explosion bigger or smaller (particle sizes, speeds and where they start).
local function Explosion(Name: string?, Position: Vector3, Amount: number, Scale: number?)
	local Folder = Name and EffectItems and EffectItems:FindFirstChild(Name)
	local Template = Folder and Folder:FindFirstChild("explosion")
	if not (Template and Template:IsA("BasePart")) then
		return
	end
	local Size = Scale or 1
	local Copy = Template:Clone()
	Copy.Anchored = true
	Copy.CanCollide = false
	Copy.CanQuery = false
	Copy.CanTouch = false
	Copy.Size *= Size
	Copy.CFrame = CFrame.new(Position)
	local Longest = 0
	for _, Emitter in Copy:GetDescendants() do
		if Emitter:IsA("Attachment") then
			Emitter.Position *= Size
		end
		if not Emitter:IsA("ParticleEmitter") then
			continue
		end
		if Size ~= 1 then
			local Keys = {}
			for _, Key in Emitter.Size.Keypoints do
				table.insert(Keys, NumberSequenceKeypoint.new(Key.Time, Key.Value * Size, Key.Envelope * Size))
			end
			Emitter.Size = NumberSequence.new(Keys)
			Emitter.Speed = NumberRange.new(Emitter.Speed.Min * Size, Emitter.Speed.Max * Size)
			Emitter.Acceleration *= Size
		end
		local Count = tonumber(Emitter:GetAttribute("EmitCount")) or 0
		local Delay = tonumber(Emitter:GetAttribute("EmitDelay")) or 0
		local Duration = tonumber(Emitter:GetAttribute("EmitDuration")) or 0
		Count = if Count > 0 then math.max(1, math.round(Count * Amount)) else 0
		Emitter.Enabled = false
		task.delay(Delay, function()
			if not Emitter.Parent then
				return
			end
			if Count > 0 then
				Emitter:Emit(Count)
			end
			if Duration > 0 then
				Emitter.Enabled = true
				task.delay(Duration, function()
					Emitter.Enabled = false
				end)
			end
		end)
		Longest = math.max(Longest, Delay + Duration + Emitter.Lifetime.Max)
	end
	Copy.Parent = Visuals()
	Debris:AddItem(Copy, Longest + 0.5)
end

local function RedLight(Position: Vector3, Range: number, Brightness: number, Time: number)
	local Holder = Instance.new("Attachment")
	Holder.WorldPosition = Position + Vector3.yAxis * 3
	Holder.Parent = workspace.Terrain
	local Light = Instance.new("PointLight")
	Light.Color = Color3.fromRGB(255, 60, 40)
	Light.Brightness = Brightness
	Light.Range = Range
	Light.Parent = Holder
	TweenService:Create(Light, TweenInfo.new(Time), { Brightness = 0 }):Play()
	Debris:AddItem(Holder, Time + 0.05)
end

-- once the Muggy Ball lands, the pink Light on top flips between solid and faded every 0.1s
function Effects.BombBlink(Data)
	local Bomb: Model? = Data.Bomb
	local Light = Bomb and Bomb:FindFirstChild("Light", true)
	if not (Light and Light:IsA("BasePart")) then
		return
	end
	local Glow = Instance.new("PointLight")
	Glow.Color = BOMB_PINK
	Glow.Range = 10
	Glow.Brightness = 0
	Glow.Parent = Light
	local Started = false
	local Connection
	Connection = RunService.RenderStepped:Connect(function()
		if not Light:IsDescendantOf(workspace) then
			Connection:Disconnect()
			return
		end
		local T = workspace:GetServerTimeNow() - Data.BlinkAt
		local On = T >= 0 and math.floor(T / BLINK_BEAT) % 2 == 0
		Light.Transparency = if On then 0 else 0.65
		Glow.Brightness = if On then 4 else 0
		if T >= 0 and not Started then
			Started = true
			Sound("ColaFuse", Light)
		end
	end)
end

function Effects.BombExplode(Data)
	local Position: Vector3 = Data.Position
	if not Near(Position) then
		return
	end
	SoundAt("BombExplode", Position)
	Explosion(Data.Explosion, Position, 1)
	RedLight(Position, Data.Radius * 2.5, 14, 0.7)
	Shards(Position, 12, Color3.fromRGB(60, 18, 18), 70)
end

-- The snail rings: a comic speech bubble pops out of it saying "Puru puru puru..." and shakes with
-- each ring while the ringtone loops (Sounds > Items > DenDenRing). When the call goes through it
-- says "Kacha!" (DenDenGacha, the receiver being picked up) right before the barrage.
local TextService = game:GetService("TextService")
local BUBBLE_FONT = Enum.Font.BuilderSansMedium
local BUBBLE_TEXT = 16

-- looks like Roblox's default chat bubble: off-white, rounded, dark grey text, a caret underneath
local function RingBubble(Adornee: Attachment): ((string) -> (), UIScale, BillboardGui, TextLabel)
	local Bubble = Instance.new("BillboardGui")
	Bubble.Name = "DenDenBubble"
	Bubble.Adornee = Adornee
	Bubble.StudsOffsetWorldSpace = Vector3.new(0, 1.1, 0) -- just above the snail
	Bubble.AlwaysOnTop = true
	Bubble.MaxDistance = 120
	Bubble.LightInfluence = 0
	local Scale = Instance.new("UIScale")
	Scale.Scale = 0
	Scale.Parent = Bubble
	local Body = Instance.new("Frame")
	Body.Size = UDim2.new(1, 0, 1, -8)
	Body.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
	Body.BackgroundTransparency = 0.1
	Body.BorderSizePixel = 0
	Body.Parent = Bubble
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 12)
	Corner.Parent = Body
	local Caret = Instance.new("ImageLabel")
	Caret.Image = "rbxasset://textures/ui/InGameChat/Caret.png"
	Caret.BackgroundTransparency = 1
	Caret.ImageColor3 = Body.BackgroundColor3
	Caret.ImageTransparency = Body.BackgroundTransparency
	Caret.Size = UDim2.fromOffset(12, 8)
	Caret.AnchorPoint = Vector2.new(0.5, 0)
	Caret.Position = UDim2.new(0.5, 0, 1, -8)
	Caret.Parent = Bubble
	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.fromScale(1, 1)
	Label.BackgroundTransparency = 1
	Label.Font = BUBBLE_FONT
	Label.TextSize = BUBBLE_TEXT
	Label.TextColor3 = Color3.fromRGB(57, 59, 61)
	Label.Parent = Body
	Bubble.Parent = Adornee
	-- sized to its text, like chat bubbles
	local function SetText(Text: string)
		Label.Text = Text
		local Bounds = TextService:GetTextSize(Text, BUBBLE_TEXT, BUBBLE_FONT, Vector2.new(400, 100))
		Bubble.Size = UDim2.fromOffset(Bounds.X + 24, Bounds.Y + 16 + 8)
	end
	return SetText, Scale, Bubble, Label
end

function Effects.BusterCallRing(Data)
	local Character: Model? = Data.Character
	if not Character then
		return
	end
	-- the bubble comes out of the snail in their hand (the held model), or their head if it's gone
	local Held = Character:FindFirstChild("HeldItem")
	local Snail = (Held and (Held:IsA("Model") and (Held.PrimaryPart or Held:FindFirstChildWhichIsA("BasePart", true)) or Held:IsA("BasePart") and Held))
		or Character:FindFirstChild("Head")
	if not (Snail and Snail:IsA("BasePart")) then
		return
	end

	local Ring: Sound? = nil
	local Template = SoundsFolder and SoundsFolder:FindFirstChild("DenDenRing")
	if Template and Template:IsA("Sound") then
		Ring = Template:Clone()
		Ring.Looped = true
		Ring.Parent = Snail
		Ring:Play()
	end

	-- the bubble hangs off a point that follows the snail, so it stays up for the "Kacha!" even after
	-- the snail is used up (the server removes it when the call goes through)
	local Anchor = Instance.new("Attachment")
	Anchor.WorldPosition = Snail.Position
	Anchor.Parent = workspace.Terrain
	local Follow = RunService.RenderStepped:Connect(function()
		if Snail.Parent then
			Anchor.WorldPosition = Snail.Position
		end
	end)
	local SetText, Scale, Bubble, Label = RingBubble(Anchor)
	SetText("Puru puru puru...")
	TweenService:Create(Scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	local Ends = os.clock() + Data.Time
	task.spawn(function()
		-- each ring: a quick jolt of the bubble
		while Bubble.Parent and os.clock() < Ends do
			Label.Rotation = math.random(-4, 4)
			Scale.Scale = 1 + math.random(0, 6) / 100
			task.wait(0.07)
		end
		if Ring then
			Ring:Destroy()
		end
		Follow:Disconnect()
		if not Bubble.Parent then
			Anchor:Destroy()
			return
		end
		-- picked up: "Kacha!", then the barrage
		Label.Rotation = 0
		SetText("Kacha!")
		Scale.Scale = 0.6
		TweenService:Create(Scale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1.15 }):Play()
		SoundAt("DenDenGacha", Anchor.WorldPosition)
		task.wait(0.9)
		TweenService:Create(Scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0 }):Play()
		task.wait(0.15)
		Anchor:Destroy()
	end)
end

-- The BusterCall > MousePoint marker is 120 studs across; this sizes a copy of it to Radius
local MARKER_RADIUS = 60
local function SizeMarker(Marker: Instance, Radius: number)
	local Factor = Radius / MARKER_RADIUS
	for _, Emitter in Marker:GetDescendants() do
		if Emitter:IsA("ParticleEmitter") then
			local Points = {}
			for _, Point in Emitter.Size.Keypoints do
				table.insert(Points, NumberSequenceKeypoint.new(Point.Time, Point.Value * Factor, Point.Envelope * Factor))
			end
			Emitter.Size = NumberSequence.new(Points)
		end
	end
end

-- a marker flat on the ground at Position, Radius studs across the middle, until Until (server time)
local function GroundMarker(Position: Vector3, Radius: number, Until: number)
	local Folder = EffectItems and EffectItems:FindFirstChild("BusterCall")
	local Template = Folder and Folder:FindFirstChild("MousePoint")
	if not Template then
		return
	end
	local Marker = Template:Clone()
	SizeMarker(Marker, Radius)
	Marker.CFrame = CFrame.new(Position + Vector3.yAxis * 0.05) -- flat on the ground, like the aim marker
	Marker.Parent = Visuals()
	for _, Emitter in Marker:GetDescendants() do
		if Emitter:IsA("ParticleEmitter") then
			Emitter.Enabled = true
			Emitter:Emit(1)
		end
	end
	Debris:AddItem(Marker, math.max(Until - workspace:GetServerTimeNow(), 0) + 0.1)
end

-- Soulbound's Rocket Launchers aim: while the snail rings, a red marker follows your mouse on the
-- ground and you turn to face it; when the time is up its spot is sent to ItemService. Only the
-- caller gets this effect.
function Effects.BusterCallAim(Data)
	local UserInputService = game:GetService("UserInputService")
	local Character: Model? = Data.Character
	local Root = Character and Character:FindFirstChild("HumanoidRootPart") :: BasePart?
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not (Character and Root and Humanoid) then
		return
	end
	local UseRemote = ReplicatedStorage.Remotes:WaitForChild("Items"):WaitForChild("Use")
	local World = workspace:FindFirstChild("World")
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {
		Character,
		Visuals(),
		World and World:FindFirstChild("Live"),
		World and World:FindFirstChild("ItemPickups"),
	}

	-- the marker sits on the ground, never on a roof: buildings (Models named "Building") are
	-- skipped when finding the ground, the same as ItemService does for where the barrage lands
	local GroundParams = RaycastParams.new()
	GroundParams.FilterType = Enum.RaycastFilterType.Exclude
	local Skip = table.clone(Params.FilterDescendantsInstances)
	local Map = World and World:FindFirstChild("Map")
	if Map then
		for _, Model in Map:GetDescendants() do
			if Model:IsA("Model") and Model.Name == "Building" then
				table.insert(Skip, Model)
			end
		end
	end
	GroundParams.FilterDescendantsInstances = Skip

	local Folder = EffectItems and EffectItems:FindFirstChild("BusterCall")
	local Template = Folder and Folder:FindFirstChild("MousePoint")
	local Marker = Template and Template:Clone() :: BasePart?
	if Marker then
		SizeMarker(Marker, ItemConfig.Items.BusterCall.Spread) -- as big as where most of them land
		-- upright, so its particles (which face across the attachment's Top) lie flat on the ground
		Marker.CFrame = CFrame.new(Root.Position)
		Marker.Parent = Visuals()
		for _, Emitter in Marker:GetDescendants() do
			if Emitter:IsA("ParticleEmitter") then
				Emitter.Enabled = true
				Emitter:Emit(Emitter.Rate)
			end
		end
		local Spin = Marker:FindFirstChildOfClass("Attachment")
		if Spin then
			TweenService:Create(Spin, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { CFrame = CFrame.Angles(math.pi, 0, 0) }):Play()
		end
	end

	local Camera = workspace.CurrentCamera
	local FieldOfView = Camera.FieldOfView
	TweenService:Create(Camera, TweenInfo.new(Data.Time), { FieldOfView = FieldOfView + 6 }):Play()
	local AutoRotate = Humanoid.AutoRotate
	Humanoid.AutoRotate = false

	local Point = Root.Position
	local Ends = os.clock() + Data.Time
	while os.clock() < Ends and Character.Parent and Humanoid.Health > 0 do
		local Mouse = UserInputService:GetMouseLocation()
		local Ray = Camera:ViewportPointToRay(Mouse.X, Mouse.Y)
		local Hit = workspace:Raycast(Ray.Origin, Ray.Direction * 1000, Params)
		local Aim = if Hit then Hit.Position else Ray.Origin + Ray.Direction * 1000
		local Flat = Vector3.new(Aim.X - Root.Position.X, 0, Aim.Z - Root.Position.Z)
		if Flat.Magnitude > Data.Range then
			Aim = Root.Position + Flat.Unit * Data.Range + Vector3.yAxis * (Aim.Y - Root.Position.Y)
		end
		local Ground = workspace:Raycast(Aim + Vector3.yAxis * 30, Vector3.yAxis * -300, GroundParams)
		if Ground then
			Aim = Ground.Position
		end
		Point = Aim
		if Flat.Magnitude > 0.5 then
			Root.CFrame = CFrame.lookAlong(Root.Position, Flat.Unit)
		end
		if Marker then
			Marker.CFrame = CFrame.new(Aim + Vector3.yAxis * 0.05)
		end
		RunService.RenderStepped:Wait()
	end

	Humanoid.AutoRotate = AutoRotate
	TweenService:Create(Camera, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { FieldOfView = FieldOfView }):Play()
	if Marker then
		Marker:Destroy()
	end
	UseRemote:FireServer("Aim", Point)
end

-- a plain red cannonball wearing Soulbound's Rocket Launchers missile trail and exhaust
-- (ReplicatedStorage > Assets > Effects > Items > BusterCall > RocketTrail: its attachments are
-- copied onto the ball; the back of the ball is +Z, the way it came from)
local function MakeRocket()
	local Model = Instance.new("Model")
	Model.Name = "BusterRocket"
	local Body = Bit({ Shape = Enum.PartType.Ball, Size = Vector3.one * 2.4, Color = Color3.fromRGB(190, 28, 28), Material = Enum.Material.SmoothPlastic, Parent = Model })
	local Folder = EffectItems and EffectItems:FindFirstChild("BusterCall")
	local Template = Folder and Folder:FindFirstChild("RocketTrail")
	local Effects: { Instance } = {}
	if Template then
		for _, Child in Template:GetChildren() do
			Child:Clone().Parent = Body
		end
		-- the trail's attachments point at the template's, so hook it up to the copies
		local Trail = Body:FindFirstChildWhichIsA("Trail", true)
		if Trail then
			Trail.Attachment0 = Body:FindFirstChild("A")
			Trail.Attachment1 = Body:FindFirstChild("B")
		end
		for _, Thing in Body:GetDescendants() do
			if Thing:IsA("ParticleEmitter") or Thing:IsA("Trail") then
				table.insert(Effects, Thing)
			end
		end
	end
	-- the rocket's whoosh while it flies (Sounds > Items > RocketLoop)
	local Loop = SoundsFolder and SoundsFolder:FindFirstChild("RocketLoop")
	if Loop and Loop:IsA("Sound") then
		local Copy = Loop:Clone()
		Copy.Parent = Body
		Copy:Play()
		table.insert(Effects, Copy)
	end
	Model.Parent = Visuals()
	return Model, function(At: CFrame)
		Body.CFrame = At
	end, Effects
end

-- A cannon shot: fired from From so that, under Gravity, it lands on To after FlightTime seconds.
-- Position = From + Velocity * t - Gravity * t^2 / 2 (up), the arc a real cannonball makes.
local function FlyRocket(Rocket, Name: string?)
	local Info = ItemConfig.Items.BusterCall
	local Gravity = Vector3.yAxis * Info.Gravity
	local FlightTime = Rocket.LandAt - Rocket.LaunchAt
	local Velocity = (Rocket.To - Rocket.From) / FlightTime + Gravity * FlightTime / 2
	local Model, Place, Effects = MakeRocket()
	local Connection
	Connection = RunService.RenderStepped:Connect(function()
		local Time = math.clamp(workspace:GetServerTimeNow() - Rocket.LaunchAt, 0, FlightTime)
		local Position = Rocket.From + Velocity * Time - Gravity * (Time * Time / 2)
		local Direction = Velocity - Gravity * Time -- which way it's heading right now
		Place(CFrame.lookAlong(Position, Direction))
		if Time < FlightTime then
			return
		end
		Connection:Disconnect()
		for _, Effect in Effects do
			if Effect:IsA("Sound") then
				Effect:Stop()
			else
				(Effect :: any).Enabled = false
			end
		end
		for _, Part in Model:GetChildren() do
			if Part:IsA("BasePart") then
				Part.Transparency = 1
			end
		end
		Debris:AddItem(Model, 1)
		SoundAt("BombExplode", Rocket.To)
		Explosion(Name, Rocket.To, Info.ExplosionAmount, Rocket.Scale)
		RedLight(Rocket.To, 20 * Rocket.Scale, 6 + 4 * Rocket.Scale, 0.5)
	end)
end

-- the fleet's rockets come out of the sky onto the zone; everyone sees the marker flash there too
function Effects.BusterCall(Data)
	local Center: Vector3 = Data.Center
	if not Near(Center) then
		return
	end
	local Last = 0
	for _, Rocket in Data.Rockets do
		Last = math.max(Last, Rocket.LandAt)
		task.delay(math.max(Rocket.LaunchAt - workspace:GetServerTimeNow(), 0), function()
			GroundMarker(Rocket.To, Rocket.Radius or 20, Rocket.LandAt) -- where this one lands
			FlyRocket(Rocket, Data.Explosion)
		end)
	end
	-- the big one where you called it, the size of the zone
	GroundMarker(Center, ItemConfig.Items.BusterCall.Spread, Last + 0.2)
end

return function(Data: any)
	local Effect = Effects[Data.SkillType]
	if Effect then
		Effect(Data)
	end
end
