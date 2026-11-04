 

local v1 = {}
local u2 = game:GetService("RunService")
function v1.start(_, u3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u4 = u3.Bomb
    local u5 = u3.Character
    local _ = u3.Radius
    local u6 = u3.ID
    local u7 = u4:Clone()
    u7.Size = u4.Size + Vector3.new(0.5, 0.5, 0.5)
    u7.Material = Enum.Material.Neon
    u7.Color = Color3.fromRGB(248, 97, 27)
    u7.CastShadow = false
    u7.Parent = u4
    local u8 = false
    local u9 = 0
    local u10 = nil
    u10 = u2.Heartbeat:Connect(function(p11) --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u6
            [4] = u10
            [5] = u7
            [6] = u3
            [7] = u9
            [8] = u8
        --]]
        local v12 = (u5.HumanoidRootPart.Position - u4.Position).Magnitude
        if u5:FindFirstChild(u6) and u4.Parent then
            local v13 = (v12 - u3.Radius) / v12 * 0.5
            u9 = u9 + p11 * (u4:GetAttribute("Exploding") and 5 or v13)
            local v14 = u9 * 3.141592653589793
            local v15 = math.sin(v14)
            u7.Transparency = v15
            if v15 < 0 then
                if not u8 then
                    u8 = true
                    _G.PlaySound(u4, script.beep)
                    return
                end
            elseif u8 then
                u8 = false
            end
        else
            u10:Disconnect()
            u7:Destroy()
        end
    end)
end
return v1