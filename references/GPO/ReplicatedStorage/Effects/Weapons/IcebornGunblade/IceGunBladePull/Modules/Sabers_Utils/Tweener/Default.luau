 

local u1 = game:GetService("TweenService")
local u2 = {}
u2.__index = u2
function u2.create(p3, p4, p5) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = u2
    local v7 = setmetatable({}, v6)
    v7.Objs = {}
    v7.ObjsID = 0
    v7:SetTween(p3, p4, p5)
    return v7
end
function u2.AddObj(p8, p9) --[[ Line: 16 ]]
    p8.ObjsID = p8.ObjsID + 1
    p8.Objs[p8.ObjsID] = p9
end
function u2.SetTween(u10, p11, p12, p13, p14) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p11 == nil then
        return
    elseif p12 == nil then
        return
    elseif p13 ~= nil then
        u10.Tween = u1:Create(p11, p12, p13)
        if p14 == true then
            u10:AddObj(u10.Tween.Completed:Connect(function() --[[ Line: 28 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                u10:CleanUp()
            end))
        end
    end
end
function u2.GetTween(p15) --[[ Line: 34 ]]
    return p15.Tween
end
function u2.Play(p16) --[[ Line: 38 ]]
    if p16:GetTween() ~= nil then
        p16:GetTween():Play()
    end
end
function u2.Stop(p17) --[[ Line: 43 ]]
    p17:Stop()
end
function u2.Cancel(p18) --[[ Line: 47 ]]
    if p18:GetTween() ~= nil then
        p18:GetTween():Cancel()
    end
end
function u2.Pause(p19) --[[ Line: 52 ]]
    if p19:GetTween() ~= nil then
        p19:GetTween():Pause()
    end
end
function u2.CleanUp(p20) --[[ Line: 57 ]]
    if p20:GetTween() ~= nil then
        p20.Tween:Cancel()
        p20.Tween = nil
    end
    for _, v21 in p20.Objs do
        if typeof(v21) == "RBXScriptConnection" then
            v21:Disconnect()
        elseif typeof(v21) == "Instance" then
            v21:Destroy()
        end
    end
    setmetatable(p20, nil)
    warn("Cleaning Up")
end
return u2