 

local u1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("LowLevel")
local u2 = require(game.ReplicatedStorage.Modules.LowLevel)
local u3 = require(game.ReplicatedStorage.Modules.Leveling)
local u4 = u3.LowLevel
require(game.ReplicatedStorage.Modules.FastWait)
local u5 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
require(game.ReplicatedStorage.Modules.Raycast)
local u6 = require(game.ReplicatedStorage.Modules.Trove)
local u7 = require(game.ReplicatedStorage.Modules.StreamingObjectsModule)
local u8 = require(u1.Modules.FastSignal)
local v9 = game:GetService("CollectionService")
local u10 = {}
local u11 = {}
for _, v12 in v9:GetTagged("CustomHP") do
    u10[v12] = true
end
v9:GetInstanceAddedSignal("CustomHP"):Connect(function(p13) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    u10[p13] = true
end)
v9:GetInstanceRemovedSignal("CustomHP"):Connect(function(p14) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    u10[p14] = nil
end)
local function u26(u15) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u10
    --]]
    if u15 == nil then
        return nil
    end
    if u11[u15] then
        return u11[u15]
    end
    local v16 = workspace.PlayerCharacters:GetChildren()
    local v17 = nil
    for v18 = 1, #v16 do
        if u15:IsDescendantOf(v16[v18]) then
            v17 = v16[v18]
            break
        end
    end
    if v17 == nil then
        local v19 = workspace.NPCs:GetChildren()
        for v20 = 1, #v19 do
            if u15:IsDescendantOf(v19[v20]) then
                v17 = v19[v20]
                break
            end
        end
    end
    if v17 == nil then
        local v21 = workspace.Ships:GetChildren()
        for v22 = 1, #v21 do
            if u15:IsDescendantOf(v21[v22]) then
                v17 = v21[v22]
                break
            end
        end
    end
    if v17 == nil then
        local v23 = workspace.Env:GetChildren()
        for v24 = 1, #v23 do
            if v23[v24]:FindFirstChild("barrelHP") and u15:IsDescendantOf(v23[v24]) then
                v17 = v23[v24]
                break
            end
        end
    end
    if v17 == nil then
        for v25 in u10 do
            if u15:IsDescendantOf(v25) then
                v17 = v25
                break
            end
        end
    end
    if v17 then
        u11[u15] = v17
        task.delay(5, function() --[[ Line: 87 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u15
            --]]
            if u11[u15] then
                u11[u15] = nil
            end
        end)
    end
    return v17
