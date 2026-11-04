 

 

local Players = game:GetService("Players");
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil");
local UserFlag = v1.getUserFlag("UserPlayerScriptsCCLIntegrationD");
local UserFlag2 = v1.getUserFlag("UserPlayerScriptsPlayerControlState2");
local UserFlag3 = v1.getUserFlag("UserPlayerScriptsTaskDeferSimulation");
local UserFlag4 = v1.getUserFlag("UserPlayerScriptsImportWaitForAbilitiesFolder");
local u2;

if UserFlag4 then
    u2 = nil;
else
    local function waitForChildren(p3: userdata, u4: table, p5: number?) -- Line: 22
        if #u4 == 0 then
            return nil;
        end;

        for _, v in u4 do
            local v6 = p3:FindFirstChild(v);

            if v6 then
                return v6;
            end;
        end;

        local coroutine_running_ret = coroutine.running();
        local u7 = nil;
        local u8 = false;

        local function settle(p9: userdata?) -- Line: 41
            -- upvalues: u8 (ref), u7 (ref), coroutine_running_ret (copy)
            if u8 then
                return;
            end;

            u8 = true;
            u7 = p9;
            task.spawn(coroutine_running_ret);
        end;

        local v11 = p3.ChildAdded:Connect(function(p10: userdata) -- Line: 54
            -- upvalues: u4 (copy), u8 (ref), u7 (ref), coroutine_running_ret (copy)
            if table.find(u4, p10.Name) then
                if u8 then
                    return;
                end;

                u8 = true;
                u7 = p10;
                task.spawn(coroutine_running_ret);
            end;
        end);
        local v12;

        if p5 then
            v12 = task.delay(p5, function() -- Line: 61
                -- upvalues: u8 (ref), u7 (ref), coroutine_running_ret (copy)
                if u8 then
                    return;
                end;

                u8 = true;
                u7 = nil;
                task.spawn(coroutine_running_ret);
            end);
        else
            v12 = nil;
        end;

        coroutine.yield();
        v11:Disconnect();

        if v12 and coroutine.status(v12) == "suspended" then
            task.cancel(v12);
        end;

        return u7;
    end;

    u2 = function(p13: userdata, p14: number?) -- Line: 85
        -- upvalues: waitForChildren (copy)
        if not p13 then
            return nil;
        end;

        local u15;

        if p14 then
            u15 = time() + p14;
        else
            u15 = nil;
        end;

        local function getRemainingTime() -- Line: 92
            -- upvalues: u15 (copy)
            if not u15 then
                return nil;
            end;

            local v16 = u15 - time();

            return math.max(v16, 0);
        end;

        local v17 = { "AbilityManagerActor", "Abilities" };
        local v18;

        if u15 then
            local v19 = u15 - time();
            v18 = math.max(v19, 0);
        else
            v18 = nil;
        end;

        local v20 = waitForChildren(p13, v17, v18);

        if not v20 then
            return nil;
        end;

        if v20.Name == "Abilities" then
            if v20:IsA("Folder") then
                return v20;
            end;

            return nil;
        end;

        local v21;

        if u15 then
            local v22 = u15 - time();
            v21 = math.max(v22, 0);
        else
            v21 = nil;
        end;

        local v23;

        if v21 then
            v23 = v20:WaitForChild("Abilities", v21);
        else
            v23 = v20:WaitForChild("Abilities");
        end;

        if v23 and v23:IsA("Folder") then
            return v23;
        end;

        return nil;
    end;
end;

