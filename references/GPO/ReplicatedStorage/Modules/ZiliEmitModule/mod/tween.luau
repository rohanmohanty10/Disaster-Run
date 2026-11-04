 

local u1 = game:GetService("RunService")
local u2 = require("./logger")
local u3 = require("./utility")
local u4 = require("../obj/Bezier")
return {
    ["fromParams"] = function(u5, u6, u7, u8, u9, u10, p11) --[[ Name: fromParams, Line 10 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u4
            [4] = u1
        --]]
        local v12, v13 = pcall(function() --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u5
            --]]
            return u3.deserializePath(u5)
        end)
        if not v12 then
            u2.error((("failed to decode bezier path data with error: %*"):format(v13)))
        end
        local u14 = u4.new(v13, 0)
        local u15 = 0
        local u16 = nil
        local function v27(p17) --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u15
                [3] = u6
                [4] = u14
                [5] = u7
                [6] = u8
                [7] = u16
                [8] = u9
            --]]
            if not u10 and u15 == 0 then
                local v18 = u15 + p17
                local v19 = u6
                local v20 = math.max(v19, 0)
                u15 = math.clamp(v18, 0, v20)
            end
            local v21 = u15 / u6
            local v22 = u7(1 - u14:getEase((math.clamp(v21, 0, 1))).y, p17, u15)
            if v22 ~= nil then
                local v23
                if u6 == 0 then
                    v23 = u6 < u15
                else
                    v23 = u6 <= u15
                end
                if not v23 then
                    ::l14::
                    if v22 then
                        local v24 = u15 + v22
                        local v25 = u6
                        local v26 = math.max(v25, 0)
                        u15 = math.clamp(v24, 0, v26)
                    end
                    return
                end
            end
            if not (u8 and u8.Connected) then
                u16()
                if u9 then
                    u9(true)
                end
                return
            end
            goto l14
        end
        if not p11 then
            local u28 = u1.RenderStepped:Connect(v27)
            u16 = function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u28
                --]]
                u28:Disconnect()
            end
            return u28
        end
        local u29 = u3.getRanomId()
        u1:BindToRenderStep(u29, p11, v27)
        local u30 = true
        u16 = function() --[[ Line: 78 ]]
            --[[
            Upvalues:
                [1] = u30
                [2] = u1
                [3] = u29
            --]]
            if u30 then
                u30 = false
                u1:UnbindFromRenderStep(u29)
            end
        end
        return u16
    end,
    ["timer"] = function(u31, u32, u33, p34, p35) --[[ Name: timer, Line 92 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
        --]]
        local u36 = coroutine.running()
        local u37 = 0
        local u38 = nil
        local function v45(p39) --[[ Line: 105 ]]
            --[[
            Upvalues:
                [1] = u32
                [2] = u37
                [3] = u31
                [4] = u33
                [5] = u38
                [6] = u36
            --]]
            local v40 = u32(p39, u37)
            if v40 ~= nil then
                local v41
                if u31 == 0 then
                    v41 = u31 < u37
                else
                    v41 = u31 <= u37
                end
                if not v41 then
                    ::l11::
                    if v40 then
                        local v42 = u37 + v40
                        local v43 = u31
                        local v44 = math.max(v43, 0)
                        u37 = math.clamp(v42, 0, v44)
                    end
                    return
                end
            end
            if not (u33 and u33.Connected) then
                u38()
                task.spawn(u36)
                return
            end
            goto l11
        end
        local v46
        if p35 then
            local u47 = u3.getRanomId()
            u1:BindToRenderStep(u47, p35, v45)
            local u48 = true
            u38 = function() --[[ Line: 135 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u1
                    [3] = u47
                --]]
                if u48 then
                    u48 = false
                    u1:UnbindFromRenderStep(u47)
                end
            end
            v46 = u38
        else
            local u49 = u1.RenderStepped:Connect(v45)
            u38 = function() --[[ Line: 125 ]]
                --[[
                Upvalues:
                    [1] = u49
                --]]
                u49:Disconnect()
            end
            v46 = u38
        end
        if p34 then
            table.insert(p34, v46)
        end
        coroutine.yield()
    end
}