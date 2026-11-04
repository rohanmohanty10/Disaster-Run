 

local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v2 = {}
local u3 = Random.new()
local u4 = {
    "rbxassetid://7705979827",
    "rbxassetid://7705974023",
    "rbxassetid://7705978451",
    "rbxassetid://7705940637",
    "rbxassetid://7705937588",
    "rbxassetid://7705937343",
    "rbxassetid://7705937128",
    "rbxassetid://7705934381",
    "rbxassetid://7705934271",
    "rbxassetid://7705934167",
    "rbxassetid://7705934031",
    "rbxassetid://7705930916",
    "rbxassetid://7705930821",
    "rbxassetid://7705927887",
    "rbxassetid://7705916433",
    "rbxassetid://7705916340",
    "rbxassetid://7705916190",
    "rbxassetid://7705916053",
    "rbxassetid://7705915909",
    "rbxassetid://7705915808",
    "rbxassetid://7675246449"
}
local u5 = {
    "rbxassetid://7705769450",
    "rbxassetid://7705769280",
    "rbxassetid://7705756214",
    "rbxassetid://7705769065",
    "rbxassetid://7705750796",
    "rbxassetid://7705750664",
    "rbxassetid://7705750501",
    "rbxassetid://7705748277",
    "rbxassetid://7705766960",
    "rbxassetid://7705742211",
    "rbxassetid://7705742115",
    "rbxassetid://7705738438",
    "rbxassetid://7705737024",
    "rbxassetid://7705736773",
    "rbxassetid://7705736572",
    "rbxassetid://7705736043",
    "rbxassetid://7705735969",
    "rbxassetid://7705735853",
    "rbxassetid://7705735713",
    "rbxassetid://7705731809",
    "rbxassetid://7705726511",
    "rbxassetid://7705726368",
    "rbxassetid://7705726168",
    "rbxassetid://7705726031",
    "rbxassetid://7705725934",
    "rbxassetid://7705725825",
    "rbxassetid://7705725724",
    "rbxassetid://7705725636",
    "rbxassetid://7705720566"
}
local u6 = {
    "rbxassetid://7705705163",
    "rbxassetid://7705704999",
    "rbxassetid://7705704725",
    "rbxassetid://7704898251",
    "rbxassetid://7704894864",
    "rbxassetid://7704891124",
    "rbxassetid://7704890983",
    "rbxassetid://7704890832",
    "rbxassetid://7704890658",
    "rbxassetid://7704890576",
    "rbxassetid://7704890193",
    "rbxassetid://7704890093",
    "rbxassetid://7704889190",
    "rbxassetid://7705697468",
    "rbxassetid://7705697615",
    "rbxassetid://7705697468",
    "rbxassetid://7704870049",
    "rbxassetid://7704869780",
    "rbxassetid://7705690307",
    "rbxassetid://7705690178",
    "rbxassetid://7705687118",
    "rbxassetid://7705686977",
    "rbxassetid://7704842129",
    "rbxassetid://7704841960",
    "rbxassetid://7704840678",
    "rbxassetid://7704831497",
    "rbxassetid://7704831497",
    "rbxassetid://7704831280",
    "rbxassetid://7704828277",
    "rbxassetid://7704828009",
    "rbxassetid://7704827887",
    "rbxassetid://7704827722",
    "rbxassetid://7704827592",
    "rbxassetid://7704827391",
    "rbxassetid://7704827139",
    "rbxassetid://7704826917",
    "rbxassetid://7704823742",
    "rbxassetid://7704819849",
    "rbxassetid://7704819700",
    "rbxassetid://7704815668",
    "rbxassetid://7704815500",
    "rbxassetid://7704813432",
    "rbxassetid://7704806560",
    "rbxassetid://7704806340",
    "rbxassetid://7704798013"
}
local function u9(p7) --[[ Line: 111 ]]
    for v8 = 1, #p7 do
        game:GetService("ContentProvider"):Preload(p7[v8])
    end
end
task.spawn(function() --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u6
        [3] = u5
        [4] = u4
    --]]
    u9(u6)
    u9(u5)
    u9(u4)
end)
function AlignCFrame(p10, p11, _)
    local v12 = p10.Position
    local v13 = p10.LookVector:Cross(p11).Unit
    local v14 = (v13.Magnitude > 0.001 and v13 and v13 or p10.RightVector).Unit
    local v15 = v14:Cross(p11).Unit.Unit
    return CFrame.fromMatrix(v12, v14, p11, v15)
end
local function u23(p16, p17, p18) --[[ Line: 135 ]]
    if p17 == nil then
        p17 = CFrame.new()
    end
    local v19 = CFrame.new(p16.Position + Vector3.new(0, 5, 0))
    local v20 = Ray.new(v19.Position, v19.upVector * -25)
    local _, v21, v22 = _G.raycastWhitelist(v20, { workspace.Env, workspace.Islands, workspace.Ships })
    if p18 == nil then
        return p16
    else
        return AlignCFrame(CFrame.new(Vector3.new(), p16.LookVector) + v21, v22) * p17
    end
