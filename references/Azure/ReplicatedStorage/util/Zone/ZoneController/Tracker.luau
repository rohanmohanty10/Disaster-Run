 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=6245329519

-- ! Source from the asset above; the game may have edited it since.

--[[
-- This enables data on volumes, HumanoidRootParts, etc to be handled on an event-basis, instead of being retrieved every interval

-- LOCAL
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local heartbeat = runService.Heartbeat
local Signal = require(script.Parent.Parent.Signal)
local Janitor = require(script.Parent.Parent.Janitor)



-- PUBLIC
local Tracker = {}
Tracker.__index = Tracker
local trackers = {}
Tracker.trackers = trackers
Tracker.itemAdded = Signal.new()
Tracker.itemRemoved = Signal.new()
Tracker.bodyPartsToIgnore = {
	-- We ignore these due to their insignificance (e.g. we ignore the lower and
	-- upper torso because the HumanoidRootPart also covers these areas)
	-- This ultimately reduces the burden on the player region checks
	UpperTorso = true,
	LowerTorso = true,
	Torso = true,
	LeftHand = true,
	RightHand = true,
	LeftFoot = true,
	RightFoot = true,
}



-- FUNCTIONS
function Tracker.getCombinedTotalVolumes()
	local combinedVolume = 0
	for tracker, _ in pairs(trackers) do
		combinedVolume += tracker.totalVolume
	end
	return combinedVolume
end

function Tracker.getCharacterSize(character)
	local head = character and character:FindFirstChild("Head")
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not(hrp and head) then return nil end
	if not head:IsA("BasePart") then
		head = hrp
	end
	local headY = head.Size.Y
	local hrpSize = hrp.Size
	local charSize = (hrpSize * Vector3.new(2, 2, 1)) + Vector3.new(0, headY, 0)
	local charCFrame = hrp.CFrame * CFrame.new(0, headY/2 - hrpSize.Y/2, 0)
	return charSize, charCFrame
end



-- CONSTRUCTOR
function Tracker.new(name)
	local self = {}
	setmetatable(self, Tracker)
	
	self.name = name
	self.totalVolume = 0
	self.parts = {}
	self.partToItem = {}
	self.items = {}
	self.whitelistParams = nil
	self.characters = {}
	self.baseParts = {}
	self.exitDetections = {}
	self.janitor = Janitor.new()

	if name == "player" then
		local function updatePlayerCharacters()
			local characters = {}
			for _, player in pairs(players:GetPlayers()) do
				local character = player.Character
				if character then
					characters[character] = true
				end
			end
			self.characters = characters
		end
		
		local function playerAdded(player)
			local function charAdded(character)
				local humanoid = character:WaitForChild("Humanoid", 3)
				if humanoid then
					updatePlayerCharacters()
					self:update()
					for _, valueInstance in pairs(humanoid:GetChildren()) do
						if valueInstance:IsA("NumberValue") then
							valueInstance.Changed:Connect(function()
								self:update()
							end)
						end
					end
				end
			end
			if player.Character then
				charAdded(player.Character)
			end
			player.CharacterAdded:Connect(charAdded)
			player.CharacterRemoving:Connect(function(removingCharacter)
				self.exitDetections[removingCharacter] = nil
			end)
		end
		
		players.PlayerAdded:Connect(playerAdded)
		for _, player in pairs(players:GetPlayers()) do
			playerAdded(player)
		end
		
		players.PlayerRemoving:Connect(function(player)
			updatePlayerCharacters()
			self:update()
		end)


	elseif name == "item" then
		local function updateItem(itemDetail, newValue)
			if itemDetail.isCharacter then
				self.characters[itemDetail.item] = newValue
			elseif itemDetail.isBasePart then
				self.baseParts[itemDetail.item] = newValue
			end
			self:update()
		end
		Tracker.itemAdded:Connect(function(itemDetail)
			updateItem(itemDetail, true)
		end)
		Tracker.itemRemoved:Connect(function(itemDetail)
			self.exitDetections[itemDetail.item] = nil
			updateItem(itemDetail, nil)
		end)
	end

	trackers[self] = true
	task.defer(self.update, self)
	return self
end



-- METHODS
function Tracker:_preventMultiFrameUpdates(methodName, ...)
	-- This prevents the funtion being called twice within a single frame
	-- If called more than once, the function will initally be delayed again until the next frame, then all others cancelled
	self._preventMultiDetails = self._preventMultiDetails or {}
	local detail = self._preventMultiDetails[methodName]
	if not detail then
		detail = {
			calling = false,
			callsThisFrame = 0,
			updatedThisFrame = false,
		}
		self._preventMultiDetails[methodName] = detail
	end

	detail.callsThisFrame += 1
	if detail.callsThisFrame == 1 then
		local args = table.pack(...)
		task.defer(function()
			local newCallsThisFrame = detail.callsThisFrame
			detail.callsThisFrame = 0
			if newCallsThisFrame > 1 then
				self[methodName](self, unpack(args))
			end
		end)
		return false
	end
	return true
end

function Tracker:update()
	if self:_preventMultiFrameUpdates("update") then
		return
	end
	
	self.totalVolume = 0
	self.parts = {}
	self.partToItem = {}
	self.items = {}
	
	-- This tracks the bodyparts of a character
	for character, _ in pairs(self.characters) do
		local charSize = Tracker.getCharacterSize(character)
		if not charSize then
			continue
		end
		local rSize = charSize
		local charVolume = rSize.X*rSize.Y*rSize.Z
		self.totalVolume += charVolume
		
		local characterJanitor = self.janitor:add(Janitor.new(), "destroy", "trackCharacterParts-"..self.name)
		local function updateTrackerOnParentChanged(instance)
			characterJanitor:add(instance.AncestryChanged:Connect(function()
				if not instance:IsDescendantOf(game) then
					if instance.Parent == nil and characterJanitor ~= nil then
						characterJanitor:destroy()
						characterJanitor = nil
						self:update()
					end
				end
			end), "Disconnect")
		end

		for _, part in pairs(character:GetChildren()) do
			if part:IsA("BasePart") and not Tracker.bodyPartsToIgnore[part.Name] then
				self.partToItem[part] = character
				table.insert(self.parts, part)
				updateTrackerOnParentChanged(part)
			end
		end
		updateTrackerOnParentChanged(character)
		table.insert(self.items, character)
	end

	-- This tracks any additional baseParts
	for additionalPart, _ in pairs(self.baseParts) do
		local rSize = additionalPart.Size
		local partVolume = rSize.X*rSize.Y*rSize.Z
		self.totalVolume += partVolume
		self.partToItem[additionalPart] = additionalPart
		table.insert(self.parts, additionalPart)
		table.insert(self.items, additionalPart)
	end
	
	-- This creates the whitelist so that
	self.whitelistParams = OverlapParams.new()
	self.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
	self.whitelistParams.MaxParts = #self.parts
	self.whitelistParams.FilterDescendantsInstances = self.parts
end



return Tracker
]]

 

