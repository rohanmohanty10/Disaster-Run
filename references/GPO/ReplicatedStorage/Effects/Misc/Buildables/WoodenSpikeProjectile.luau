 

return {
    ["start"] = function(_, p1, u2, p3) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local u4 = script.WoodenSpike:Clone()
            u4:SetPrimaryPartCFrame(p1)
            u4.Parent = workspace.Effects
            _G.PlaySound(u4.PrimaryPart, script.WoodCannonShoot, {
                ["RandomPitch"] = true
            })
            _G.tween(u4.PrimaryPart, {
                p3,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u2
            })
            task.delay(p3, function() --[[ Line: 17 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u2
                --]]
                _G.particleEnabled(u4, false)
                u4:SetPrimaryPartCFrame(u2)
                _G.PlaySound(u4.PrimaryPart, script.HitSFX, {
                    ["RandomPitch"] = true
                })
                local v5 = script.WoodSpikeExplosion:Clone()
                v5.CFrame = u2
                v5.Parent = workspace.Effects
                _G.customEmit(v5)
                _G.destroy(v5, 4)
                u4.Center.Transparency = 1
                u4["Meshes/WoodBullet_Cylinder.014"].Transparency = 1
                _G.destroy(u4, 1)
            end)
        end
    end
}