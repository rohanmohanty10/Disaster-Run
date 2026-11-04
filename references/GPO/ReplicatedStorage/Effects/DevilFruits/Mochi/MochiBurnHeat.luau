 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            local v2 = p1.PrimaryPart:FindFirstChild("burnMochi")
            if v2 then
                v2 = v2.Value
            end
            if v2 then
                v2:SetAttribute("movin", false)
                v2.HotBall.Size = v2.HotBall.Size - Vector3.new(0.4, 0.4, 0.4)
                _G.tween(v2.WhiteBall.Mesh, {
                    0.35,
                    "Quart",
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = v2.WhiteBall.Mesh.Scale + Vector3.new(0.11, 0.11, 0.11)
                })
                _G.tween(v2.HotBall, {
                    0.35,
                    "Sine",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = v2.HotBall.Size + Vector3.new(1, 1, 1)
                })
                _G.tween(v2.root.DoughHand, {
                    0.3,
                    "Sine",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["C1"] = v2.root.DoughHand.C1 * CFrame.new(0.2, 0.2, 0.3)
                })
                v2.HotBall.BrickColor = BrickColor.new("CGA brown")
                v2.HotBall.Material = Enum.Material.Neon
                v2.HotBall.Fire.Enabled = true
                _G.customEmit(v2)
                v2.HakiBlackHand.Size = v2.DoughHand.Size - Vector3.new(0.08, 0.08, 0.08)
                _G.PlaySound(p1.HumanoidRootPart, script.No)
                if p1:FindFirstChild("BusoMelee") == nil then
                    v2.HakiBlackHand.Transparency = 0
                    v2.HakiBlackHand.Material = Enum.Material.Neon
                    v2.HakiBlackHand.BrickColor = BrickColor.new("CGA brown")
                else
                    _G.PlaySound(p1.HumanoidRootPart, script.Haki)
                    v2.DoughHand.Color = Color3.new(1, 0.807843, 0.811765)
                    v2.DoughHand.Material = Enum.Material.Neon
                    v2.DoughHand.Transparency = -0.6
                    v2.HakiBlackHand.Transparency = 0
                end
                _G.tween(v2.DoughHand, {
                    0.35,
                    "Quad",
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
            end
        end
    end
}