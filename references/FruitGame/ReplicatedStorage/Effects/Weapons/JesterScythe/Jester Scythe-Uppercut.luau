 

local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v2 = {}
Random.new()
local u3 = {
    "rbxassetid://7631047144",
    "rbxassetid://7630565717",
    "rbxassetid://7630565282",
    "rbxassetid://7630564894",
    "rbxassetid://7630564228",
    "rbxassetid://7630557972",
    "rbxassetid://7630557430",
    "rbxassetid://7630556948",
    "rbxassetid://7630556431",
    "rbxassetid://7630541633",
    "rbxassetid://7630541008",
    "rbxassetid://7630540358",
    "rbxassetid://7630526842",
    "rbxassetid://7630526405",
    "rbxassetid://7630525946",
    "rbxassetid://7630525539",
    "rbxassetid://7630525008",
    "rbxassetid://7630524480",
    "rbxassetid://7630523910"
}
local u4 = require(game.ReplicatedStorage.Modules.sBeat)
function PlayFlipbook(u5, _, u6)
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    coroutine.wrap(function() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u5
            [3] = u4
            [4] = u6
        --]]
        for v7 = 1, #u3 do
            u5.Texture = u3[v7]
            u4()
        end
        if u6 then
            u6()
        end
    end)()
end
function AlignCFrame(p8, p9, _)
    local v10 = p8.Position
    local v11 = p8.LookVector:Cross(p9).Unit
    local v12 = (v11.Magnitude > 0.001 and v11 and v11 or p8.RightVector).Unit
    local v13 = v12:Cross(p9).Unit.Unit
    return CFrame.fromMatrix(v10, v12, p9, v13)
end
local function u21(p14, p15, p16) --[[ Line: 59 ]]
    if p15 == nil then
        p15 = CFrame.new()
    end
    local v17 = CFrame.new(p14.Position + Vector3.new(0, 5, 0))
    local v18 = Ray.new(v17.Position, v17.upVector * -25)
    local _, v19, v20 = _G.raycastWhitelist(v18, { workspace.Env, workspace.Islands, workspace.Ships })
    if p16 == nil then
        return p14
    else
        return AlignCFrame(CFrame.new(Vector3.new(), p14.LookVector) + v19, v20) * p15
    end
end
function v2.start(_, p22) --[[ Line: 75 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u21
    --]]
    if _G.checkRenderDistance(p22.PrimaryPart.Position) ~= false then
        local v23 = p22.HumanoidRootPart
        _G.PlaySound(p22.Head, script.Sound)
        local v24 = script.Sparks:Clone()
        u1.apply(v24, p22)
        v24.CFrame = u21(v23.CFrame * CFrame.new(0, -3, -2) * CFrame.Angles(0.2617993877991494, 0, 0))
        v24.Parent = workspace.Effects
        _G.customEmit(v24)
        _G.destroy(v24, 0.3)
        local _ = { 0.08333333333333333, "Quad", Enum.EasingDirection.Out }
        local v25 = script.SplashBlack:Clone()
        u1.apply(v25, p22)
        v25.CFrame = u21(v23.CFrame * CFrame.new(0, -2.99, -11))
        v25.Size = Vector3.new(15, 0.05, 50)
        v25.Parent = workspace.Effects
        _G.tween(v25[1], { 1.3, "Quad", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        local v26 = script.SplashColored:Clone()
        u1.apply(v26, p22)
        v26.CFrame = u21(v23.CFrame * CFrame.new(0, -2.98, -11))
        v26.Size = Vector3.new(3, 0.05, 40)
        v26.Parent = workspace.Effects
        _G.tween(v26[1], { 0.5, "Sine", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        local v27 = script.UpBlack:Clone()
        u1.apply(v27, p22)
        v27.CFrame = u21(v23.CFrame * CFrame.new(0, -3, -6) * CFrame.Angles(0.3490658503988659, 0, 1.5707963267948966))
        v27.Parent = workspace.Effects
        _G.tween(v27[1], { 1.3, "Quad", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        _G.tween(v27[2], { 1.3, "Quad", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        local v28 = script.UpColored:Clone()
        u1.apply(v28, p22)
        v28.CFrame = u21(v23.CFrame * CFrame.new(0, -3, -6) * CFrame.Angles(0.3490658503988659, 0, 1.5707963267948966))
        v28.Parent = workspace.Effects
        _G.tween(v28[1], { 0.5, "Sine", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        _G.tween(v28[2], { 0.5, "Sine", Enum.EasingDirection.InOut }, {
            ["Transparency"] = 1
        })
        local v29 = script.Slash:Clone()
        u1.apply(v29, p22)
        v29.CFrame = v23.CFrame * CFrame.new(0, -2, -5) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.Angles(0, 0.6108652381980153, 0)
        v29.Parent = workspace.Effects
        _G.tween(v29, { 0.3333333333333333, "Quad", Enum.EasingDirection.Out }, {
            ["CFrame"] = v29.CFrame * CFrame.Angles(0, -1.7453292519943295, 0)
        })
        _G.tween(v29.Mesh, { 0.3333333333333333, "Quad", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(13, 13, 13)
        })
        local v30 = CFrame.new(v23.CFrame.Position)
        local v31 = Ray.new(v30.Position, v30.upVector * -7)
        local v32, _, _ = _G.raycastWhitelist(v31, { workspace.Env, workspace.Islands, workspace.Ships })
        if v32 then
            local v33 = script.Dust:Clone()
            u1.apply(v33, p22)
            v33.CFrame = u21(v23.CFrame, nil, true)
            v33.Parent = workspace.Effects
            v33.Attachment.Dust.Color = ColorSequence.new(v32.Color)
            _G.customEmit(v33.Attachment)
            _G.destroy(v33, 2)
        end
        PlayFlipbook(v29.Decal, script.Flipbook)
        local v34 = script.Sparks2:Clone()
        u1.apply(v34, p22)
        v34.CFrame = u21(v23.CFrame * CFrame.new(0, -4, -18.5) * CFrame.Angles(1.0471975511965976, 0, 1.5707963267948966) * CFrame.new(0, 0, 1), CFrame.Angles(1.5707963267948966, 0, 0))
        v34.Parent = workspace.Effects
        _G.customEmit(v34.Attachment)
        _G.destroy(v34, 0.3)
        local v35 = script.Part:Clone()
        u1.apply(v35, p22)
        v35.CFrame = v23.CFrame * CFrame.new(0, 0, -5)
        v35.Parent = workspace.Effects
        _G.tween(v35.PointLight, { 0.25, "Quad", Enum.EasingDirection.Out }, {
            ["Range"] = 25,
            ["Brightness"] = 0
        })
        _G.destroy(v35, 0.25)
        _G.destroy(v29, 1)
        _G.destroy(v28, 2)
        _G.destroy(v27, 2)
        _G.destroy(v26, 2)
        _G.destroy(v25, 2)
    end
end
return v2