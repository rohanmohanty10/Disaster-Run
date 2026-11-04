 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
local RunService = game:GetService("RunService")

local Option = require(script.Parent.Parent.Option)

local Util = {}

Util.IsServer = RunService:IsServer()
Util.WaitForChildTimeout = 60
Util.DefaultCommFolderName = "__comm__"
Util.None = newproxy()

function Util.GetCommSubFolder(parent: Instance, subFolderName: string): Option.Option
	local subFolder: Instance = nil
	if Util.IsServer then
		subFolder = parent:FindFirstChild(subFolderName)
		if not subFolder then
			subFolder = Instance.new("Folder")
			subFolder.Name = subFolderName
			subFolder.Parent = parent
		end
	else
		subFolder = parent:WaitForChild(subFolderName, Util.WaitForChildTimeout)
	end
	return Option.Wrap(subFolder)
end

return Util

]]

 

local RunService = game:GetService("RunService");
local Option = require(script.Parent.Parent.Option);
local u1 = {
    IsServer = RunService:IsServer(),
    WaitForChildTimeout = 60,
    DefaultCommFolderName = "__comm__",
    None = newproxy()
};

function u1.GetCommSubFolder(p2: userdata, p3: string) -- Line: 12
    -- upvalues: u1 (copy), Option (copy)
    local v4;

    if u1.IsServer then
        v4 = p2:FindFirstChild(p3);

        if not v4 then
            v4 = Instance.new("Folder");
            v4.Name = p3;
            v4.Parent = p2;
        end;
    else
        v4 = p2:WaitForChild(p3, u1.WaitForChildTimeout);
    end;

    return Option.Wrap(v4);
end;

return u1;