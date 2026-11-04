 

local v1 = {}
game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = Random.new()
local u4 = script
local function u24(p5, p6, p7) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local u8 = u3:NextNumber(5, 10)
    local u9 = u3:NextNumber(5, 10)
    local u10 = 0
    local u11 = 6.283185307179586 * math.random()
    local u12 = 9.42477796076938 * math.random() * (p7 == "Second" and 1 or -1)
    local u13 = u3:NextNumber(15, 20)
    local u14 = p5 * (p7 == "Second" and CFrame.Angles(0, 0, 0) or CFrame.Angles(0, 0, 1.5707963267948966))
    local u15 = script.MiniSlashTrail:Clone()
    u15.CFrame = u14 * CFrame.new(math.sin(u11) * u8, 0, math.cos(u11) * u9)
    u15.Parent = p6
    local u16 = u3:NextNumber(0.3, 0.5)
    local u17 = u16
    local u18 = (math.random(2) == 1 and 1 or -1) * math.random()
    local u19 = nil
    u19 = u2.Heartbeat:Connect(function(p20) --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u19
            [3] = u15
            [4] = u17
            [5] = u11
            [6] = u12
            [7] = u8
            [8] = u13
            [9] = u9
            [10] = u10
            [11] = u18
            [12] = u14
        --]]
        if u16 <= 0 then
            u19:Disconnect()
            _G.particleEnabled(u15, false)
        else
            local v21 = u16 / u17
            u11 = u11 + u12 * p20 * v21
            u8 = u8 + u13 * p20 * v21
            u9 = u9 + u13 * p20 * v21
            u10 = u10 + u13 * p20 * v21 * u18
            local v22 = u11
            local v23 = u11
            u15.CFrame = u14 * CFrame.new(math.sin(v22) * u8, u10 * (u17 - u16) / u17, math.cos(v23) * u9)
            u16 = u16 - p20
        end
    end)
end
local u25 = {
    "rbxassetid://15070515736",
    "rbxassetid://15070515616",
    "rbxassetid://15070515508",
    "rbxassetid://15070515335",
    "rbxassetid://15070507939",
    "rbxassetid://15070507731",
    "rbxassetid://15070507525",
    "rbxassetid://15070507286",
    "rbxassetid://15070507127",
    "rbxassetid://15070506849",
    "rbxassetid://15070499930",
    "rbxassetid://15070499653",
    "rbxassetid://15070499438",
    "rbxassetid://15070499249",
    "rbxassetid://15070499115",
    "rbxassetid://15070498981",
    ""
}
function v1.start(_, p26) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u25
        [3] = u2
        [4] = u24
        [5] = u3
    --]]
    local u27 = p26.CFrame
    local u28 = 0
    local u29 = tick()
    local u30 = u4.GreenSlash:Clone()
    u30.CFrame = u27 * CFrame.Angles(0, 0, 1.5707963267948966)
    u30.Decal.Texture = ""
    u30.Parent = workspace.Effects
    local u31 = u4.SlashTrail:Clone()
    task.spawn(function() --[[ Line: 85 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u30
        --]]
        for _, v32 in pairs(u25) do
            u30.Decal.Texture = v32
            task.wait(0.01)
        end
    end)
    task.spawn(function() --[[ Line: 92 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u28
            [3] = u31
            [4] = u2
            [5] = u29
        --]]
        local v33 = u27
        local v34 = CFrame.new
        local v35 = u28
        local v36 = math.rad(v35)
        local v37 = -math.cos(v36) * 10
        local v38 = u28
        local v39 = math.rad(v38)
        local u40 = v33 * v34(0, v37, math.sin(v39) * 10).Position
        u31.Position = u40
        u31.Parent = workspace.Effects
        _G.destroy(u31, 5)
        local u41 = nil
        local u42 = nil
        u42 = u2.Heartbeat:Connect(function(p43) --[[ Line: 107 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u42
                [3] = u31
                [4] = u40
                [5] = u27
                [6] = u28
                [7] = u41
            --]]
            if tick() - u29 >= 0.2 then
                u42:Disconnect()
                _G.particleEnabled(u31, false)
            end
            local v44 = u27
            local v45 = CFrame.new
            local v46 = u28
            local v47 = math.rad(v46)
            local v48 = -math.cos(v47) * 10
            local v49 = u28
            local v50 = math.rad(v49)
            u40 = v44 * v45(0, v48, math.sin(v50) * 10).Position
            local v51 = u27
            local v52 = CFrame.new
            local v53 = u28 + -1260 * p43
            local v54 = math.rad(v53)
            local v55 = -math.cos(v54) * 10
            local v56 = u28 + -1260 * p43
            local v57 = math.rad(v56)
            u41 = v51 * v52(0, v55, math.sin(v57) * 10).Position
            u31.CFrame = CFrame.lookAt(u40, u41)
            u28 = u28 + -1260 * p43
        end)
    end)
    for _ = 1, 15 do
        u24(u27 * CFrame.Angles(0, 3.141592653589793, 1.5707963267948966), workspace.Effects, "Second")
        task.wait(u3:NextNumber(0, 0.05))
    end
end
return v1