 

local v1 = {}
require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
require(game:GetService("ReplicatedStorage").Modules.sBeat)
Random.new()
function Rashomon_Camerawork(p2, p3)
    local v4 = workspace.CurrentCamera
    v4.CameraType = Enum.CameraType.Scriptable
    local v5 = game:GetService("RunService").RenderStepped
    local v6 = p3.HumanoidRootPart.CFrame
    local v7 = 0
    while v7 < p2 do
        local v8 = v5:Wait()
        local v9 = v4.CFrame
        local v10 = v6 * CFrame.new(-7.54604673, -1.90004063, -4.7572937, -0.88096714, -0.148958504, -0.449119568, -7.4505806e-9, 0.949156642, -0.314804673, 0.473177552, -0.277332574, -0.83617568)
        local v11 = v8 * 17
        v4.CFrame = v9:Lerp(v10, (math.min(v11, 1)))
        v7 = v7 + v8
    end
    v4.CameraType = Enum.CameraType.Custom
end
function v1.start(_, p12) --[[ Line: 22 ]]
    Rashomon_Camerawork(1.3, p12)
end
return v1