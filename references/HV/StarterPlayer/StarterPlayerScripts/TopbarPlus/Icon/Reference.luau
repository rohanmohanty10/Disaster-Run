 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[[
-- This module enables you to place Icon wherever you like within the data model while
-- still enabling third-party applications (such as HDAdmin/Nanoblox) to locate it
-- This is necessary to prevent two TopbarPlus applications initiating at runtime which would
-- cause icons to overlap with each other

local replicatedStorage = game:GetService("ReplicatedStorage")
local Reference = {}
Reference.objectName = "TopbarPlusReference"

function Reference.addToReplicatedStorage()
	local existingItem = replicatedStorage:FindFirstChild(Reference.objectName)
    if existingItem then
        return false
    end
    local objectValue = Instance.new("ObjectValue")
	objectValue.Name = Reference.objectName
    objectValue.Value = script.Parent
    objectValue.Parent = replicatedStorage
    return objectValue
end

function Reference.getObject()
	local objectValue = replicatedStorage:FindFirstChild(Reference.objectName)
    if objectValue then
        return objectValue
    end
    return false
end

return Reference
]]

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    objectName = "TopbarPlusReference"
};

function u1.addToReplicatedStorage() -- Line: 10
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    if ReplicatedStorage:FindFirstChild(u1.objectName) then
        return false;
    end;

    local ObjectValue = Instance.new("ObjectValue");
    ObjectValue.Name = u1.objectName;
    ObjectValue.Value = script.Parent;
    ObjectValue.Parent = ReplicatedStorage;

    return ObjectValue;
end;

function u1.getObject() -- Line: 22
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    return ReplicatedStorage:FindFirstChild(u1.objectName) or false;
end;

return u1;