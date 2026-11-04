 

local v1 = game:GetService("RunService")
local u2 = game.ReplicatedStorage.Refrences.Fishman
local u3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Tween)
require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
local u4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Spring)
local u5 = workspace:WaitForChild("Effects")
local u6 = require(u2.Effects.Portal)
local u7 = {}
v1:BindToRenderStep(script.Parent.Name .. "-" .. script.Name, Enum.RenderPriority.Last.Value - 1000, function(p8) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u3
    --]]
    local v9 = tick()
    local v10 = 0
    for v11, v13 in next, u7 do
        if v10 > 0 then
            local v13 = u7[v11 - v10]
        end
        local v14 = v9 - v13.Start
        if v13.Reference.Parent and (not v13.Splatted and v13.FadeIn + v13.FadeOut + v13.Lifetime >= v14) then
            local v15 = 1
            local v16
            if v13.FadeIn + v13.Lifetime < v14 then
                local v17 = (v14 - v13.FadeIn - v13.Lifetime) / v13.FadeOut
                v15 = u3.ease["in"].sine(v17, 1, -1, 1)
                local v18 = u3.ease.inout.quad(v17, 0, 1, 1)
                v16 = u3.point(v13.Transparency, 1, v18)
            elseif v13.FadeIn < v14 then
                local _ = (v14 - v13.FadeIn) / v13.Lifetime
                v16 = v13.Transparency
            else
                local v19 = v14 / v13.FadeIn
                v15 = u3.ease.out.quad(v19, 0, 1, 1)
                v16 = u3.point(1, v13.Transparency, v15)
                local _ = v19 < 0.25
            end
            v13.CFrame = v13.Reference.CFrame
            local v20 = v13.LastCFrame:Lerp(v13.CFrame, p8 * 12)
            local v21 = v13.CFrame.p - v13.LastCFrame.p
            v13.Spring:SetGoal(v21.Magnitude)
            local v22 = v13.Spring:GetPosition()
            v13.Part.Size = Vector3.new(1, 1, 1) * v15 + Vector3.new(v22, v22, v22) * v15 * v13.Scale * 0.075
            v13.Part.Transparency = v16
            v13.Part.CFrame = v20 * CFrame.new(Vector3.new(), v13.Reference.RotVelocity.Magnitude > 0.01 and (v13.Reference.RotVelocity.Unit or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0))
            v13.Spring:Update(p8)
            v13.LastCFrame = v13.Part.CFrame
            v13.LastVelocity = v13.LastCFrame.p - v13.CFrame.p
            if v13.FadeIn < v14 and (v21.Y < 0 and not v13.Splatted) then
                local v23 = Ray.new(v20.p - v21.Unit * 0.5, v21.Unit * v13.Scale * 0.75 + v21.Unit * 0.5)
                local v24, v25, v26 = _G.raycastWhitelist(v23, { workspace.Islands, workspace.Env, workspace.Ships })
                if v24 then
                    v13:Splat(CFrame.new(v25, v25 + v26) * CFrame.Angles(-1.5707963267948966, 0, 0))
                end
            end
        else
            v13:Destroy()
            table.remove(u7, v11 - v10)
            v10 = v10 + 1
        end
    end
end)
local u37 = {
    ["new"] = function(p27, p28) --[[ Name: new, Line 85 ]]
        --[[
        Upvalues:
            [1] = u37
        --]]
        local v29 = {
            ["Reference"] = p27
        }
        v29.CFrame = p28.CFrame or v29.Reference.CFrame
        v29.Scale = p28.Scale or Vector2.new(1, 2)
        v29.FadeIn = p28.FadeIn or 0.3
        v29.Lifetime = p28.Lifetime or 2
        v29.FadeOut = p28.FadeOut or 0.75
        v29.Transparency = p28.Transparency or 0.55
        v29.Velocity = p27.Velocity
        local v30 = {
            ["__index"] = u37
        }
        return setmetatable(v29, v30):__init()
    end,
    ["__init"] = function(p31) --[[ Name: __init, Line 99 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u5
            [4] = u7
        --]]
        if p31.Part then
            return p31
        end
        p31.LastVelocity = p31.Velocity
        p31.LastCFrame = p31.CFrame
        p31.Spring = u4.new(0.5, 2, 1)
        p31.Part = u2.Assets.WaterBlob:Clone()
        p31.Part.Size = Vector3.new(0, 0, 0)
        p31.Part.Transparency = p31.Transparency
        p31.Mass = p31.Part:GetMass()
        p31.Part.A.Position = Vector3.new(0, 0, -0.5) * p31.Scale
        p31.Part.B.Position = Vector3.new(0, 0, 0.5) * p31.Scale
        p31.Part.CFrame = p31.CFrame
        p31.Part.Anchored = true
        p31.Part.Parent = u5
        local v32 = script.MiniWaterBallFall:Clone()
        v32.Parent = p31.Part.A
        v32:Play()
        p31.SoundLoop = v32
        p31.Start = tick()
        local v33 = u7
        table.insert(v33, p31)
        return p31
    end,
    ["Splat"] = function(u34, u35) --[[ Name: Splat, Line 139 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        u34.Splatted = true
        spawn(function() --[[ Line: 141 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u6
                [3] = u35
            --]]
            local _ = tick() - u34.Start
            u6({
                ["CFrame"] = u35 or CFrame.new(u34.LastCFrame.p),
                ["FadeIn"] = u34.FadeIn * 1.125,
                ["Lifetime"] = 0.9,
                ["FadeOut"] = u34.FadeOut,
                ["Scale"] = u34.Scale * 2,
                ["Surface"] = u35,
                ["Special2"] = true,
                ["Shake"] = false,
                ["Small"] = true
            })
        end)
    end,
    ["Destroy"] = function(u36) --[[ Name: Destroy, Line 159 ]]
        if not u36.Splatted then
            u36:Splat()
        end
        spawn(function() --[[ Line: 166 ]]
            --[[
            Upvalues:
                [1] = u36
            --]]
            u36.Part.Transparency = 1
            task.wait(2)
            u36.Part:Destroy()
        end)
    end
}
return u37