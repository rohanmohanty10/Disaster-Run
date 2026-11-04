 

local v1 = {}
local u2 = {
    ["Head"] = "Head",
    ["RightUpperArm"] = "RightArm",
    ["LeftUpperArm"] = "LeftArm",
    ["LeftUpperLeg"] = "LeftLeg",
    ["RightUpperLeg"] = "RightLeg",
    ["UpperTorso"] = "Torso"
}
local u3 = {
    932154428,
    932154085,
    932153746,
    932153061,
    921606174
}
function do_poof_efx(p4)
    local v5 = script.PoofEffect:Clone()
    v5:PivotTo(CFrame.new(p4))
    v5.SwirlA.Size = Vector3.new(7, 7, 3)
    v5.SwirlB.Size = Vector3.new(5, 5, 3)
    v5.Parent = workspace.Effects
    _G.tween(v5.SwirlA, {
        1,
        "EntranceProductive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v5.SwirlA.CFrame * CFrame.Angles(0, 0, 2.13),
        ["Size"] = Vector3.new(29, 29, 4),
        ["Transparency"] = 1
    })
    _G.tween(v5.SwirlB, {
        0.75,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v5.SwirlB.CFrame * CFrame.Angles(0, 0, -3.13),
        ["Size"] = Vector3.new(32, 32, 5),
        ["Transparency"] = 1
    })
    v5.root.Attachment.Core:Emit(1)
    v5.root.Attachment.FillStar:Emit(8)
    v5.root.Attachment.HollowStar:Emit(6)
    v5.root.Attachment.Smoke:Emit(6)
    _G.destroy(v5, 1.5)
    local v6 = Random.new()
    _G.PlaySound(v5.PrimaryPart, script.Transform, {
        ["PlaybackSpeed"] = v6:NextNumber(0.9, 1.05)
    })
    _G.PlaySound(v5.PrimaryPart, script.Pop, {
        ["PlaybackSpeed"] = v6:NextNumber(0.4, 0.9)
    })
end
function do_revert_efx(p7)
    local v8 = script.RevertEffect:Clone()
    v8:PivotTo(CFrame.new(p7))
    v8.Parent = workspace.Effects
    v8.root.Attachment.Core:Emit(2)
    v8.root.Attachment.Smoke:Emit(5)
    _G.destroy(v8, 1.6)
    _G.PlaySound(v8.PrimaryPart, script.Revert, {
        ["PlaybackSpeed"] = Random.new():NextNumber(0.95, 1.05)
    })
end
local u9 = {}
local u32 = {
    ["attach_doll"] = function(p10, p11) --[[ Line: 59 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u2
            [3] = u3
        --]]
        if not p10:FindFirstChild("DollParts") then
            if u9[p10] == nil then
                u9[p10] = {}
            end
            local v12 = p10:GetDescendants()
            for v13 = 1, #v12 do
                if v12[v13]:IsA("BasePart") then
                    u9[p10][v12[v13]] = v12[v13].Transparency
                    v12[v13].Transparency = 1
                end
            end
            p10.Humanoid.HipHeight = p10.Humanoid.BodyHeightScale.Value * 2 * 0.4
            do_poof_efx(p10.HumanoidRootPart.Position)
            local v14 = Instance.new("Model")
            v14.Name = "DollParts"
            for v15, v16 in u2 do
                local v17 = p10[v15]
                local v18 = script.DollParts[v16]:Clone()
                v18.Weld.Part1 = v17
                v18.Parent = v14
                local v19 = v18:GetChildren()
                for v20 = 1, #v19 do
                    if v19[v20]:IsA("BasePart") then
                        v19[v20].Parent = v14
                    end
                end
            end
            v14.Torso.Decal.Texture = "rbxassetid://" .. u3[Random.new():NextInteger(1, 5)]
            if p11 ~= nil then
                local v21 = script.DollParts.DahNoobAcc:Clone()
                v21.root.Weld.Part1 = p10.Head
                v21.Parent = v14
                v14.RightArm.BrickColor = BrickColor.new("Really black")
                v14.LeftLeg.BrickColor = BrickColor.new("Royal purple")
            end
            v14.Parent = p10
        end
    end,
    ["remove_doll"] = function(p22) --[[ Line: 102 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        if p22:FindFirstChild("DollParts") then
            if u9[p22] then
                for v23, v24 in u9[p22] do
                    if v23 then
                        v23.Transparency = v24
                    end
                end
                u9[p22] = nil
            end
            p22.Humanoid.HipHeight = p22.Humanoid.BodyHeightScale.Value * 2
            do_revert_efx(p22.HumanoidRootPart.Position)
            p22.DollParts:Destroy()
        end
    end,
    ["spin_swoosh"] = function(_, p25) --[[ Line: 121 ]]
        local v26 = script.Swoosh:Clone()
        v26.CFrame = p25.CFrame
        v26.Parent = workspace.Effects
        _G.tween(v26, { 0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut }, {
            ["CFrame"] = v26.CFrame * CFrame.Angles(0, -3.13, 0)
        })
        _G.tween(v26.Decal, { 0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
        _G.tween(v26.Mesh, { 0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(16, 120, 16)
        })
        _G.destroy(v26, 0.12)
    end,
    ["swap"] = function(_, p27, p28) --[[ Line: 132 ]]
        local v29 = (p27 - p28).Magnitude * 0.5
        if v29 > 10 then
            do_revert_efx(p27)
        end
        do_revert_efx(p28)
        local v30 = script.Line:Clone()
        local v31 = v29 * 2
        v30.Size = Vector3.new(v31, 6, 6)
        v30.CFrame = CFrame.new(p28, p27) * CFrame.new(0, 0, -v29) * CFrame.Angles(0, 1.57079, 0)
        v30.Parent = workspace.Effects
        _G.tween(v30, { 0.5, "FabricDecelerate", Enum.EasingDirection.Out }, {
            ["Size"] = Vector3.new(4, 0.1, 0.1),
            ["CFrame"] = v30.CFrame * CFrame.new(v29, 0, 0),
            ["Transparency"] = 1
        })
        _G.destroy(v30, 0.5)
    end
}
function v1.start(_, p33, p34, ...) --[[ Line: 148 ]]
    --[[
    Upvalues:
        [1] = u32
    --]]
    if p34 == "remove_plushie" or _G.checkRenderDistance(p33.HumanoidRootPart.Position) then
        u32[p34](p33, unpack({ ... }))
    end
end
return v1