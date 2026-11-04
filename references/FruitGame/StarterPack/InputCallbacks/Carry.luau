 

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
    p5.carrycd = false
    return v7
end
function u1.PC_Activate(p8) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    task.wait()
    if p8.Handler.carrycd == false and (u3.Humanoid.Health > 0 and (_G.canuse == true and _G.isCustomHUB == false)) then
        if _G.check:inspect(u3) then
            p8.Handler.carrycd = true
            local v9 = p8.Utils.getinregion
            local v10 = u3
            local v11 = {}
            local v12 = u3.HumanoidRootPart.CFrame
            local v13 = 8 * u3.Humanoid.BodyHeightScale.Value
            __set_list(v11, 1, {v12, (Vector3.new(8, v13, 8))})
            local v14 = v9(v10, v11)
            for v15 = 1, #v14 do
                if v14[v15].Parent.Parent == u4 and v14[v15].Parent:FindFirstChild("gripped") == nil then
                    game.ReplicatedStorage.Events.KnockedOut:FireServer("carry", v14[v15].Parent)
                    break
                end
            end
        elseif u3:FindFirstChild("ragcarry") then
            p8.Handler.carrycd = true
            game.ReplicatedStorage.Events.KnockedOut:FireServer("drop", u3:FindFirstChild("ragcarry").Value)
        end
        if p8.Handler.carrycd == true then
            task.wait(0.5)
            p8.Handler.carrycd = false
        end
    end
end
u1.Mobile_Activate = u1.PC_Activate
return u1