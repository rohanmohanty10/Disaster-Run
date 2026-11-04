 

game:GetService("TweenService")
local v1 = game:GetService("Players")
local u2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local _ = workspace.CurrentCamera
require(v3.Modules.CameraShaker)
local _ = v1.LocalPlayer
local _ = _G.Emit
local v4 = {}
local u5 = RaycastParams.new()
local v6 = Enum.RaycastFilterType.Include
local v7 = { workspace.Islands, workspace.Ships, workspace.Env }
u5.FilterType = v6
u5.FilterDescendantsInstances = v7
function v4.start(_, p8, p9, p10, p11) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
    --]]
    local v12 = p8 == game.Players.LocalPlayer.Character
    local v13 = p9.Position
    local v14 = p8.HumanoidRootPart
    local v15 = v14.Position
    local v16 = (v15 - v13).Magnitude
    local v17 = math.min(v16, p11)
    if v17 == p11 then
        v13 = v15 + (v13 - v15).Unit * p11
    end
    local v18 = {}
    local v19 = {
        ["Position"] = v15,
        ["Normal"] = v14.CFrame.UpVector
    }
    table.insert(v18, v19)
    local v20 = (v13 - v15 - Vector3.new(0, -98.1, 0)) / 1
    local v21 = 0
    local v22 = false
    while v21 <= 4 do
        local v23 = Vector3.new(0, -98.1, 0) * v21 * v21 + v20 * v21 + v15
        local v24 = v21 + 0.02
        local v25 = Vector3.new(0, -98.1, 0) * v24 * v24 + v20 * v24 + v15
        local v26 = v23 - (v25 - v23) * 0.05
        local v27 = v25 - v26
        local v28 = workspace:Raycast(v26, v27, u5)
        if v28 then
            local v29 = {
                ["Position"] = v28.Position,
                ["Normal"] = v28.Normal
            }
            table.insert(v18, v29)
            v22 = true
            break
        end
        local v30 = {
            ["Position"] = v23,
            ["Normal"] = v14.CFrame.UpVector
        }
        table.insert(v18, v30)
        v21 = v21 + 0.02
    end
    if not v22 then
        table.insert(v18, {
            ["Position"] = v13,
            ["Normal"] = Vector3.new(0, 1, 0)
        })
    end
    if #v18 < 3 then
        local v31 = {
            ["Position"] = (v15 + v18[#v18].Position) / 2 + Vector3.new(0, 5, 0),
            ["Normal"] = Vector3.new(0, 1, 0)
        }
        table.insert(v18, 2, v31)
    end
    local v32 = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(0, 1, 0)):Cross(CFrame.new(v15, v13).RightVector))
    local v33 = v17 / p11
    local v34 = math.clamp(v33, 0.25, 0.5)
    for v35 = 1, #v18 - 1 do
        local v36 = v34 / (#v18 - 1)
        local v37 = v14.Size.Y / 2 + p8.Humanoid.HipHeight
        local v38 = v18[v35].Position + v18[v35].Normal * v37
        local v39 = v18[v35 + 1].Position + v18[v35 + 1].Normal * v37
        local v40 = 0
        while true do
            p8.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
            p8.PrimaryPart.AssemblyAngularVelocity = Vector3.new()
            p8.Humanoid.AutoRotate = false
            v14.CFrame = v32 + v38:Lerp(v39, v40)
            if v40 >= 1 then
                break
            end
            local _, v41 = u2.Stepped:Wait()
            local v42 = v40 + v41 / v36
            v40 = math.clamp(v42, 0, 1)
        end
    end
    if v12 == true then
        p10:SetAttribute("clientSmashed", true)
        p10:FireServer("Smash", p8.PrimaryPart.CFrame)
    end
    local v43 = p8.PrimaryPart.CFrame
    local v44 = workspace:Raycast(v43.Position, v43.LookVector * 5, u5)
    local v45 = not v44 and 5 or v44.Position - v43.Position
    local v46 = workspace:Raycast((v43 * CFrame.new(0, 0, -v45)).Position, Vector3.new(0, -15, 0), u5)
    local v47 = nil
    if v46 then
        v47 = v46.Instance and {
            ["Color"] = v46.Instance.Color,
            ["Material"] = v46.Instance.Material,
            ["Position"] = v46.Position,
            ["Normal"] = v46.Normal
        } or v47
    end
    _G.PlayEffect("DragonTailStomp", nil, p8, {
        ["Type"] = "Smash",
        ["CFrame"] = v43,
        ["lookOffset"] = v45,
        ["castInfo"] = v47
    })
end
return v4