if not UserFlag then
    local Players2 = game:GetService("Players");
    local v24 = {};
    local u25 = nil;
    local u26 = nil;
    local BindableEvent = Instance.new("BindableEvent");
    local u27 = nil;
    local u28 = false;

    local function characterAdded(p29) -- Line: 500
        -- upvalues: u25 (ref), u26 (ref), u27 (ref), BindableEvent (copy)
        u25 = nil;
        u26 = nil;

        if u27 then
            u27:Disconnect();
            u27 = nil;
        end;

        if p29 then
            u25 = p29:FindFirstChild("AbilityManagerActor");
            u26 = p29:FindFirstChildOfClass("Humanoid");

            while not u26 do
                p29.ChildAdded:wait();
                u26 = p29:FindFirstChildOfClass("Humanoid");
            end;

            BindableEvent:Fire();
            u27 = u26:GetPropertyChangedSignal("EvaluateStateMachine"):Connect(function() -- Line: 517
                -- upvalues: BindableEvent (ref)
                BindableEvent:Fire();
            end);
        end;
    end;

    local function lazyInit() -- Line: 523
        -- upvalues: u28 (ref), Players2 (copy), characterAdded (copy)
        if u28 then
            return;
        end;

        u28 = true;
        local LocalPlayer = Players2.LocalPlayer;

        if LocalPlayer then
            LocalPlayer.characterAdded:Connect(characterAdded);

            if LocalPlayer.Character then
                characterAdded(LocalPlayer.Character);
            end;
        end;
    end;

    function v24.isEnabled() -- Line: 538
        -- upvalues: u28 (ref), Players2 (copy), characterAdded (copy), u25 (ref), u26 (ref)
        if not u28 then
            u28 = true;
            local LocalPlayer = Players2.LocalPlayer;

            if LocalPlayer then
                LocalPlayer.characterAdded:Connect(characterAdded);

                if LocalPlayer.Character then
                    characterAdded(LocalPlayer.Character);
                end;
            end;
        end;

        local v30;

        if u25 == nil then
            v30 = false;
        else
            v30 = u26 and not u26.EvaluateStateMachine;
        end;

        return v30;
    end;

    function v24.GetEnabledChangedSignal() -- Line: 543
        -- upvalues: u28 (ref), Players2 (copy), characterAdded (copy), BindableEvent (copy)
        if not u28 then
            u28 = true;
            local LocalPlayer = Players2.LocalPlayer;

            if LocalPlayer then
                LocalPlayer.characterAdded:Connect(characterAdded);

                if LocalPlayer.Character then
                    characterAdded(LocalPlayer.Character);
                end;
            end;
        end;

        return BindableEvent.Event;
    end;

    return v24;
end;

local u31 = {};
u31.__index = u31;
local u32 = {};
Players.PlayerRemoving:Connect(function(p33) -- Line: 125
    -- upvalues: u32 (copy)
    wait(1);
    local v34 = u32[p33.UserId];

    if v34 then
        v34:destroy();
        u32[p33.UserId] = nil;
    end;
end);

local function createAbilitiesByInputNameTable(p35) -- Line: 135
    local v36 = {};

    for _, child in p35:GetChildren() do
        if child:IsA("Configuration") then
            local Attribute = child:GetAttribute("InputName");

            if Attribute then
                v36[Attribute] = child;
            end;
        end;
    end;

    return v36;
end;

local function notifyAbilitiesChanged(p37, u38) -- Line: 148
    local u40 = p37.ChildAdded:Connect(function(p39) -- Line: 149
        -- upvalues: u38 (copy)
        if p39:IsA("Configuration") then
            u38(p39, "added");
        end;
    end);
    local u42 = p37.ChildRemoved:Connect(function(p41) -- Line: 154
        -- upvalues: u38 (copy)
        if p41:IsA("Configuration") then
            u38(p41, "removed");
        end;
    end);

    return function() -- Line: 159
        -- upvalues: u40 (copy), u42 (copy)
        u40:Disconnect();
        u42:Disconnect();
    end;
end;

