 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
game:GetService("UserInputService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = workspace.Effects
local v5 = {}
require(v3.Modules.Essentials)
local u6 = require(v3.Modules.Utility)
local u7 = {
    "rbxassetid://7051550601",
    "rbxassetid://7051550509",
    "rbxassetid://7051550382",
    "rbxassetid://7051550310",
    "rbxassetid://7051550225",
    "rbxassetid://7051644826",
    "rbxassetid://7051634906",
    "rbxassetid://7051637153",
    "rbxassetid://7051637747"
}
local u8 = math.rad
local u9 = math.random
local function u15(p10) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u8
        [3] = u4
        [4] = u6
        [5] = u2
        [6] = u7
    --]]
    for _ = 1, math.random(1, 2) do
        local u11 = script.MainSlash:Clone()
        u11.Mesh.Scale = Vector3.new(3, 0.25, 3) * u9(5, 20) / 10
        u11.CFrame = p10 * CFrame.Angles(u8((u9(-360, 360))), u8((u9(-360, 360))), (u8((u9(-20, 20)))))
        u11.Parent = u4
        local v12 = u9(7, 35) / 100
        u6:AddItem(u11, v12)
        local v13 = TweenInfo.new(v12, Enum.EasingStyle.Exponential)
        u2:Create(u11.Texture, v13, {
            ["Transparency"] = 1
        }):Play()
        u2:Create(u11.Mesh, v13, {
            ["Scale"] = u11.Mesh.Scale * 1.5
        }):Play()
        u2:Create(u11, TweenInfo.new(v12, Enum.EasingStyle.Sine), {
            ["CFrame"] = u11.CFrame * CFrame.Angles(0, u8((u9(-200, -130))), 0)
        }):Play()
        task.defer(function() --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u11
            --]]
            for _, v14 in u7 do
                if not u11:FindFirstChild("Texture") then
                    return
                end
                u11.Texture.Texture = v14
                task.wait(0.075)
            end
        end)
        task.wait(0.02)
    end
end
TweenCreate = _G.Ess.Tween
local function u16(...) --[[ Line: 93 ]]
    _G.PlayEffect("SnowBodyInvis", nil, ...)
end
function v5.start(_, u17, p18) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
        [3] = u6
        [4] = u2
        [5] = u16
        [6] = u15
    --]]
    if _G.checkRenderDistance(u17.PrimaryPart.Position) ~= false then
        task.spawn(function() --[[ Line: 103 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u4
                [3] = u1
                [4] = u6
            --]]
            for _ = 1, 25 do
                local u19 = script.SwirlTrail:Clone()
                local v20 = u17.HumanoidRootPart.Position
                local v21 = math.random(-10, 10)
                local v22 = math.random(0, 5)
                local v23 = math.random
                u19.Position = v20 + Vector3.new(v21, v22, v23(-10, 10))
                u19.Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.2, math.random(5, 100) / 100, 0), NumberSequenceKeypoint.new(1, 0, 0) })
                u19.Parent = u4
                local u24 = 0
                local u25 = u19.CFrame.Position
                local v26 = u19.Position
                local v27 = math.random(-8, 8)
                local v28 = math.random(-8, 8)
                local v29 = math.random
                local u30 = v26 + Vector3.new(v27, v28, v29(-8, 8))
                local u31 = nil
                local u32 = math.random(20, 50) / 150
                u31 = u1.RenderStepped:Connect(function(p33) --[[ Line: 116 ]]
                    --[[
                    Upvalues:
                        [1] = u24
                        [2] = u32
                        [3] = u17
                        [4] = u19
                        [5] = u6
                        [6] = u31
                        [7] = u25
                        [8] = u30
                    --]]
                    local v34 = u24 / u32
                    local v35 = u17.PrimaryPart.Position
                    if v34 >= 1 or (u19.Position - v35).Magnitude < 0.2 then
                        u6:AddItem(u19, 1)
                        u31:Disconnect()
                    else
                        u19.Position = u6:GetQuadBezier(v34, u25, u30, v35)
                        u24 = u24 + p33
                    end
                end)
                task.wait(math.random(0.1, 0.35) / 15)
            end
        end)
        local v36 = _G.PlaySound(u17.PrimaryPart, script.YukiFrostFormStart)
        v36.Parent = u17.PrimaryPart
        task.wait(0.3)
        local v37 = script.Ground:Clone()
        u6:QuickWeld(v37, u17.HumanoidRootPart, CFrame.new(0, 2.5, 0))
        v37.Parent = u4
        u6:Emit(v37.Start)
        local v38 = script.CharSpiral:Clone()
        v38.CFrame = u17.HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0)
        v38.Parent = u4
        u6:AddItem(v38, 1)
        local v39 = TweenInfo.new(0.75, Enum.EasingStyle.Exponential)
        u2:Create(v38.Texture, v39, {
            ["Transparency"] = 1
        }):Play()
        u2:Create(v38.Mesh, v39, {
            ["Scale"] = Vector3.new(8, 1, 8)
        }):Play()
        local v40 = u2
        local v41 = {}
        local v42 = v38.Orientation
        local v43 = v38.Orientation.Y - 700
        v41.Orientation = v42 + Vector3.new(0, v43, 0)
        v40:Create(v38, v39, v41):Play()
        task.spawn(function() --[[ Line: 154 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u17
            --]]
            u16(u17, {}, 0.15, 0.25, true)
        end)
        u6:Emit(v37.Vanish)
        u6:ToggleEnabled(v37.During, true)
        local u44 = true
        p18.Destroying:Connect(function() --[[ Line: 162 ]]
            --[[
            Upvalues:
                [1] = u44
            --]]
            u44 = false
        end)
        while u44 == true and (p18 and p18:IsDescendantOf(game)) do
            task.spawn(u15, u17.HumanoidRootPart.CFrame)
            task.wait(0.1)
        end
        u6:Emit(v37)
        v37.Transparency = 1
        u6:AddItem(v37, 3)
        u6:ToggleEnabled(v37.During, false)
        if v36 then
            _G.tween(v36, {
                0.25,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v36, 0.25)
        end
        _G.PlaySound(u17.PrimaryPart, script.YukiFrostFormEnd)
        task.spawn(function() --[[ Line: 180 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u17
            --]]
            u16(u17, {}, 0.15, 0.25, false)
        end)
    end
end
return v5