local Players = game:GetService("Players");
local _ = game:GetService("RunService").Heartbeat;
local Signal = require(script.Parent.Parent.Signal);
local Janitor = require(script.Parent.Parent.Janitor);
local u1 = {};
u1.__index = u1;
local u2 = {};
u1.trackers = u2;
u1.itemAdded = Signal.new();
u1.itemRemoved = Signal.new();
u1.bodyPartsToIgnore = {
    UpperTorso = true,
    LowerTorso = true,
    Torso = true,
    LeftHand = true,
    RightHand = true,
    LeftFoot = true,
    RightFoot = true
};

function u1.getCombinedTotalVolumes() -- Line: 35
    -- upvalues: u2 (copy)
    local v3 = 0;

    for i, _ in pairs(u2) do
        v3 = v3 + i.totalVolume;
    end;

    return v3;
end;

function u1.getCharacterSize(p4) -- Line: 43
    local v5;

    if p4 then
        v5 = p4:FindFirstChild("Head");
    else
        v5 = p4;
    end;

    if p4 then
        p4 = p4:FindFirstChild("HumanoidRootPart");
    end;

    if not (p4 and v5) then
        return nil;
    end;

    if not v5:IsA("BasePart") then
        v5 = p4;
    end;

    local Y = v5.Size.Y;
    local Size = p4.Size;

    return Size * Vector3.new(2, 2, 1) + Vector3.new(0, Y, 0), p4.CFrame * CFrame.new(0, Y / 2 - Size.Y / 2, 0);
