 

local u1 = game:GetService("RunService")
local u2 = require(script.Parent.Default)
local u3 = {}
u3.__index = u3
setmetatable(u3, u2)
function u3.create(u4, p5, p6) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u1
    --]]
    if typeof(u4) == "Instance" then
        if u4:IsA("Model") then
            if p6 then
                if p6.EndCF then
                    local v7 = u2.create(u4, p5, nil)
                    local v8 = u3
                    local u9 = setmetatable(v7, v8)
                    local u10 = Instance.new("CFrameValue")
                    u9:AddObj(u10)
                    u10.Value = p6.StartCF or u4:GetPivot()
                    u10.Parent = u4
                    u9:SetTween(u10, p5, {
                        ["Value"] = p6.EndCF
                    }, true)
                    u9:AddObj(u1.RenderStepped:Connect(function() --[[ Line: 25 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u4
                            [3] = u10
                        --]]
                        if u9:GetTween() ~= nil then
                            if u9:GetTween().PlaybackState == Enum.PlaybackState.Playing then
                                u4:PivotTo(u10.Value)
                            end
                        end
                    end))
                    return u9
                end
            end
        else
            return
        end
    else
        return
    end
end
return u3