 

local u1 = game:GetService("RunService"):IsClient()
local u2 = {}
local v3 = require(game.ReplicatedStorage.Modules.MaidClass)
require(game.ReplicatedStorage.Modules.RotatedRegion3)
game:GetService("HttpService")
v3.new()
u2.__index = u2
local _ = Ray.new
local v4 = game:GetService("RunService")
local u5 = require(script:WaitForChild("Signal"))
local function u9(p6, p7, p8, _) --[[ Line: 78 ]]
    return _G.raycast:cast(p6, p7, p8, "Ignore")
end
local function u13(p10, p11, p12, _) --[[ Line: 84 ]]
    if not p12 or typeof(p12) ~= "table" then
        error("Call in CastWhitelist failed! Whitelist table is either nil, or is not actually a table.", 0)
    end
    return _G.raycast:cast(p10, p11, p12)
end
local function u17(p14, p15, p16, _) --[[ Line: 96 ]]
    if not p16 or typeof(p16) ~= "table" then
        error("Call in CastBlacklist failed! Blacklist table is either nil, or is not actually a table.", 0)
    end
    return _G.raycast:cast(p14, p15, p16, "Ignore")
end
local u18 = Vector3.new
local u19 = {}
local u20 = {}
function u2.GetBullet(_, p21) --[[ Line: 145 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u20
    --]]
    return u19[u20[p21]]
end
local u22 = nil
local u23 = game:GetService("CollectionService")
if game["Run Service"]:IsClient() == false then
    u22 = require(game.ServerScriptService.DamageHandler.Logia)
else
    script.RemoteEvent.OnClientEvent:Connect(function(p24, p25) --[[ Line: 155 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u20
        --]]
        if u19[u20[p24]] then
            u19[u20[p24]](p25)
        end
    end)
end
if u1 then
    local _ = v4.Stepped
else
    local _ = v4.Heartbeat
