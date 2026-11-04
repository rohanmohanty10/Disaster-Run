 

local v1 = {}
local u2 = script:WaitForChild("Animations")
function PlayAnim(p3, p4)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = (p3:FindFirstChild("Humanoid") or p3:FindFirstChild("AnimationController")).Animator:LoadAnimation(u2[p4])
    v5:Play()
    return v5
end
function v1.start(_, u6, _) --[[ Line: 13 ]]
    if _G.checkRenderDistance(u6.PrimaryPart.Position) then
        local u7 = script:WaitForChild("Stretch"):Clone()
        u7.Parent = workspace.Effects
        u7:PivotTo(u6:GetPrimaryPartCFrame() * CFrame.new(0, -2.95, -4.557) * CFrame.Angles(0, 3.141592653589793, 0))
        u7.Cube.Transparency = 1
        PlayAnim(u7, "Shadow Idle")
        task.delay(0.3, function() --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u6
            --]]
            PlayAnim(u7, "Shadow")
            _G.tween(u7.Cube, { 0.4, "Cubic", Enum.EasingDirection.InOut }, {
                ["Transparency"] = 0
            })
            task.delay(0.75, function() --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u7
                --]]
                local v8 = script:WaitForChild("CutShadow"):Clone()
                v8.CFrame = u6:GetPrimaryPartCFrame() * CFrame.new(0, -1.5, -8)
                v8.Parent = workspace.Effects
                _G.destroy(v8, 2)
                _G.tween(u7.Cube, { 0.2, "Quad", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                _G.customEmit(v8)
                _G.destroy(u7, 1)
            end)
        end)
        task.wait(1.11)
        local v9 = script:WaitForChild("Effects"):Clone()
        v9.CFrame = u6:GetPrimaryPartCFrame() * CFrame.new(0, -0.5, -3.5)
        v9.Parent = workspace.Effects
        _G.customEmit(v9.Attachment)
        _G.destroy(v9, 1.2)
        task.wait(0.656)
        local v10 = script:WaitForChild("Kick"):Clone()
        v10.CFrame = u6:GetPrimaryPartCFrame() * CFrame.new(0, 1.25, -3) * CFrame.Angles(0, 3.141592653589793, 0)
        v10.Parent = workspace.Effects
        _G.customEmit(v10)
        _G.destroy(v10, 1.2)
    end
end
return v1