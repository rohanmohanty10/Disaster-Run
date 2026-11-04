 

local _, u1, _, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
repeat
    task.wait()
until game.Players.LocalPlayer.Character
task.wait(1)
local u2 = game.Players.LocalPlayer.Character
local v3 = u2:WaitForChild("UpperTorso"):WaitForChild("Waist")
local v4 = u2:WaitForChild("LowerTorso"):WaitForChild("Root")
local _ = v3.C0
local _ = v4.C0
local v5 = u2.Humanoid:LoadAnimation(script.sidewalk)
local v6 = u2.Humanoid:LoadAnimation(script.sidewalk2)
v5.Priority = Enum.AnimationPriority.Movement
v6.Priority = Enum.AnimationPriority.Movement
local u7 = true
local u8 = script.ColorCorrection:Clone()
u8.Parent = workspace.CurrentCamera
u8.Name = "heart"
local v9 = {
    ["TintColor"] = Color3.fromRGB(255, 149, 149),
    ["Saturation"] = -0.2,
    ["Contrast"] = 0.5
}
local v10 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0.4)
local u11 = game:GetService("TweenService"):Create(u8, v10, v9)
local v12 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0.4)
game:GetService("TweenService"):Create(workspace.CurrentCamera, v12, {
    ["FieldOfView"] = 60
})
local u13 = false
local u14 = u2:WaitForChild("HumanoidRootPart")
local u15 = u2.Humanoid
local u16 = u15:LoadAnimation(script.hurt)
u16.Priority = Enum.AnimationPriority.Idle
Vector3.new()
local function v21() --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u14
        [3] = u1
        [4] = u15
        [5] = u13
        [6] = u7
        [7] = u16
        [8] = u11
        [9] = u8
    --]]
    if u2.PrimaryPart and u2:FindFirstChild("Humanoid") then
        local _ = (u14.CFrame * CFrame.new(0, -2, 0)).p
        if u1.Parent == workspace.Ragdolls then
            u15.WalkSpeed = 0
            u13 = false
        elseif u13 == false then
            u13 = true
            u15.WalkSpeed = 16
        end
        if _G.TurnCharacterToMouse == true and u15.Sit == true then
            _G.TurnCharacterToMouse = false
        end
        if u15.Health < u15.MaxHealth / 4 then
            local _ = u15.Health / (u15.MaxHealth / 4)
            local v17 = _G.ScaleWithHP(16)
            local v18 = math.clamp(v17, 8, 16)
            if v18 < u15.WalkSpeed then
                u15.WalkSpeed = v18
            end
            u7 = false
            if script.Heartbeat.IsPlaying == false then
                script.Heartbeat:Play()
            end
            if u16.IsPlaying == false then
                u16:Play()
            end
            if u11.PlaybackState ~= Enum.PlaybackState.Playing then
                u11:Play()
            end
        elseif u15.Health >= u15.MaxHealth / 4 then
            if u7 == false then
                u7 = true
                u15.WalkSpeed = 16
            end
            if u16.IsPlaying == true then
                u16:Stop()
            end
            if u11.PlaybackState == Enum.PlaybackState.Playing then
                script.Heartbeat:Stop()
                u11:Cancel()
                local v19 = {
                    ["TintColor"] = Color3.fromRGB(255, 255, 255),
                    ["Saturation"] = 0,
                    ["Contrast"] = 0
                }
                local v20 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                game:GetService("TweenService"):Create(u8, v20, v19):Play()
            end
        end
        if u1:FindFirstChild("Stun") then
            u15.Jump = false
        end
    end
end
game["Run Service"].Stepped:Connect(v21)