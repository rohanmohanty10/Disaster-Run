 

local v1 = {}
local u2 = 0
local u3 = script.test:Clone()
local u4 = CFrame.new(0, 0, -0.25)
local function u8(u5) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u6 = u3:GetDescendants()
    for u7 = 1, #u6 do
        pcall(function() --[[ Line: 10 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u7
                [3] = u5
            --]]
            u6[u7].Enabled = u5
        end)
    end
end
function v1.start(_, p9) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u2
    --]]
    u8(true)
    u2 = u2 + p9
end
local u10 = tick()
local u11 = 0
game["Run Service"].RenderStepped:Connect(function() --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u10
        [4] = u8
        [5] = u11
        [6] = u4
    --]]
    local v12 = game.Players.LocalPlayer.Character
    local v13 = v12 ~= nil
    if v12 and v12.UpperTorso:FindFirstChild("Poison") == nil then
        v13 = false
    end
    if v12 and (v12.UpperTorso:FindFirstChild("Poison") and v12.UpperTorso:FindFirstChild("Poison").Enabled == false) then
        v13 = false
    end
    if u2 > 0 and v13 == true then
        u3.Parent = workspace.CurrentCamera
        u2 = u2 - (tick() - u10)
    else
        u2 = 0
        if u3 and (u3:FindFirstChild("Attachment") and u3.Attachment.Poison.Enabled == true) then
            u8(false)
            u11 = tick()
        end
        if tick() - u11 > 4 then
            u3.Parent = nil
        end
    end
    u3.CFrame = workspace.CurrentCamera.CFrame * u4
    u10 = tick()
end)
return v1