end
local u26 = v4.Heartbeat
local function u91(_, u27, u28, u29, u30, u31, u32, u33, u34, u35, p36, u37, u38) --[[ Line: 186 ]]
    --[[
    Upvalues:
        [1] = u26
        [2] = u1
        [3] = u19
        [4] = u20
        [5] = u18
        [6] = u23
        [7] = u22
    --]]
    if type(u29) == "number" then
        u29 = u28.Unit * u29
    end
    local u39 = p36 or Vector3.new()
    local u40 = 0
    local u41 = 0
    local u42 = u27
    local u43 = {}
    local u44 = nil
    local u45 = tick()
    local u46 = u29.magnitude
    u33.Anchored = true
    u44 = u26:Connect(function(p47) --[[ Line: 201 ]]
        --[[
        Upvalues:
            [1] = u40
            [2] = u1
            [3] = u45
            [4] = u44
            [5] = u37
            [6] = u38
            [7] = u19
            [8] = u20
            [9] = u33
            [10] = u28
            [11] = u29
            [12] = u46
            [13] = u27
            [14] = u42
            [15] = u41
            [16] = u39
            [17] = u18
            [18] = u30
            [19] = u34
            [20] = u35
            [21] = u43
            [22] = u23
            [23] = u22
            [24] = u32
            [25] = u31
        --]]
        if p47 <= 0 then
            return
        else
            u40 = u40 + p47
            if u1 == true then
                if tick() - u45 >= 1 then
                    u45 = tick()
                    local v48 = u44
                    local v49 = u37
                    local v50 = nil
                    local v51 = v50 == nil and 0.1 or v50
                    if u19[v49] then
                        u19[v49] = nil
                    end
                    if u20[v49] then
                        u20[v49] = nil
                    end
                    if v48 then
                        v48:Disconnect()
                    end
                    if v49 then
                        _G.destroy(v49, v51)
                    end
                    u44:Disconnect()
                    u44 = nil
                    return
                end
                u45 = tick()
            end
            if u33:IsDescendantOf(game) == false then
                u44:Disconnect()
                local v52 = u44
                local v53 = u37
                local v54 = nil
                local v55 = v54 == nil and 0.1 or v54
                if u19[v53] then
                    u19[v53] = nil
                end
                if u20[v53] then
                    u20[v53] = nil
                end
                if v52 then
                    v52:Disconnect()
                end
                if v53 then
                    _G.destroy(v53, v55)
                end
                u44 = nil
                return
            else
                if u33 and (u33.Parent ~= nil and (u33:FindFirstChild("tenseiSucked") and u33:FindFirstChild("tenseiSucked").Value ~= nil)) then
                    u28 = (u33:FindFirstChild("tenseiSucked").Value.Position - u33.Position).Unit * 200
                    u29 = u28.Unit * u46
                    u27 = u33.CFrame.p
                    u42 = u33.CFrame.p
                    u40 = 0
                    u41 = 0
                    u33:FindFirstChild("tenseiSucked").Value = nil
                end
                local v56 = u28.Magnitude
                local v57 = (u28.Unit + u29).Unit * u29.Magnitude
                local v58 = u40
                local v59 = u27
                local v60 = u39
                local v61 = u18(v60.X * v58 ^ 2 / 2, v60.Y * v58 ^ 2 / 2, v60.Z * v58 ^ 2 / 2)
                local v62 = v59 + v57 * v58 + v61
                local v63 = v62 - u42
                local v64 = v63.Unit * u29.Magnitude * p47
                local u65, u66, u67, u68 = u30(u42, v64, u34, u35)
                if u65 == nil then
                    local v69
                    if u33:IsA("Model") then
                        v69 = u33:GetModelSize()
                    else
                        v69 = u33.Size
                    end
                    if v69 then
                        local v70 = RaycastParams.new()
                        v70.FilterDescendantsInstances = u34
                        v70.FilterType = Enum.RaycastFilterType.Exclude
                        local v71 = v64.Magnitude == v64.Magnitude and (v64.Magnitude ~= (1 / 0) and v64.Magnitude ~= (-1 / 0))
                        if v69.X ~= v69.X or (v69.X == (1 / 0) or v69.X == (-1 / 0)) then
                            v71 = false
                        end
                        if v71 == true then
                            local v72 = workspace:Spherecast(CFrame.new(u42, v64).Position, (v69 * 0.4).X, v64, v70)
                            if v72 and v72.Instance then
                                u65 = v72.Instance
                                u66 = v72.Position
                                u67 = v72.Normal
                            end
                        end
                    end
                end
                if u65 and (u65 ~= u33 and u33:FindFirstChild("FinishHit") == nil) then
                    local v73 = _G.getHumanoid(u65)
                    if v73 ~= nil and (v73.Parent:FindFirstChild("KenHaki") and v73.Parent:findFirstChild("SafeFF") == nil) then
                        if u1 == true and v73.Parent == game.Players.LocalPlayer.Character then
                            v73:LoadAnimation(script.Dodge["D" .. math.random(1, 4)]):Play()
                        elseif u1 == false and u43[v73.Parent] == nil then
                            u43[v73.Parent] = true
                            require(game.ServerScriptService.DamageHandler):KenDodge(v73.Parent, false)
                            return
                        end
                    end
                    if u23:HasTag(u33, "BulletLogia") == false then
                        if v73 == nil or v73 then
                            if u22 and (v73 and (v73.Parent:GetAttribute("ToriLoaded") == nil and (v73.Parent:FindFirstChild("Logia") ~= nil and (u33:FindFirstChild("Buso") == nil and u22:apply(v73.Parent, u65) == true)))) then
                                u23:AddTag(u33, "BulletLogia")
                            else
                                pcall(function() --[[ Line: 314 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u32
                                        [2] = u65
                                        [3] = u66
                                        [4] = u67
                                        [5] = u68
                                        [6] = u33
                                    --]]
                                    u32:Fire(u65, u66, u67, u68, u33)
                                end)
                                local v74 = u44
                                local v75 = u37
                                local v76 = 5
                                local v77 = v76 == nil and 0.1 or v76
                                if u19[v75] then
                                    u19[v75] = nil
                                end
                                if u20[v75] then
                                    u20[v75] = nil
                                end
                                if v74 then
                                    v74:Disconnect()
                                end
                                if v75 then
                                    _G.destroy(v75, v77)
                                end
                            end
                        end
                        if u22 and (u33:FindFirstChild("Buso") == nil and (v73.Parent:GetAttribute("ToriLoaded") == nil and u22:apply(v73.Parent, u65) == true)) then
                            u23:AddTag(u33, "BulletLogia")
                            return
                        end
                    end
                    Instance.new("BoolValue", u33).Name = "FinishHit"
                elseif u33:FindFirstChild("FinishHit") then
                    local v78 = u44
                    local v79 = u37
                    local v80 = 5
                    local v81 = v80 == nil and 0.1 or v80
                    if u19[v79] then
                        u19[v79] = nil
                    end
                    if u20[v79] then
                        u20[v79] = nil
                    end
                    if v78 then
                        v78:Disconnect()
                    end
                    if v79 then
                        _G.destroy(v79, v81)
                    end
                    return
                end
                if u1 then
                    local v82 = v56 * 10 + 500
                    if v82 < (workspace.CurrentCamera.CFrame.Position - u42).magnitude and v82 < (workspace.CurrentCamera.CFrame.Position - u27).magnitude then
                        local v83 = u44
                        local v84 = u37
                        local v85 = nil
                        local v86 = v85 == nil and 0.1 or v85
                        if u19[v84] then
                            u19[v84] = nil
                        end
                        if u20[v84] then
                            u20[v84] = nil
                        end
                        if v83 then
                            v83:Disconnect()
                        end
                        if v84 then
                            _G.destroy(v84, v86)
                        end
                        if u33 then
                            u33:Destroy()
                        end
                        return
                    end
                end
                if v56 < u41 then
                    pcall(function() --[[ Line: 347 ]]
                        --[[
                        Upvalues:
                            [1] = u32
                            [2] = u42
                            [3] = u33
                            [4] = u44
                            [5] = u37
                            [6] = u38
                            [7] = u19
                            [8] = u20
                        --]]
                        u32:Fire(nil, u42, nil, nil, u33)
                        u44:Disconnect()
                        local v87 = u44
                        local v88 = u37
                        local v89 = nil
                        local v90 = v89 == nil and 0.1 or v89
                        if u19[v88] then
                            u19[v88] = nil
                        end
                        if u20[v88] then
                            u20[v88] = nil
                        end
                        if v87 then
                            v87:Disconnect()
                        end
                        if v88 then
                            _G.destroy(v88, v90)
                        end
                    end)
                    if u33 then
                        u33:Destroy()
                    end
                else
                    u31:Fire(u27, u42, v64.Unit, v63.Magnitude, u33, p47)
                    u42 = v62
                    u41 = u41 + v63.Magnitude
                end
            end
        end
    end)
