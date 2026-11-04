 

local v1 = game:GetService("ReplicatedFirst"):WaitForChild("_SoftShutdownClientPackages")
local v2 = require(v1.SoftShutdownServiceClient)
local v3 = require(v1.ServiceBag).new()
v3:GetService(v2)
v3:Init()
v3:Start()