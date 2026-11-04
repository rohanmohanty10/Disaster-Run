 

local v1 = game:GetService("ReplicatedStorage").Modules
local v2 = require(v1.DataStructures.CustomEnum)
local v3 = v2.Class.new("Climbing", {
    "Up",
    "Down",
    "Left",
    "Right",
    "Tip",
    "Idling"
})
local v4 = v2.Class.new("Stunned", { "Default", "GettingUp" })
local v5 = v2.Class.new("Crouching", { "Idling", "Walking" })
local v6 = v2.Class.new("State", {
    "Idling",
    "Jumping",
    "Walking",
    "Running",
    "Falling"
})
local v7 = v2.Class.new("ImmutableState", {
    "Dead",
    "CastingSpell",
    "Ragdolling",
    "Slashing",
    "Swimming"
})
v7:AddItem(v3)
v7:AddItem(v4)
v6:AddItem(v5)
return {
    ["State"] = v6,
    ["CrouchState"] = v5,
    ["ImmutableState"] = v7,
    ["ClimbState"] = v3,
    ["StunState"] = v4
}