end
local function u120(p92, p93, p94, p95, p96, p97, p98, p99, p100, p101, p102, p103, p104) --[[ Line: 364 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u13
        [3] = u17
        [4] = u91
    --]]
    local v105 = typeof(p94) == "Vector3"
    local v106 = typeof(p94)
    assert(v105, ("Invalid type for parameter \'%s\' (Expected %s, got %s)"):format("origin", "Vector3", v106))
    local v107 = typeof(p95) == "Vector3"
    local v108 = typeof(p95)
    assert(v107, ("Invalid type for parameter \'%s\' (Expected %s, got %s)"):format("directionWithMagnitude", "Vector3", v108))
    local v109 = typeof(p96) == "Vector3" and true or typeof(p96) == "number"
    local v110 = typeof(p96)
    assert(v109, ("Invalid type for parameter \'%s\' (Expected %s, got %s)"):format("velocity", "Variant<Vector3, number>", v110))
    if p97 ~= nil then
        local v111 = typeof(p97) == "Instance"
        local v112 = typeof(p97)
        assert(v111, ("Invalid type for parameter \'%s\' (Expected %s, got %s)"):format("cosmeticBulletObject", "Instance", v112))
    end
    if p99 ~= nil then
        local v113 = typeof(p99) == "boolean"
        local v114 = typeof(p99)
        assert(v113, ("Invalid type for parameter \'%s\' (Expected %s, got %s)"):format("ignoreWater", "boolean", v114))
    end
    if p100 ~= nil then
        local v115 = typeof(p100) == "Vector3"
        local v116 = typeof(p100)
        assert(v115, ("Invalid type for parameter \'%s\' (Expected %s, got %s)"):format("bulletAcceleration", "Vector3", v116))
    end
    if p101 ~= nil then
        local v117 = typeof(p101) == "table"
        local v118 = typeof(p101)
        assert(v117, ("Invalid type for parameter \'%s\' (Expected %s, got %s)"):format("list", "table", v118))
    end
    local v119 = u9
    if p101 == nil then
        p101 = p98
    elseif p102 then
        v119 = u13
    else
        v119 = u17
    end
    u91(p92, p94, p95, p96, v119, p93.LengthChanged, p93.RayHit, p97, p101, p99, p100, p103, p104)
end
function u2.new() --[[ Line: 395 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
    --]]
    local v121 = {
        ["LengthChanged"] = u5:CreateNewSignal(),
        ["RayHit"] = u5:CreateNewSignal()
    }
    local v122 = u2
    return setmetatable(v121, v122)
end
function u2.Fire(p123, p124, p125, p126, p127, p128, p129, p130, p131, p132, p133) --[[ Line: 403 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u120
    --]]
    local v134 = getmetatable(p123) == u2
    assert(v134, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Fire", "FastCast.new()"))
    u120(p124, p123, p125, p126, p127, p128, p129, p130, p131, nil, nil, p132, p133)
end
function u2.FireWithWhitelist(p135, p136, p137, p138, p139, p140, p141, p142, p143, p144, _) --[[ Line: 409 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u120
    --]]
    local v145 = getmetatable(p135) == u2
    assert(v145, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("FireWithWhitelist", "FastCast.new()"))
    u120(p136, p135, p137, p138, p139, p141, nil, p142, p143, p140, true, p144)
end
function u2.FireWithBlacklist(p146, p147, p148, p149, p150, p151, p152, p153, p154, p155, p156) --[[ Line: 415 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u120
    --]]
    local v157 = getmetatable(p146) == u2
    assert(v157, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("FireWithBlacklist", "FastCast.new()"))
    u120(p147, p146, p148, p149, p150, p152, nil, p153, p154, p151, false, p155, p156)
end
return u2