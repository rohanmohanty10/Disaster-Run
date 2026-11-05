local PS_OwnerId = game.PrivateServerOwnerId

game.ReplicatedStorage.PS_Owner.Value = PS_OwnerId



--Services
local W = game:GetService('Workspace')
local Players = game:GetService('Players')
local RNS = game:GetService('RunService')
local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')
local MPS = game:GetService('MarketplaceService')
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")



--Variables
local DefaultGravity = 196.2

--local MapCenter = Vector3.new(148.887, 438.305, 10.311)
--local StormStep = nil
local CounterConnections = {}
local MapTransparencies = {}
local MapCollisions = {}

--for _,v in workspace.Map:GetDescendants() do
--	task.spawn(function()
--		pcall(function()
--			if v.Transparency ~= nil then
--				MapTransparencies[v] = v.Transparency
--			end
--		end)
--	end)
--end

--for _,v in workspace.Miscellaneous:GetChildren() do
--	if v.Name == "Aurora" or v.Name == "Spawns" then continue end

--	for _,vv in v:GetDescendants() do
--		task.spawn(function()
--			pcall(function()
--				if vv.Transparency ~= nil then
--					MapTransparencies[vv] = vv.Transparency
--				end
--			end)
--		end)
--	end
--end


--for _,v in workspace.Map:GetDescendants() do
--	task.spawn(function()
--		pcall(function()
--			if v.CanCollide ~= nil then
--				MapCollisions[v] = v.CanCollide
--			end
--		end)
--	end)
--end

--for _,v in workspace.Miscellaneous:GetChildren() do
--	if v.Name == "Aurora" or v.Name == "Spawns" then continue end

--	for _,vv in v:GetDescendants() do
--		task.spawn(function()
--			pcall(function()
--				if vv.CanCollide ~= nil then
--					MapCollisions[vv] = vv.CanCollide
--				end
--			end)
--		end)
--	end
--end



--Assets
--local Assets = SvSt.Assets

--local MoveAnims = Assets.Animations.Moves
--local MoveSounds = Assets.Sounds.Moves



--Bindables
--local Bindables = SvSt.Bindables

--local SpnDmy = Bindables.SpawnDummy



--Remotes
local Remotes = RS.Remotes

local ReplicateSet = Remotes.Replicate.Set

local CommandRemotes = Remotes.Commands
local SetCommand = CommandRemotes.Set
local GetCommand = CommandRemotes.Get



--Modules
--local SvModules = SvSt.Modules
--local RpModules = RS.Modules


--local AnimationService = require(SvModules.AnimationService)
--local iFramesService = require(SvModules.iFramesService)
--local StunHandler = require(SvModules.StunHandler)
--local DamageHandler = require(SvModules.DamageHandler)
--local SoundsModule = require(SvModules.SoundsModule)
--local RagdollHandler = require(SvModules.RagdollHandler)
--local MovesetHandler = require(SvModules.MovesetHandler)


--local WeldSystem = require(RpModules.WeldSystem)
--local BoatTween = require(RpModules.BoatTween)


--local InfoModule = require(RS.Info)


--Owner Functions


local ConfigFunctions = {
	CustomSpeed = function(Player: Player, Params)
		local Character = Player.Character
		if not Character then return end
		Character:SetAttribute("CustomSpeed", Params.Speed)
		print("Speed")
	end,
	HitboxVisual = function(Player: Player, Params)
		local Character = Player.Character
		if not Character then return end
		Character:SetAttribute("ShowHitbox", Params)
		
	end,
	
}

local function GivePermission(Player: Player)
	SetCommand.OnServerEvent:Connect(function(p, ConfigName, Params)
		if p ~= Player then return end
		if not p:GetAttribute("Owner") then return end
		if not ConfigFunctions[ConfigName] then return end

		ConfigFunctions[ConfigName](Player, Params)
	end)
end



--Runtime
--shared.giveCommands = function(Player: Player)
--	--Remotes.Comunicator.Set:FireClient(Player, 'PS+')
--	GivePermission(Player)

--	--local Commands = Player:WaitForChild('Commands')

--	--if workspace.Configuration.Mode.Value == 'All' then
--	--	for _,v in workspace.Configuration:GetChildren() do
--	--		if v.Name ~= 'Mode' then
--	--			Commands:WaitForChild(v.Name).Value = v.Value
--	--		end
--	--	end
		
--	--elseif workspace.Configuration.Mode.Value == 'Me' then
--	--	for _,v in workspace.Configuration:GetChildren() do
--	--		if v.Name ~= 'Mode' then
--	--			Commands:WaitForChild(v.Name).Value = v.Value
--	--		end
--	--	end
--	--end
--end