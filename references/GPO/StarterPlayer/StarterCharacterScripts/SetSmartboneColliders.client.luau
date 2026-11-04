 

local v1 = script.Parent
local v2 = {
    "UpperTorso",
    "Head",
    "LeftUpperArm",
    "RightUpperArm",
    "RightUpperLeg",
    "LeftUpperLeg"
}
for v3 = 1, #v2 do
    local v4 = v1:WaitForChild(v2[v3], 3)
    if v4 then
        game:GetService("CollectionService"):AddTag(v4, "SmartCollider")
        game:GetService("CollectionService"):AddTag(v4, "SmartBone")
        game:GetService("CollectionService"):AddTag(v4, "Roots")
        v4:SetAttribute("ColliderShape", "Box")
    end
end
script:Destroy()