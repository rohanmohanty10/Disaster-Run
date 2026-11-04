 

local v1 = {}
local u2 = game:GetService("TweenService")
function v1.start(_, p3, _) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) == false then
        return
    else
        local _, v4 = p3:GetBoundingBox()
        local v5 = Ray.new(p3.HumanoidRootPart.CFrame * CFrame.new(0, 0, -v4.Z / 2).Position, Vector3.new(0, -10, 0))
        local v6, v7, v8 = _G.raycastWhitelist(v5, { workspace.Islands, workspace.Env, workspace.Ships })
        if v6 then
            local v9 = script.BirdPeck:Clone()
            local v10 = v9.Peck
            v9.Peck.CFrame = CFrame.new(v7, v7 + v8)
            v9.Parent = workspace.Effects
            u2:Create(v10.Mesh, TweenInfo.new(0.075, Enum.EasingStyle.Quad), {
                ["Scale"] = Vector3.new(-22.5, -0.35, -0.35),
                ["Offset"] = Vector3.new(-10.25, 0, 0)
            }):Play()
            u2:Create(v10.Decal, TweenInfo.new(0.075, Enum.EasingStyle.Linear), {
                ["Transparency"] = 1
            }):Play()
            _G.customEmit(v10)
            _G.destroy(v9, 2.5)
        end
    end
end
return v1