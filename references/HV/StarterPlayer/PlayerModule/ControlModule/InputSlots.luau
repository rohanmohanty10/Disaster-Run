 

 

local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil");
game:GetService("StarterPlayer");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
UserSettings():GetService("UserGameSettings");
local UserInputService = game:GetService("UserInputService");
local InputReplication = require(script.Parent:WaitForChild("InputReplication"));
local u2 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface")).get(Players.LocalPlayer);
local UserFlag = v1.getUserFlag("UserPlayerScriptsPlayerControlState2");
local UserFlag2 = v1.getUserFlag("UserAbilitiesUserInterfaceB");
local UserFlag3 = v1.getUserFlag("UserPSUseBindToAnimation");
local u3 = UserFlag2 and "ControlState" or "PlayerControlState";
local u4 = {};
u4.__index = u4;
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local BindableEvent = Instance.new("BindableEvent");
local u9 = 0;
local BindableEvent2 = Instance.new("BindableEvent");

local function shallow_equal(p10, p11) -- Line: 33
    if p10 == p11 then
        return true;
    end;

    for i, v in pairs(p10) do
        if p11[i] ~= v then
            return false;
        end;
    end;

    for i, _ in pairs(p11) do
        if p10[i] == nil then
            return false;
        end;
    end;

    return true;
end;

local function findInSparseTable(p12, p13) -- Line: 40
    for i, v in pairs(p12) do
        if v == p13 then
            return i;
        end;
    end;

    return nil;
end;

function u4.GetNumOverflowSlots() -- Line: 49
    return 3;
end;

function u4.getOverflowScrollIndex() -- Line: 53
    -- upvalues: u9 (ref)
    return u9;
end;

