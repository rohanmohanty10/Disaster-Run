 

local v1 = game:GetService("ReplicatedStorage")
local v2 = workspace:WaitForChild("ZipLines")
if #v2:GetChildren() <= 0 then
    v2.ChildAdded:Wait()
end
require(v1.Modules["GPO Zipline"]).Initialize()