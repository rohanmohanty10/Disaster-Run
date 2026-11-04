 

local _ = script
game:GetService("ReplicatedStorage")
game:GetService("RunService")
local u1 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local _ = workspace.Effects
game:GetService("Debris")
game:GetService("TweenService")
Random.new()
local v2 = {}
local function u6(p3) --[[ Line: 11 ]]
    local v4 = p3:GetDescendants()
    for v5 = 1, #v4 do
        if v4[v5]:IsA("ParticleEmitter") then
            v4[v5].LockedToPart = false
        end
    end
end
local function u10(p7) --[[ Line: 20 ]]
    local v8 = p7:GetDescendants()
    for v9 = 1, #v8 do
        if v8[v9]:IsA("ParticleEmitter") then
            v8[v9].LockedToPart = true
        end
    end
end
function v2.start(_, p11, p12, p13) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u10
        [3] = u6
    --]]
    if p12 then
        local v14 = script[p13]:FindFirstChild("M" .. p11)
        local v15 = 1 + (p12.Size.Y - 2) / 4
        local v16 = v15 < 1.05 and 1.05 or v15
        if v14 then
            local v17 = Instance.new("Model")
            local u18 = v14:Clone()
            u1.apply(u18, p12.Parent)
            u10(u18)
            u18.Parent = v17
            v17:ScaleTo(v16)
            u18.Attachment:Destroy()
            u18.Parent = p12
            v17:Destroy()
            _G.customEmit(u18)
            _G.destroy(u18, 3)
            task.delay(0.2, function() --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u18
                --]]
                u6(u18)
            end)
        end
    end
end
return v2