function u4.setOverflowScrollIndex(p14) -- Line: 57
    -- upvalues: u9 (ref), u6 (ref), BindableEvent2 (copy)
    local v15 = u9;
    local math_min_ret = math.min(#u6 - 3, p14);
    u9 = math.max(0, math_min_ret);

    if u9 ~= v15 then
        BindableEvent2:Fire();
    end;
end;

function u4.getScrollIndexChangedEvent() -- Line: 65
    -- upvalues: BindableEvent2 (copy)
    return BindableEvent2.Event;
end;

function u4.setupSlotActions(u16, u17) -- Line: 69
    -- upvalues: UserFlag (copy), UserFlag3 (copy), RunService (copy), u2 (copy), InputReplication (copy), u5 (copy), u6 (ref), UserInputService (copy), u4 (copy), shallow_equal (copy), BindableEvent (copy), UserFlag2 (copy), u3 (copy), u7 (copy), u8 (copy), u9 (ref)
    local function getAbilityAction(p18) -- Line: 70
        -- upvalues: UserFlag (ref), u17 (copy), u16 (copy)
        if not p18 then
            return nil;
        end;

        local v19;

        if UserFlag and not u17 then
            v19 = script.Parent.Parent:FindFirstChild("InputContexts");
        else
            v19 = u16:FindFirstChild("InputContexts");
        end;

        if not v19 then
            return nil;
        end;

        local CharacterContext = v19:FindFirstChild("CharacterContext");

        if CharacterContext then
            return CharacterContext:FindFirstChild(p18 .. "Action");
        end;

        return nil;
    end;

    if not UserFlag then
        if UserFlag3 then
            RunService:BindToAnimation(function(p20) -- Line: 85
                -- upvalues: u2 (ref), InputReplication (ref), u16 (copy)
                if u2:isEnabled() then
                    InputReplication.FireCustomInputs(u16);
                    InputReplication.SendInputToCCLCharacter(u16);
                end;
            end, Enum.StepFrequency.Hz60);
        else
            RunService:BindToSimulation(function(p21) -- Line: 92
                -- upvalues: u2 (ref), InputReplication (ref), u16 (copy)
                if u2:isEnabled() then
                    InputReplication.FireCustomInputs(u16);
                    InputReplication.SendInputToCCLCharacter(u16);
                end;
            end, Enum.StepFrequency.Hz60);
        end;
    end;

    local u22 = {};

    local function updateSlotMap() -- Line: 103
        -- upvalues: u5 (ref), u6 (ref), u2 (ref), UserInputService (ref), u22 (copy), u4 (ref), shallow_equal (ref), BindableEvent (ref)
        local table_clone_ret = table.clone(u5);
        local table_clone_ret2 = table.clone(u6);
        local Abilities = u2:GetAbilities();
        local v23 = UserInputService.PreferredInput == Enum.PreferredInput.Touch and 7 or 11;

        for i, v in pairs(u5) do
            local v24 = i;
            local v25 = v;
            local v26 = nil;

            for i2, v2 in pairs(Abilities) do
                if v2 == v25 then
                    v26 = i2;
                    break;
                end;
            end;

            if not v26 or v23 < v24 then
                u5[v24] = nil;
            end;
        end;

        u6 = {};
        local v27 = {};

        for _, v in ipairs(Abilities) do
            local v28 = v;
            local v29 = nil;

            for i, v2 in pairs(u5) do
                if v2 == v28 then
                    v29 = i;
                    break;
                end;
            end;

            if not v29 then
                table.insert(v27, v28);
            end;
        end;

        for _, v in ipairs(v27) do
            local AbilityConfig = u2:GetAbilityConfig(v);

            if AbilityConfig then
                local v30 = tonumber(AbilityConfig.Slot);

                if v30 > 0 then
                    if u5[v30] or v30 > v23 then
                        table.insert(u6, v);
                    else
                        u5[v30] = v;
                    end;
                end;
            end;
        end;

        for _, v in ipairs(v27) do
            local AbilityConfig = u2:GetAbilityConfig(v);

            if AbilityConfig and tonumber(AbilityConfig.Slot) == 0 then
                local v31 = u22[v];

                if v31 and (v31 > 0 and (v31 <= v23 and not u5[v31])) then
                    u5[v31] = v;
                else
                    local v32 = v;
                    local v33 = -1;

                    for i = 1, v23 do
                        if not u5[i] then
                            v33 = i;
                            break;
                        end;

                        local _ = i;
                    end;

                    if v33 == -1 then
                        table.insert(u6, v32);
                    else
                        u5[v33] = v32;
                        u22[v32] = v33;
                    end;
                end;
            end;
        end;

        u4.setOverflowScrollIndex(u4.getOverflowScrollIndex());

        if not (shallow_equal(u5, table_clone_ret) and shallow_equal(u6, table_clone_ret2)) then
            BindableEvent:Fire();
        end;
    end;

    u2:GetAbilitiesChangedSignal():Connect(updateSlotMap);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(updateSlotMap);
    updateSlotMap();
    task.spawn(function() -- Line: 186
        -- upvalues: UserFlag2 (ref), u3 (ref), UserFlag (ref), u17 (copy), u16 (copy), u7 (ref), u5 (ref), getAbilityAction (copy), u8 (ref), u6 (ref), u9 (ref)
        local function UpdateAbilityInPCS(p34, p35, p36) -- Line: 187
            -- upvalues: UserFlag2 (ref), u3 (ref)
            local Character = p34.Character;

            if not Character then
                return;
            end;

            local v37;

            if UserFlag2 then
                v37 = Character:FindFirstChildOfClass(u3);
            else
                v37 = Character:FindFirstChild(u3);
            end;

            if not v37 then
                return;
            end;

            v37:UpdateFields({
                [p35] = p36
            });
        end;

        local v38;

        if UserFlag and not u17 then
            v38 = script.Parent.Parent:FindFirstChild("InputContexts");
        else
            v38 = u16:WaitForChild("InputContexts", (1 / 0));
        end;

        local CharacterContext = v38:WaitForChild("CharacterContext");

        for i = 1, 11 do
            local v39 = CharacterContext:WaitForChild("AbilityAction" .. tostring(i));
            u7[i] = v39;
            v39.StateChanged:Connect(function(p40) -- Line: 208
                -- upvalues: UserFlag (ref), u5 (ref), i (copy), UpdateAbilityInPCS (copy), u16 (ref), getAbilityAction (ref)
                if UserFlag then
                    if u5[i] ~= nil and u5[i] ~= "" then
                        UpdateAbilityInPCS(u16, u5[i], p40);
                    end;
                else
                    local v41 = getAbilityAction(u5[i]);
                    local v42 = v41 and v41:FindFirstChild("ScriptableBinding");

                    if v42 then
                        v42:Fire(p40);
                    end;
                end;
            end);
            local _ = i;
        end;

        if UserFlag then
            for i = 1, 3 do
                local v43 = CharacterContext:WaitForChild("OverflowAction" .. tostring(i));
                u8[i] = v43;
                v43.StateChanged:Connect(function(p44) -- Line: 229
                    -- upvalues: u6 (ref), i (copy), u9 (ref), UpdateAbilityInPCS (copy), u16 (ref)
                    local v45 = u6[i + u9];

                    if v45 ~= nil and v45 ~= "" then
                        UpdateAbilityInPCS(u16, v45, p44);
                    end;
                end);
                local _ = i;
            end;
        end;
    end);
end;

function u4.GetSlotMapChangedSignal() -- Line: 240
    -- upvalues: BindableEvent (copy)
    return BindableEvent.Event;
end;

function u4.GetSlotMap() -- Line: 244
    -- upvalues: u5 (copy)
    return u5;
end;

function u4.GetAbilitiesInOverflow() -- Line: 248
    -- upvalues: u6 (ref)
    return u6;
end;

function u4.GetActionInSlot(p46) -- Line: 252
    -- upvalues: u7 (copy)
    return u7[p46];
end;

function u4.GetOverflowAction(p47) -- Line: 256
    -- upvalues: u8 (copy)
    return u8[p47];
end;

return u4;