  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Stands = require(PathShortcuts.ReplicatedModules.Stands);
local Signal = require(PathShortcuts.KnitPath.Signal);
local StateHandler = require(PathShortcuts.ReplicatedModules.StateHandler);
local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local AbilityService = require(ReplicatedRoot.Services.Gameplay.AbilityService);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = Knit.CreateController({
    Name = "MoveInputController",
    MoveBinding = false,
    Active = true,
    Inputs = {},
    DPadDirectionChanged = Signal.new()
});
local Promise = require(Knit.Util.Promise);
local u2 = nil;
local u3 = nil;
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = 0;
local u14 = {
    [Enum.KeyCode.DPadLeft] = 1,
    [Enum.KeyCode.DPadRight] = 2,
    [Enum.KeyCode.DPadUp] = 4,
    [Enum.KeyCode.DPadDown] = 8
};
local u15 = {
    [Enum.KeyCode.DPadLeft] = 0,
    [Enum.KeyCode.DPadRight] = 1,
    [Enum.KeyCode.DPadUp] = 2,
    [Enum.KeyCode.DPadDown] = 3
};
require(game.ReplicatedStorage.ReplicatedModules.CustomKeybindMap);
local InputUtil = require(game.ReplicatedStorage.ReplicatedRoot.Libraries.Utility.InputUtil);
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = {};

local function DebugPrint(...) -- Line: 74
end;

function u1.GetMoveset(p20) -- Line: 82
    -- upvalues: LocalPlayer (copy), Stands (copy), AbilityService (copy), u7 (ref), u8 (ref)
    local v21 = Stands[LocalPlayer.Data.Ability.Value] or LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v22 = LocalPlayer.Data.Skin:GetAttribute("SkinName");
    local v23 = AbilityService.GetAbilityInfo(v21);

    if v23 and not v23.IsLegacy then
        local v24 = AbilityService.GetAbilityData({
            Ability = v21
        });

        if v24.Moveset then
            return v24.Moveset;
        end;
    end;

    local v25 = u7.GetStats(v21, v22);

    if v25 then
        return v25.Moveset;
    end;

    return u8.Movesets[v21];
end;

function u1.GetMovesInfo(p26, p27) -- Line: 100
    -- upvalues: AbilityService (copy), u7 (ref)
    local v28 = AbilityService.GetAbilityInfo(p27);

    if v28 and not v28.IsLegacy then
        local v29 = AbilityService.GetAbilityData({
            Ability = p27
        });

        if v29.Moveset and v29.Moveset.MovesInfo then
            return v29.Moveset.MovesInfo;
        end;
    end;

    local v30 = u7.GetStats(p27);

    return v30 and v30.Moveset and v30.Moveset.MovesInfo;
end;

function u1.GetNewMoveInputController(p31) -- Line: 116
    return require(game.ReplicatedStorage.ReplicatedRoot.Services.MoveInputController);
end;

function u1.IsLegacyMoveset(p32) -- Line: 120
    -- upvalues: LocalPlayer (copy), AbilityService (copy)
    local v33 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    LocalPlayer.Data.Skin:GetAttribute("SkinName");

    return AbilityService.GetAbilityInfo(v33).IsLegacy and true or false;
end;

function u1.IsMovesetValid(p34) -- Line: 129
    -- upvalues: Core (copy), u1 (copy)
    return Core.Flags.UseNewMovesetUI == false and true or u1:IsLegacyMoveset();
end;

function u1.GetHandleType(p35, p36) -- Line: 136
    -- upvalues: UserInputService (copy), u1 (copy)
    local v37 = p36 or UserInputService:GetLastInputType();

    return u1:IsLegacyMoveset() and 0 or ((v37 == Enum.UserInputType.Touch or v37 == Enum.UserInputType.Gamepad1) and 2 or 1);
end;

local u38 = nil;

