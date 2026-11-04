 

local _ = script
local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
local u2 = game:GetService("TweenService")
Random.new()
local u3 = require(v1.Modules.Client.WeaponVFXRecolor)
return {
    ["start"] = function(_, p4, p5) --[[ Name: start, Line 29 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        if p5 then
            if script.M1s:FindFirstChild("S" .. p4) then
                local v6 = script.M1s:Clone()
                local v7
                if p5 then
                    v7 = p5.Parent
                else
                    v7 = p5
                end
                u3.apply(v6, v7)
                local v8 = v6:GetChildren()
                for v9 = 1, #v8 do
                    if v8[v9].Name ~= "S" .. p4 then
                        v8[v9]:Destroy()
                    end
                end
                v6:PivotTo(p5.CFrame)
                v6.Parent = workspace.Effects
                _G.customEmit(v6)
                _G.destroy(v6, 3)
            end
        end
    end
}