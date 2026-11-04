 

local u1 = {}
u1.__index = u1
local v2 = game.Players.LocalPlayer
game:GetService("UserInputService")
local u3 = v2.Character or v2.CharacterAdded:Wait()
local u4 = require(game.ReplicatedStorage.Util.Movement.DashTypes)
function u1.new(p5) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v6 = u1
    local v7 = setmetatable({}, v6)
    v7.Handler = p5
    v7.Utils = p5.Utils
    p5.dashcd = false
    return v7
end
function u1.PC_Activate(p8) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    if u3:GetAttribute("Grounded") then
        print("Grounded")
        return
    elseif _G.check:inspect(u3, true) then
        if p8.Handler.dashcd == true then
            print("DashCD")
            return
        elseif u3:FindFirstChild("Block") then
            print("Blocking")
            return
        elseif _G.canuse == true or _G.blocking == true then
            u3:FindFirstChild("inCombat")
            p8.Handler.dashcd = true
            u4:dash(p8.Handler.dashcd)
            p8.Handler.dashcd = false
        else
            print("blocking?")
        end
    else
        print("Inspect")
        return
    end
end
u1.Mobile_Activate = u1.PC_Activate
return u1