 

local v1 = game:GetService("ReplicatedStorage")
require(v1.Modules.CameraShaker)
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local u3 = workspace.Effects
local u4 = {}
local u5 = {
    "rbxassetid://13262712654",
    "rbxassetid://13262712402",
    "rbxassetid://13262712266",
    "rbxassetid://13262712105",
    "rbxassetid://13262706765",
    "rbxassetid://13262706656",
    "rbxassetid://13262706530",
    "rbxassetid://13262706358",
    "rbxassetid://13262715553",
    "rbxassetid://13262706009",
    "rbxassetid://13262701091",
    "rbxassetid://13262700920",
    "rbxassetid://13262700770",
    "rbxassetid://13262715411",
    "rbxassetid://13262700469",
    "rbxassetid://13262700290"
}
local u6 = {
    "rbxassetid://13262749732",
    "rbxassetid://13262749544",
    "rbxassetid://13262749155",
    "rbxassetid://13262748673",
    "rbxassetid://13262743695",
    "rbxassetid://13262743508",
    "rbxassetid://13262743373",
    "rbxassetid://13262742953",
    "rbxassetid://13262742798",
    "rbxassetid://13262742287",
    "rbxassetid://13262737878",
    "rbxassetid://13262737606",
    "rbxassetid://13262737406",
    "rbxassetid://13262737158",
    "rbxassetid://13262736902",
    "rbxassetid://13262736729"
}
function Flipbook(p7, u8, u9, u10)
    local u11 = p7:FindFirstChildOfClass("SpecialMesh")
    if u11 and u8 then
        task.spawn(function() --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u11
                [3] = u9
                [4] = u10
            --]]
            for v12 = 1, #u8 do
                u11.TextureId = u8[v12]
                task.wait(1 / u9)
            end
            if u10 == true then
                u11.Parent:Destroy()
            end
        end)
    end
