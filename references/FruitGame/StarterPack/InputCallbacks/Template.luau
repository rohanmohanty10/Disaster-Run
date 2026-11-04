 

local u1 = {}
u1.__index = u1
local v2 = game.Players.LocalPlayer
game:GetService("UserInputService")
if not v2.Character then
    v2.CharacterAdded:Wait()
end
function u1.new(p3) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = u1
    local v5 = setmetatable({}, v4)
    v5.Handler = p3
    v5.Utils = p3.Utils
    return v5
end
function u1.PC_Activate(_) --[[ Line: 16 ]] end
u1.Mobile_Activate = u1.PC_Activate
return u1