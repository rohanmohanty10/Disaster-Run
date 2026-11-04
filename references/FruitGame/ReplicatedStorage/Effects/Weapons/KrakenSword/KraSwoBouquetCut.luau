 

local v1 = {}
function recu_to_zero(p2, p3, p4)
    local v5 = p2:GetChildren()
    if #v5 ~= 0 then
        v5[1].CFrame = v5[1].CFrame:lerp(p3, p4)
        recu_to_zero(v5[1], p3, p4)
    end
end
require(game:GetService("ReplicatedStorage").Modules.sBeat)
require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
function v1.start(_, p6, p7) --[[ Line: 24 ]]
    if _G.checkRenderDistance(p6.HumanoidRootPart.Position) then
        local v8 = {
            ["Size"] = Vector3.new(0, 0, 0),
            ["Transparency"] = 1
        }
        local v9 = p7:FindFirstChild("Tentacle").Color
        local v10 = ColorSequence.new(v9)
        local _ = p7.root.CFrame.LookVector
        local v11 = Random.new()
        local v12 = p7.root.CFrame
        local v13 = script.boucut:Clone()
        v13:PivotTo(v12)
        v13.root.Attachment.Shine1.Color = v10
        v13.root.Attachment.Shine2.Color = v10
        v13.root.Attachment.Sparkles.Color = v10
        _G.customEmit(v13.root.Attachment.Sparkles)
        _G.customEmit(v13.root.Attachment.Shine2)
        _G.customEmit(v13.root.Attachment.Shine1)
        local v14 = Ray.new(p6.HumanoidRootPart.CFrame.Position, p6.HumanoidRootPart.CFrame.upVector * -10)
        local v15, _, _ = _G.raycastWhitelist(v14, { workspace.Islands, workspace.Ships, workspace.Env })
        if v15 then
            v13.root.Attachment.sm2.Color = ColorSequence.new(v15.Color)
            _G.customEmit(v13.root.Attachment.sm2)
        end
        v13.Parent = workspace.Effects
        _G.destroy(v13, 2.4)
        for _, v16 in p7:GetChildren() do
            v16.Transparency = 1
            local v17 = v11:NextNumber(0, 100) > 50 and script.Top:Clone() or script.Bottom:Clone()
            local v18 = v11:NextNumber(3, 7)
            v17.Color = v9
            v17.CFrame = v12 * CFrame.new(0, v18, 0)
            v17.BodyVelocity.Velocity = v12.LookVector * v18 * 18 + v12.rightVector * v11:NextNumber(-16, 16)
            v17.Parent = v13
            v17.AssemblyAngularVelocity = v17.BodyVelocity.Velocity * 0.1
            _G.tween(v17, {
                v11:NextNumber(0.2, 0.7),
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, v8)
        end
        p7.Name = "blahlblahla"
    end
end
return v1