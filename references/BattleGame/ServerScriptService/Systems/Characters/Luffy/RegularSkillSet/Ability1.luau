local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")


local ServerModules = ServerStorage.SBGModules

local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer = ReplicatedStorage.Remotes


local StunHandler = require(ServerModules.StunHandler)
local HitboxHandler = require(ServerModules.HitboxHandler)
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local NewKnockback = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService = require(ServerModules.iFramesService)
--local WeaponsHandler = require(ServerModules.WeaponsHandler)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Sounds = ReplicatedStorage.Assets.Sounds
local Animations = ServerStorage.Assets.Animations
local CurrentAnimations = Animations.Luffy
--local Models = ServerStorage.Assets.Models


--local Weapons = Models.Weapons

--local MoveAnims = Animations.Moves
local MoveSounds = Sounds.Characters

--local CombatAnims = Animations.Combat
--local CombatSounds = Sounds.Combat


--local ComSet = RemotesContainer.Comunicator.Set
--local ComGet = RemotesContainer.Comunicator.Get


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad
--local StartAirDetect = ServerStorage.Bindables.AirDetector

--local Assets = shared.Assets

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true


return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false
		
		
		local StartAnimation = CurrentAnimations.FirstMove.Barrage
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}
		
		StartEvents["Hit"] = StartTrack:GetMarkerReachedSignal("Hit"):Once(function()
			--ReplicateEffects_Set:FireAllClients("GatlingGun", {
			--	Origin = HumRP,
			--	Character = Character,

			--	--Duration = 1.5,
			--	Duration = 3,
			--	--Rate = 0.025
			--	Rate = 0.1
			--})
			RemotesContainer.ClientEffects:FireAllClients("LuffyFirstAbility", {Attacker = Character, SkillType =  "start"})

			
		end)
		
		StartTrack.Stopped:Once(function()
			for _,v in StartEvents do
				v:Disconnect()
			end
			

			if Hit then return end

			StunHandler:Unstun(Character, Stun)
		end)
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
	end
}