end;

function u1.new(p6) -- Line: 60
    -- upvalues: u1 (copy), Janitor (copy), Players (copy), u2 (copy)
    local u7 = {};
    setmetatable(u7, u1);
    u7.name = p6;
    u7.totalVolume = 0;
    u7.parts = {};
    u7.partToItem = {};
    u7.items = {};
    u7.whitelistParams = nil;
    u7.characters = {};
    u7.baseParts = {};
    u7.exitDetections = {};
    u7.janitor = Janitor.new();

    if p6 == "player" then
        local function updatePlayerCharacters() -- Line: 76
            -- upvalues: Players (ref), u7 (copy)
            local v8 = {};

            for _, v in pairs(Players:GetPlayers()) do
                local Character = v.Character;

                if Character then
                    v8[Character] = true;
                end;
            end;

            u7.characters = v8;
        end;

        local function playerAdded(p9) -- Line: 87
            -- upvalues: updatePlayerCharacters (copy), u7 (copy)
            local function charAdded(p10) -- Line: 88
                -- upvalues: updatePlayerCharacters (ref), u7 (ref)
                local Humanoid = p10:WaitForChild("Humanoid", 3);

                if Humanoid then
                    updatePlayerCharacters();
                    u7:update();

                    for _, child in pairs(Humanoid:GetChildren()) do
                        if child:IsA("NumberValue") then
                            child.Changed:Connect(function() -- Line: 95
                                -- upvalues: u7 (ref)
                                u7:update();
                            end);
                        end;
                    end;
                end;
            end;

            if p9.Character then
                charAdded(p9.Character);
            end;

            p9.CharacterAdded:Connect(charAdded);
            p9.CharacterRemoving:Connect(function(p11) -- Line: 106
                -- upvalues: u7 (ref)
                u7.exitDetections[p11] = nil;
            end);
        end;

        Players.PlayerAdded:Connect(playerAdded);

        for _, v in pairs(Players:GetPlayers()) do
            playerAdded(v);
        end;

        Players.PlayerRemoving:Connect(function(p12) -- Line: 116
            -- upvalues: updatePlayerCharacters (copy), u7 (copy)
            updatePlayerCharacters();
            u7:update();
        end);
    elseif p6 == "item" then
        local function updateItem(p13, p14) -- Line: 123
            -- upvalues: u7 (copy)
            if p13.isCharacter then
                u7.characters[p13.item] = p14;
            elseif p13.isBasePart then
                u7.baseParts[p13.item] = p14;
            end;

            u7:update();
        end;

        u1.itemAdded:Connect(function(p15) -- Line: 131
            -- upvalues: u7 (copy)
            if p15.isCharacter then
                u7.characters[p15.item] = true;
            elseif p15.isBasePart then
                u7.baseParts[p15.item] = true;
            end;

            u7:update();
        end);
        u1.itemRemoved:Connect(function(p16) -- Line: 134
            -- upvalues: u7 (copy)
            u7.exitDetections[p16.item] = nil;

            if p16.isCharacter then
                u7.characters[p16.item] = nil;
            elseif p16.isBasePart then
                u7.baseParts[p16.item] = nil;
            end;

            u7:update();
        end);
    end;

    u2[u7] = true;
    task.defer(u7.update, u7);

    return u7;
