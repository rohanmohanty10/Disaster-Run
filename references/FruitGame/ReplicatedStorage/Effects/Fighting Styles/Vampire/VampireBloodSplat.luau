 

local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
game:GetService("PhysicsService")
local u3 = game:GetService("RunService")
require(v2.Modules.CameraShaker)
require(v2.Modules.HitboxManager)
local u4 = require(v2.Modules.BezierFormula)
local u5 = require(v2.Modules.Client.WeaponVFXRecolor)
local u6 = workspace.Effects
local u7 = Random.new()
local function u18(p8, p9, p10) --[[ Line: 14 ]]
    local function v16(u11, p12, p13) --[[ Line: 15 ]]
        for _, v14 in ipairs(u11:GetDescendants()) do
            if v14:IsA("ParticleEmitter") or v14:IsA("Trail") then
                v14.Enabled = p12
            end
        end
        if p13 then
            task.delay(p13, function() --[[ Line: 23 ]]
                --[[
                Upvalues:
                    [1] = u11
                --]]
                for _, v15 in ipairs(u11:GetDescendants()) do
                    if v15:IsA("ParticleEmitter") or v15:IsA("Trail") then
                        v15.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p8) == "table" then
        for _, v17 in p8 do
            v16(v17, p9, p10)
        end
    else
        v16(p8, p9, p10)
    end
end
local function u21(p19, p20) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    return u7:NextNumber(p19, p20)
end
function v1.start(_, p22, p23, p24, p25, p26, p27, p28, p29) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u7
        [3] = u21
        [4] = u4
        [5] = u6
        [6] = u3
        [7] = u18
    --]]
    if _G.checkRenderDistance(p23) ~= false then
        for _ = 1, p22 do
            local u30 = script.Splat:Clone()
            u5.apply(u30, p29)
            if typeof(p23) == "Vector3" then
                u30.CFrame = CFrame.new(p23) * CFrame.new(u7:NextNumber(-p24, p24), 0, u21(-p24, p24))
            else
                u30.CFrame = p23 * CFrame.new(u7:NextNumber(-p24, p24), 0, u21(-p24, p24))
            end
            local u31 = 0
            local u32 = u30.Position
            local v33 = math.random(-p25, p25)
            local v34 = math.random(unpack(p27))
            local v35 = math.random
            local v36 = -p25
            local u37 = u32 + Vector3.new(v33, v34, v35(v36, p25))
            local u38 = (CFrame.lookAt(u30.Position:Lerp(u37, 0.25), u37) * CFrame.new(0, math.random(u21(p26 / 2, p26)), 0)).Position
            local u39 = u7:NextNumber(0.8, 1.8)
            u30.CFrame = CFrame.new(u4.QuadBezier(u31, u32, u38, u37))
            u30.Parent = u6
            _G.destroy(u30, 5)
            local u40 = nil
            local u41 = nil
            if p28 == nil then
                local v44 = u3.Stepped:Connect(function(_, p42) --[[ Line: 69 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                        [2] = u39
                        [3] = u30
                        [4] = u4
                        [5] = u32
                        [6] = u38
                        [7] = u37
                        [8] = u40
                        [9] = u41
                        [10] = u18
                    --]]
                    u31 = u31 + p42 * u39
                    u30.Velocity = Vector3.new(0, 0, 0)
                    u30.RotVelocity = Vector3.new(0, 0, 0)
                    local v43 = u4.QuadBezier(u31, u32, u38, u37)
                    if u31 >= 1 then
                        if u40 then
                            u40:Disconnect()
                        end
                        u41:Disconnect()
                        u18(u30["Aura + Trail"], false)
                        _G.destroy(u30, 3)
                        u30.Anchored = true
                    else
                        u30.CFrame = CFrame.new(v43)
                    end
                end)
                u41 = v44
            else
                u30.Anchored = false
                u30.Velocity = p28
            end
            task.defer(function() --[[ Line: 94 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u30
                    [3] = u41
                    [4] = u18
                --]]
                u40 = u30.Touched:Connect(function() --[[ Line: 95 ]]
                    --[[
                    Upvalues:
                        [1] = u30
                        [2] = u40
                        [3] = u41
                        [4] = u18
                    --]]
                    if u30.Anchored == true then
                        u40:Disconnect()
                        u40 = nil
                    else
                        u30.Anchored = true
                        u40:Disconnect()
                        if u41 then
                            u41:Disconnect()
                        end
                        u18(u30["Aura + Trail"], false)
                        _G.customEmit(u30)
                        _G.destroy(u30, 3)
                        _G.tween(u30, {
                            1,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Size"] = Vector3.new(0, 0, 0)
                        })
                    end
                end)
            end)
        end
    end
end
return v1