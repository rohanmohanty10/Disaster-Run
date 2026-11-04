 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
require(v1.Modules.CraterHandler)
require(v1.Modules.BezierFormula)
require(v1.Modules.LightningBolt)
local u3 = v2.LocalPlayer
local u4 = workspace.Effects
local function u15(p5, p6, p7) --[[ Line: 18 ]]
    local function v13(u8, p9, p10) --[[ Line: 19 ]]
        for _, v11 in ipairs(u8:GetDescendants()) do
            if v11:IsA("ParticleEmitter") or v11:IsA("Trail") then
                v11.Enabled = p9
            end
        end
        if p10 then
            task.delay(p10, function() --[[ Line: 27 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                for _, v12 in ipairs(u8:GetDescendants()) do
                    if v12:IsA("ParticleEmitter") or v12:IsA("Trail") then
                        v12.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p5) == "table" then
        for _, v14 in p5 do
            v13(v14, p6, p7)
        end
    else
        v13(p5, p6, p7)
    end
end
local v16 = RaycastParams.new()
v16.FilterType = Enum.RaycastFilterType.Include
v16.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p17, p18, p19, p20, p21) --[[ Name: start, Line 61 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u15
            [3] = u3
        --]]
        if _G.checkRenderDistance(p18.PrimaryPart.Position) ~= false then
            if p17 == "Bite" then
                local u22 = p18.HumanoidRootPart
                local v23 = p19.HumanoidRootPart
                local v24 = script.GrabEmit:Clone()
                v24.CFrame = v23.CFrame * CFrame.new(0, 0, -2)
                v24.Parent = u4
                _G.customEmit(v24)
                _G.destroy(v24, 3)
                _G.PlaySound(p18.PrimaryPart, script["Audio/SLGrabHit"])
                task.wait(0.5)
                local v25 = script.BiteEmit:Clone()
                v25.CFrame = v23.CFrame * CFrame.new(0, 0, -2)
                v25.Parent = u4
                _G.customEmit(v25)
                _G.destroy(v25, 3)
                local u26 = script.Bite:Clone()
                u26.CFrame = v23.CFrame * CFrame.new(0, 0, -2)
                u26.Parent = u4
                u15(u26, true)
                Color3.fromRGB(142, 161, 255)
                local u27 = Random.new()
                local v28 = Instance.new("Highlight")
                v28.FillColor = Color3.fromRGB(230, 255, 255)
                v28.FillTransparency = 1
                v28.OutlineTransparency = 1
                v28.DepthMode = Enum.HighlightDepthMode.Occluded
                v28.Parent = p18
                _G.tween(v28, { 0.5, "Cubic", Enum.EasingDirection.Out }, {
                    ["FillTransparency"] = 0.1
                })
                local v29 = script.PointLight:Clone()
                v29.Parent = p18.PrimaryPart
                _G.tween(v29, {
                    0.05,
                    "Cubic",
                    Enum.EasingDirection.Out,
                    -1,
                    true,
                    0
                }, {
                    ["Range"] = 16
                })
                task.spawn(function() --[[ Line: 103 ]]
                    --[[
                    Upvalues:
                        [1] = u26
                        [2] = u27
                    --]]
                    CFrame.new(u26.Position)
                    local _ = {
                        ["WorldPosition"] = u26.Position,
                        ["WorldAxis"] = Vector3.new(0, 1, 0)
                    }
                    for _ = 1, 20 do
                        _G.PlayEffect("DeadLightning", nil, {
                            ["StartPosition"] = u26.Position,
                            ["EndPosition"] = u26.Position + u27:NextUnitVector() * u27:NextNumber(2, 5),
                            ["Points"] = 6,
                            ["Size"] = 1,
                            ["Branches"] = false,
                            ["RandomSize"] = NumberRange.new(0.15, 1),
                            ["Offset"] = NumberRange.new(-10, 10),
                            ["MainColor"] = Color3.fromRGB(142, 161, 255),
                            ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                            ["NoHighlight"] = true,
                            ["LightningDuration"] = math.random(30, 75) / 1000,
                            ["WaitFunction"] = function(p30, _) --[[ Name: WaitFunction, Line 121 ]]
                                if p30 % 2 == 0 then
                                    task.wait()
                                end
                            end
                        })
                        task.wait(0.034999999999999996)
                    end
                end)
                task.wait(0.7)
                _G.tween(v29, {
                    0.25,
                    "Cubic",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    -1
                }, {
                    ["Brightness"] = 0
                })
                _G.destroy(v29, 0.25)
                u15(u26, false)
                _G.destroy(u26, 3)
                local v31 = script.PointLight:Clone()
                v31.Parent = p18.PrimaryPart
                task.wait(1)
                _G.tween(v31, {
                    0.25,
                    "Cubic",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Brightness"] = 0,
                    ["Range"] = 25
                })
                _G.destroy(v31, 0.25)
                _G.tween(v28, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                    ["FillTransparency"] = 1
                })
                _G.destroy(v28, 0.25)
                local v32 = script.Kick:Clone()
                v32.CFrame = u22.CFrame
                v32.Parent = u4
                _G.customEmit(v32)
                _G.destroy(v32, 3)
                local v33 = u22.CFrame
                local v34 = u22.CFrame * CFrame.new(0, 0, -40)
                local v35 = (v33.Position - v34.Position).Magnitude
                math.clamp(v35, 0, 40)
                task.spawn(function() --[[ Line: 172 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                    --]]
                    local v36 = u22.CFrame * CFrame.new(0, 0, -2)
                    local v37 = {
                        ["WorldPosition"] = v36.Position,
                        ["WorldAxis"] = Vector3.new(0, 1, 0)
                    }
                    for _ = 1, 8 do
                        local v38 = {
                            ["WorldPosition"] = (v36 * CFrame.new(math.random(-10, 10), math.random(0, 15), math.random(-40, -15))).Position,
                            ["WorldAxis"] = Vector3.new(0, 1, 0)
                        }
                        _G.PlayEffect("DeadLightning", nil, {
                            ["StartPosition"] = v37.WorldPosition,
                            ["EndPosition"] = v38.WorldPosition,
                            ["Points"] = 6,
                            ["Size"] = 1,
                            ["Branches"] = true,
                            ["RandomSize"] = NumberRange.new(0.15, 1),
                            ["Offset"] = NumberRange.new(-10, 10),
                            ["MainColor"] = Color3.fromRGB(142, 161, 255),
                            ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                            ["NoHighlight"] = true,
                            ["LightningDuration"] = math.random(100, 150) / 1000,
                            ["WaitFunction"] = function(p39, _) --[[ Name: WaitFunction, Line 205 ]]
                                if p39 % 2 == 0 then
                                    task.wait(0.05)
                                end
                            end
                        })
                        task.wait()
                    end
                end)
                if u3.Character == p18 then
                    _G.camShake:ShakeOnce(5, 17, 0.2, 0.4)
                    return
                end
            elseif p17 == "Dash" then
                local _ = p18.HumanoidRootPart
                local v40 = script.Dash:Clone()
                v40.CFrame = CFrame.new(p20, p21.Position)
                v40.Parent = u4
                _G.customEmit(v40)
                _G.destroy(v40, 3)
                _G.PlaySound(p18.PrimaryPart, script["Audio/SLGrabDash"]).Parent = p18.PrimaryPart
            end
        end
    end
}