end;

function u1._preventMultiFrameUpdates(u17, u18, ...) -- Line: 148
    u17._preventMultiDetails = u17._preventMultiDetails or {};
    local u19 = u17._preventMultiDetails[u18];

    if not u19 then
        u19 = {
            calling = false,
            callsThisFrame = 0,
            updatedThisFrame = false
        };
        u17._preventMultiDetails[u18] = u19;
    end;

    u19.callsThisFrame = u19.callsThisFrame + 1;

    if u19.callsThisFrame ~= 1 then
        return true;
    end;

    local table_pack_ret = table.pack(...);
    task.defer(function() -- Line: 165
        -- upvalues: u19 (ref), u17 (copy), u18 (copy), table_pack_ret (copy)
        local callsThisFrame = u19.callsThisFrame;
        u19.callsThisFrame = 0;

        if callsThisFrame > 1 then
            u17[u18](u17, unpack(table_pack_ret));
        end;
    end);

    return false;
end;

function u1.update(u20) -- Line: 177
    -- upvalues: u1 (copy), Janitor (copy)
    if u20:_preventMultiFrameUpdates("update") then
        return;
    end;

    u20.totalVolume = 0;
    u20.parts = {};
    u20.partToItem = {};
    u20.items = {};

    for i, _ in pairs(u20.characters) do
        local CharacterSize = u1.getCharacterSize(i);

        if CharacterSize then
            u20.totalVolume = u20.totalVolume + CharacterSize.X * CharacterSize.Y * CharacterSize.Z;
            local u21 = u20.janitor:add(Janitor.new(), "destroy", "trackCharacterParts-" .. u20.name);

            local function updateTrackerOnParentChanged(u22) -- Line: 198
                -- upvalues: u21 (ref), u20 (copy)
                u21:add(u22.AncestryChanged:Connect(function() -- Line: 199
                    -- upvalues: u22 (copy), u21 (ref), u20 (ref)
                    if not (u22:IsDescendantOf(game) or (u22.Parent ~= nil or u21 == nil)) then
                        u21:destroy();
                        u21 = nil;
                        u20:update();
                    end;
                end), "Disconnect");
            end;

            local u23 = i;

            for _, child in pairs(i:GetChildren()) do
                if child:IsA("BasePart") and not u1.bodyPartsToIgnore[child.Name] then
                    u20.partToItem[child] = u23;
                    table.insert(u20.parts, child);
                    u21:add(child.AncestryChanged:Connect(function() -- Line: 199
                        -- upvalues: child (copy), u21 (ref), u20 (copy)
                        if not (child:IsDescendantOf(game) or (child.Parent ~= nil or u21 == nil)) then
                            u21:destroy();
                            u21 = nil;
                            u20:update();
                        end;
                    end), "Disconnect");
                end;
            end;

            u21:add(u23.AncestryChanged:Connect(function() -- Line: 199
                -- upvalues: u23 (copy), u21 (ref), u20 (copy)
                if not (u23:IsDescendantOf(game) or (u23.Parent ~= nil or u21 == nil)) then
                    u21:destroy();
                    u21 = nil;
                    u20:update();
                end;
            end), "Disconnect");
            table.insert(u20.items, u23);
        end;
    end;

    for i, _ in pairs(u20.baseParts) do
        local Size = i.Size;
        u20.totalVolume = u20.totalVolume + Size.X * Size.Y * Size.Z;
        u20.partToItem[i] = i;
        table.insert(u20.parts, i);
        table.insert(u20.items, i);
    end;

    u20.whitelistParams = OverlapParams.new();
    u20.whitelistParams.FilterType = Enum.RaycastFilterType.Include;
    u20.whitelistParams.MaxParts = #u20.parts;
    u20.whitelistParams.FilterDescendantsInstances = u20.parts;
end;

return u1;