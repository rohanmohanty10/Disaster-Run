 

if script:IsDescendantOf(workspace) ~= false then
    local v1 = script.Parent:WaitForChild("AnimationController")
    local v2 = script:WaitForChild("Animation")
    local u3 = script.Parent.Parent
    local u4 = script.Parent
    u3:WaitForChild("Middle")
    local u5 = u3:WaitForChild("fakeMiddle")
    local v6 = u3:WaitForChild("SafeScale")
    local v7 = script.HookDestroy:Clone()
    v7.HookedModel.Value = u3
    v7.Parent = u4
    v7.Enabled = true
    local u8 = u4:GetChildren()
    local u9 = {}
    for v10 = 1, #u8 do
        local v11 = u8[v10]
        if v11:IsA("BasePart") then
            u9[v11] = v11.Transparency
        end
    end
    task.defer(function() --[[ Line: 28 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        u4.Parent = workspace.Effects
    end)
    u5:GetPropertyChangedSignal("Transparency"):Connect(function() --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u8
            [3] = u9
        --]]
        local v12 = u5.Transparency
        for v13 = 1, #u8 do
            local v14 = u8[v13]
            if v14:IsA("BasePart") then
                if v12 >= 1 then
                    v14.Transparency = 1
                else
                    v14.Transparency = u9[v14]
                end
            end
        end
    end)
    v1:LoadAnimation(v2):Play()
    function v6.OnInvoke(p15) --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        if p15 == true then
            u4.Parent = u3
        else
            u4.Parent = workspace.Effects
        end
    end
end