 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.sBeat)
function v1.start(_, _, _) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v3 = script.Frames:GetChildren()
    CFrame.new(1242.48682, 455.18222, -249.810471, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    local _ = workspace.Islands["Reverse Mountain"].Gate.PrimaryPart.CFrame
    local v4 = CFrame.new(1069.09082, 427.88681, -298.473633, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    workspace.NPCs["Gatekeeper Puff"].Humanoid:LoadAnimation(game.ReplicatedStorage.Modules.NPCInteractions.Talks["Gatekeeper Puff"].Animation):Play()
    local v5 = script.Frames["1"].Value
    local v6 = #script.Frames:GetChildren()
    local v7 = workspace.CurrentCamera.CFrame
    local v8 = {}
    for v9 = 1, #v3 do
        local v10 = v3[v9].Name
        tonumber(v10)
        v8[v9] = v3[v9].Value
        v3[v9]:SetAttribute("num", v9)
    end
    local v11 = game.Players.LocalPlayer.PlayerGui:GetChildren()
    local v12 = {}
    for v13 = 1, #v11 do
        if v11[v13]:IsA("ScreenGui") and v11[v13].Enabled == true then
            v11[v13].Enabled = false
            local v14 = v11[v13]
            table.insert(v12, v14)
        end
    end
    _G.tween(workspace.CurrentCamera, {
        1,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["FieldOfView"] = 100
    })
    local v15 = script.ScreenGui:Clone()
    v15.Parent = game.Players.LocalPlayer.PlayerGui
    for v16 = 1, v6 do
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        v5 = v5:Lerp(script.Frames[v16].Value, 0.2)
        local v17 = v4:ToObjectSpace(v5)
        workspace.CurrentCamera.CFrame = workspace.Islands["Reverse Mountain"].Gate.PrimaryPart.CFrame:ToWorldSpace(v17)
        u2()
    end
    task.wait(2)
    _G.tween(workspace.CurrentCamera, {
        1,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v7,
        ["FieldOfView"] = 70
    })
    v15:Destroy()
    task.wait(1)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    for v18 = 1, #v12 do
        if v12[v18] then
            v12[v18].Enabled = true
        end
    end
end
return v1