function u31._new(u43) -- Line: 165
    -- upvalues: u31 (copy), UserFlag2 (copy), UserFlag3 (copy)
    local u44 = setmetatable({}, u31);
    u44._player = u43;
    u44._data = {};
    u44._character = nil;
    u44._humanoid = nil;
    u44._enabledChangedEvent = Instance.new("BindableEvent");
    u44._abilitiesChangedEvent = Instance.new("BindableEvent");
    u44._evaluateStateMachineChangedConnection = nil;
    u44._abilityChangedEvents = {};
    u44._abilityChangedConnections = {};
    u44._abilitiesByInputName = {};
    u44._disconnectAbilitiesChanged = nil;

    if UserFlag2 and not UserFlag3 then
        task.spawn(function() -- Line: 182
            -- upvalues: u44 (copy), u43 (copy)
            u44._characterAddedConnection = u43.CharacterAdded:Connect(function(p45) -- Line: 183
                -- upvalues: u44 (ref)
                u44:_onCharacterAdded(p45);
            end);
        end);
    else
        u44._characterAddedConnection = u43.CharacterAdded:Connect(function(p46) -- Line: 188
            -- upvalues: u44 (copy)
            u44:_onCharacterAdded(p46);
        end);
    end;

    if u43.Character then
        u44:_onCharacterAdded(u43.Character);
    end;

    return u44;
end;

local u47 = nil;

function u31._avatarAbilities() -- Line: 202
    -- upvalues: u47 (ref)
    if not u47 then
        local Packages = game:GetService("ReplicatedStorage"):FindFirstChild("Packages");
        local v48;

        if Packages then
            v48 = Packages:FindFirstChild("AvatarAbilities");
        else
            v48 = nil;
        end;

        local v49;

        if v48 then
            v49 = require(v48);
        else
            v49 = nil;
        end;

        u47 = v49 or require("@rbx/AvatarAbilities");
    end;

    return u47;
end;

function u31.get(p50) -- Line: 215
    -- upvalues: u32 (copy), u31 (copy)
    if not p50 or p50.UserId == 0 then
        return nil;
    end;

    local v51 = u32[p50.UserId];

    if not v51 then
        v51 = u31._new(p50);
        u32[p50.UserId] = v51;
    end;

    return v51;
end;

function u31._hookUpAbilityChangedEvent(u52, u53, u54) -- Line: 225
    local v55 = u52._abilitiesByInputName[u53];

    if not v55 then
        return;
    end;

    local SyncedState = v55:FindFirstChild("SyncedState");

    if not SyncedState then
        return;
    end;

    if not u52._abilityChangedConnections[u54] then
        u52._abilityChangedConnections[u54] = {};
    end;

    if u52._abilityChangedConnections[u54][u53] then
        u52._abilityChangedConnections[u54][u53]:Disconnect();
        u52._abilityChangedConnections[u54][u53] = nil;
    end;

    u52._abilityChangedConnections[u54][u53] = SyncedState:GetAttributeChangedSignal(u54):Connect(function() -- Line: 239
        -- upvalues: u52 (copy), u54 (copy), u53 (copy)
        u52._abilityChangedEvents[u54][u53]:Fire();
    end);
end;

