 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = {}
u3.__index = u3
function u3.new(u4, p5, p6) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u1
    --]]
    if p6 then
        if p6.EndCF then
            local v7 = u3
            local u8 = setmetatable({}, v7)
            local u9 = Instance.new("CFrameValue")
            u9.Value = p6.StartCF or u4:GetPivot()
            u9.Parent = u4
            u8.Tween = u2:Create(u9, p5, {
                ["Value"] = p6.EndCF
            })
            u8.Con = u1.RenderStepped:Connect(function() --[[ Line: 18 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u9
                --]]
                u4:PivotTo(u9.Value)
            end)
            u8.Tween.Completed:Connect(function() --[[ Line: 22 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                local v10 = u8.Con
                if typeof(v10) == "RBXScriptConnection" then
                    u8.Con:Disconnect()
                end
            end)
            return u8
        end
    end
end
function u3.Play(p11) --[[ Line: 30 ]]
    p11.Tween:Play()
end
return u3