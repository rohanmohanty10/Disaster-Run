 

local u1 = game:GetService("TeleportService")
game:GetService("Players")
local v2 = script.Parent.Parent.Promises
local u3 = require(v2.Promise)
local u43 = {
    ["PromiseTeleportAsync"] = function(u4, u5, u6) --[[ Name: PromiseTeleportAsync, Line 12 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        print(type(u4), u4)
        local v7 = type(u4) == "number"
        assert(v7, "Invalid PlaceId")
        local v8 = type(u5) == "table"
        assert(v8, "Invalid Players")
        local v9 = typeof(u6) == "Instance" and u6:IsA("TeleportOptions") or u6 == nil
        assert(v9, "Invalid TeleportOptions")
        return u3.spawn(function(p10, p11) --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u4
                [3] = u5
                [4] = u6
            --]]
            local u12 = nil
            local v13, v14 = pcall(function() --[[ Line: 22 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u1
                    [3] = u4
                    [4] = u5
                    [5] = u6
                --]]
                u12 = u1:TeleportAsync(u4, u5, u6)
            end)
            if not v13 then
                p11(v14)
            end
            return p10(u12)
        end)
    end,
    ["PromiseTeleportAsyncWithRetry"] = function(p15, p16, p17, p18) --[[ Name: PromiseTeleportAsyncWithRetry, Line 38 ]]
        --[[
        Upvalues:
            [1] = u43
        --]]
        local v19 = 0
        local v20 = p18 or 360
        repeat
            print("Teleporting Players..., Retry Count:", v19)
            local v21 = u43.PromiseTeleportAsync(p15, p16, p17)
            v19 = v19 + 1
            task.wait(1)
        until v21:IsFulfilled() or v19 == v20
        return v21
    end,
    ["CustomTeleportAsync"] = function(u22) --[[ Name: CustomTeleportAsync, Line 60 ]]
        --[[
        Upvalues:
            [1] = u43
        --]]
        local u23 = u22.Players
        local u24 = u22.PlaceId
        local u25 = u22.Retries or 5
        local v26 = u22.ReservedServerAccessCode
        local v27 = u22.TeleportData
        local u28 = u22.TeleportOptions or Instance.new("TeleportOptions")
        if v27 ~= nil then
            u28:SetTeleportData(v27)
        end
        if u28 and u28.ReservedServerAccessCode ~= nil then
            local v29 = u28:GetTeleportData()
            if v29 and typeof(v29) == "table" then
                v29.CurrentReservedServerAccessCode = u28.ReservedServerAccessCode
                u28:SetTeleportData(v29)
            end
        end
        if v26 then
            u28.ReservedServerAccessCode = v26
        end
        local function u32() --[[ Line: 90 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u23
                [3] = u43
                [4] = u24
                [5] = u28
                [6] = u25
            --]]
            if (u22.ListenToHopReady or false) == true then
                for _, u30 in ipairs(u23) do
                    if u30 and u30:IsDescendantOf(u23) then
                        ({}):ListenToHopReady(function() --[[ Line: 105 ]]
                            --[[
                            Upvalues:
                                [1] = u43
                                [2] = u24
                                [3] = u30
                                [4] = u28
                                [5] = u25
                            --]]
                            local v31 = { u30 }
                            u43.PromiseTeleportAsyncWithRetry(u24, v31, u28, u25)
                        end)
                    end
                end
            else
                print("tp")
                u43.PromiseTeleportAsyncWithRetry(u24, u23, u28, u25)
            end
        end
        if (u22.ReserveServer or false) == true then
            local v33 = 0
            repeat
                local v34 = u43.PromiseReserveServer(u24)
                v33 = v33 + 1
                task.wait(1)
            until v34:IsFulfilled() or v33 == 5
            v34:Then(function(p35) --[[ Line: 148 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u32
                --]]
                print("access code", p35)
                u28.ReservedServerAccessCode = p35
                u32()
            end):Catch(function(_) --[[ Line: 152 ]]
                warn("Failed to generate AccessCode")
            end)
        else
            u32()
        end
    end,
    ["PromiseReserveServer"] = function(u36) --[[ Name: PromiseReserveServer, Line 165 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        return u3.spawn(function(p37, p38) --[[ Line: 166 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u36
            --]]
            local u39 = nil
            local v40, v41 = pcall(function() --[[ Line: 168 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u1
                    [3] = u36
                --]]
                u39 = u1:ReserveServer(u36)
            end)
            if v40 then
                return p37(u39)
            else
                return p38(v41)
            end
        end)
    end,
    ["IsServerReserved"] = function() --[[ Name: IsServerReserved, Line 179 ]]
        local v42
        if game.PrivateServerId == "" then
            v42 = false
        else
            v42 = game.PrivateServerOwnerId == 0
        end
        return v42
    end
}
local function u50(u44, u45, u46) --[[ Line: 187 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v47 = 0
    while true do
        local v48, v49 = pcall(function() --[[ Line: 192 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u44
                [3] = u45
                [4] = u46
            --]]
            return u1:TeleportAsync(u44, u45, u46)
        end)
        v47 = v47 + 1
        if not v48 then
            task.wait(1)
        end
        if v48 or v47 == 10 then
            if not v48 then
                warn(v49)
            end
            return v48, v49
        end
    end
end
u1.TeleportInitFailed:Connect(function(p51, p52, p53, p54, p55) --[[ Name: handleFailedTeleport, Line 208 ]]
    --[[
    Upvalues:
        [1] = u50
    --]]
    if p52 == Enum.TeleportResult.Flooded then
        task.wait(15)
    elseif p52 == Enum.TeleportResult.Failure then
        task.wait(1)
    else
        warn(("Invalid teleport [%s]: %s"):format(p52.Name, p53))
    end
    warn("telekport failed for " .. p51.Name)
    if p55 and (p55:GetTeleportData() and p55:GetTeleportData().gamemode ~= nil) then
        if p51:GetAttribute("teleportFailed") == nil then
            game.ReplicatedStorage.Events.note:FireClient(p51, "TELEPORT FAILED, RETRYING!")
            p51:SetAttribute("teleportFailed", true)
        end
        u50(p54, { p51 }, p55)
    end
end)
return u43