 

local v1 = {}
game:GetService("Debris")
game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = workspace:WaitForChild("Effects")
local u4 = Random.new()
function v1.start(_, p5, p6) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u3
    --]]
    if p5 == nil or p6 == nil then
        return
    end
    local v7 = p6:WaitForChild("UpperTorso")
    while p5 do
        task.wait(u4:NextNumber(0.25, 1.25))
        if not (p5:IsDescendantOf(workspace) and p5.PrimaryPart) then
            break
        end
        if (p5.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 100 and v7.Transparency ~= 1 then
            local v8 = u4:NextNumber(0.05, 0.15)
            local v9 = p5:Clone()
            for _, v10 in v9:GetChildren() do
                if v10:IsA("BasePart") and v10.Name ~= "RootPart" then
                    v10.CastShadow = false
                    v10.Transparency = u4:NextNumber(0.8, 0.95)
                    u2:Create(v10, TweenInfo.new(v8, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        ["Transparency"] = 1
                    }):Play()
                end
            end
            local v11 = Instance.new("Weld")
            v11.Part0 = p5.RootPart
            v11.Part1 = v9.RootPart
            v11.C0 = p5.RootPart.CFrame:ToObjectSpace(v9.RootPart.CFrame)
            u2:Create(v11, TweenInfo.new(v8 / u4:NextNumber(1.25, 2), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["C1"] = CFrame.new(u4:NextNumber(-0.5, 0.5), u4:NextNumber(-0.5, 0.75), u4:NextNumber(-0.5, 0.5))
            }):Play()
            v11.Parent = v9
            v9.Parent = u3
            task.delay(v8, v9.Destroy, v9)
            if math.random(1, 4) == 1 then
                task.wait(v8 / u4:NextNumber(1.5, 2))
            end
        end
    end
end
return v1