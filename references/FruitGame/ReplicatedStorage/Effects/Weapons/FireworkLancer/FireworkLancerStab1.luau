 

local u1 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local u2 = script.SpearStab
local u3 = script.SpearStabPrestige
local u4 = script.Dust
return {
    ["start"] = function(_, p5, p6) --[[ Name: start, Line 8 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
            [4] = u4
        --]]
        if _G.checkRenderDistance(p5.Position) ~= false then
            local v7
            if p6 then
                v7 = u3:Clone()
            else
                v7 = u2:Clone()
            end
            u1.apply(v7, p5.Parent)
            local v8 = u4:Clone()
            u1.apply(v8, p5.Parent)
            local v9 = v7.Main
            local v10 = v7.FakeMain
            local _ = v7.BeanWindBlue
            local _ = v7.BeanWindRed
            local _ = v7.BlueStab
            local _ = v7.BlueWind
            local _ = v7.RedStab
            local _ = v7.RedWind
            v7:SetPrimaryPartCFrame(p5.CFrame * CFrame.new(1, 0, -1.5))
            local v11, _, _ = _G.getRayFloor(p5.CFrame, 9)
            v8.CFrame = p5.CFrame * CFrame.new(0, -3, 0)
            v8.Parent = workspace.Effects
            v7.Parent = workspace.Effects
            local v12 = v7:GetPrimaryPartCFrame().LookVector
            for _, v13 in v7:GetChildren() do
                if v13 ~= v9 and v13 ~= v10 then
                    if v13.Name == "BeanWindBlue" or v13.Name == "BeanWindRed" then
                        _G.tween(v13.Mesh, { 0.22, "Quint", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(0.05, 0.15, 0.15)
                        })
                        _G.tween(v13, { 0.22, "Quint", Enum.EasingDirection.Out }, {
                            ["Position"] = v13.Position + -v12,
                            ["Orientation"] = v13.Orientation + (v13.CFrame * CFrame.Angles(3.9269908169872414, 0, 0)):ToAxisAngle()
                        })
                        _G.tween(v13.Decal, { 0.22, "Quint", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                    elseif v13.Name == "BlueWind" or v13.Name == "RedWind" then
                        _G.tween(v13.Mesh, { 0.46, "Quint", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(0.3, 0, 0)
                        })
                        _G.tween(v13, { 0.46, "Quint", Enum.EasingDirection.Out }, {
                            ["Position"] = v13.Position + v12 * 2
                        })
                        _G.tween(v13.Decal, { 0.46, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                    elseif v13.Name == "Wind" then
                        _G.tween(v13.Mesh, { 0.2, "Quint", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(0.24, 0.18, 0.18)
                        })
                        _G.tween(v13, { 0.2, "Quint", Enum.EasingDirection.Out }, {
                            ["Position"] = v13.Position - v12 * 9
                        })
                        _G.tween(v13.Decal, { 0.2, "Quint", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                    elseif v13.Name == "Wind1" then
                        _G.tween(v13.Mesh, { 0.23, "Cubic", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(0.45, 0.08, 0.08)
                        })
                        _G.tween(v13, { 0.23, "Cubic", Enum.EasingDirection.Out }, {
                            ["Position"] = v13.Position + v12 * 5,
                            ["Orientation"] = v13.Orientation + (v13.CFrame * CFrame.Angles(2.792526803190927, 0, 0)):ToAxisAngle()
                        })
                        _G.tween(v13.Decal, { 0.26, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                    elseif v13.Name == "Wind2" then
                        _G.tween(v13.Mesh, { 0.23, "Cubic", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(0.2, 0.15, 0.15)
                        })
                        _G.tween(v13, { 0.23, "Cubic", Enum.EasingDirection.Out }, {
                            ["Position"] = v13.Position + v12 * 7,
                            ["Orientation"] = v13.Orientation + (v13.CFrame * CFrame.Angles(2.792526803190927, 0, 0)):ToAxisAngle()
                        })
                        _G.tween(v13.Decal, { 0.33, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                    else
                        _G.tween(v13.Mesh, { 0.43, "Quint", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(0.35, 0, 0)
                        })
                        _G.tween(v13, { 0.43, "Quint", Enum.EasingDirection.Out }, {
                            ["Position"] = v13.Position + v12 * 3
                        })
                    end
                end
            end
            _G.customEmit(v9)
            for _, v14 in v8:GetDescendants() do
                if v14:IsA("ParticleEmitter") and v11 then
                    v14.Color = ColorSequence.new(v11.Color)
                    _G.customEmit(v14)
                end
            end
            for _, v15 in v10:GetDescendants() do
                if v15:IsA("ParticleEmitter") then
                    _G.customEmit(v15)
                end
            end
            _G.destroy(v7, 0.9)
            _G.destroy(v8, 1)
        end
    end
}