end
local u24 = require(game.ReplicatedStorage.Modules.sBeat)
local function u29(p25, p26) --[[ Line: 152 ]]
    local v27 = p25:GetDescendants()
    for v28 = 1, #v27 do
        if v27[v28]:IsA("ParticleEmitter") and v27[v28].Parent.Name == "Attachment" then
            v27[v28]:Emit(p26)
        end
    end
end
function v2.start(_, p30) --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u29
        [3] = u6
        [4] = u24
        [5] = u5
        [6] = u4
        [7] = u3
        [8] = u23
    --]]
    if _G.checkRenderDistance(p30.PrimaryPart.Position) ~= false then
        _G.PlaySound(p30.PrimaryPart, script.slash)
        task.wait(0.25)
        local v31 = p30.HumanoidRootPart
        local u32 = script.LargeSlash:Clone()
        u1.apply(u32, p30)
        local v33 = v31.CFrame
        local v34 = CFrame.Angles
        local v35 = math.random(-360, 360)
        u32.CFrame = v33 * v34(0, math.rad(v35), 0)
        u32.Parent = workspace.Effects
        local u36 = script.SmallSlash:Clone()
        u1.apply(u36, p30)
        local v37 = v31.CFrame
        local v38 = CFrame.Angles
        local v39 = math.random(-360, 360)
        u36.CFrame = v37 * v38(0, math.rad(v39), 0)
        u36.Parent = workspace.Effects
        local u40 = script.WindFX:Clone()
        u1.apply(u40, p30)
        local v41 = v31.CFrame
        local v42 = CFrame.Angles
        local v43 = math.random(-360, 360)
        u40.CFrame = v41 * v42(0, math.rad(v43), 0)
        u40.Parent = workspace.Effects
        u32.Center.new3:Emit(8)
        u32.Center.new4:Emit(8)
        local v44 = script.LargeSlash:Clone()
        u1.apply(v44, p30)
        local v45 = v31.CFrame
        local v46 = CFrame.Angles
        local v47 = math.random(-360, 360)
        v44.CFrame = v45 * v46(0, math.rad(v47), 0)
        v44.Parent = workspace.Effects
        v44.Decal.Texture = ""
        u29(v44, 5)
        task.spawn(function() --[[ Line: 193 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u24
                [3] = u32
            --]]
            for v48 = 1, #u6 do
                u24()
                u32:FindFirstChild("Decal").Texture = u6[v48]
            end
        end)
        coroutine.wrap(function() --[[ Line: 199 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u24
                [3] = u40
            --]]
            for v49 = 1, #u5 do
                u24()
                u40:FindFirstChild("Decal").Texture = u5[v49]
            end
        end)()
        coroutine.wrap(function() --[[ Line: 205 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u24
                [3] = u36
            --]]
            for v50 = 1, #u4 do
                u24()
                u36:FindFirstChild("Decal").Texture = u4[v50]
            end
        end)()
        local v51 = CFrame.Angles(0, 0.03490658503988659, 0)
        local v52 = CFrame.Angles(0, 0.13962634015954636, 0)
        _G.PlayEffect("Rotate", nil, v44, v51)
        _G.PlayEffect("Rotate", nil, u32, v52)
        _G.PlayEffect("Rotate", nil, u40, v52)
        _G.PlayEffect("Rotate", nil, u36, v52)
        _G.destroy(u32, 2)
        _G.destroy(v44, 2)
        _G.destroy(u40, 2)
        _G.destroy(u36, 2)
        local v53 = script.Wind:Clone()
        u1.apply(v53, p30)
        v53.Parent = workspace.Effects
        local v54 = v31.CFrame * CFrame.new(0, -1.5, 0)
        local v55 = CFrame.Angles
        local v56 = u3:NextInteger(0, 360)
        v53.CFrame = v54 * v55(0, math.rad(v56), 0)
        _G.tween(v53.Mesh, { 0.6, "Quint", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(8, 3, 8)
        })
        _G.tween(v53.Decal, { 0.8, "Sine", Enum.EasingDirection.In }, {
            ["Transparency"] = 1
        })
        _G.tween(v53, { 0.8, "Sine", Enum.EasingDirection.Out }, {
            ["CFrame"] = v53.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
        })
        _G.destroy(v53, 0.8)
        local v57 = CFrame.new(v31.CFrame.Position)
        local v58 = Ray.new(v57.Position, v57.upVector * -7)
        local v59, _, _ = _G.raycastWhitelist(v58, { workspace.Env, workspace.Islands, workspace.Ships })
        if v59 then
            local v60 = script.Dust:Clone()
            u1.apply(v60, p30)
            v60.CFrame = u23(v31.CFrame, nil, true)
            v60.Parent = workspace.Effects
            v60.Attachment.Dust.Color = ColorSequence.new(v59.Color)
            _G.customEmit(v60.Attachment)
            _G.destroy(v60, 2)
        end
        local v61 = script.Part:Clone()
        u1.apply(v61, p30)
        v61.CFrame = v31.CFrame
        v61.Parent = workspace.Effects
        _G.tween(v61.PointLight, { 0.5, "Quad", Enum.EasingDirection.Out }, {
            ["Range"] = 20,
            ["Brightness"] = 0
        })
        _G.destroy(v61, 0.5)
    end
end
return v2