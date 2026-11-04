 

local u1 = require(script.Parent:WaitForChild("getLastWordFromPascalCase"))
local u2 = {}
for _, v3 in ipairs(script:GetChildren()) do
    u2[v3.Name] = v3
end
return function(p4) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v5 = Instance.new("Folder")
    v5.Name = "RagdollConstraints"
    for _, v6 in pairs(p4) do
        if v6.Joint.Name ~= "Root" then
            local v7 = v6.Joint.Name
            local v8 = (u2[u1(v7)] or u2.Default):Clone()
            v8.Attachment0 = v6.Attachment0
            v8.Attachment1 = v6.Attachment1
            v8.Name = v7 .. "RagdollConstraint"
            local v9 = Instance.new("ObjectValue")
            v9.Name = "RigidJoint"
            v9.Value = v6.Joint
            v9.Parent = v8
            v8.Parent = v5
        end
    end
    return v5
end