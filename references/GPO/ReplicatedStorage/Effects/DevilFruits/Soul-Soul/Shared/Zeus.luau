 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = workspace:WaitForChild("Effects")
local u4 = require(script.LightningBolt)
local u5 = require(script.LightningBolt.LightningSparks)
function v1.TweenIn(p6) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v7 = next
    local v8, v9 = p6:GetDescendants()
    for _, v10 in v7, v8, v9 do
        if v10:IsA("BasePart") and v10.Name ~= p6.PrimaryPart then
            if not v10:GetAttribute("OldSize") then
                v10:SetAttribute("OldSize", v10.Size)
            end
            u2:Create(v10, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
                ["Size"] = Vector3.new(0, 0, 0)
            }):Play()
        elseif v10:IsA("Bone") and v10.Name ~= "Hat" then
            if not v10:GetAttribute("OldCF") then
                v10:SetAttribute("OldCF", v10.CFrame)
            end
            u2:Create(v10, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
                ["CFrame"] = CFrame.new(0, 0, 0)
            }):Play()
        elseif v10:IsA("ParticleEmitter") then
            v10.Enabled = false
        end
    end
end
function v1.TweenOut(p11) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v12 = next
    local v13, v14 = p11:GetDescendants()
    for _, v15 in v12, v13, v14 do
        if v15:IsA("BasePart") and (v15.Name ~= p11.PrimaryPart and v15:GetAttribute("OldSize")) then
            u2:Create(v15, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                ["Size"] = v15:GetAttribute("OldSize")
            }):Play()
        elseif v15:IsA("Bone") and (v15.Name ~= "Hat" and v15:GetAttribute("OldCF")) then
            u2:Create(v15, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                ["CFrame"] = v15:GetAttribute("OldCF")
            }):Play()
        elseif v15:IsA("ParticleEmitter") and p11.Parent.CurrentCloud.Value == "Zeus" then
            v15.Enabled = true
        end
    end
end
function v1.Lightning(p16, p17, p18, p19) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
    --]]
    local u20 = Instance.new("Part", u3)
    local u21 = Instance.new("Part", u3)
    u20.Anchored = true
    u21.Anchored = true
    u20.CanCollide = false
    u21.CanCollide = false
    u20.Transparency = 1
    u21.Transparency = 1
    u20.Position = p16
    u21.Position = p17
    local v22 = Instance.new("Attachment", u20)
    local v23 = Instance.new("Attachment", u21)
    if p19 then
        local v24 = u4.new(v22, v23, p19.PartCount)
        v24.CurveSize0 = 5
        v24.CurveSize1 = -2.5
        v24.PulseSpeed = p19.PulseSpeed
        v24.PulseLength = p19.PulseLength
        v24.FadeLength = p19.FadeLength
        v24.Color = p18
        if p19.Bolts then
            u5.new(v24, p19.Bolts)
        end
    end
    task.delay(1, function() --[[ Line: 68 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u21
        --]]
        u20:Destroy()
        u21:Destroy()
    end)
end
return v1