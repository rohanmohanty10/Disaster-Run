 

local u1 = {}
u1.__index = u1
local v2 = game.Players.LocalPlayer
game:GetService("UserInputService")
local u3 = v2.Character or v2.CharacterAdded:Wait()
local u4 = workspace:WaitForChild("Ragdolls", 5)
function u1.new(p5) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v6 = u1
    local v7 = setmetatable({}, v6)
    v7.Handler = p5
    v7.Utils = p5.Utils
    return v7
end
local u8 = false
function u1.PC_Activate(p9) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u8
        [3] = u4
    --]]
    if u3:FindFirstChild("Blocking") == nil and (p9.Handler.carrycd == false and (u3.Humanoid.Health > 0 and (u8 == false and _G.isCustomHUB == false))) then
        u8 = true
        if _G.check:inspect(u3) and (_G.canuse == true and u3.HumanoidRootPart:FindFirstChild("gripweld") == nil) then
            local v10 = p9.Utils.getinregion(u3, { u3.HumanoidRootPart.CFrame, Vector3.new(8, 8, 8) })
            for v11 = 1, #v10 do
                if v10[v11].Parent.Parent == u4 then
                    game.ReplicatedStorage.Events.KnockedOut:FireServer("grip", v10[v11].Parent, u3.HumanoidRootPart.CFrame)
                    break
                end
            end
        elseif u3:FindFirstChild("gripweld") then
            game.ReplicatedStorage.Events.KnockedOut:FireServer("grip", nil)
        end
        task.wait(0.5)
        u8 = false
    end
end
u1.Mobile_Activate = u1.PC_Activate
return u1