function u31._onCharacterAdded(u56, u57) -- Line: 244
    -- upvalues: UserFlag4 (copy), u2 (ref), notifyAbilitiesChanged (copy), createAbilitiesByInputNameTable (copy)
    u56._humanoid = nil;
    u56._character = u57;
    u56._abilitiesByInputName = {};
    u56._data = {};

    if u56._disconnectAbilitiesChanged then
        u56._disconnectAbilitiesChanged();
        u56._disconnectAbilitiesChanged = nil;
    end;

    for _, v in u56._abilityChangedConnections do
        for _, v2 in v do
            v2:Disconnect();
        end;
    end;

    u56._abilityChangedConnections = {};

    if u56._evaluateStateMachineChangedConnection then
        u56._evaluateStateMachineChangedConnection:Disconnect();
        u56._evaluateStateMachineChangedConnection = nil;
    end;

    if not u56._character then
        return;
    end;

    local function isStale() -- Line: 271
        -- upvalues: u56 (copy), u57 (copy)
        return u56._character ~= u57;
    end;

    task.spawn(function() -- Line: 276
        -- upvalues: UserFlag4 (ref), u56 (copy), u57 (copy), u2 (ref), notifyAbilitiesChanged (ref), createAbilitiesByInputNameTable (ref)
        local u58;

        if UserFlag4 then
            u58 = u56._avatarAbilities().waitForAbilitiesFolder(u57);
        else
            u58 = u2(u57);
        end;

        if not u58 or u56._character ~= u57 then
            return;
        end;

        u56._humanoid = u57:FindFirstChildOfClass("Humanoid");

        while not u56._humanoid do
            u57.ChildAdded:Wait();

            if u56._character ~= u57 then
                return;
            end;

            u56._humanoid = u57:FindFirstChildOfClass("Humanoid");
        end;

        if u56._evaluateStateMachineChangedConnection then
            u56._evaluateStateMachineChangedConnection:Disconnect();
            u56._evaluateStateMachineChangedConnection = nil;
        end;

        local function enabledChanged() -- Line: 297
            -- upvalues: u56 (ref), notifyAbilitiesChanged (ref), u58 (ref), createAbilitiesByInputNameTable (ref)
            if u56._disconnectAbilitiesChanged then
                u56._disconnectAbilitiesChanged();
                u56._disconnectAbilitiesChanged = nil;
            end;

            if u56:isEnabled() then
                u56._disconnectAbilitiesChanged = notifyAbilitiesChanged(u58, function(p59, p60) -- Line: 304
                    -- upvalues: u56 (ref)
                    local Attribute = p59:GetAttribute("InputName");

                    if not Attribute then
                        return;
                    end;

                    if p60 == "added" then
                        u56._abilitiesByInputName[Attribute] = p59;

                        for i, v in u56._abilityChangedEvents do
                            if v[Attribute] then
                                u56:_hookUpAbilityChangedEvent(Attribute, i);
                            end;
                        end;
                    elseif u56._abilitiesByInputName[Attribute] == p59 then
                        u56._abilitiesByInputName[Attribute] = nil;

                        for _, v in u56._abilityChangedConnections do
                            local v61 = v[Attribute];

                            if v61 then
                                v61:Disconnect();
                                v[Attribute] = nil;
                            end;
                        end;
                    end;

                    u56._abilitiesChangedEvent:Fire();
                end);
                u56._abilitiesByInputName = createAbilitiesByInputNameTable(u58);
                u56._abilitiesChangedEvent:Fire();

                for i, v in u56._abilityChangedEvents do
                    local v62 = i;

                    for i2, v2 in v do
                        v2:Fire();
                        u56:_hookUpAbilityChangedEvent(i2, v62);
                    end;
                end;
            end;

            u56._enabledChangedEvent:Fire();
        end;

        u56._evaluateStateMachineChangedConnection = u56._humanoid:GetPropertyChangedSignal("EvaluateStateMachine"):Connect(function() -- Line: 350
            -- upvalues: enabledChanged (copy)
            enabledChanged();
        end);
        enabledChanged();
    end);
end;

function u31.isEnabled(p63) -- Line: 357
    local v64;

    if p63._humanoid == nil then
        v64 = false;
    else
        v64 = not p63._humanoid.EvaluateStateMachine;
    end;

    return v64;
end;

function u31.GetEnabledChangedSignal(p65) -- Line: 361
    return p65._enabledChangedEvent.Event;
end;

function u31.SendInput(p66, p67, p68) -- Line: 365
    if not p66:isEnabled() then
        return;
    end;

    if p68 ~= p66._data[p67] then
        p66._data[p67] = p68;
        p66._avatarAbilities().setAbilityManagerCommand(p66._character, p67, p68);
    end;
end;

