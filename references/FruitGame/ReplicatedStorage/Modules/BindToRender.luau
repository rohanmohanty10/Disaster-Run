 

local u1 = {}
local u2 = {}
local v3 = game:GetService("RunService")
local u4 = require(game.ReplicatedStorage.Modules.MaidClass).new()
local u5 = 0
function u1.AddToRender(_, p6, p7, p8) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v9 = {}
    u1:RemoveFromRender(p6)
    v9.scriptObj = p7
    v9.Name = p6
    v9.orgFPS = p8 or 1
    v9.FPS = p8 or 1
    v9.CurrentFrame = 0
    local v10 = Instance.new("BindableEvent", script.Binds)
    v10.Name = p6
    v9.BindEvent = v10
    u2[p6] = v9
    u4[v9] = v9
    return v10
end
local function u14(p11, p12) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    if p11.BindEvent ~= nil then
        p12.BindEvent:Destroy()
    end
    for v13, _ in p12 do
        p12[v13] = nil
    end
    u4[{}] = nil
    u2[p11] = nil
end
function u1.RemoveFromRender(_, p15) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u14
    --]]
    if u2[p15] then
        u14(u2[p15], u2[p15])
    end
end
local u16 = 0
local u17 = 0
local function v22(u18) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u16
        [3] = u2
        [4] = u14
        [5] = u5
    --]]
    u17 = u17 + 1
    if tick() - u16 >= 1 then
        u17 = 0
        u16 = tick()
    elseif tick() - u16 < 1 and u17 > 60 then
        u17 = 0
        return
    end
    local v19 = 0
    for v20, u21 in u2 do
        if u21.scriptObj == nil or (u21.scriptObj.Parent == nil or not u21.scriptObj:IsA("Script") and (not u21.scriptObj:IsA("LocalScript") or u21.scriptObj.Disabled ~= false)) then
            u14(v20, u21)
        else
            u21.CurrentFrame = u21.CurrentFrame + 1
            if u21.CurrentFrame % u21.FPS == 0 then
                task.spawn(function() --[[ Line: 64 ]]
                    --[[
                    Upvalues:
                        [1] = u21
                        [2] = u18
                    --]]
                    u21.BindEvent:Fire(u18)
                end)
            end
            v19 = v19 + 1
        end
    end
    u5 = v19
end
local v23 = game:GetService("RunService").Heartbeat
local u24 = nil
local u25 = nil
local u26 = {}
local function v33() --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u26
        [3] = u25
    --]]
    u24 = tick()
    for v27 = #u26, 1, -1 do
        local v28 = u26
        local v29 = v27 + 1
        local v30
        if u26[v27] >= u24 - 1 then
            v30 = u26[v27] or nil
        else
            v30 = nil
        end
        v28[v29] = v30
    end
    u26[1] = u24
    local v31 = tick() - u25 >= 1 and #u26 or #u26 / (tick() - u25)
    local v32 = math.floor(v31)
    _G.FPS = v32
    script:SetAttribute("FPS", v32)
end
u25 = tick()
v23:Connect(v33)
v3.RenderStepped:Connect(v22)
return u1