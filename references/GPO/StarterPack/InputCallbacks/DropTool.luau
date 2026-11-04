 

local u1 = {}
u1.__index = u1
local v2 = game.Players.LocalPlayer
game:GetService("UserInputService")
local u3 = v2.Character or v2.CharacterAdded:Wait()
local u4 = {}
local u5 = nil
local u6 = false
function u1.new(p7) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v8 = u1
    local v9 = setmetatable({}, v8)
    v9.Handler = p7
    v9.Utils = p7.Utils
    p7.carrycd = false
    return v9
end
function u1.PC_Activate(_) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
        [3] = u6
    --]]
    require(game.ReplicatedStorage.Modules.ScriptSet)
    if u5 and (u3.Parent ~= workspace.Effects and u3.Parent ~= workspace.Ragdolls) then
        u6 = true
        local u10 = u3:FindFirstChildWhichIsA("Tool")
        local u11 = false
        if u10 == u5 then
            task.defer(function() --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u10
                    [3] = u11
                --]]
                if u3.RightHand:WaitForChild("RightGrip", 3) == nil then
                    return
                else
                    local u12 = u10:WaitForChild("Handle", 5)
                    if u12 ~= nil then
                        task.spawn(function() --[[ Line: 40 ]]
                            --[[
                            Upvalues:
                                [1] = u3
                                [2] = u12
                                [3] = u11
                            --]]
                            while true do
                                local v13 = u3.RightHand:GetChildren()
                                for v14 = 1, #v13 do
                                    if v13[v14]:IsA("Weld") and (v13[v14].Name == "RightGrip" and v13[v14].Part1 == u12) then
                                        v13[v14]:Destroy()
                                    end
                                end
                                task.wait()
                                if u11 == true then
                                    return
                                end
                            end
                        end)
                    end
                end
            end)
        end
        local v15, v16 = pcall(function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            game.ReplicatedStorage.Events.Tools:InvokeServer("drop", u5)
        end)
        local _ = true
        if not v15 then
            warn("error " .. v16)
        end
        u5 = nil
        u6 = false
    end
end
v2.Backpack.ChildAdded:Connect(function(u17) --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    if u17:IsA("Tool") and u4[u17] == nil then
        local u18 = 0
        u4[u17] = u17.AncestryChanged:Connect(function() --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u3
                [3] = u18
            --]]
            if u17.Parent == u3 and tick() - u18 <= 0.1 then
                task.defer(function() --[[ Line: 70 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                    --]]
                    u3.Humanoid:UnequipTools()
                end)
                u18 = tick()
            else
                u18 = tick()
            end
        end)
    end
end)
local v19 = v2.Backpack:GetChildren()
local u20 = u5
for v21 = 1, #v19 do
    if v19[v21]:IsA("Tool") then
        local u22 = v19[v21]
        local u23 = 0
        u4[u22] = u22.AncestryChanged:Connect(function() --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u3
                [3] = u23
            --]]
            if u22.Parent == u3 and tick() - u23 <= 0.1 then
                task.defer(function() --[[ Line: 70 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                    --]]
                    u3.Humanoid:UnequipTools()
                end)
                u23 = tick()
            else
                u23 = tick()
            end
        end)
    end
end
game["Run Service"].Heartbeat:Connect(function() --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u20
    --]]
    local v24 = u3:FindFirstChildWhichIsA("Tool")
    if v24 ~= u20 then
        if v24 and v24:FindFirstChild("CanBeDropped") then
            u20 = v24
            return
        end
        u20 = nil
    end
end)
u1.Mobile_Activate = u1.PC_Activate
return u1