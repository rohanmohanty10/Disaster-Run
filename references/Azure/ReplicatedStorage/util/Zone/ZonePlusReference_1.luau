 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=6245329519

-- ! Source from the asset above; the game may have edited it since.

--[[
-- This module enables you to place Zone wherever you like within the data model while
-- still enabling third-party applications (such as HDAdmin/Nanoblox) to locate it
-- This is necessary to prevent two ZonePlus applications initiating at runtime which would
-- diminish it's overall efficiency

local replicatedStorage = game:GetService("ReplicatedStorage")
local ZonePlusReference = {}

function ZonePlusReference.addToReplicatedStorage()
    local existingItem = replicatedStorage:FindFirstChild(script.Name)
    if existingItem then
        return false
    end
    local objectValue = Instance.new("ObjectValue")
    objectValue.Name = script.Name
    objectValue.Value = script.Parent
    objectValue.Parent = replicatedStorage
    local locationValue = Instance.new("BoolValue")
    locationValue.Name = (game:GetService("RunService"):IsClient() and "Client") or "Server"
    locationValue.Value = true
    locationValue.Parent = objectValue
    return objectValue
end

function ZonePlusReference.getObject()
    local objectValue = replicatedStorage:FindFirstChild(script.Name)
    if objectValue then
        return objectValue
    end
    return false
end

return ZonePlusReference
]]

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return {
    addToReplicatedStorage = function() -- Line: 9, Name: addToReplicatedStorage
        -- upvalues: ReplicatedStorage (copy)
        if ReplicatedStorage:FindFirstChild(script.Name) then
            return false;
        end;

        local ObjectValue = Instance.new("ObjectValue");
        ObjectValue.Name = script.Name;
        ObjectValue.Value = script.Parent;
        ObjectValue.Parent = ReplicatedStorage;
        local BoolValue = Instance.new("BoolValue");
        BoolValue.Name = game:GetService("RunService"):IsClient() and "Client" or "Server";
        BoolValue.Value = true;
        BoolValue.Parent = ObjectValue;

        return ObjectValue;
    end,

    getObject = function() -- Line: 25, Name: getObject
        -- upvalues: ReplicatedStorage (copy)
        return ReplicatedStorage:FindFirstChild(script.Name) or false;
    end
};