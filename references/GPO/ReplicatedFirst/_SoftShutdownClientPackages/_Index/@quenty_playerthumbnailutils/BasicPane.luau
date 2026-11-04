 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Signal")
local u3 = v1("Maid")
local u4 = {}
u4.__index = u4
u4.ClassName = "BasicPane"
function u4.isBasicPane(p5) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v6 = type(p5) == "table" and (u3.isMaid(p5._maid) and u2.isSignal(p5.VisibleChanged))
    if v6 then
        local v7 = p5.SetVisible
        if type(v7) == "function" then
            local v8 = p5.IsVisible
            if type(v8) == "function" then
                local v9 = p5.Show
                if type(v9) == "function" then
                    local v10 = p5.Hide
                    if type(v10) == "function" then
                        local v11 = p5.Toggle
                        if type(v11) == "function" then
                            local v12 = p5.Destroy
                            v6 = type(v12) == "function"
                        else
                            v6 = false
                        end
                    else
                        v6 = false
                    end
                else
                    v6 = false
                end
            else
                v6 = false
            end
        else
            v6 = false
        end
    end
    return v6
end
function u4.new(p13) --[[ Line: 72 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
    --]]
    local v14 = u4
    local v15 = setmetatable({}, v14)
    v15._maid = u3.new()
    v15.Maid = v15._maid
    v15._visible = false
    v15.VisibleChanged = u2.new()
    v15._maid:GiveTask(v15.VisibleChanged)
    if p13 then
        v15._gui = p13
        v15.Gui = p13
        v15._maid:GiveTask(p13)
    end
    return v15
end
function u4.SetVisible(p16, p17, p18) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v19 = type(p17) == "boolean"
    assert(v19, "Bad isVisible")
    if p16._visible ~= p17 then
        p16._visible = p17
        local v20 = u3.new()
        p16._maid._paneVisibleMaid = v20
        p16.VisibleChanged:Fire(p16._visible, p18, v20)
    end
end
function u4.Show(p21, p22) --[[ Line: 114 ]]
    p21:SetVisible(true, p22)
end
function u4.Hide(p23, p24) --[[ Line: 122 ]]
    p23:SetVisible(false, p24)
end
function u4.Toggle(p25, p26) --[[ Line: 130 ]]
    p25:SetVisible(not p25._visible, p26)
end
function u4.IsVisible(p27) --[[ Line: 138 ]]
    return p27._visible
end
function u4.Destroy(p28) --[[ Line: 146 ]]
    p28._maid:DoCleaning()
    p28._maid = nil
    setmetatable(p28, nil)
end
return u4