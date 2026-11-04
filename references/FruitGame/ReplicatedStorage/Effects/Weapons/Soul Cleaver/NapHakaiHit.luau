 

local v1 = {}
game:GetService("Debris")
game:GetService("TweenService")
game:GetService("RunService")
script:WaitForChild("Animations")
script:WaitForChild("Models")
script:WaitForChild("SFX")
local u2 = script:WaitForChild("VFX")
script:WaitForChild("Other")
workspace:WaitForChild("Effects")
require(script.Parent:WaitForChild("Shared"))
local u3 = Random.new()
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Include
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
local u5 = require(script.Parent.NapSoulLightning)
function v1.start(_, p6, p7, p8) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
        [4] = u5
    --]]
    if p7.PrimaryPart ~= nil then
        local v9
        if p6:GetAttribute("SoulCleaverBlazed") == true then
            v9 = ColorSequence.new(Color3.fromRGB(255, 122, 55))
            local _ = u2.FireVariants.FireElecHit
        else
            v9 = ColorSequence.new(Color3.fromRGB(102, 42, 255))
            local _ = u2.ElecHit
        end
        local u10 = p6:GetAttribute("SoulCleaverBlazed") == true
        local v11 = p7.PrimaryPart
        local v12 = script.SFX.NapoleonIkokuHit
        if u10 == true then
            v12 = script.SFX.NapoleonIkokuFireHit
        end
        if p8 == nil then
            _G.PlaySound(v11, v12, {
                ["RandomPitch"] = true
            }).Parent = v11
        end
        for _ = 1, math.random(4, 6) do
            local v13 = Vector3.new(0, 1, 0)
            local v14, v15, v16 = _G.getRayFloor(v11.CFrame, 15)
            if v14 then
                local v17 = {
                    ["Instance"] = v14,
                    ["Position"] = v15,
                    ["Normal"] = v16
                }
                local v18 = v13:Dot(v17.Normal)
                local v19 = (math.abs(v18) > 0.99 and Vector3.new(1, 0, 0) or v13):Cross(v17.Normal).Unit
                local v20 = v19:Cross(v17.Normal).Unit
                local v21 = u3:NextNumber(0.1, 0.2)
                local v22 = -v17.Normal * 15 + (v19 + v20) * u3:NextUnitVector() * 15
                local u23 = workspace:Raycast(v15 + v17.Normal * 5, v22, u4)
                if u23 then
                    local _ = u23.Position
                    local v24 = u23.Normal:Cross(v22.Unit)
                    local u25 = Instance.new("Attachment")
                    u25.Parent = p7.PrimaryPart
                    local u26 = Instance.new("Attachment")
                    u26.WorldCFrame = CFrame.fromMatrix(u23.Position, -v24, u23.Normal) * CFrame.Angles(0, 0, 1.5707963267948966)
                    u26.Parent = workspace.Terrain
                    local v27 = u3:NextNumber(2, 5)
                    local v28 = u5.new({
                        ["Attachment0"] = u25,
                        ["Attachment1"] = u26,
                        ["CurveSize0"] = v27,
                        ["CurveSize1"] = -v27,
                        ["Width"] = NumberRange.new(u3:NextNumber(0.4, 0.6)),
                        ["BoltDuration"] = u3:NextNumber(0.1, 0.25),
                        ["RadiusOffset"] = NumberRange.new(1, 2),
                        ["BeamColor"] = v9
                    })
                    task.delay(v21, function() --[[ Line: 114 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u10
                        --]]
                        _G.PlayEffect("NapLightningHitFloor", nil, u23, u10)
                    end)
                    v28.Destroyed:Once(function() --[[ Line: 118 ]]
                        --[[
                        Upvalues:
                            [1] = u25
                            [2] = u26
                        --]]
                        u25:Destroy()
                        u26:Destroy()
                    end)
                    task.wait(u3:NextNumber(0.2, 0.4))
                end
            end
        end
    end
end
return v1