 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
local RunService = game:GetService("RunService")

if RunService:IsServer() then
	return require(script.KnitServer)
else
	local KnitServer = script:FindFirstChild("KnitServer")
	if KnitServer and RunService:IsRunning() then
		KnitServer:Destroy()
	end

	return require(script.KnitClient)
end

]]

 

local RunService = game:GetService("RunService");

if RunService:IsServer() then
    return require(script.KnitServer);
end;

local KnitServer = script:FindFirstChild("KnitServer");

if KnitServer and RunService:IsRunning() then
    KnitServer:Destroy();
end;

return require(script.KnitClient);