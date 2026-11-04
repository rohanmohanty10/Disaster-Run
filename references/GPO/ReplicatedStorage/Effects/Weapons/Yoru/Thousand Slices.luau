 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
local u3 = game:GetService("TweenService")
require(v1.Modules.CraterHandler)
local u4 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local _ = v2.LocalPlayer
local u5 = workspace.Effects
local function u16(p6, p7, p8) --[[ Line: 16 ]]
    local function v14(u9, p10, p11) --[[ Line: 17 ]]
        for _, v12 in ipairs(u9:GetDescendants()) do
            if v12:IsA("ParticleEmitter") or v12:IsA("Trail") then
                v12.Enabled = p10
            end
        end
        if p11 then
            task.delay(p11, function() --[[ Line: 25 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                for _, v13 in ipairs(u9:GetDescendants()) do
                    if v13:IsA("ParticleEmitter") or v13:IsA("Trail") then
                        v13.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p6) == "table" then
        for _, v15 in p6 do
            v14(v15, p7, p8)
        end
    else
        v14(p6, p7, p8)
    end
end
local u17 = RaycastParams.new()
u17.FilterType = Enum.RaycastFilterType.Include
u17.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p18, p19, p20) --[[ Name: start, Line 52 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u16
            [4] = u17
            [5] = u3
        --]]
        if _G.checkRenderDistance(p18.Position) == false then
            return
        end
        local v21 = script.Effects:GetScale()
        local v22 = 15 * v21
        local v23 = script.Effects["First (Emit)"]:Clone()
        v23.CFrame = p18 * CFrame.new(0, -3, -v22)
        if p19 then
            _G.recolorParticles(v23, p19)
            u4.apply(v23, p20)
        end
        v23.Parent = u5
        _G.customEmit(v23)
        _G.destroy(v23, 2)
        local v24 = _G.PlaySound(p18, script.YoruSliceBarrage)
        task.wait(0.7)
        local v25 = script.Effects["Second (Emit)"]:Clone()
        v25.CFrame = p18 * CFrame.new(0, 0, -v22)
        if p19 then
            _G.recolorParticles(v25, p19)
            u4.apply(v25, p20)
        end
        v25.Parent = u5
        _G.customEmit(v25)
        _G.destroy(v25, 1)
        task.wait(0.05)
        local v26 = script.Effects.Slices:Clone()
        v26:PivotTo(p18 * CFrame.new(0, 1, -v22))
        if p19 then
            _G.recolorParticles(v26, p19)
            u4.apply(v26, p20)
        end
        v26.Parent = u5
        u16(v26["Third (Enable)"], true)
        local v27 = workspace:Raycast(v26.GroundScratch.Position + Vector3.new(0, 5, 0), Vector3.new(0, -12, 0), u17)
        if v27 then
            u16(v26.GroundScratch, true)
            v26.GroundScratch.CFrame = CFrame.new(v27.Position, v27.Position + v27.Normal) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -0.2, 0)
        end
        for _ = 0, 25 do
            local v28 = script.Effects.Green:Clone()
            local v29 = v26.PrimaryPart.CFrame * CFrame.new(math.random(-8, 8) * v21, math.random(-8, 8) * v21, math.random(-8, 8) * v21)
            local v30 = CFrame.Angles
            local v31 = math.random(-360, 360)
            local v32 = math.rad(v31)
            local v33 = math.random(-360, 360)
            local v34 = math.rad(v33)
            local v35 = math.random(-360, 360)
            v28.CFrame = v29 * v30(v32, v34, (math.rad(v35)))
            if p19 then
                v28.Color = p19
                u4.apply(v28, p20)
            end
            v28.Parent = u5
            _G.destroy(v28, 0.2)
            local v36 = u3
            local v37 = v28.Mesh
            local v38 = TweenInfo.new(0.1)
            local v39 = {}
            local v40 = math.random
            v39.Scale = Vector3.new(0, 0, v40(10, 15)) * v21
            v36:Create(v37, v38, v39):Play()
            local v41 = script.Effects.Black:Clone()
            local v42 = v26.PrimaryPart.CFrame * CFrame.new(math.random(-8, 8) * v21, math.random(-8, 8) * v21, math.random(-8, 8) * v21)
            local v43 = CFrame.Angles
            local v44 = math.random(-360, 360)
            local v45 = math.rad(v44)
            local v46 = math.random(-360, 360)
            local v47 = math.rad(v46)
            local v48 = math.random(-360, 360)
            v41.CFrame = v42 * v43(v45, v47, (math.rad(v48)))
            if p19 then
                u4.apply(v41, p20)
            end
            v41.Parent = u5
            _G.destroy(v41, 0.2)
            local v49 = u3
            local v50 = v41.Mesh
            local v51 = TweenInfo.new(0.1)
            local v52 = {}
            local v53 = math.random
            v52.Scale = Vector3.new(0, 0, v53(10, 15)) * v21
            v49:Create(v50, v51, v52):Play()
            if p20 and p20:FindFirstChild("PB") then
                if v24 then
                    u3:Create(v24, TweenInfo.new(0.25), {
                        ["Volume"] = 0
                    }):Play()
                end
                break
            end
            task.wait(0.064)
        end
        u16(v26, false)
        _G.destroy(v26, 2)
    end
}