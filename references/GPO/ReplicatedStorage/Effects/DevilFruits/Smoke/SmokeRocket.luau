 

game:GetService("RunService")
local u1 = script
local v2 = {}
game:GetService("TweenService")
Random.new()
function v2.start(_, p3) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = Instance.new("Folder")
    v4.Name = "EffectsFolder"
    v4.Parent = workspace.Effects
    p3:WaitForChild("HumanoidRootPart")
    local v5 = u1.PlayerSmoke:Clone()
    v5.Parent = v4
    local v6 = p3 == game.Players.LocalPlayer.Character
    local v7 = _G.PlaySound(p3.PrimaryPart, script.SmokeRocketStart)
    v7.Parent = p3.PrimaryPart
    local v8 = script.SmokeRocketLoop:Clone()
    v8.Parent = p3.PrimaryPart
    v8:Play()
    while true do
        v5.CFrame = p3.PrimaryPart.CFrame
        if v6 == true then
            p3.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
            p3.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            v5.CFrame = CFrame.new(p3.PrimaryPart.Position, _G.MouseCF.Position)
        end
        game["Run Service"].RenderStepped:Wait()
        if p3:GetAttribute("SmokeRocketHold") == nil then
            if v8 then
                _G.tween(v8, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                _G.destroy(v8, 0.25)
            end
            if v7 then
                _G.tween(v7, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                _G.destroy(v7, 0.25)
            end
            local v9 = u1.FloorHit:Clone()
            v9.Position = p3.PrimaryPart.Position
            v9.Parent = v4
            for _, v10 in pairs(v5:GetDescendants()) do
                if v10:IsA("ParticleEmitter") then
                    v10.Enabled = false
                end
            end
            for _, v11 in pairs(v9:GetDescendants()) do
                if v11:IsA("ParticleEmitter") then
                    v11:Emit(v11:GetAttribute("EmitCount"))
                end
            end
            task.wait(3.5)
            v4:Destroy()
            return
        end
    end
end
return v2