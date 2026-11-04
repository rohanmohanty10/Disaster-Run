 

return {
    ["start"] = function(_, p1, p2, p3, p4) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p2.Position) ~= false then
            p1.Archivable = true
            local v5 = p1:Clone()
            v5:PivotTo(p3)
            v5:BreakJoints()
            v5.Humanoid:Destroy()
            v5.Archivable = false
            v5.PrimaryPart.Anchored = true
            local v6 = v5:GetDescendants()
            local u7 = {}
            for v8 = 1, #v6 do
                if v6[v8]:IsA("Script") or (v6[v8]:IsA("LocalScript") or (v6[v8]:IsA("BillboardGui") or (v6[v8]:IsA("Decal") or v6[v8]:IsA("ParticleEmitter")))) then
                    v6[v8]:Destroy()
                elseif v6[v8]:IsA("BasePart") then
                    v6[v8].Anchored = true
                    v6[v8].CastShadow = false
                    v6[v8].CanTouch = false
                    v6[v8].CanQuery = false
                    v6[v8].CanCollide = false
                    if v6[v8].Transparency ~= 1 then
                        u7[v6[v8]] = v6[v8].CFrame
                    end
                end
            end
            v5:PivotTo(p2)
            v5.Parent = workspace.Effects
            local u9 = p4 == nil and 0.2 or p4
            task.spawn(function() --[[ Line: 38 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u9
                --]]
                for v10, v11 in u7 do
                    local v12 = v10.CFrame
                    v10.CanCollide = false
                    v10.Anchored = true
                    v10.CFrame = v11
                    v10.Transparency = -1
                    v10.CastShadow = false
                    _G.tween(v10, {
                        u9,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1,
                        ["CFrame"] = v12
                    })
                end
                u7 = nil
            end)
            _G.destroy(v5, 0.25)
        end
    end
}