end
local function u23(p13, p14, p15) --[[ Line: 64 ]]
    local function v21(u16, p17, p18) --[[ Line: 65 ]]
        for _, v19 in ipairs(u16:GetDescendants()) do
            if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
                v19.Enabled = p17
            end
        end
        if p18 then
            task.delay(p18, function() --[[ Line: 73 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                for _, v20 in ipairs(u16:GetDescendants()) do
                    if v20:IsA("ParticleEmitter") or v20:IsA("Trail") then
                        v20.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p13) == "table" then
        for _, v22 in p13 do
            v21(v22, p14, p15)
        end
    else
        v21(p13, p14, p15)
    end
end
return {
    ["start"] = function(_, p24, p25, _, p26) --[[ Name: start, Line 97 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u3
            [4] = u23
            [5] = u6
            [6] = u5
        --]]
        if _G.checkRenderDistance(p25.PrimaryPart.Position) == false then
            return
        elseif p24 == "Hold" then
            u4[p25] = {}
            for _, v27 in script.Aura:GetDescendants() do
                if v27:IsA("ParticleEmitter") then
                    local v28 = v27:Clone()
                    u2.apply(v28, p25)
                    v28.Parent = p25[v27.Parent.Name]
                    v28.Enabled = true
                    local v29 = u4[p25]
                    table.insert(v29, v28)
                end
            end
        elseif p24 == "Release" then
            for _, v30 in ipairs(u4[p25]) do
                if v30 then
                    v30.Enabled = false
                    _G.destroy(v30, 2)
                end
            end
            u4[p25] = nil
            local v31 = script["BloodBurst VFX"]:Clone()
            u2.apply(v31, p25)
            v31.CFrame = p26
            v31.Parent = u3
            u23(v31, true, 0.5)
            _G.destroy(v31, 3)
            local u32 = script["Blood Burst"]:Clone()
            u2.apply(u32, p25)
            u32:PivotTo(p26 * CFrame.new(0, 4, 0))
            u32.Parent = u3
            _G.destroy(u32, 2.3)
            Flipbook(u32["Blood Floor"], u6, 24)
            Flipbook(u32.BloodDome, u6, 24)
            Flipbook(u32.InnerWave, u6, 24)
            Flipbook(u32.InnerWave2, u6, 24)
            Flipbook(u32.Wave1, u5, 24)
            Flipbook(u32.Wave2, u5, 24)
            u32.Wave1.Position = u32.Wave1.Position + Vector3.new(0, -4, 0)
            local v33 = u32.Wave1.Mesh
            local v34 = u32.Wave1.Mesh.Scale.X
            local v35 = u32.Wave1.Mesh.Scale.Y * 6
            local v36 = u32.Wave1.Mesh.Scale.Z
            v33.Scale = Vector3.new(v34, v35, v36)
            local v37 = u32.Wave2.Mesh
            local v38 = u32.Wave2.Mesh.Scale.X
            local v39 = u32.Wave2.Mesh.Scale.Y * 6
            local v40 = u32.Wave2.Mesh.Scale.Z
            v37.Scale = Vector3.new(v38, v39, v40)
            local v41 = u32.InnerWave.Mesh
            local v42 = u32.InnerWave.Mesh.Scale.X
            local v43 = u32.InnerWave.Mesh.Scale.Y * 6
            local v44 = u32.InnerWave.Mesh.Scale.Z
            v41.Scale = Vector3.new(v42, v43, v44)
            local v45 = u32.InnerWave2.Mesh
            local v46 = u32.InnerWave2.Mesh.Scale.X
            local v47 = u32.InnerWave2.Mesh.Scale.Y * 6
            local v48 = u32.InnerWave2.Mesh.Scale.Z
            v45.Scale = Vector3.new(v46, v47, v48)
            _G.tween(u32.BloodDome.Mesh, {
                0.75,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = u32.BloodDome.Mesh.Scale * 1.5
            })
            _G.tween(u32["Blood Floor"].Mesh, {
                0.75,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = u32["Blood Floor"].Mesh.Scale * 2
            })
            local v49 = _G.tween
            local v50 = u32.Wave1.Mesh
            local v51 = {
                0.75,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v52 = {}
            local v53 = u32.Wave1.Mesh.Scale.X * 3
            local v54 = u32.Wave1.Mesh.Scale.Z * 3
            v52.Scale = Vector3.new(v53, 0, v54)
            v49(v50, v51, v52)
            local v55 = _G.tween
            local v56 = u32.Wave2.Mesh
            local v57 = {
                0.75,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v58 = {}
            local v59 = u32.Wave2.Mesh.Scale.X * 4
            local v60 = u32.Wave2.Mesh.Scale.Z * 4
            v58.Scale = Vector3.new(v59, 0, v60)
            v55(v56, v57, v58)
            local v61 = _G.tween
            local v62 = u32.InnerWave.Mesh
            local v63 = {
                0.75,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v64 = {}
            local v65 = u32.InnerWave.Mesh.Scale.X * 3
            local v66 = u32.InnerWave.Mesh.Scale.Z * 3
            v64.Scale = Vector3.new(v65, 0, v66)
            v61(v62, v63, v64)
            local v67 = _G.tween
            local v68 = u32.InnerWave2.Mesh
            local v69 = {
                0.75,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v70 = {}
            local v71 = u32.InnerWave2.Mesh.Scale.X * 2
            local v72 = u32.InnerWave2.Mesh.Scale.Z * 2
            v70.Scale = Vector3.new(v71, 0, v72)
            v67(v68, v69, v70)
            task.delay(0.30000000000000004, function() --[[ Line: 161 ]]
                --[[
                Upvalues:
                    [1] = u32
                --]]
                _G.tween(u32.Wave1, {
                    0.75,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["Position"] = u32.Wave1.Position + Vector3.new(0, -2, 0)
                })
                _G.tween(u32.Wave2, {
                    0.75,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["Position"] = u32.Wave2.Position + Vector3.new(0, -5, 0)
                })
                _G.tween(u32.InnerWave, {
                    0.75,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["Position"] = u32.InnerWave.Position + Vector3.new(0, -5, 0)
                })
                _G.tween(u32.InnerWave2, {
                    0.75,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["Position"] = u32.InnerWave2.Position + Vector3.new(0, -5, 0)
                })
                _G.tween(u32["Blood Floor"], {
                    0.75,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.tween(u32.BloodDome, {
                    0.75,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
            end)
        end
    end
}