function u1.GetEquippedMoves(p39) -- Line: 149
    -- upvalues: LocalPlayer (copy), u1 (copy), u7 (ref), u38 (ref), u18 (ref), UserInputService (copy), u19 (ref), u17 (ref), StateHandler (copy), u16 (ref)
    local v40 = {};
    local v41 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v42 = u1:GetMovesInfo(v41);
    u7.GetStats(v41);
    local v43 = u1:GetMoveset();
    local v44 = not (v43 and v43.DefaultMoveState) and "Universal" or v43.DefaultMoveState;
    local MovesInfo = u38.Moveset.MovesInfo;

    if not u18 then
        u18 = {};
    end;

    if not v42 then
        warn("NO MOVES INFO FOR", v41);

        return v40;
    end;

    local Character = LocalPlayer.Character;
    local v45 = UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1;
    local v46 = v45 == true and "c" or "k";
    local v47 = {};
    local v48 = {};
    local v49 = {};
    local v50 = 0;

    for i, v in u19 or {} do
        if i == "EquippedMoves" then
            for i2, v2 in v do
                if v2 == false then
                    v49[i2] = true;
                else
                    local v51 = v42[i2];
                    local v52 = v2[v46];

                    if not v51 and MovesInfo[i2] then
                        v51 = MovesInfo[i2];
                    end;

                    if v51 and v52 ~= nil then
                        local v53 = v52 > 10000;
                        local v54;

                        if v51.Airborne then
                            v54 = v48;
                        else
                            v54 = v47;
                        end;

                        local v55 = {};
                        local v56;

                        if v53 then
                            v56 = v52 - 10000;
                        else
                            v56 = v52;
                        end;

                        v55.Keybind = u17[v56];
                        v55.DPadDirection = not v2.c and 0 or v2.d;
                        v55.State = v51.State;
                        v55.Priority = StateHandler.GetStatePriority(Character, v51.State) or 0;
                        v55.Held = v53;
                        v55.Airborne = v51.Airborne;
                        v40[i2] = v55;

                        if not v54[v52] then
                            v54[v52] = {};
                        end;

                        v54[v52][v51.State] = true;

                        if not v51.Equipped and v51.MoveCapCount ~= false then
                            v50 = v50 + 1;
                        end;
                    end;
                end;
            end;
        end;
    end;

    for i, v in v42 do
        if not (v40[i] or v49[i]) then
            local v57;

            if v45 then
                v57 = v.DefaultConsoleKeybind;
            else
                v57 = v.DefaultKeybind;
            end;

            if v57 ~= nil and (v.Equipped ~= false and u16) then
                local v58;

                if v57 then
                    v58 = string.find(v57, "+") ~= nil;
                else
                    v58 = false;
                end;

                local v59 = v57:upper();
                local v60;

                if v58 then
                    v60 = u16[v59:sub(0, v59:len() - 1)] + 10000;
                else
                    v60 = u16[v59];
                end;

                if v60 ~= nil then
                    local v61;

                    if v.Airborne then
                        v61 = v48;
                    else
                        v61 = v47;
                    end;

                    if (not v61[v60] or not v61[v60][v.State] and (not v61[v60][v44] or (v43 and v43.Groups and (v43.Groups[v44].Priority or 0) or 0) ~= (v.State and (v43.Groups[v.State].Priority or 0) or 0))) and (v.Equipped or v.Unlocked and v50 < 7) then
                        local v62;

                        if v57 then
                            v62 = string.find(v57, "+", 1, true) ~= nil;
                        else
                            v62 = false;
                        end;

                        v40[i] = {
                            Keybind = v57:upper():gsub("%+$", ""),
                            DPadDirection = not v45 and 0 or v.DefaultDPadDirection,
                            State = v.State,
                            Priority = StateHandler.GetStatePriority(Character, v.State) or 0,
                            Held = v62,
                            Airborne = v.Airborne
                        };

                        if not v61[v60] then
                            v61[v60] = {};
                        end;

                        v61[v60][v.State] = true;

                        if not v.Equipped and v.MoveCapCount ~= false then
                            v50 = v50 + 1;
                        end;
                    end;
                end;
            end;
        end;
    end;

    table.clear(u18);

    for i, v in v40 do
        local v63 = "";

        if v.Airborne then
            v63 = v63 .. "^";
        end;

        if v.Held then
            v63 = v63 .. "+";
        end;

        u18[v.Keybind .. v63] = i;
    end;

    return v40;
end;

function u1.ResolveInput(p64, p65) -- Line: 296
    local v66 = p65.UserInputType == Enum.UserInputType.Gamepad1 and 1 or 0;

    return typeof(p65) == "string" and {
        Platform = v66,
        Input = p65
    } or (p65.KeyCode and p65.KeyCode ~= Enum.KeyCode.Unknown and {
        Platform = v66,
        Input = p65.KeyCode.Name
    } or {
        Platform = v66,
        Input = p65.UserInputType.Name
    });
