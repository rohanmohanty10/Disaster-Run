 

local v1 = game:GetService("ReplicatedStorage")
local v2 = script.Parent
require(v2.WaitForYields)
local v3 = v1.Modules.Client.Managers
require(v3.ReplicaClientManager).Initialize()