end
local u27 = game["Run Service"]:IsServer()
return function() --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u3
        [3] = u4
        [4] = u2
        [5] = u7
        [6] = u26
        [7] = u5
        [8] = u6
        [9] = u8
        [10] = u1
    --]]
    function _G.fw(p28) --[[ Line: 99 ]]
        task.wait(p28)
    end
    _G.customPrestigePrefix = {
        ["Cupid\'s Bow"] = { "Blessed" },
        ["Mega-Pow"] = { "Anomalized" },
        ["World Ender"] = { "Hollow\'s", "Prestige" },
        ["Candy Cane"] = { "Iceborn", "Prestige" }
    }
    if u27 == true then
        local u29 = game:GetService("DataStoreService")
        local u30 = 0
        local u31 = false
        function _G.dataAPISuccess(p32, p33) --[[ Line: 117 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u30
                [3] = u31
            --]]
            local u34 = u29:GetDataStore("TestStore" .. math.random(1, 1000))
            if tick() - u30 <= 3 and p33 == nil then
                return u31
            end
            local v35, _ = pcall(function() --[[ Line: 123 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                return u34:SetAsync("TestKey", math.random(1, 1000))
            end)
            u31 = v35
            u30 = tick()
            if v35 == false and p32 then
                game.ReplicatedStorage.Events.note:FireClient(p32, "<Color=Red>ROBLOX DATASTORE API IS DOWN, TRY LATER!")
            end
            return v35
        end
    end
    workspace:WaitForChild("Islands")
    workspace:WaitForChild("Env")
    workspace:WaitForChild("Ships")
    game.ReplicatedStorage:WaitForChild("Modules")
    local v36 = RaycastParams.new()
    v36.FilterType = Enum.RaycastFilterType.Include
    v36.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
    v36.IgnoreWater = true
    _G.RayParams = v36
    _G.RaycastParams = _G.RayParams
    _G.Ess = require(game.ReplicatedStorage.Modules.Essentials)
    _G.m1HitDelay = 0
    function _G.char_npc(p37) --[[ Line: 153 ]]
        if p37:IsA("Model") then
            return p37
        end
        if p37:IsA("Player") then
            p37 = p37.Character or p37
        end
        return p37
    end
    if u27 == false then
        task.spawn(function() --[[ Line: 169 ]]
            local v38 = game.ReplicatedStorage:WaitForChild("returnIsArena", 30)
            if v38 then
                local v39, v40 = pcall(v38.InvokeServer, v38)
                if v39 then
                    _G.arena = v40
                end
            end
        end)
        script:GetAttributeChangedSignal("m1HitDelay"):Connect(function() --[[ Line: 179 ]]
            _G.m1HitDelay = script:GetAttribute("m1HitDelay")
        end)
        function _G.HasTitle(p41, p42) --[[ Line: 183 ]]
            local v43 = game.ReplicatedStorage:WaitForChild("Stats" .. p41.Name, 100000000000):WaitForChild("Titles")
            local v44 = false
            for v45, _ in game:GetService("HttpService"):JSONDecode(v43.AllTitles.Value) do
                if v45 == p42 then
                    return true
                end
            end
            return v44
        end
    else
        script:SetAttribute("m1HitDelay", _G.m1HitDelay)
    end
    _G.notAllowed = {
        ["ETPose"] = true,
        ["Drink"] = true,
        ["Cannonball"] = true,
        ["Tool"] = true
    }
    _G.bannedItems = {
        ["Mysterious Book"] = true,
        ["Cyborg Gear"] = true,
        ["Music Snail"] = true,
        ["Book of Nitoryu"] = true,
        ["Kraken Blade"] = true,
        ["AnonAE3X"] = true,
        ["xVoidStar"] = true,
        ["xFedora"] = true,
        ["Black Cape"] = true,
        ["Scorched Heart"] = true,
        ["Admiral Cape"] = true,
        ["Fruit Bag"] = true,
        ["Ace"] = true,
        ["Prestige Dark Blade"] = true
    }
    function _G.filterColor(p46, p47) --[[ Line: 202 ]]
        if p46 == nil or (not p46:IsA("Player") or p46.UserId ~= 86413514) then
            return p47
        else
            return Color3.fromRGB(0, 0, 0)
        end
    end
    _G.dashPercentAmmount = 0.005
    _G.maxBounty = u3.MaxBounty
    function _G.matchMaterial(p48, p49) --[[ Line: 214 ]]
        p48.Material = p49.Material
        p48.MaterialVariant = p49.MaterialVariant
        p48.Color = p49.Color
    end
    function _G.requestStream(p50, p51, p52) --[[ Line: 220 ]]
        local v53
        if p50 == nil then
            if game["Run Service"]:IsClient() ~= true then
                return
            end
            v53 = game.Players.LocalPlayer
        elseif p50 == nil or typeof(p50) == "Instance" then
            v53 = p50
        else
            if game["Run Service"]:IsClient() ~= true then
                return
            end
            v53 = game.Players.LocalPlayer
            p51 = p50
        end
        if workspace.StreamingEnabled ~= false then
            v53:RequestStreamAroundAsync(p51, p52)
        end
    end
    local u54 = 1
    if game["Run Service"]:IsClient() then
        local u55 = UserSettings():GetService("UserGameSettings")
        u55:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() --[[ Name: updateGraphicSettings, Line 246 ]]
            --[[
            Upvalues:
                [1] = u55
                [2] = u54
            --]]
            local v56 = u55.SavedQualityLevel.Value
            if u55.SavedQualityLevel == Enum.SavedQualitySetting.Automatic then
                u54 = 0.5
            else
                u54 = v56 / 10
            end
        end)
        local v57 = u55.SavedQualityLevel.Value
        local v58
        if u55.SavedQualityLevel == Enum.SavedQualitySetting.Automatic then
            v58 = 0.5
            u54 = v58
        else
            v58 = v57 / 10
            u54 = v58
        end
        function _G.HasBaseItem(p59, p60) --[[ Line: 258 ]]
            local v61 = require(game.ReplicatedStorage.Modules.ToolDesc)
            local v62 = game.ReplicatedStorage:FindFirstChild("Stats" .. p59.Name)
            if v62 == nil then
                return false
            end
            local v63 = v62:WaitForChild("Inventory", 10)
            if v63 == nil then
                return false
            end
            local v64 = v63:WaitForChild("Inventory", 10)
            if v64 == nil then
                return false
            end
            local v65 = false
            for v66, _ in game:GetService("HttpService"):JSONDecode(v64.Value) do
                if v61[v66] and v61[v66].BaseItem == p60 then
                    return true
                end
            end
            return v65
        end
    end
    function _G.inCombat(p67) --[[ Line: 279 ]]
        return p67:FindFirstChild("inCombat") ~= nil
    end
    function _G.fruitsInStorage(p68, p69) --[[ Line: 283 ]]
        if p69 == "Dark Root" then
            return {}
        end
        local v70 = game.ReplicatedStorage:FindFirstChild("Stats" .. p68.Name)
        local v71 = _G.HasItem(p68, "Prestige Fruitbag")
        if _G.HasItem(p68, "Fruit Bag") ~= false or (v70.Gamepasses.FruitBag.Value ~= false or v71 ~= false) then
            return {}
        end
        local v72 = require(game.ReplicatedStorage.Modules.ToolDesc)
        local v73 = v70:WaitForChild("Inventory", 10)
        if v73 == nil then
            return {}
        end
        local v74 = v73:WaitForChild("Inventory", 10)
        if v74 == nil then
            return {}
        end
        local v75 = 0
        local v76 = nil
        for v77, v78 in game:GetService("HttpService"):JSONDecode(v74.Value) do
            if v72 and (v72[v77] and (v77 ~= "Dark Root" and v72[v77].Type == "Fruit")) then
                v75 = v75 + v78
                v76 = v77
            end
        end
        return { v76 }
    end
    local u79 = nil
    if u27 == false then
        task.spawn(function() --[[ Line: 315 ]]
            --[[
            Upvalues:
                [1] = u79
            --]]
            u79 = game.ReplicatedStorage:WaitForChild("Stats" .. game.Players.LocalPlayer.Name)
        end)
    end
    function _G.customEmit(u80, u81, p82) --[[ Line: 320 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u79
            [3] = u54
        --]]
        if u80 == nil then
            return
        elseif game["Run Service"]:IsServer() == true then
            CFrame.new()
            if (u80.Parent:IsA("BasePart") or u80.Parent:IsA("Model")) and u80.Parent:IsA("Terrain") == false then
                if u80.Parent:IsA("Model") then
                    u80.Parent:GetPivot()
                else
                    local _ = u80.Parent.CFrame
                end
            elseif u80:IsA("Attachment") then
                local _ = u80.WorldCFrame
            elseif u80.Parent:IsA("Attachment") then
                local _ = u80.Parent.WorldCFrame
            elseif u80:IsA("BasePart") then
                local _ = u80.CFrame
            end
            _G.PlayEffect("CustomEmit", nil, u80, u81, p82)
        else
            local u83 = (u27 ~= false or not u79) and 1 or u79.Settings.ParticleEmitRate.Value
            local v94, v95 = pcall(function() --[[ Line: 349 ]]
                --[[
                Upvalues:
                    [1] = u54
                    [2] = u83
                    [3] = u81
                    [4] = u80
                --]]
                local u84 = u54 * u83
                local function v91(u85) --[[ Line: 352 ]]
                    --[[
                    Upvalues:
                        [1] = u81
                        [2] = u84
                    --]]
                    local v86 = u85:GetAttribute("EmitDelay") or 0
                    local u87 = u85:GetAttribute("EmitDuration") or 0
                    task.delay(v86, function() --[[ Line: 356 ]]
                        --[[
                        Upvalues:
                            [1] = u81
                            [2] = u85
                            [3] = u87
                            [4] = u84
                        --]]
                        if u81 == nil then
                            local v88 = u85:GetAttribute("EmitCount")
                            if (v88 == nil or v88 == 0) and u87 == 0 then
                                return
                            end
                            if typeof(v88) ~= "number" and u87 == 0 then
                                return
                            end
                            if v88 then
                                local v89 = (v88 or 5) * u84
                                u85:Emit(v89 < 1 and 1 or v89)
                            end
                        else
                            local v90 = u85.Rate * u84
                            u85:Emit(v90 < 1 and 1 or v90)
                        end
                        if u87 and u87 ~= 0 then
                            u85.Enabled = true
                            task.delay(u87, function() --[[ Line: 388 ]]
                                --[[
                                Upvalues:
                                    [1] = u85
                                --]]
                                u85.Enabled = false
                            end)
                        end
                    end)
                end
                local v92 = u80
                if typeof(v92) == "Instance" then
                    if u80 and u80:IsA("ParticleEmitter") then
                        v91(u80)
                    else
                        for _, v93 in ipairs(u80:QueryDescendants("ParticleEmitter")) do
                            v91(v93)
                        end
                    end
                else
                    return
                end
            end)
            if not v94 then
                warn("ERROR:", v95)
            end
        end
    end
    if game["Run Service"]:IsClient() then
        function _G.shakenear(u96, u97, u98, u99, u100, u101) --[[ Line: 414 ]]
            task.spawn(function() --[[ Line: 415 ]]
                --[[
                Upvalues:
                    [1] = u101
                    [2] = u96
                    [3] = u97
                    [4] = u98
                    [5] = u99
                    [6] = u100
                --]]
                if u101 == nil then
                    u101 = {}
                end
                local v102 = game.Players.LocalPlayer.Character
                if v102 and (v102:FindFirstChild("HumanoidRootPart") and (u101[v102] == nil and (u96 - v102.HumanoidRootPart.Position).Magnitude <= u97)) then
                    _G.camshake(u98, u99, u100)
                end
            end)
        end
        _G.MouseOld = require(script.Mouse)
    end
    function _G.weakTable(p103) --[[ Line: 432 ]]
        return setmetatable(p103, {
            ["__mode"] = "v"
        })
    end
    _G.allowMelee = {
        ["Melee"] = true,
        ["Rokushiki"] = true,
        ["Electro"] = true,
        ["Mera-Mera"] = true,
        ["Bari-Bari"] = true,
        ["Pika-Pika"] = true,
        ["Paw-Paw"] = true,
        ["Suke-Suke"] = true,
        ["Magu-Magu"] = true,
        ["Hie-Hie"] = true,
        ["Bomb-Bomb"] = true,
        ["Goro-Goro"] = true,
        ["Zushi-Zushi"] = true,
        ["VTori-Tori"] = true,
        ["Mero-Mero"] = true,
        ["Gura-Gura"] = true,
        ["Spin-Spin"] = true,
        ["Gomu-Gomu"] = true
    }
    function _G.raycastWithLand(p104, p105) --[[ Line: 438 ]]
        local v106 = Ray.new(p104, p105)
        local v107, v108, v109 = _G.raycastWhitelist(v106, {
            workspace.Islands,
            workspace.Ships,
            workspace.Env,
            workspace.FruitFloors
        })
        return v107, v108, v109
    end
    function _G.getAccessorys(p110) --[[ Line: 444 ]]
        if not p110 then
            return {}
        end
        local v111 = workspace.Effects.PlayerHats:GetChildren()
        local v112 = {}
        for v113 = 1, #v111 do
            local v114 = v111[v113].Name
            local v115 = p110.Name
            if v114:sub(1, (string.len(v115))) == p110.Name then
                local v116 = v111[v113]:GetDescendants()
                for v117 = 1, #v116 do
                    local v118 = v116[v117]
                    table.insert(v112, v118)
                end
            end
        end
        if p110 then
            local v119 = p110:GetChildren()
            for v120 = 1, #v119 do
                if v119[v120]:GetAttribute("busoModel") ~= nil then
                    local v121 = v119[v120]:GetDescendants()
                    for v122 = 1, #v121 do
                        local v123 = v121[v122]
                        table.insert(v112, v123)
                    end
                end
            end
        end
        return v112
    end
    function _G.PlaySound(p124, p125, p126, _) --[[ Line: 476 ]]
        if p124 == nil then
            return
        elseif typeof(p124) ~= "Instance" or p124.Parent then
            if p125 then
                if p126 and p126.RandomSound then
                    local v127 = p125:GetChildren()
                    if #v127 <= 0 then
                        return
                    end
                    p125 = v127[math.random(1, #v127)]
                end
                local v128 = p125.TimeLength + 5
                local u129 = p125:Clone()
                if p126 then
                    for u130, u131 in p126 do
                        pcall(function() --[[ Line: 504 ]]
                            --[[
                            Upvalues:
                                [1] = u129
                                [2] = u130
                                [3] = u131
                            --]]
                            if u129[u130] then
                                u129[u130] = u131
                            end
                        end)
                    end
                    if p126.RandomPitch ~= nil then
                        u129.Pitch = math.random(90, 110) / 100
                    end
                end
                u129.PlayOnRemove = false
                if typeof(p124) == "Instance" and not p124:IsA("Attachment") or typeof(p124) == "CFrame" then
                    local v132 = Instance.new("Attachment")
                    local v133 = nil
                    if typeof(p124) == "Instance" then
                        if p124:IsA("BasePart") then
                            v133 = p124.CFrame
                        elseif p124:IsA("Model") then
                            v133 = p124:GetPivot()
                        end
                    else
                        v133 = p124
                    end
                    if v132:IsA("Attachment") then
                        v132.WorldCFrame = v133
                    else
                        v132.CFrame = v133
                    end
                    u129.Parent = v132
                    if p124 and typeof(p124) == "Instance" then
                        v132.Parent = workspace.Terrain
                    else
                        v132.Parent = workspace.Terrain
                    end
                    _G.destroy(v132, v128)
                    _G.destroy(u129, v128)
                elseif typeof(p124) == "Instance" and p124:IsA("Attachment") then
                    u129.Parent = p124
                    _G.destroy(u129, v128)
                end
                u129.PlayOnRemove = false
                u129:Play()
                return u129
            end
        end
    end
    local u134 = {}
    function _G.getTargets(u135, p136, u137, u138, p139, p140) --[[ Line: 574 ]]
        --[[
        Upvalues:
            [1] = u134
            [2] = u4
            [3] = u2
        --]]
        if u135 == nil then
            return {}
        end
        local v141 = tick()
        local v142 = (p136 and 1 or 0) + (u137 and 2 or 0) + (u138 and 4 or 0) + (p139 and 8 or 0) + (p140 and 16 or 0)
        if u134[u135] and (u134[u135][v142] and v141 - u134[u135][v142].timestamp < 0.5) then
            return u134[u135][v142].targets
        end
        local u143 = {}
        local u144 = game.Players:GetPlayerFromCharacter(u135)
        if u135 == nil then
            u135 = workspace.Holder
        end
        if u135.Parent == workspace.Effects then
            return {}
        end
        local u145 = u135:FindFirstChild("playerOwner")
        if u145 then
            u135 = u145.Value.Character
            u144 = game.Players:GetPlayerFromCharacter(u135)
        end
        local function v164(p146) --[[ Line: 619 ]]
            --[[
            Upvalues:
                [1] = u135
                [2] = u144
                [3] = u145
                [4] = u138
                [5] = u143
            --]]
            for v147 = 1, #p146 do
                local v148 = p146[v147]
                if v148:FindFirstChildWhichIsA("ForceField") == nil and (v148:FindFirstChild("HumanoidRootPart") and (v148:FindFirstChildWhichIsA("Humanoid") and (v148 ~= u135 and (not v148:GetAttribute("dmgWhitelist") or (not u144 or u144:GetAttribute("safePlayer") ~= nil))))) then
                    if v148:FindFirstChild("playerOwner") then
                        local v149 = v148:FindFirstChild("playerOwner").Value
                        if (not (v149 and (u144 and (u144:FindFirstChild("Party") and v149:FindFirstChild("Party")))) or (not v149.Party.Value or u144.Party.Value ~= v149.Party.Value) and u144 ~= v149) and ((not v149 or v149 ~= game.Players:GetPlayerFromCharacter(v148)) and (not v149 or (not u145 or v149 ~= u145.Value))) then
                            ::l23::
                            if not v148:FindFirstChild("Info") or (not v148.Info:FindFirstChild("Hostile") or v148.Info.Hostile.Value ~= false) then
                                if v148:FindFirstChild("SeaNPC") == nil then
                                    if v148:GetAttribute("modelHitbox") then
                                        if u138 then
                                            local v150 = u143
                                            table.insert(v150, v148)
                                        else
                                            local v151 = v148:QueryDescendants("BasePart")
                                            for v152 = 1, #v151 do
                                                local v153 = u143
                                                local v154 = v151[v152]
                                                table.insert(v153, v154)
                                            end
                                            local v155 = u143
                                            local v156 = v148.HumanoidRootPart
                                            table.insert(v155, v156)
                                        end
                                    elseif u138 then
                                        local v157 = u143
                                        table.insert(v157, v148)
                                    else
                                        local v158 = u143
                                        local v159 = v148.HumanoidRootPart
                                        table.insert(v158, v159)
                                    end
                                else
                                    local v160 = v148:QueryDescendants("BasePart")
                                    for v161 = 1, #v160 do
                                        local v162 = u143
                                        local v163 = v160[v161]
                                        table.insert(v162, v163)
                                    end
                                end
                            end
                        end
                    elseif not u145 or u145.Value ~= game.Players:GetPlayerFromCharacter(v148) then
                        goto l23
                    end
                end
            end
        end
        if u135 and (u135.Parent ~= workspace.NPCs or u145) and u135.Parent ~= workspace.Ships.NPC then
            v164(workspace.NPCs:GetChildren())
        else
            local v165 = workspace.NPCs:GetChildren()
            for v166 = 1, #v165 do
                local v167 = v165[v166]
                if v167:FindFirstChildWhichIsA("ForceField") == nil and (v167:FindFirstChild("HumanoidRootPart") and (v167:FindFirstChildWhichIsA("Humanoid") and (v167:FindFirstChild("playerOwner") and (not v167:GetAttribute("dmgWhitelist") or (not u144 or u144:GetAttribute("safePlayer") ~= nil))))) then
                    if v167:GetAttribute("modelHitbox") then
                        if u138 then
                            table.insert(u143, v167)
                        else
                            local v168 = v167:QueryDescendants("BasePart")
                            for v169 = 1, #v168 do
                                local v170 = v168[v169]
                                table.insert(u143, v170)
                            end
                            local v171 = v167.HumanoidRootPart
                            table.insert(u143, v171)
                        end
                    elseif u138 then
                        table.insert(u143, v167)
                    else
                        local v172 = v167.HumanoidRootPart
                        table.insert(u143, v172)
                    end
                end
            end
        end
        local u173
        if u135 then
            u173 = game.ReplicatedStorage:FindFirstChild("Stats" .. u135.Name)
        else
            u173 = nil
        end
        if (u173 == nil or u173 and u4 <= u173.Stats.Level.Value) and not (u144 and u144:GetAttribute("safePlayer")) then
            local u174 = workspace.PlayerCharacters:GetChildren()
            if p139 then
                local v175 = workspace.Ragdolls:GetChildren()
                for v176 = 1, #v175 do
                    local v177 = v175[v176]
                    table.insert(u174, v177)
                end
            end
            for u178 = 1, #u174 do
                local _, v204 = pcall(function() --[[ Line: 718 ]]
                    --[[
                    Upvalues:
                        [1] = u174
                        [2] = u178
                        [3] = u135
                        [4] = u145
                        [5] = u144
                        [6] = u2
                        [7] = u137
                        [8] = u173
                        [9] = u138
                        [10] = u143
                    --]]
                    local v179 = u174[u178]
                    if v179 ~= u135 and (v179.Name ~= u135.Name and (v179:FindFirstChild("iFrame") == nil and (v179:FindFirstChild("HumanoidRootPart") and (v179:FindFirstChildWhichIsA("Humanoid") and (v179:FindFirstChildWhichIsA("Humanoid").Health > 0 and v179:FindFirstChildWhichIsA("ForceField") == nil))))) then
                        local v180 = (not u145 or u145.Value ~= game.Players:GetPlayerFromCharacter(v179)) and true or false
                        if u144 and v180 then
                            local v181 = game.ReplicatedStorage:FindFirstChild("Stats" .. v179.Name)
                            local v182 = game.Players:GetPlayerFromCharacter(v179)
                            if v182 == nil and game.Players:FindFirstChild(v179.Name) then
                                v182 = game.Players:FindFirstChild(v179.Name)
                            end
                            if u2(u144, v179, true) == false or v182 == nil then
                                local v183 = (not v182 or (u137 ~= nil or (u144.Team ~= game.Teams.Marine or (v182.Team ~= game.Teams.Marine or u144.CrewPVP.Value ~= false and v182.CrewPVP.Value ~= false)))) and true or false
                                if v182 and (u144.Party.Value and (u137 == nil and (v182:FindFirstChild("Party") and v182.Party.Value == u144.Party.Value))) then
                                    v183 = false
                                end
                                if v182 and (u137 == nil and (v181.Stats.Crew.Value == u173.Stats.Crew.Value and (v181.Stats.Crew.Value ~= "" and (u144.CrewPVP.Value == false or v182.CrewPVP.Value == false)))) then
                                    v183 = false
                                end
                                if u135:FindFirstChild("SafeFF") or v179:FindFirstChild("SafeFF") then
                                    if v179:FindFirstChild("dummyNPC") == nil and u137 == nil then
                                        v183 = false
                                    end
                                end
                                if v179:GetAttribute("playerName") and v179:GetAttribute("playerName") == u135.Name then
                                    v183 = false
                                end
                                if v183 == true then
                                    if v179:GetAttribute("modelHitbox") then
                                        if u138 then
                                            local v184 = u143
                                            table.insert(v184, v179)
                                        else
                                            local v185 = v179:QueryDescendants("BasePart")
                                            for v186 = 1, #v185 do
                                                local v187 = u143
                                                local v188 = v185[v186]
                                                table.insert(v187, v188)
                                            end
                                            local v189 = u143
                                            local v190 = v179.HumanoidRootPart
                                            table.insert(v189, v190)
                                        end
                                    elseif u138 then
                                        local v191 = u143
                                        table.insert(v191, v179)
                                    else
                                        local v192 = u143
                                        local v193 = v179.HumanoidRootPart
                                        table.insert(v192, v193)
                                    end
                                end
                            end
                        elseif v180 == true then
                            if v179:GetAttribute("modelHitbox") then
                                if u138 then
                                    local v194 = u143
                                    table.insert(v194, v179)
                                else
                                    local v195 = v179:QueryDescendants("BasePart")
                                    for v196 = 1, #v195 do
                                        local v197 = u143
                                        local v198 = v195[v196]
                                        table.insert(v197, v198)
                                    end
                                    local v199 = u143
                                    local v200 = v179.HumanoidRootPart
                                    table.insert(v199, v200)
                                end
                            end
                            if u138 then
                                local v201 = u143
                                table.insert(v201, v179)
                                return
                            end
                            local v202 = u143
                            local v203 = v179.HumanoidRootPart
                            table.insert(v202, v203)
                        end
                    end
                end)
                if v204 then
                    warn("error", v204)
                end
            end
        end
        if p136 then
            local v205 = workspace.Ships:GetChildren()
            for v206 = 1, #v205 do
                if v205[v206] ~= u135 and v205[v206]:FindFirstChild("HumanoidRootPart") then
                    local v207 = v205[v206].HumanoidRootPart
                    table.insert(u143, v207)
                end
            end
            if u135 and (u135.Parent ~= workspace.NPCs and u135.Parent ~= workspace.Ships.NPC) then
                local v208 = workspace.Ships.NPC:GetChildren()
                for v209 = 1, #v208 do
                    if v208[v209] ~= u135 and v208[v209]:FindFirstChild("HumanoidRootPart") then
                        local v210 = v208[v209].HumanoidRootPart
                        table.insert(u143, v210)
                    end
                end
            end
        end
        if p140 then
            local v211 = workspace.Env:GetChildren()
            for v212 = 1, #v211 do
                if v211[v212]:FindFirstChild("barrelHP") and v211[v212]:GetAttribute("iFrame") == nil then
                    local v213 = v211[v212]
                    table.insert(u143, v213)
                end
            end
            for _, v214 in pairs(game:GetService("CollectionService"):GetTagged("CustomHP")) do
                if v214:GetAttribute("iFrame") == nil then
                    table.insert(u143, v214)
                end
            end
        end
        local v215 = workspace:FindFirstChild("Holder")
        if v215 then
            local v216 = v215.PrimaryPart
            table.insert(u143, v216)
        end
        if not u134[u135] then
            u134[u135] = {}
        end
        u134[u135][v142] = {
            ["timestamp"] = v141,
            ["targets"] = u143
        }
        task.delay(0.5, function() --[[ Line: 838 ]]
            --[[
            Upvalues:
                [1] = u134
                [2] = u135
            --]]
            u134[u135] = nil
        end)
        return u143
    end
    function _G.checkUlt(p217) --[[ Line: 844 ]]
        if game.ReplicatedStorage.reservedCode.Value ~= "arena" then
            return true
        end
        game.ReplicatedStorage:FindFirstChild("Stats" .. p217.Name)
        local _ = p217.UltsUsed.Value
        local _ = p217.leaderstats.Damage.Value
        if _G.checkUltDamage(p217) <= p217.leaderstats.UltBar.Value then
            return true
        end
        if game["Run Service"]:IsServer() == false then
            script.UltNotReady:Play()
            _G.displayMessage("<Color=Red>Your ultimate bar needs to be full!")
        end
        return false
    end
    function _G.isSameParty(p218, p219) --[[ Line: 865 ]]
        if p218:IsA("Model") then
            local v220 = game.Players:GetPlayerFromCharacter(p218)
            if v220 then
                return _G.isSameParty(v220, p219)
            else
                return false
            end
        elseif p218:IsA("Player") then
            if p218:FindFirstChild("Party") then
                return p218.Party.Value ~= nil and p218.Party.Value == p219.Party.Value
            else
                return false
            end
        else
            return false
        end
    end
    function _G.checkUltDamage(p221) --[[ Line: 888 ]]
        if game.ReplicatedStorage.reservedCode.Value == "arena" then
            local v222 = game.ReplicatedStorage:FindFirstChild("Stats" .. p221.Name)
            local _ = p221.UltsUsed.Value
            local _ = p221.leaderstats.Damage.Value
            local v223 = 1000 - v222.Stats.Defense.Value
            return math.clamp(v223, 0, 10000) + 1200
        end
    end
    function _G.getRayFloor(p224, p225, p226, p227) --[[ Line: 898 ]]
        local v228 = p225 + 1
        local v229
        if p226 and typeof(p226) == "boolean" then
            v229 = nil
        else
            v229 = p226
            p226 = p227
        end
        local v230 = v229 == nil and { workspace.Islands, workspace.Ships, workspace.Env } or v229
        local v231 = Ray.new(p224.Position + Vector3.new(0, 1, 0), CFrame.new(p224.Position).UpVector * -v228)
        local v232, v233, v234 = _G.raycastWhitelist(v231, v230, p226)
        return v232, v233, v234
    end
    function _G.getRayWall(p235, p236, p237) --[[ Line: 916 ]]
        local v238 = p237 == nil and { workspace.Islands, workspace.Ships, workspace.Env } or p237
        local v239 = (p235.Position - p236.Position).Magnitude
        local v240 = Ray.new(p235.Position, (p235.Position - p236.Position).Unit * -v239)
        local v241, v242, v243 = _G.raycastWhitelist(v240, v238)
        return v241, v242, v243
    end
    function _G.particleEnabled(p244, p245, p246, p247) --[[ Line: 945 ]]
        local v248 = {}
        for v249 in pairs(p247 or {}) do
            local v250 = "[ClassName=\"" .. v249 .. "\"]"
            table.insert(v248, v250)
        end
        if p246 then
            table.insert(v248, "Trail")
            table.insert(v248, "Beam")
        end
        local v251 = p244:QueryDescendants("ParticleEmitter" .. (#v248 > 0 and "," .. table.concat(v248, ",") or ""))
        for _, v252 in ipairs(v251) do
            v252.Enabled = p245
        end
    end
    function _G.clampCF(p253, p254, p255) --[[ Line: 963 ]]
        if (p254.Position - p253.PrimaryPart.Position).Magnitude > (p255 == nil and 15 or p255) then
            p254 = p253.PrimaryPart.CFrame
        end
        return p254
    end
    function _G.scaleParticle(p256, p257, p258) --[[ Line: 974 ]]
        local v259 = p257 or 1
        local v260
        if p258 == nil then
            v260 = p256:QueryDescendants(">ParticleEmitter")
        else
            v260 = p256:QueryDescendants("ParticleEmitter")
        end
        for _, v261 in v260 do
            local v262 = {}
            for _, v263 in v261.Size.Keypoints do
                local v264 = v263.Value * v259
                local v265 = NumberSequenceKeypoint.new(v263.Time, v264)
                table.insert(v262, v265)
            end
            v261.Drag = v261.Drag / v259
            v261.Size = NumberSequence.new(v262)
            v261.Speed = NumberRange.new(v261.Speed.Min * v259, v261.Speed.Max * v259)
        end
    end
    function _G.scaleModel(p266, p267) --[[ Line: 1007 ]]
        local v268 = p266.PrimaryPart
        local v269
        if v268 == nil then
            v269 = p266:GetPivot()
        else
            v269 = v268.CFrame
        end
        for _, v270 in p266:QueryDescendants(">BasePart") do
            v270.Size = v270.Size * p267
            if v270 ~= v268 then
                v270.CFrame = v269 + v269:inverse() * v270.Position * p267
            end
        end
        return p266
    end
    function _G.streamObject(p271, p272) --[[ Line: 1035 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        return u7:convertArgs(p271, p272)
    end
    function _G.awaitObject(p273) --[[ Line: 1039 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        return u7:resolveArgs(p273)
    end
    function _G.streamArgs(...) --[[ Line: 1095 ]]
        local u274 = false
        local function u280(p275) --[[ Line: 1125 ]]
            --[[
            Upvalues:
                [1] = u274
                [2] = u280
            --]]
            for v276, v277 in pairs(p275) do
                local v278 = typeof(v277)
                if v278 == "Instance" and v277:IsA("Player") == false then
                    if v277:IsA("ObjectValue") and v277:GetAttribute("StreamedObject") ~= nil then
                        local v279 = _G.awaitObject(v277)
                        if v279 == "INVALID" then
                            u274 = true
                            return p275
                        end
                        p275[v276] = v279
                    end
                elseif v278 == "table" then
                    p275[v276] = u280(v277)
                end
                if v277 == "fakeNil" then
                    p275[v276] = nil
                end
            end
            return p275
        end
        local v281 = u280({ ... })
        return u274 == true and "INVALID" or v281
    end
    _G.getTargetByPart = u26
    function _G.getTargetsInRegion(p282, p283, p284, p285, p286) --[[ Line: 1221 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        if typeof(p284) == "Vector3" then
            local v287 = p283
            p283 = p284
            p284 = v287
        end
        local v288 = u5.new(p284, p283)
        if p285 ~= nil then
            v288 = u5.Ball(p284, p283)
        end
        local v289 = v288:FindPartsInRegion3WithWhiteList(_G.getTargets(p282, p286, nil, true), 50000)
        local v290 = {}
        local v291 = {}
        for v292 = 1, #v289 do
            local v293 = _G.getTargetByPart(v289[v292])
            if not table.find(v290, v293) and v293 then
                if v293 == p282 or not (v293 and v293:FindFirstChild("HumanoidRootPart")) then
                    if v293 and table.find(v290, v293) == nil then
                        table.insert(v290, v293)
                    else
                        warn("couldnt find real target for " .. v289[v292]:GetFullName())
                    end
                else
                    table.insert(v290, v293)
                end
            end
        end
        for v294 = 1, #v290 do
            local v295 = v290[v294]
            if v295 and v295:FindFirstChild("HumanoidRootPart") then
                local v296 = v295.HumanoidRootPart
                table.insert(v291, v296)
            else
                warn("couldnt find target for " .. v295:GetFullName())
            end
        end
        return v291
    end
    function _G.getTargetNearMouse(p297) --[[ Line: 1266 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        local v298 = game.Players.LocalPlayer.Character
        local v299 = p297 or 150
        local v300 = nil
        local v301 = _G.getTargets(v298)
        local v302 = _G.MouseCF
        local _, v303 = _G.raycast:cast(v298.PrimaryPart.Position, (v298.PrimaryPart.Position - v302.Position).unit * (v298.PrimaryPart.Position - v302.Position).magnitude, { workspace.Islands, workspace.Ships, workspace.Env })
        CFrame.new(v303)
        if _G.MouseTarget ~= nil then
            for _, v304 in v301 do
                if _G.MouseTarget:IsDescendantOf(v304.Parent) then
                    local v305 = u26(v304)
                    if v305 and v305.PrimaryPart then
                        return v305.PrimaryPart
                    end
                end
            end
        end
        local v306 = workspace.CurrentCamera
        for _, v307 in v301 do
            local v308, v309 = v306:WorldToScreenPoint(v307.Position)
            if v309 then
                local v310 = (Vector2.new(v308.X, v308.Y) - game:GetService("UserInputService"):GetMouseLocation()).Magnitude
                local v311 = v298.PrimaryPart.Position
                local v312 = Ray.new(v311, (v311 - v307.Position).unit * -(v311 - v307.Position).magnitude)
                local v313, _, _ = _G.raycastWhitelist(v312, { workspace.Islands, workspace.Ships, workspace.Env })
                if v310 < v299 and v313 == nil then
                    v300 = v307
                    v299 = v310
                end
            end
        end
        if v300 then
            local v314 = u26(v300)
            if v314 and v314.PrimaryPart then
                return v314.PrimaryPart
            else
                return nil
            end
        else
            return nil
        end
    end
    function _G.Emit(p315, p316, p317, p318) --[[ Line: 1331 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u79
        --]]
        if game["Run Service"]:IsServer() == true then
            _G.PlayEffect("Emit", nil, p315, p316, p317, p318)
            return
        else
            if typeof(p315) ~= "table" and typeof(p315) == "Instance" then
                p315 = p315:GetChildren()
            end
            if p315 ~= nil then
                local u319 = (u27 ~= false or not u79) and 1 or u79.Settings.ParticleEmitRate.Value
                local function u334(u320, p321) --[[ Line: 1345 ]]
                    --[[
                    Upvalues:
                        [1] = u319
                    --]]
                    local v322 = u320:GetAttribute("EmitCount")
                    local v323 = u320:GetAttribute("EmitDelay")
                    local u324 = (p321 or v322) and p321 and p321 or (u320:GetAttribute("EmitCount") or 10)
                    if not v322 or (v322 > 0 or v323 ~= nil and (not v323 or v323 > 0)) then
                        task.delay(v323 or 0, function() --[[ Line: 1353 ]]
                            --[[
                            Upvalues:
                                [1] = u324
                                [2] = u320
                                [3] = u319
                            --]]
                            local v325 = UserSettings().GameSettings.SavedQualityLevel
                            if v325 == Enum.SavedQualitySetting.Automatic then
                                local v326 = u324 == 1 and 1 or 0.5
                                if u320 ~= nil then
                                    local v327 = u320
                                    local v328 = u324 * v326
                                    local v329 = math.ceil(v328) * u319
                                    v327:Emit((math.max(v329, 1)))
                                    return
                                end
                            else
                                local v330 = u324 == 1 and 1 or v325.Value / 10
                                if u320 ~= nil then
                                    local v331 = u320
                                    local v332 = u324 * v330
                                    local v333 = math.ceil(v332) * u319
                                    v331:Emit((math.max(v333, 1)))
                                end
                            end
                        end)
                    end
                end
                if p316 then
                    for _, u335 in pairs(p315) do
                        if u335:IsA("ParticleEmitter") then
                            local v336 = u335:GetAttribute("EmitDelay")
                            if v336 then
                                task.delay(v336, function() --[[ Line: 1378 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u334
                                        [2] = u335
                                    --]]
                                    u334(u335, u335:GetAttribute("EmitCount"))
                                end)
                            else
                                u334(u335, u335:GetAttribute("EmitCount"))
                            end
                        end
                    end
                else
                    for _, u337 in pairs(p315) do
                        if u337:IsA("ParticleEmitter") then
                            if u337.Enabled then
                                local _ = u337.Enabled
                            else
                                u334(u337, u337:GetAttribute("EmitCount"))
                            end
                            u337.Enabled = not u337.Enabled
                            if p317 then
                                task.delay(p317, function() --[[ Line: 1398 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u337
                                    --]]
                                    u337.Enabled = not u337.Enabled
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
    function _G.flipbook(u338, u339, u340, u341) --[[ Line: 1407 ]]
        local u342 = u338:FindFirstChildOfClass("SpecialMesh")
        if u342 and u339 then
            task.spawn(function() --[[ Line: 1410 ]]
                --[[
                Upvalues:
                    [1] = u339
                    [2] = u338
                    [3] = u342
                    [4] = u340
                    [5] = u341
                --]]
                local v343 = game.Players.LocalPlayer.Character
                if workspace.Effects.Decals:FindFirstChild(u339[1]) == nil and (v343 ~= nil and v343:FindFirstChild("Head")) then
                    local v344 = script.DecalHolder:Clone()
                    v344.Name = u339[1]
                    v344.CFrame = CFrame.new(u338.Position.X, -500, u338.Position.Z)
                    v344.Parent = workspace.Effects.Decals
                    for v345 = 1, #u339 do
                        local v346 = Instance.new("Decal")
                        v346.Texture = u339[v345]
                        v346.Parent = v344
                    end
                    v344.Anchored = true
                end
                for v347 = 1, #u339 do
                    u342.TextureId = u339[v347]
                    task.wait(1 / u340)
                end
                if u341 == true then
                    u342.Parent:Destroy()
                end
            end)
        end
    end
    function _G.recolorParticles(p348, p349, p350) --[[ Line: 1436 ]]
        if p349 ~= nil then
            for _, v351 in p348:GetDescendants() do
                if (v351:IsA("ParticleEmitter") or (v351:IsA("BasePart") or (v351:IsA("PointLight") or (v351:IsA("Trail") or (v351:IsA("Decal") or v351:IsA("Beam")))))) and (p350 == nil and v351:GetAttribute("recolorable") ~= nil or p350 and v351:GetAttribute(p350) ~= nil) then
                    if v351:IsA("Trail") or (v351:IsA("ParticleEmitter") or v351:IsA("Beam")) then
                        if typeof(p349) == "ColorSequence" then
                            v351.Color = p349
                        else
                            v351.Color = ColorSequence.new(p349)
                        end
                    elseif v351:IsA("Decal") then
                        v351.Color3 = p349
                    else
                        v351.Color = p349
                    end
                end
            end
        end
    end
    function _G.removeGroundParticles(p352, p353) --[[ Line: 1460 ]]
        local v354 = p353 or "UseGroundColor"
        for _, v355 in p352:GetDescendants() do
            if v355:IsA("ParticleEmitter") and v355:GetAttribute(v354) then
                v355:Destroy()
            end
        end
    end
    _G.transInfo = {}
    _G.transTrash = {}
    task.spawn(function() --[[ Line: 1494 ]]
        while true do
            task.wait(5)
            for v356, v357 in pairs(_G.transTrash) do
                if v356 == nil or v356 and v356.Parent == nil then
                    if v357 then
                        v357:Destroy()
                    end
                    if v356 then
                        v356:Destroy()
                    end
                    _G.transTrash[v356] = nil
                end
            end
            for v358, _ in pairs(_G.transInfo) do
                if v358 == nil or v358 and v358.Parent == nil then
                    if v358 then
                        v358:Destroy()
                    end
                    _G.transInfo[v358] = nil
                end
            end
        end
    end)
    function _G.transparentCharacter(u359, p360, p361, _, p362, p363) --[[ Line: 1521 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u6
        --]]
        local u364 = u359:GetDescendants()
        table.insert(u364, u359)
        local v365 = _G.getAccessorys(u359)
        for v366 = 1, #v365 do
            local v367 = v365[v366]
            table.insert(u364, v367)
        end
        local u368 = p362 == nil and {} or p362
        local u369 = p363 == nil and {} or p363
        local u370 = _G.transTrash[u359]
        local function u374(p371) --[[ Line: 1539 ]]
            --[[
            Upvalues:
                [1] = u369
                [2] = u368
            --]]
            if #u369 > 0 then
                for v372 = 1, #u369 do
                    if p371:HasTag(u369[v372]) then
                        return false
                    end
                end
            end
            if p371:FindFirstAncestorWhichIsA("Tool") then
                return false
            end
            local v373 = p371:IsA("BasePart") or (p371:IsA("Decal") or (p371:IsA("ParticleEmitter") or (p371:IsA("Beam") or p371:IsA("Trail")))) or p371:IsA("PointLight")
            if v373 then
                if p371:GetAttribute("toriPart") == nil and p371:GetAttribute("alwaysVisible") == nil then
                    v373 = table.find(u368, p371.ClassName) == nil
                else
                    v373 = false
                end
            end
            return v373
        end
        local u375 = "transparentCharacterHidden" .. (u27 == true and "_Server" or "_Client")
        local function u389(u376, p377) --[[ Line: 1560 ]]
            --[[
            Upvalues:
                [1] = u374
                [2] = u375
                [3] = u370
            --]]
            if u374(u376) == true then
                local u378 = u376:IsA("ParticleEmitter") or (u376:IsA("Beam") or u376:IsA("Trail"))
                local u379 = u376:IsA("PointLight")
                local v380 = false
                local v381 = u376:GetAttribute(u375) ~= nil
                if u376:IsA("BasePart") or u376:IsA("Decal") then
                    v380 = u376.Transparency ~= 1 and true or v380
                end
                local v382 = u378 == true and u376.Transparency ~= NumberSequence.new(1) and true or v380
                if (u379 and u376.Enabled == true and true or v382) == true and v381 == false then
                    local function v383() --[[ Line: 1580 ]]
                        --[[
                        Upvalues:
                            [1] = u370
                            [2] = u376
                            [3] = u379
                            [4] = u378
                        --]]
                        if u370.Clearing == true then
                            return
                        elseif _G.transInfo[u376] == nil then
                            return
                        elseif u379 then
                            u376.Enabled = false
                            return
                        elseif u378 == false then
                            u376.Transparency = 1
                        else
                            u376.Transparency = NumberSequence.new(1)
                        end
                    end
                    local v384 = u379 == true and "Enabled" or "Transparency"
                    if _G.transInfo[u376] == nil then
                        local u385 = true
                        _G.transInfo[u376] = {
                            ["Value"] = u376[v384],
                            ["Count"] = 0
                        }
                        u370.AttachedParts[u376] = true
                        u376:SetAttribute(u375, true)
                        local u386 = u370:Add(function() --[[ Line: 1614 ]]
                            --[[
                            Upvalues:
                                [1] = u385
                                [2] = u376
                                [3] = u370
                            --]]
                            if u385 == false then
                                return
                            elseif not _G.transInfo[u376] or _G.transInfo[u376].Count <= 0 then
                                u370.AttachedParts[u376] = nil
                                _G.transInfo[u376] = nil
                            end
                        end)
                        u370:Add(u376.Destroying:Connect(function() --[[ Line: 1628 ]]
                            --[[
                            Upvalues:
                                [1] = u376
                                [2] = u370
                                [3] = u386
                            --]]
                            if _G.transInfo[u376] then
                                _G.transInfo[u376] = nil
                            end
                            u370:Remove(u386)
                        end))
                    end
                    local v387 = _G.transInfo[u376]
                    v387.Count = v387.Count + 1
                    if u370.Clearing ~= true and _G.transInfo[u376] ~= nil then
                        if u379 then
                            u376.Enabled = false
                        elseif u378 == false then
                            u376.Transparency = 1
                        else
                            u376.Transparency = NumberSequence.new(1)
                        end
                    end
                    if u379 == false then
                        u370:Connect(u376:GetPropertyChangedSignal("Transparency"), v383)
                    else
                        u370:Connect(u376:GetPropertyChangedSignal("Enabled"), v383)
                    end
                    return
                end
                if v381 == true and (p377 == nil and _G.transInfo[u376]) then
                    local v388 = _G.transInfo[u376]
                    v388.Count = v388.Count + 1
                end
            end
        end
        if p360 == nil and _G.transTrash[u359] == nil then
            local u390 = u6.new()
            _G.transTrash[u359] = u390
            u390.AttachedParts = {}
            u390:AttachToInstance(u359)
            u390:Add(function() --[[ Line: 1658 ]]
                --[[
                Upvalues:
                    [1] = u359
                    [2] = u375
                    [3] = u390
                --]]
                _G.transTrash[u359] = nil
                local v391 = {}
                for v392, _ in pairs(_G.transInfo) do
                    if v392:IsDescendantOf(u359) then
                        table.insert(v391, v392)
                    end
                end
                for _, v393 in ipairs(v391) do
                    _G.transInfo[v393] = nil
                    v393:SetAttribute(u375, nil)
                    v393:SetAttribute(u375 .. "Count", nil)
                end
                for v394, _ in pairs(u390.AttachedParts) do
                    if v394 then
                        _G.transInfo[v394] = nil
                    end
                end
                table.clear(u390.AttachedParts)
            end)
            u390:Add(u359.ChildAdded:Connect(function(p395) --[[ Line: 1683 ]]
                --[[
                Upvalues:
                    [1] = u389
                --]]
                if p395:IsA("Model") and p395:IsA("Tool") == false then
                    local v396 = p395:GetDescendants()
                    for v397 = 1, #v396 do
                        u389(v396[v397], true)
                    end
                end
            end))
            u370 = u390
        end
        local v398 = false
        for u399 = 1, #u364 do
            if u374(u364[u399]) == true then
                local v400 = p361 == nil or u364[u399]:IsDescendantOf(p361) ~= true
                if p360 == nil and v400 == true then
                    u389(u364[u399])
                elseif _G.transInfo[u364[u399]] then
                    local v401 = _G.transInfo[u364[u399]]
                    v401.Count = v401.Count - 1
                    if p360 == "forceShow" then
                        _G.transInfo[u364[u399]].Count = 0
                    end
                    if _G.transInfo[u364[u399]].Count <= 0 then
                        local u402 = _G.transInfo[u364[u399]].Value
                        if u364[u399].Parent == u359 and v398 == false then
                            v398 = true
                            if _G.transTrash[u359] then
                                _G.transTrash[u359].Clearing = true
                            end
                        end
                        _G.transInfo[u364[u399]] = nil
                        if u370 then
                            u370.AttachedParts[u364[u399]] = nil
                        end
                        task.defer(function() --[[ Line: 1726 ]]
                            --[[
                            Upvalues:
                                [1] = u364
                                [2] = u399
                                [3] = u402
                                [4] = u375
                            --]]
                            if u364[u399] and u364[u399].Parent then
                                if u364[u399]:IsA("PointLight") == false then
                                    u364[u399].Transparency = u402
                                else
                                    u364[u399].Enabled = true
                                end
                                u364[u399]:SetAttribute(u375, nil)
                                u364[u399]:SetAttribute(u375 .. "Count", nil)
                            end
                        end)
                    end
                end
                if _G.transInfo[u364[u399]] then
                    u364[u399]:SetAttribute(u375 .. "Count", _G.transInfo[u364[u399]].Count)
                else
                    u364[u399]:SetAttribute(u375 .. "Count", nil)
                end
            end
        end
        if (v398 == false and (u370 and (next(u370.AttachedParts) == nil and p360 ~= nil)) and true or v398) == true and _G.transTrash[u359] then
            _G.transTrash[u359]:Destroy()
            _G.transTrash[u359] = nil
        end
    end
    function _G.bodyGetSection(p403, p404) --[[ Line: 1763 ]]
        local v405 = p403:GetDescendants()
        local v406 = {}
        for v407 = 1, #v405 do
            if (v405[v407]:IsA("Motor6D") or (v405[v407]:IsA("Weld") or v405[v407]:IsA("WeldConstraint"))) and v405[v407].Part0 == p404 then
                local v408 = v405[v407].Part1
                table.insert(v406, v408)
            end
        end
        local v409 = {}
        for v410 = 1, #v406 do
            local v411 = v406[v410].Parent
            if v411 and (v411:IsA("Model") and v411 ~= p403) then
                for _, v412 in pairs(v411:GetDescendants()) do
                    if v412:IsA("BasePart") then
                        table.insert(v409, v412)
                    end
                end
            end
        end
        table.insert(v409, p404)
        return v409
    end
    function _G.bodyTransSection(p413, p414, p415) --[[ Line: 1793 ]]
        local v416 = p413:GetDescendants()
        local v417 = {}
        local v418 = { "ParticleEmitter" }
        for v419 = 1, #v416 do
            if (v416[v419]:IsA("Motor6D") or (v416[v419]:IsA("Weld") or v416[v419]:IsA("WeldConstraint"))) and v416[v419].Part0 == p414 then
                local v420 = v416[v419].Part1
                table.insert(v417, v420)
            end
        end
        for v421 = 1, #v417 do
            local v422 = v417[v421].Parent
            if v422 and (v422:IsA("Model") and v422 ~= p413) then
                _G.transparentCharacter(v422, p415, nil, nil, v418)
            end
        end
        if p415 == nil then
            _G.transparentCharacter(p414, nil, nil, nil, v418)
        elseif p415 ~= nil and _G.transInfo[p414] ~= nil then
            _G.transparentCharacter(p414, true, nil, nil, v418)
        end
    end
    _G.Apply = require(game.ReplicatedStorage.Modules.ApplyRig)
    function _G.modeBarModuleNames(p423) --[[ Line: 1830 ]]
        return string.split(p423, "-")[1]
    end
    function _G.setCollisionGroup(p424, p425) --[[ Line: 1835 ]]
        p424.CollisionGroup = p425
    end
    function _G.getBone(p426, p427) --[[ Line: 1839 ]]
        return p426:FindFirstChild(p427, true)
    end
    function _G.showPlayersModel(p428, p429) --[[ Line: 1851 ]]
        if p429 == true then
            p428.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
        else
            p428.ModelStreamingMode = Enum.ModelStreamingMode.Default
        end
    end
    function _G.getWeaponTool(p430, p431) --[[ Line: 1860 ]]
        local v432 = game.Players:GetPlayerFromCharacter(p430)
        local v433 = p430:FindFirstChildWhichIsA("Tool")
        local v434 = nil
        if v433 and v433.Name == p431 then
            return v433
        end
        if v432 then
            v434 = v432.Backpack:FindFirstChild(p431)
        end
        return v434
    end
    function _G.getTrueCD(p435, p436) --[[ Line: 1874 ]]
        local v437 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
        local v438 = {
            ["BuddhaMode"] = 1,
            ["PteraMode"] = 0.37,
            ["ToriFullForm"] = 0.37,
            ["VenomDemon"] = 1.1,
            ["BlackLeg"] = 0.29,
            ["FishmanKarate"] = 0.29,
            ["DragonClaw"] = 0.29,
            ["Iron Fist"] = 0.3,
            ["Abyssal Karate"] = 0.29,
            ["VenomDemonModel"] = 1.1,
            ["MochiV2-MochiV2"] = 0.26,
            ["DragonHybird"] = v437.DragonHybird.cooldown,
            ["LeopardHybird"] = 0.58,
            ["BuddhaHybird"] = v437.BuddhaHybird.cooldown
        }
        if table.find({
            "BuddhaMode",
            "PteraMode",
            "ToriFullForm",
            "VenomDemon",
            "LeopardHybird"
        }, p436) then
            return v438[p436]
        end
        local v439 = v437[p436]
        local v440
        if v439 then
            local v441 = _G.getWeaponTool(p435, p436)
            if v441 and (v441:GetAttribute("Offhand") == true and v439.offhandData ~= nil) then
                v439 = v439.offhandData
            end
            v440 = v439.cooldown
        else
            v440 = 0.25
        end
        if v438[p436] then
            v440 = v438[p436]
        end
        return v440
    end
    _G.toolLockedCustomM1s = {
        ["DragonHybird"] = "Dragon-Dragon",
        ["BuddhaHybird"] = "Buddha-Buddha"
    }
    function _G.getHitBox(p442, p443, p444) --[[ Line: 1930 ]]
        local v445 = game.ReplicatedStorage:FindFirstChild("Stats" .. p442.Name)
        local v446 = game.Players:GetPlayerFromCharacter(p442)
        local v447 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
        local v448 = p442:FindFirstChildWhichIsA("Tool")
        local v449 = p442:GetAttribute("customM1")
        local v450 = Vector3.new(6, 10, 8)
        local v451 = CFrame.new(0, 0, -1)
        local v452 = v448 and (v448.Name or "") or ""
        local v453 = false
        if p444 and p444.Tool ~= nil then
            v448 = p444.Tool
        end
        local v454 = v447[v452]
        local v455 = v448 and (v454 and v449 == nil) and true or v453
        if v449 and (_G.toolLockedCustomM1s[v449] and (v448 and _G.toolLockedCustomM1s[v449] ~= v448.Name)) then
            v449 = nil
        end
        if v448 and v448:FindFirstChild("weaponOverride") then
            v452 = v448:FindFirstChild("weaponOverride").Value
            v454 = v447[v452]
        end
        if v449 == nil and (v445 and (v448 and (not v454 and (v445.Stats.FightingStyle.Value ~= "" and (game.ReplicatedStorage.CombatAnimations:FindFirstChild(v445.Stats.FightingStyle.Value) and v448:GetAttributes().MeleeTool ~= nil))))) then
            v448 = v446.Backpack:FindFirstChild(v445.Stats.FightingStyle.Value) or v448
            v452 = v448.Name
            v454 = v447[v452]
        end
        if v448 and (v448:GetAttribute("Offhand") and v454.offhandData ~= nil) then
            v454 = v454.offhandData
        end
        if p443 and v455 == false then
            v454 = v447[p443]
        else
            p443 = v452
        end
        local v456 = _G.getTrueCD(p442, v449 == nil and p443 and p443 or v449)
        if (v449 == nil or v455 == true) and v454 then
            v450 = v454.Range
            v451 = v454.Offset
            v456 = v454.cooldown
        end
        if v448 then
            if v448.Name == "BlackLeg" then
                v451 = CFrame.new(0, 0, -1.5)
                v450 = Vector3.new(6, 10, 8)
            elseif v448.Name == "FishmanKarate" then
                v451 = CFrame.new(0, 0, -1.5)
                v450 = Vector3.new(6, 10, 8)
            elseif v448.Name == "DragonClaw" then
                v451 = CFrame.new(0, 0, -1.5)
                v450 = Vector3.new(6, 10, 8)
            elseif v448.Name == "Iron Fist" then
                v451 = CFrame.new(0, 0, -1.5)
                v450 = Vector3.new(6, 10, 8)
            elseif v448.Name == "Abyssal Karate" then
                v451 = CFrame.new(0, 0, -1.5)
                v450 = Vector3.new(6, 10, 8)
            elseif v448:GetAttributes().MeleeTool ~= nil then
                v451 = CFrame.new(0, 0, -1)
                v450 = Vector3.new(6, 10, 8)
            end
        end
        if v454 == nil then
            v450 = v449 and Vector3.new(0.25, 0.25, 0.25) or v450
            if v449 and _G.toolLockedCustomM1s[v449] ~= nil then
                local v457 = v447[v449]
                if v457 then
                    v450 = v457.Range
                    v451 = v457.Offset
                end
            end
        end
        local v458 = v450.X
        local v459 = v450.Z
        return Vector3.new(v458, 11, v459), v451, v456, v449
    end
    function _G.isInsideBrick(p460, p461, p462) --[[ Line: 2066 ]]
        local v463 = p461:PointToObjectSpace(p460)
        local v464 = v463.X
        local v465
        if math.abs(v464) <= p462.X / 2 then
            local v466 = v463.Y
            if math.abs(v466) <= p462.Y / 2 then
                local v467 = v463.Z
                v465 = math.abs(v467) <= p462.Z / 2
            else
                v465 = false
            end
        else
            v465 = false
        end
        return v465
    end
    function _G.getTargetsWithENV(p468) --[[ Line: 2073 ]]
        local v469 = { workspace.Env, workspace.Ships, workspace.Islands }
        for _, v470 in pairs(_G.getTargets(p468, nil, nil, true)) do
            table.insert(v469, v470)
        end
        return v469
    end
    _G.SulongFurColors = {
        Color3.fromRGB(171, 137, 171),
        Color3.fromRGB(168, 168, 168),
        Color3.fromRGB(117, 176, 176),
        Color3.fromRGB(138, 163, 166)
    }
    function _G.getHumanoid(p471, p472) --[[ Line: 2088 ]]
        if typeof(p471) ~= "Instance" then
            return nil
        end
        if p471 == nil then
            return nil
        end
        local v473 = p471:FindFirstAncestorWhichIsA("Model")
        if p472 then
            if p472:IsA("Player") and v473 == p472.Character then
                return
            end
            if p472 == v473 then
                return
            end
        end
        if v473 then
            return v473:FindFirstChildWhichIsA("Humanoid")
        end
    end
    _G.layoutMulti = {
        ["Common"] = 0,
        ["Uncommon"] = -500,
        ["Rare"] = -600,
        ["Epic"] = -700,
        ["Legendary"] = -800,
        ["Mythical"] = -900,
        ["Collectable"] = -1000
    }
    function _G.hairTransparency(p474, p475) --[[ Line: 2124 ]]
        if p474:FindFirstChild("Hairs") ~= nil then
            local v476 = p474.Hairs:GetChildren()
            for v477 = 1, #v476 do
                v476[v477].Transparency = p475
            end
        end
    end
    function _G.checkPartIsBarrierFruit(p478) --[[ Line: 2134 ]]
        if p478 == nil then
            return false
        else
            return p478.CollisionGroup:match("Barrier") ~= nil
        end
    end
    function _G.getMasteryInfo(p479, p480) --[[ Line: 2143 ]]
        local v481 = game.ReplicatedStorage:FindFirstChild("Stats" .. p479.Name)
        if v481 then
            local v482 = game:GetService("HttpService"):JSONDecode(v481.MasteryPercentages.AllMasterys.Value)
            if v482[p480] then
                return v482[p480].Progress, v482[p480].Max
            end
        end
        return nil
    end
    function _G.promptQuestion(u483, u484, u485, u486, u487, u488) --[[ Line: 2155 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        if not (u486 and u483.PlayerGui:FindFirstChild(u486)) then
            local u489 = nil
            _G.bindableExcu(function() --[[ Line: 2161 ]]
                --[[
                Upvalues:
                    [1] = u489
                    [2] = u484
                    [3] = u486
                    [4] = u488
                    [5] = u27
                    [6] = u487
                    [7] = u485
                    [8] = u483
                --]]
                u489 = script.ConfirmationPrompt:Clone()
                u489.Main.TextLabel.Text = u484
                if u486 then
                    u489.Name = u486
                end
                if u488 and u488.ScaleWithText ~= nil then
                    u489:SetAttribute("ScaleWithText", true)
                end
                local u490 = u488
                if u490 then
                    u490 = u488.MultiSelect == true
                end
                if u490 then
                    u489:SetAttribute("MultiSelect", true)
                end
                u489:SetAttribute("isServer", u27)
                if u487 == true then
                    u489.ResetOnSpawn = false
                end
                local v491 = u489.Main.OptionsFrame
                local v492 = v491.Accept:Clone()
                local v493 = false
                for v494, v495 in pairs(u485) do
                    if typeof(v495) == "table" and v495.Function ~= nil then
                        if v493 == false then
                            local v496 = v491:GetChildren()
                            v493 = true
                            for v497 = 1, #v496 do
                                if v496[v497]:IsA("ImageButton") then
                                    v496[v497]:Destroy()
                                end
                            end
                        end
                        local v498 = v492:Clone()
                        v498.ImageColor3 = v495.Color or Color3.fromRGB(255, 255, 255)
                        v498.Text.Text = v495.Label or v494
                        v498.Name = v494
                        v498:SetAttribute("buttonValue", v495.ButtonValue or v494)
                        if v495.LayoutOrder then
                            v498.LayoutOrder = v495.LayoutOrder
                        end
                        if u490 and v495.Toggleable then
                            v498:SetAttribute("Toggleable", true)
                            v498:SetAttribute("Selected", v495.Selected == true)
                            v498:SetAttribute("SelectedColor", v495.Color or Color3.fromRGB(100, 200, 100))
                            v498:SetAttribute("UnselectedColor", v495.UnselectedColor or Color3.fromRGB(80, 80, 80))
                            if not v495.Selected then
                                v498.ImageColor3 = v495.UnselectedColor or Color3.fromRGB(80, 80, 80)
                            end
                        end
                        v498.Parent = v491
                    end
                end
                u489.Parent = u483.PlayerGui
                local u499 = nil
                local function u505(p500) --[[ Line: 2220 ]]
                    --[[
                    Upvalues:
                        [1] = u490
                        [2] = u488
                        [3] = u485
                    --]]
                    if p500 == "true" then
                        p500 = true
                    elseif p500 == "false" then
                        p500 = false
                    end
                    if u490 and (typeof(p500) == "string" and string.sub(p500, 1, 12) == "MULTISELECT:") then
                        local v501 = {}
                        local v502 = string.sub(p500, 13)
                        if v502 ~= "" then
                            for v503 in string.gmatch(v502, "([^,]+)") do
                                table.insert(v501, v503)
                            end
                        end
                        if u488 and u488.OnApply then
                            u488.OnApply(v501)
                        end
                    elseif u485[p500] then
                        local v504 = u485[p500]
                        if typeof(v504) == "table" and u485[p500].Function ~= nil then
                            u485[p500].Function()
                            return
                        end
                        u485[p500]()
                    end
                end
                if u27 == true then
                    local _ = u489.RemoteEvent.OnServerEvent:Connect(function(p506, u507) --[[ Line: 2253 ]]
                        --[[
                        Upvalues:
                            [1] = u483
                            [2] = u499
                            [3] = u505
                            [4] = u489
                        --]]
                        if p506 == u483 then
                            u499:Disconnect()
                            u499 = nil
                            local _, v508 = pcall(function() --[[ Line: 2259 ]]
                                --[[
                                Upvalues:
                                    [1] = u505
                                    [2] = u507
                                --]]
                                u505(u507)
                            end)
                            if v508 then
                                warn("ERROR:", v508)
                            end
                            if u489 then
                                u489:Destroy()
                            end
                        end
                    end)
                else
                    local _ = u489.clientEvent.Event:Connect(function(u509) --[[ Line: 2270 ]]
                        --[[
                        Upvalues:
                            [1] = u499
                            [2] = u505
                            [3] = u489
                        --]]
                        u499:Disconnect()
                        u499 = nil
                        local _, v510 = pcall(function() --[[ Line: 2273 ]]
                            --[[
                            Upvalues:
                                [1] = u505
                                [2] = u509
                            --]]
                            u505(u509)
                        end)
                        if v510 then
                            warn("ERROR:", v510)
                        end
                        if u489 then
                            u489:Destroy()
                        end
                    end)
                end
                u489.Client.Enabled = true
            end)
            return u489
        end
    end
    function _G.promptQuestionSlider(u511, u512) --[[ Line: 2291 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u27
        --]]
        local u513 = u512.staysForever
        local u514 = u512.uiName
        if u514 and u511.PlayerGui:FindFirstChild(u514) then
            return
        elseif u512.Start == nil or (u512.End == nil or u512.Start < u512.End) then
            local u515 = nil
            local u516 = Instance.new("BindableEvent", script)
            local u517 = u8.new()
            u516.Event:Connect(function() --[[ Line: 2307 ]]
                --[[
                Upvalues:
                    [1] = u515
                    [2] = u514
                    [3] = u27
                    [4] = u513
                    [5] = u512
                    [6] = u511
                    [7] = u517
                    [8] = u516
                --]]
                u515 = script.PromptNumberSlider:Clone()
                if u514 then
                    u515.Name = u514
                end
                u515:SetAttribute("isServer", u27)
                if u513 == true then
                    u515.ResetOnSpawn = false
                end
                local v518 = u515.Main.Slider
                v518:SetAttribute("Start", u512.Start)
                v518:SetAttribute("End", u512.End)
                v518:SetAttribute("DisplayText", u512.DisplayText)
                if u512.Increment then
                    v518:SetAttribute("Increment", u512.Increment)
                end
                if u512.AcceptText then
                    u515.Main.OptionsFrame.Accept.Text.Text = u512.AcceptText
                end
                if u512.DeclineText then
                    u515.Main.OptionsFrame.Decline.Text.Text = u512.DeclineText
                end
                u515.Parent = u511.PlayerGui
                local u519 = nil
                if u27 == true then
                    local _ = u515.RemoteEvent.OnServerEvent:Connect(function(p520, p521) --[[ Line: 2351 ]]
                        --[[
                        Upvalues:
                            [1] = u511
                            [2] = u519
                            [3] = u512
                            [4] = u517
                            [5] = u515
                        --]]
                        if p520 == u511 then
                            u519:Disconnect()
                            u519 = nil
                            if typeof(p521) == "number" then
                                local v522 = u512.finishFunction
                                if p521 == p521 then
                                    local v523 = math.floor(p521)
                                    warn("client finished", v523)
                                    v522(v523)
                                end
                            end
                            u517:Fire()
                            if u515 then
                                u515:Destroy()
                            end
                        end
                    end)
                else
                    local _ = u515.clientEvent.Event:Connect(function(p524) --[[ Line: 2367 ]]
                        --[[
                        Upvalues:
                            [1] = u519
                            [2] = u512
                            [3] = u517
                            [4] = u515
                        --]]
                        u519:Disconnect()
                        u519 = nil
                        if typeof(p524) == "number" then
                            local v525 = u512.finishFunction
                            if p524 == p524 then
                                local v526 = math.floor(p524)
                                warn("client finished", v526)
                                v525(v526)
                            end
                        end
                        u517:Fire()
                        if u515 then
                            u515:Destroy()
                        end
                    end)
                end
                u515.Client.Enabled = true
                u516:Destroy()
            end)
            u516:Fire()
            u517:Wait()
            u517:DisconnectAll()
        end
    end
    _G.FightingStylesV2 = {
        ["Moonlit Electro"] = true,
        ["Abyssal Karate"] = true,
        ["Kamishiki"] = true
    }
    function _G.getCurrentActiveV2(p527) --[[ Line: 2396 ]]
        return game.ReplicatedStorage:FindFirstChild("Stats" .. p527.Name).Settings.CurrentV2.Value
    end
    function _G.playerFruitPassiveEnabled(p528) --[[ Line: 2401 ]]
        local v529 = game.ReplicatedStorage:FindFirstChild("Stats" .. p528.Name)
        local v530 = v529.Stats.DF.Value:match("V2") ~= nil
        local v531 = _G.FightingStylesV2[v529.Stats.FightingStyle.Value] ~= nil
        if v531 == true and v530 == false then
            return false
        end
        if v530 == true and v531 == false then
            return true
        end
        if v530 == true and v531 == true then
            return _G.getCurrentActiveV2(p528) ~= "Fighting Style"
        end
        if v531 == false and v530 == false then
            return true
        end
    end
    function _G.getFirstPart(p532) --[[ Line: 2427 ]]
        local v533 = string.split(p532, "-")
        return string.gsub(v533[1], "V2", "")
    end
    function _G.isFruitSupressed(p534) --[[ Line: 2434 ]]
        local v535 = game.ReplicatedStorage:FindFirstChild("Stats" .. p534.Name)
        if v535 == nil then
            return false
        end
        local v536 = v535.Stats.DF.Value:match("V2") ~= nil
        local v537 = _G.FightingStylesV2[v535.Stats.FightingStyle.Value] ~= nil
        return v535.Settings.CurrentV2.Value == "Fighting Style" and v537 == true and true or (v536 == false and (v535.Stats.DF.Value ~= "" and _G.FightingStylesV2[v535.Stats.FightingStyle.Value]) and true or false)
    end
    function _G.isFightingStyleSupressed(p538) --[[ Line: 2454 ]]
        local v539 = game.ReplicatedStorage:FindFirstChild("Stats" .. p538.Name)
        if v539 == nil then
            return false
        end
        local v540 = v539.Stats.DF.Value:match("V2") ~= nil
        local v541 = _G.FightingStylesV2[v539.Stats.FightingStyle.Value] ~= nil
        return v539.Settings.CurrentV2.Value == "Fruit" and v540 == true and true or v541 == false and v540 == true
    end
    local function u550(p542, p543, p544, p545) --[[ Line: 2486 ]]
        local v546 = game.ReplicatedStorage:FindFirstChild("Stats" .. p542.Name).Stats:FindFirstChild(p543)
        if v546 then
            if (v546:IsA("NumberValue") or v546:IsA("IntValue")) and v546.Value < p544 then
                return false
            end
            if v546:IsA("StringValue") then
                if typeof(p544) == "table" then
                    for v547 = 1, #p544 do
                        if p544[v547] == v546.Value then
                            return true
                        end
                    end
                end
                if v546.Value ~= p544 then
                    return false
                end
            end
        elseif p543:match("/SKILL/") and p545 == nil then
            local v548 = string.gsub(p543, "/SKILL/", "")
            local v549 = game.ReplicatedStorage:FindFirstChild("Stats" .. p542.Name):FindFirstChild("Skills"):FindFirstChild(v548)
            if v549 and v549.Value < p544 then
                return false
            end
            if v549 == nil then
                return false
            end
        end
        return true
    end
    function _G.ScaleWithHPChar(p551, p552) --[[ Line: 2538 ]]
        return p552 * (p551.Humanoid.Health / p551.Humanoid.MaxHealth)
    end
    function _G.SkillRequirementsMet(p553, p554, p555) --[[ Line: 2522 ]]
        --[[
        Upvalues:
            [1] = u550
        --]]
        if p554 == nil then
            return true
        end
        local v556 = true
        local v557 = nil
        for v558, v559 in p554 do
            v556 = u550(p553, v558, v559, p555)
            if v556 == false then
                v557 = v559
                break
            end
            v557 = v559
        end
        return v556, v557
    end
    function _G.emitHitVfx(p560, p561, p562, p563) --[[ Line: 2545 ]]
        local v564
        if p563 and typeof(p563) == "table" then
            v564 = p563.Tag
            p563 = p563.Color
        else
            v564 = nil
        end
        local v565 = p560:Clone()
        local v566 = CFrame.Angles
        local v567 = math.random(0, 360)
        local v568 = math.rad(v567)
        local v569 = math.random(0, 360)
        local v570 = math.rad(v569)
        local v571 = math.random(0, 360)
        v565.CFrame = p561 * v566(v568, v570, (math.rad(v571)))
        if p562 then
            _G.scaleParticle(v565, p562, true)
        end
        if p563 then
            _G.recolorParticles(v565, p563, v564)
        end
        local v572 = v565:FindFirstChildWhichIsA("PointLight")
        v565.Parent = workspace.Effects
        if v572 then
            _G.tween(v572, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = v572.Range * 3,
                ["Brightness"] = 0
            })
        end
        _G.customEmit(v565)
        _G.destroy(v565, 8)
        return v565
    end
    function _G.customEmitCFrame(p573, p574) --[[ Line: 2571 ]]
        local v575 = p574.Scale
        local v576 = p574.CFrame
        local v577 = p574.Color
        local v578
        if v577 and typeof(v577) == "table" then
            v578 = v577.Tag
            v577 = v577.Color
        else
            v578 = nil
        end
        local v579 = p573:Clone()
        v579.CFrame = v576
        if v575 then
            _G.scaleParticle(v579, v575, true)
        end
        if v577 then
            _G.recolorParticles(v579, v577, v578)
        end
        local v580 = v579:FindFirstChildWhichIsA("PointLight")
        v579.Parent = workspace.Effects
        if v580 then
            _G.tween(v580, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = v580.Range * 3,
                ["Brightness"] = 0
            })
        end
        _G.customEmit(v579)
        _G.destroy(v579, 5)
        return v579
    end
    function _G.vfxToFloor(p581, p582) --[[ Line: 2602 ]]
        local v583 = p582.StartCFrame
        local v584 = p582.Depth or 6
        local v585 = p582.Offset or CFrame.Angles(-1.5709708597200962, 0, 0)
        if p582.Clone then
            p581 = p581:Clone()
        end
        local v586, v587, v588 = _G.getRayFloor(v583, v584)
        if not v586 then
            if p582.Clone then
                p581:Destroy()
            else
                p581:ClearAllChildren()
            end
            return nil
        end
        local v589 = CFrame.new(v587, v587 + v588) * v585 * CFrame.new(0, 0.1, 0)
        _G.recolorParticles(p581, v586.Color)
        if p581:IsA("BasePart") then
            p581.CFrame = v589
        elseif p581:IsA("Attachment") then
            p581.WorldCFrame = v589
        end
        if p582.Clone ~= nil then
            p581.Parent = workspace.Effects
            _G.customEmit(p581)
            _G.destroy(p581, 6)
        end
        return p581
    end
    function _G.castingSkill(p590, p591, p592) --[[ Line: 2642 ]]
        local v593 = tick()
        local v594 = false
        while true do
            if _G.check:inspect(p590) == false then
                v594 = true
                break
            end
            task.wait()
            if p591 <= tick() - v593 then
                break
            end
        end
        if p592 == true then
            task.wait(p591 - (tick() - v593))
        end
        return v594 ~= true
    end
    function _G.removeParticles(p595, p596) --[[ Line: 2662 ]]
        local v597 = p596 == nil and "recolorable" or p596
        local v598 = p595:GetDescendants()
        for v599 = 1, #v598 do
            if v598[v599]:GetAttribute(v597) ~= nil then
                v598[v599].Transparency = NumberSequence.new(1)
            end
        end
    end
    local u600 = {}
    local u601 = nil
    function _G.preloadFolderName(p602) --[[ Line: 2678 ]]
        --[[
        Upvalues:
            [1] = u600
            [2] = u601
        --]]
        if _G.effectsFolder == nil then
            repeat
                task.wait()
            until _G.effectsFolder
        end
        if not u600[p602] then
            local v603 = _G.clientEffectsFolder
            if u601 == nil then
                local v604 = v603:GetDescendants()
                local v605 = {}
                for v606 = 1, #v604 do
                    if v604[v606]:IsA("Folder") and v604[v606].Parent:IsA("Folder") then
                        local v607 = v604[v606]
                        table.insert(v605, v607)
                    end
                end
                u601 = v605
            end
            u600[p602] = true
            if u601 then
                local function v625(p608, p609) --[[ Line: 2706 ]]
                    if p608 == p609 then
                        return 10
                    end
                    local v610 = string.gsub(p608:lower(), "[%s%p]", "")
                    local v611 = string.gsub(p609:lower(), "[%s%p]", "")
                    local v612 = #v610
                    local v613 = #v611
                    local v614 = {}
                    for v615 = 0, v612 do
                        v614[v615] = {}
                        for v616 = 0, v613 do
                            v614[v615][v616] = 0
                        end
                    end
                    for v617 = 1, v612 do
                        for v618 = 1, v613 do
                            if v610:sub(v617, v617) == v611:sub(v618, v618) then
                                v614[v617][v618] = v614[v617 - 1][v618 - 1] + 1
                            else
                                local v619 = v614[v617]
                                local v620 = v614[v617 - 1][v618]
                                local v621 = v614[v617][v618 - 1]
                                v619[v618] = math.max(v620, v621)
                            end
                        end
                    end
                    local v622 = v614[v612][v613]
                    local v623 = v622 / v612
                    local v624 = v622 / v613
                    return math.max(v623, v624)
                end
                local v626 = 0
                local u627 = nil
                for v628 = 1, #u601 do
                    local v629 = v625(p602, u601[v628].Name)
                    if v626 < v629 then
                        u627 = u601[v628]
                        v626 = v629
                    end
                end
                if u627 and v626 >= 0.5 then
                    task.spawn(function() --[[ Line: 2754 ]]
                        --[[
                        Upvalues:
                            [1] = u627
                        --]]
                        local v630 = tick()
                        game:GetService("ContentProvider"):PreloadAsync(u627:GetDescendants())
                        warn("FINISHED PRELOADING", u627:GetFullName(), tick() - v630)
                    end)
                end
            end
        end
    end
    local u631 = Instance.new("BindableEvent")
    u631.Parent = script
    u631.Event:Connect(function(p632) --[[ Line: 2768 ]]
        p632()
    end)
    function _G.bindableExcu(p633) --[[ Line: 2772 ]]
        --[[
        Upvalues:
            [1] = u631
        --]]
        u631:Fire(p633)
    end
    function _G.canTargetCFrame(p634) --[[ Line: 2776 ]]
        local v635 = not p634:FindFirstChild("SeaNPC")
        if v635 == true and p634:FindFirstChild("hyperArmor") then
            v635 = false
        end
        if v635 == true and p634:FindFirstChild("AntiAir") then
            v635 = false
        end
        if v635 == true and (p634:FindFirstChild("motionLess") or p634:GetAttribute("motionLess")) then
            v635 = false
        end
        return v635
    end
    _G.ToolDesc = require(game.ReplicatedStorage.Modules.ToolDesc)
    task.spawn(function() --[[ Line: 2797 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v636 = workspace:WaitForChild("Islands")
        if v636:GetAttribute("allIslands") == nil then
            v636:GetAttributeChangedSignal("allIslands"):Wait()
        end
        _G.isCustomHUB = u1:FindFirstChild("tradingHUB") ~= nil and true or u1:FindFirstChild("fishingHUB") ~= nil
    end)
end