end;

function u1.IsMultiKeyDown(p67, p68) -- Line: 317
    -- upvalues: u1 (copy), UserInputService (copy)
    if not p68.KeyCode or p68.KeyCode == Enum.KeyCode.Unknown then
        return;
    end;

    local v69 = u1:GetMoveset();

    if type(v69.Moves) ~= "table" then
        return;
    end;

    for i, _ in pairs(v69.Moves) do
        local v70 = string.split(i, "+");

        if v70 and (#v70 > 1 and table.find(v70, p68.KeyCode.Name)) then
            for _, v in pairs(v70) do
                if not UserInputService:IsKeyDown(Enum.KeyCode[v]) then
                    return false;
                end;
            end;

            return i;
        end;
    end;
end;

function u1.GetDPadDirectionByte(p71) -- Line: 341
    -- upvalues: u13 (ref)
    return u13;
end;

local u72 = {};

local function CanUseClientMove(p73) -- Line: 346
    -- upvalues: u72 (copy)
    if p73:GetAttribute("TrueURF") then
        return true;
    end;

    for i in u72 do
        if not i.AllowClientStacking then
            return false;
        end;
    end;

    return true;
end;

u1.NO_INPUT = "NO_INPUT";

function u1.DeserializeInput(p74, p75) -- Line: 357
    -- upvalues: u2 (ref)
    local v76 = nil;
    local v77 = nil;

    if type(p75) == "buffer" then
        if buffer.len(p75) > 512 then
            return;
        end;

        local v78 = 0;
        v76 = buffer.readu8(p75, v78);
        local v79 = v78 + 1;

        if v76 == 1 then
            v77 = buffer.readu8(p75, v79);
            v79 = v79 + 1;
        end;

        p75 = buffer.readstring(p75, v79, buffer.len(p75) - v79);
    elseif type(p75) ~= "string" then
        p75 = u2.NO_INPUT;
    end;

    return {
        Input = p75,
        Platform = v76,
        DPadDirection = v77
    };
end;

function u1.FireInput(p80, p81, ...) -- Line: 385
    -- upvalues: LocalPlayer (copy), u1 (copy), UserInputService (copy), u10 (ref), u7 (ref), StateHandler (copy), u2 (ref), InputUtil (copy), Promise (copy), u4 (ref), u72 (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v82 = Character.Humanoid.FloorMaterial == Enum.Material.Air;
    local v83 = u1:GetMoveset();
    local v84 = u1:GetEquippedMoves();
    u1:GetNewMoveInputController();
    local v85 = u1:GetHandleType();

    if not v83 then
        return;
    end;

    local v86 = u1:DeserializeInput(p81);

    if v86 == nil then
        return;
    end;

    local Input = v86.Input;
    local v87 = UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 and 1 or 0;
    local v88 = u1:GetDPadDirectionByte();
    u10:GetContainer(Character or LocalPlayer);
    local v89 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v90 = LocalPlayer.Data.Skin:GetAttribute("SkinName");
    local v91 = u7.GetStats(v89, v90) or u7.GetStats(v89);

    if not v91 then
        warn(v89, "stats not found");

        return;
    end;

    local v92;

    if type(v83.Moves) == "table" then
        v92 = v83.Moves;
    else
        v92 = false;
    end;

    local v93;

    if v92 then
        v93 = v92[Input];
    else
        v93 = nil;
    end;

    local v94 = Input:upper();
    local v95 = {};
    local v96 = -1;

    for i, v in v84 do
        if v.Airborne then
            v95[v.Keybind] = i;
        end;
    end;

    for i, v in v84 do
        local Held = v.Held;
        local Priority = v.Priority;

        if not v.Airborne and StateHandler.IsStateActive(LocalPlayer.Character, (`{i}_Move`)) ~= false then
            local v97 = StateHandler.IsStateActive(LocalPlayer.Character, v.State) or StateHandler.IsStateActive(LocalPlayer.Character, (`{i}_Move`));
            local v98;

            if Held then
                v98 = v94:sub(0, v94:len() - 1) or v94;
            else
                v98 = v94;
            end;

            if v98 == v.Keybind and (v87 ~= 1 or v88 == v.DPadDirection) and (v96 < Priority and v97) then
                v93 = i;
                v96 = Priority;
            end;
        end;
    end;

    if v82 and v95[v94] then
        v93 = v95[v94];
        Input = Input .. "^";
    end;

    local v99 = buffer.create((v87 == 1 and 2 or 1) + #Input);
    buffer.writeu8(v99, 0, v87);

    if v87 == 1 then
        buffer.writeu8(v99, 1, v88);
        buffer.writestring(v99, 2, Input);
    else
        buffer.writestring(v99, 1, Input);
    end;

    if v85 == 2 or v85 == 1 then
        u2:FireInput(v99):catch(warn);
        local v100 = InputUtil.FromLegacyString(Input);

        if v85 == 2 and v100.PrefixString ~= "START-" then
            local _ = {
                KeyCode = v100.KeyCode,
                UserInputState = v100.UserInputState == Enum.UserInputState.None and Enum.UserInputState.Begin or v100.UserInputState,
                UserInputType = v100.UserInputType,
                Held = v100.Held or false
            };
            local v101 = u1:GetNewMoveInputController();
            task.spawn(v101.HandleInput, {
                GameProcessed = false,
                Input = {
                    KeyCode = v100.KeyCode,
                    UserInputState = v100.UserInputState == Enum.UserInputState.None and Enum.UserInputState.Begin or v100.UserInputState,
                    UserInputType = v100.UserInputType,
                    Held = v100.Held or false
                }
            });
        end;

        return;
    end;

    local u102 = v91.Stats[v93];
    local u103;

    if u102 and typeof(u102.Cooldown) == "table" then
        u103 = u102.Cooldown.Name or v93;
    else
        u103 = v93;
    end;

    local function SetCooldown() -- Line: 497
        -- upvalues: Promise (ref), u4 (ref), Character (copy), u103 (copy), u102 (copy)
        Promise.try(u4.CreateCooldown, Character, {
            Name = u103,
            Time = typeof(u102.Cooldown) == "table" and u102.Cooldown.Time or u102.Cooldown
        }):catch(warn);
    end;

    if u102 and u102.ClientActionable then
        if not u4.IsActionable(Character, u102.ClientActionable) then
            return;
        end;

        if u102.ClientActionable.Cooldown ~= false and u4.GetCooldown(Character, u103) then
            return;
        end;

        if typeof(u102.Cooldown) == "table" and not (u102.Cooldown.AfterMove or (u102.Cooldown.Manual or u102.Cooldown.ManualClient)) or typeof(u102.Cooldown) == "number" then
            local v104;

            if Character:GetAttribute("TrueURF") then
                v104 = true;
            else
                v104 = true;

                for i in u72 do
                    if not i.AllowClientStacking then
                        v104 = false;
                        break;
                    end;
                end;
            end;

            if v104 ~= true then
                return;
            end;

            SetCooldown();
        end;
    end;

    if not (u102 and u102.Invoke) then
        local u105 = false;
        local u106, u107;

        if u102 and not u102.Invoke then
            u72[u102] = true;

            u106 = function() -- Line: 564, Name: f
                -- upvalues: u105 (ref), u72 (ref), u102 (copy)
                if u105 then
                    return;
                end;

                u105 = true;
                u72[u102] = nil;
            end;

            u107 = task.delay(3, u106);
        else
            u107 = nil;
            u106 = nil;
        end;

        if u102 and (u102.Actionable and u102.Actionable.InterruptQuickstep ~= false) then
            u4.InterruptQuickstep();
        end;

        local v108 = u2:FireInput(v99):catch(warn);

        if u107 then
            v108:finally(function() -- Line: 576
                -- upvalues: u105 (ref), u107 (ref), u106 (ref)
                if u105 then
                    return;
                end;

                if u107 then
                    task.cancel(u107);
                end;

                u106();
            end);
        end;

        return;
    end;

    if not u102.OmitMovestackCheck then
        local v109;

        if Character:GetAttribute("TrueURF") then
            v109 = true;
        else
            v109 = true;

            for i in u72 do
                if not i.AllowClientStacking then
                    v109 = false;
                    break;
                end;
            end;
        end;

        if v109 ~= true then
            return;
        end;
    end;

    if u102.Actionable and u102.Actionable.InterruptQuickstep ~= false then
        u4.InterruptQuickstep();
    end;

    if u102.QueryMove then
        u72[u102] = true;
    end;

    Promise.try(u102.Invoke, {
        Player = LocalPlayer,
        Character = Character,
        Input = Input,
        RawInput = v99,
        IsConsole = v87 == 1,
        Stats = u102,
        MoveName = v93,
        Arguments = { ... }
    }):finally(function() -- Line: 549
        -- upvalues: u102 (copy), SetCooldown (copy), u72 (ref)
        if typeof(u102.Cooldown) == "table" and (u102.Cooldown.AfterMove and (not u102.Cooldown.Manual and (not u102.Cooldown.ManualClient and u102.Cooldown.Client ~= false))) then
            SetCooldown();

            if u102.QueryMove then
                u72[u102] = nil;
            end;
        end;
    end):catch(warn);
end;

function u1.Input(p110, p111, p112) -- Line: 586
    -- upvalues: u1 (copy), u2 (ref), u18 (ref), u9 (ref), UserInputService (copy), u5 (ref), DebugPrint (copy), u12 (ref), RunService (copy)
    if u1.MoveBinding then
        return;
    end;

    local v113 = u1:GetMoveset();

    if not v113 then
        return;
    end;

    local v114 = u1:GetHandleType(p111.UserInputType);

    local function FireRawInput(p115) -- Line: 594
        -- upvalues: u2 (ref)
        u2:FireRawInput(p115);
    end;

    local function FireInput(...) -- Line: 598
        -- upvalues: u2 (ref), u1 (ref)
        u2:FireRawInput((...));
        u1:FireInput(...);
    end;

    local v116 = u1:GetEquippedMoves();
    local Input = u1:ResolveInput(p111).Input;
    local v117;

    if type(v113.Moves) == "table" then
        v117 = v113.Moves;
    else
        v117 = false;
    end;

    if v117 then
        table.clear(u18);
    end;

    if p112 == "Began" then
        u9:AddKey(Input);
        u1.Inputs[Input] = true;
        local v118 = u1:IsMultiKeyDown(p111);

        if v118 then
            FireInput(v118);
        end;

        u1:GetDPadDirectionByte();
        local v119 = string.upper(Input);
        local _ = u18[v119];
        local v120 = u18[v119 .. "+"];

        if v120 and UserInputService:GetLastInputType() ~= Enum.UserInputType.Touch then
            for i, v in v116 do
                if v.Held and (v.Keybind and v.Keybind == v119) then
                    local v121 = u5:GetItem(v.State or "Universal", i);

                    if not v121 or v121.Visible and (v121.MoveVisible == nil or v121.MoveVisible ~= false) then
                        v120 = i;
                        break;
                    end;

                    DebugPrint("Skipping", i);
                end;
            end;

            DebugPrint("Resolved held move", v120);
            local v122 = os.clock();
            local v123 = math.max(u12.Value or 0.3, 0.01);
            local v124 = v116[v120];

            if v124 then
                v124 = u5:GetItem(v124.State or "Universal", v120);
            end;

            while v124 and (v124.Visible and (os.clock() - v122 < v123 and (v120 and u1.Inputs[Input]))) do
                RunService.Heartbeat:Wait();
            end;

            if v123 <= os.clock() - v122 then
                u1.Inputs[Input .. "+"] = true;

                if v114 ~= 1 then
                    FireInput(Input .. "+");
                end;
            else
                FireInput(Input);
            end;
        else
            FireInput(Input);
        end;

        if not v117 then
            return;
        end;

        if v117[Input] then
            FireInput(Input);
        end;

        if v117["START-" .. Input] then
            FireInput("START-" .. Input);
        end;
    elseif p112 == "Changed" then
        if u18[Input:upper()] or v117 and v117["CHANGE-" .. Input] then
            FireInput("CHANGE-" .. Input);
        end;
    elseif p112 == "Ended" then
        u9:RemoveKey(Input);
        u1.Inputs[Input] = nil;
        u1.Inputs[Input .. "+"] = nil;

        if u18[Input:upper()] or (u18[Input:upper() .. "+"] or v117 and v117[Input]) then
            FireInput("END-" .. Input);
            FireInput("END-" .. Input .. "+");
        end;
    end;
end;

local u125 = {
    [Enum.UserInputType.MouseMovement] = true,
    [Enum.UserInputType.Focus] = true
};

function u1.InputBegan(p126, p127, p128) -- Line: 712
    -- upvalues: u14 (copy), u11 (ref), u13 (ref), u15 (copy), u1 (copy), LocalPlayer (copy), u125 (copy)
    if p128 then
        return;
    end;

    if p127.UserInputType == Enum.UserInputType.Gamepad1 and (u14[p127.KeyCode] ~= nil and u11.DPadAsBinds.Value ~= true) then
        u13 = bit32.replace(u13, p127.UserInputState == Enum.UserInputState.Begin and 1 or 0, u15[p127.KeyCode]);
        u1.DPadDirectionChanged:Fire(u13);
    end;

    if LocalPlayer.Settings.MovesInMenu.Value ~= true and u1.Active ~= true then
        return;
    end;

    if u125[p127.UserInputType] then
        return;
    end;

    u1:Input(p127, "Began");
end;

local u129 = {
    [Enum.UserInputType.MouseMovement] = true,
    [Enum.UserInputType.Accelerometer] = true,
    [Enum.UserInputType.TextInput] = true,
    [Enum.UserInputType.Focus] = true
};

function u1.InputChanged(p130, p131, p132) -- Line: 730
    -- upvalues: u129 (copy), u1 (copy)
    if p132 or u129[p131.UserInputType] then
        return;
    end;

    u1:Input(p131, "Changed");
end;

function u1.InputEnded(p133, p134, p135) -- Line: 735
    -- upvalues: u14 (copy), u13 (ref), u15 (copy), u1 (copy)
    if p135 then
        return;
    end;

    if p134.UserInputType == Enum.UserInputType.Gamepad1 and u14[p134.KeyCode] ~= nil then
        u13 = bit32.replace(u13, p134.UserInputState == Enum.UserInputState.Begin and 1 or 0, u15[p134.KeyCode]);
        u1.DPadDirectionChanged:Fire(u13);
    end;

    u1:Input(p134, "Ended");
end;

function u1.KnitStart(p136) -- Line: 745
    -- upvalues: u2 (ref), Knit (copy), u4 (ref), u3 (ref), u10 (ref), u6 (ref), PathShortcuts (copy), u7 (ref), u8 (ref), u9 (ref), u5 (ref), u38 (ref), u16 (ref), u17 (ref), u11 (ref), LocalPlayer (copy), u12 (ref), UserInputService (copy), u1 (copy), u19 (ref)
    u2 = Knit.GetService("MoveInputService");
    u4 = Knit.GetController("CombatController");
    u3 = Knit.GetService("MoveService");
    u10 = require(Knit.ReplicatedModules.Independent.TagService);
    u6 = require(PathShortcuts.StandsModule);
    u7 = require(PathShortcuts.ReplicatedModules.StatsHandler);
    u8 = require(PathShortcuts.ReplicatedModules.Movesets);
    u9 = require(PathShortcuts.ReplicatedStorage.ClientModules.InputTracker);
    u5 = require(PathShortcuts.ClientControllers.MoveIndicatorController).GetSingleton();
    u38 = u7.GetStats("SubPowers");
    u16 = u3:GetKeybindsMap():expect();
    u17 = {};

    for i, v in u16 do
        u17[v] = i;
    end;

    u11 = LocalPlayer:WaitForChild("Settings");
    u12 = u11:WaitForChild("HeldFidelity");
    UserInputService.InputBegan:Connect(function(...) -- Line: 770
        -- upvalues: u1 (ref)
        u1:InputBegan(...);
    end);
    UserInputService.InputChanged:Connect(function(...) -- Line: 774
        -- upvalues: u1 (ref)
        u1:InputChanged(...);
    end);
    UserInputService.InputEnded:Connect(function(...) -- Line: 778
        -- upvalues: u1 (ref)
        u1:InputEnded(...);
    end);
    u3.MovesetUpdated:Connect(function(p137) -- Line: 782
        -- upvalues: u19 (ref)
        u19 = p137;
    end);
    UserInputService.LastInputTypeChanged:Connect(function(p138) -- Line: 786
        -- upvalues: u2 (ref)
        u2.UserInputTypeChanged:Fire(p138);
    end);
    u2.UserInputTypeChanged:Fire(UserInputService:GetLastInputType());
end;

return u1;