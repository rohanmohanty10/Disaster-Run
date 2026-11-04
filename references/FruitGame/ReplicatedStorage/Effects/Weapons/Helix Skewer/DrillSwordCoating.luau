 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = require(v2.Modules.Trove)
Random.new()
local u4 = {}
function v1.start(_, p5, p6) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    local u7 = p5:FindFirstChild("Helix SkewerSword")
    if p6 == true then
        local v8 = u7:FindFirstChild("Blade")
        if v8 then
            if u4[u7] then
                u4[u7]:Destroy()
            end
            local v9 = script.Blade:GetChildren()
            local u10 = {}
            for v11 = 1, #v9 do
                local v12 = v9[v11]:Clone()
                v12:SetAttribute("trailBypass", true)
                v12.Parent = v8
                if v12:IsA("ParticleEmitter") then
                    v12:Emit(4)
                end
                u10[v12.Name] = v12
            end
            u10.Wavy.Attachment0 = u10.A0
            u10.Wavy.Attachment1 = u10.A1
            local v13 = u3.new()
            v13:AttachToInstance(u7)
            v13:Add(function() --[[ Line: 44 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u4
                    [3] = u7
                --]]
                for _, v14 in pairs(u10) do
                    if v14:IsA("ParticleEmitter") then
                        v14.Enabled = false
                    elseif v14:IsA("Beam") then
                        v14.Enabled = false
                    end
                    _G.destroy(v14, 4)
                end
                table.clear(u10)
                u4[u7] = nil
            end)
            u4[u7] = v13
        end
    else
        if u4[u7] then
            u4[u7]:Destroy()
        end
        return
    end
end
return v1