function u31.GetAbilityAttribute(p69, p70, p71, p72) -- Line: 374
    local v73 = p69._abilitiesByInputName[p70];

    if not v73 then
        return p72;
    end;

    local SyncedState = v73:FindFirstChild("SyncedState");

    if not SyncedState then
        return p72;
    end;

    local Attribute = SyncedState:GetAttribute(p71);

    if Attribute == nil then
        return p72;
    end;

    return Attribute;
end;

function u31.GetAbilityAttributeChangedSignal(p74, p75, p76) -- Line: 384
    if not p74._abilityChangedEvents[p76] then
        p74._abilityChangedEvents[p76] = {};
    end;

    if p74._abilityChangedEvents[p76][p75] then
        return p74._abilityChangedEvents[p76][p75].Event;
    end;

    local BindableEvent = Instance.new("BindableEvent");
    p74._abilityChangedEvents[p76][p75] = BindableEvent;
    p74:_hookUpAbilityChangedEvent(p75, p76);

    return BindableEvent.Event;
end;

function u31.GetAbilityEnabled(p77, p78) -- Line: 400
    return p77:GetAbilityAttribute(p78, "Enabled", false);
end;

function u31.GetAbilityEnabledChangedSignal(p79, p80) -- Line: 404
    return p79:GetAbilityAttributeChangedSignal(p80, "Enabled");
end;

function u31.GetAbilitySuspended(p81, p82) -- Line: 408
    return p81:GetAbilityAttribute(p82, "Suspended", false);
end;

function u31.GetAbilitySuspendedChangedSignal(p83, p84) -- Line: 412
    return p83:GetAbilityAttributeChangedSignal(p84, "Suspended");
end;

function u31.GetAbilityActive(p85, p86) -- Line: 416
    return p85:GetAbilityAttribute(p86, "Active", false);
end;

function u31.GetAbilityActiveChangedSignal(p87, p88) -- Line: 420
    return p87:GetAbilityAttributeChangedSignal(p88, "Active");
end;

function u31.GetAbilityValid(p89, p90) -- Line: 424
    return p89:GetAbilityAttribute(p90, "IsValid", true);
end;

function u31.GetAbilityValidChangedSignal(p91, p92) -- Line: 428
    return p91:GetAbilityAttributeChangedSignal(p92, "IsValid");
end;

function u31.GetAbilities(p93) -- Line: 432
    local v94 = {};

    for i in p93._abilitiesByInputName do
        table.insert(v94, i);
    end;

    return v94;
end;

function u31.GetAbilitiesChangedSignal(p95) -- Line: 440
    return p95._abilitiesChangedEvent.Event;
end;

function u31.GetAbilityConfig(p96, p97) -- Line: 444
    local v98 = {
        Slot = -1
    };
    local v99 = p96._abilitiesByInputName[p97];

    if not v99 then
        return v98;
    end;

    local Attribute = v99:GetAttribute("ActionSlot");

    return Attribute and {
        Slot = tonumber(Attribute),
        ButtonAssetId = v99:GetAttribute("CustomIcon"),
        ButtonPressedAssetId = v99:GetAttribute("CustomIconActive"),
        ButtonInvalidAssetId = v99:GetAttribute("CustomIconInvalid")
    } or v98;
end;

function u31.destroy(p100) -- Line: 466
    if p100._characterAddedConnection then
        p100._characterAddedConnection:Disconnect();
        p100._characterAddedConnection = nil;
    end;

    if p100._evaluateStateMachineChangedConnection then
        p100._evaluateStateMachineChangedConnection:Disconnect();
        p100._evaluateStateMachineChangedConnection = nil;
    end;

    if p100._disconnectAbilitiesChanged then
        p100._disconnectAbilitiesChanged();
        p100._disconnectAbilitiesChanged = nil;
    end;

    for _, v in p100._abilityChangedConnections do
        for _, v2 in v do
            v2:Disconnect();
        end;
    end;

    p100._abilityChangedConnections = {};
end;

return u31;