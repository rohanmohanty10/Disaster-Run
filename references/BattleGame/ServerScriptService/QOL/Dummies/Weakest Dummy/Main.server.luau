local RNS = game:GetService('RunService')
local SvSt = game:GetService('ServerStorage')
local RS = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local Chat = game:GetService("Chat")



local Assets = RS.Assets

--local MoveSounds = Assets.Sounds.Moves
local MoveAnims = SvSt.Assets.Animations



local ReplicateSet = RS.Remotes.Replicate.Set



local RpModules = RS.Modules

local WeldSystem = require(RpModules.WeldSystem)


local SvModules = SvSt.SBGModules

local StunHandler = require(SvModules.StunHandler)
local iFramesService = require(SvModules.iFramesService)
local AnimationService = require(SvModules.AnimationService)
local DamageHandler = require(SvModules.DamageHandler)
local SoundsModule = require(SvModules.SoundsModule)



local Character = script.Parent
local Humanoid = Character.Humanoid
local HumRP = Character.HumanoidRootPart
local Head = Character.Head
local Torso = Character.Torso


Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)


--Variables
--local SpecialTexts = {
--	[9904096067] = {
--		"Astral, you may be the owner of MY game, but hitting me will not solve anything.", 
--		"Astral, Famzedo will come get you next.", 
--		"hi astral my goat."
--	},
--}

--local Texts = {
--	"I'll tell astral on you if you don't stop hitting me.", 
--	"That's it, the update is delayed by another month.", 
--	".... . / .. ... / .- .-.. .. ...- . --..-- / .... . / .. ... / .- .-- .- -.- .", 
--	"I am always watching.",
--	"Oh my god im going to dieee please bro I need this, my game is kinda homeless",

--	"Bro this isn’t balancing, this is bullying 💀",
--	"Touch me again and I'll replace you with an NPC.",
--	"Keep hitting me, see what happens… *turns off hitbox detection*",
--	"If I die one more time, I'm adding pay-to-win. Don't test me.",
--	"Help... I'm just a small indie dev with 0 sleep and 12 bugs per second.",

--	"I'm not weak, I'm just… in development.",
--	"You think you're Saitama? You're more like Mumen Rider without the bike.",
--	"Keep hitting me, and I'll remove your dash permanently.",
--	"Bro thinks he's Garou but plays like King 💀",
--	"This damage feels personal. Did I nerf your character or something?",
--	"If I unlock serious mode, you're getting sent to spawn.",
--	"Plot twist: you’re actually the tutorial enemy.",

--	"Stop… every hit spawns a new bug somewhere in my code.",
--	"If I crash, you're helping me debug. No exceptions.",
--	"Congrats, you unlocked the ‘Developer Depression’ achievement.",
--	"Why are you comboing me like I'm your pathfinding script?",
--	"You're hitting me harder than Roblox moderation hits my updates.",
--	"Bro chill, my PC is already smoking from Studio.",
--	"Lag isn't my fault, it's... uh... *mysterious Roblox forces*."
--}

local TextCount = 0



--Health Visualizer
local HealthBillboard: BillboardGui = Head.HealthBillboard
local HealthText: TextLabel = HealthBillboard.HealthText



--Functions
function ChangeHealthText(CurrentHealth)
	if HealthText then
		if CurrentHealth <= 0 then
			HealthText.Text = "0%"
		else
			local Text = tostring(math.floor(CurrentHealth * 10) / 10)

			if Text:sub(-2) == ".0" then
				Text = Text:sub(1, -3)
			end

			HealthText.Text = Text .. "%"
		end
	end
end

local function StartVisualizer(Dummy: Model)
	local VisualizerModule = require(script.Visualizer)
	task.spawn(function()
		VisualizerModule.Visualizer(Dummy)
	end)

	Dummy.AncestryChanged:Connect(function()
		if not Dummy:IsDescendantOf(game.Workspace) then
			task.wait()

			StartVisualizer(Dummy)
		end
	end)
end


--Stun Visualizer
Character.ChildAdded:Connect(function(Stun)
	if Stun.Name == "Stunned" then
		HealthText.TextColor3 = Color3.fromRGB(255, 0, 0)

		TextCount = TextCount + 1

		--if TextCount >= math.random(10, 25) then
		--	if Character:GetAttribute("LastHitBy") and SpecialTexts[Character:GetAttribute("LastHitBy")] then
		--		local Text = SpecialTexts[Character:GetAttribute("LastHitBy")]

		--		Chat:Chat(Character.Head, Text[math.random(1, #Text)])
		--	else
		--		Chat:Chat(Character.Head, Texts[math.random(1, #Texts)])
		--	end

		--	TextCount = 0
		--end

		Stun.Destroying:Once(function()
			for _,v in Character:GetChildren() do
				if v ~= Stun and v.Name == "Stunned" then
					return
				end
			end

			HealthText.TextColor3 = Color3.fromRGB(255, 255, 255)
		end)
	end
end)



--Main Visualizer
task.spawn(function()
	task.spawn(StartVisualizer, Character)
end)



--Health Regeneration
local HealConnection: RBXScriptConnection = nil


Humanoid.HealthChanged:Connect(ChangeHealthText)
ChangeHealthText(Humanoid.Health)


