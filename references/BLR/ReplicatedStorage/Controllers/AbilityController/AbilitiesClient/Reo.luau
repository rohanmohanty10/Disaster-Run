  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local LegacyFunctions = require(ReplicatedStorage.Controllers.AbilityController.LegacyFunctions);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local LocalPlayer = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local u1 = {
    Copy = require(script.Copy),
    OppressivePass = require(script.OppressivePass),
    CrossElasticoNutmeg = require(script.CrossElasticoNutmeg),
    TrivelaShot = require(script.Trivela),
    Camouflage = require(script.Camouflage),
    NeoGyroShot = require(script.Awakening.GyroShot),
    NeoDragonDrive = require(script.Awakening.DragonDrive),
    ChameleonVolley = require(script.Awakening.ChameleonVolley),
    PhysicalPressure = require(script.PhysicalPressure),
    ChameleonDefense = require(script.ChameleonDefense),
    CloseQuarterDribble = require(script.CloseQuarterDribble),
    LobPass = require(script.ReoLobPass),
    MetaDefense = require(script.Awakening.MetaDefense),
    SerpentRedirect = require(script.Awakening.Redirect),
    TapLift = require(script.Awakening.TapLift)
};
local v2 = {};

local function convertCopyAbility(p3, u4) -- Line: 45
    -- upvalues: interface (copy)
    local table_clone_ret = table.clone(p3);

    local function onUse(p5, ...) -- Line: 58
        -- upvalues: interface (ref), u4 (copy)
        local v6 = interface.CopySlot or 1;
        local v7 = ({ "AbilityOne", "AbilityTwo", "AbilityThree" })[v6];

        if interface.ExecutingCopiedMove and coroutine.status(interface.ExecutingCopiedMove) ~= "dead" then
            return;
        end;

        if tick() < interface[v7] then
            return;
        end;

        local table_clone_ret2 = table.clone(interface);
        interface.AbilityOne = -1;
        interface.AbilityTwo = -1;
        interface.AbilityThree = -1;
        interface.ExecutingCopiedMove = coroutine.create(p5);
        coroutine.resume(interface.ExecutingCopiedMove, ...);

        if u4 then
            u4();
        end;

        for i, v in { "AbilityOne", "AbilityTwo", "AbilityThree" } do
            if i ~= v6 then
                interface[v] = table_clone_ret2[v];
            end;
        end;
    end;

    local legacyFn = table_clone_ret.legacyFn;

    if legacyFn then
        function table_clone_ret.legacyFn(...) -- Line: 91
            -- upvalues: onUse (copy), legacyFn (copy)
            onUse(legacyFn, ...);
        end;
    end;

    local fn = table_clone_ret.fn;

    if fn then
        function table_clone_ret.fn(...) -- Line: 98
            -- upvalues: onUse (copy), fn (copy)
            onUse(fn, ...);
        end;
    end;

    return table_clone_ret;
end;

function v2.getKit(p8: boolean, p9: boolean) -- Line: 106
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), PlayerData (copy), countStyleMastery (copy), interface (copy), convertCopyAbility (copy), LegacyFunctions (copy), u1 (copy)
    local Character, _, v10, v11 = AbilityUtils.getCharacter();
    local v12 = {};
    local v13 = ((LocalPlayer.Team.Name == "Away" and workspace.PenaltyArea.Away or workspace.PenaltyArea.Home).Position - Character.HumanoidRootPart.Position).Magnitude > 180;
    local v14, v15;

    if p9 and PlayerData.Data then
        v14 = countStyleMastery(PlayerData.Data, "Reo");
        v15 = PlayerData.Data.DisabledMasteryLevels.Reo;
    else
        v14 = 0;
        v15 = {};
    end;

    interface.CopySlot = 1;

    if interface.CopiedMoveIndex then
        local Kit = interface:GetKit(interface.CopiedStyle, p8);

        if Kit[interface.CopiedMoveIndex] then
            v12[1] = convertCopyAbility(Kit[interface.CopiedMoveIndex], function() -- Line: 135
                -- upvalues: interface (ref), LegacyFunctions (ref)
                if not interface.ClearCopyTask then
                    interface.ClearCopyTask = task.delay(5, function() -- Line: 137
                        -- upvalues: LegacyFunctions (ref), interface (ref)
                        LegacyFunctions.clearCopy(interface);
                    end);
                end;
            end);
        else
            interface.CopiedMoveIndex = nil;
        end;
    end;

    if not v12[1] then
        if interface.CopyingStyle then
            local CopyingStyle = interface.CopyingStyle;
            local v16 = {};

            for i, v in interface:GetKit(interface.CopyingStyle, p8) do
                v16[i] = {
                    display = v.display,

                    fn = function() -- Line: 154, Name: fn
                        -- upvalues: interface (ref), i (copy), CopyingStyle (copy)
                        interface._copy_tag = nil;
                        interface.CopyingStyle = nil;
                        interface.CopiedMoveIndex = i;
                        interface.CopiedStyle = CopyingStyle;
                        print("write copy", i, CopyingStyle);
                        interface:FireServerAbility("Chameleon", {
                            VFX = "Copy"
                        });
                    end
                };
            end;

            return v16;
        end;

        v12[1] = {
            display = p8 and "Master Copy" or "99% Copy",
            fn = u1.Copy
        };
    end;

    if v13 then
        if v11.HasBall.Value then
            if interface.TrivelaShot and (v14 >= 3 and not v15[3]) then
                v12[2] = {
                    display = "Trivela Shot",
                    legacyFn = u1.TrivelaShot
                };
            else
                v12[2] = {
                    display = "Cross Elastico Nutmeg",
                    fn = u1.CrossElasticoNutmeg
                };
            end;
        else
            v12[2] = {
                display = "Camouflage",
                legacyFn = u1.Camouflage
            };
        end;
    elseif v11.HasBall.Value then
        if interface.LobPass and (v14 >= 3 and not v15[3]) then
            v12[2] = {
                display = "Lob Pass",
                legacyFn = u1.LobPass
            };
        else
            v12[2] = {
                display = "Close Quarter Dribble",
                legacyFn = u1.CloseQuarterDribble
            };
        end;
    else
        v12[2] = {
            display = "Chameleon Stealthy Steps",
            legacyFn = u1.Camouflage
        };
    end;

    if v14 >= 1 and not (v15[1] or p8) then
        if v13 then
            v12[3] = {
                display = "Oppressive Pass",
                fn = u1.OppressivePass
            };
        else
            v12[3] = {
                display = "Physical Pressure",
                fn = u1.PhysicalPressure
            };
        end;
    end;

    if v10 and (v14 >= 2 and not (v15[2] or v10:GetState() ~= Enum.HumanoidStateType.Freefall and (v10:GetState() ~= Enum.HumanoidStateType.Jumping and (v14 >= 1 and not v15[1])))) and not ((v14 < 1 or (v15[1] or v13)) and (v14 >= 1 and not v15[1])) then
        v12[3] = {
            display = "Chameleon Defense",
            legacyFn = u1.ChameleonDefense
        };
    end;

    if p8 then
        if v13 then
            v12[2] = {
                display = "Chameleon Volley",
                fn = u1.ChameleonVolley
            };

            if v11.HasBall.Value then
                v12[3] = {
                    display = "Neo Gyro Shot",
                    fn = u1.NeoGyroShot
                };
            else
                v12[3] = {
                    display = "Neo Dragon Drive",
                    fn = u1.NeoDragonDrive
                };
            end;
        else
            if interface.MetaDefenseUsed then
                if interface.LobPass then
                    v12[2] = {
                        display = "Lob Pass",
                        legacyFn = u1.LobPass
                    };
                else
                    v12[2] = {
                        display = "Close Quarter Dribble",
                        legacyFn = u1.CloseQuarterDribble
                    };
                end;
            else
                v12[2] = {
                    display = "Meta Defense",
                    fn = u1.MetaDefense
                };
            end;

            if v11.HasBall.Value then
                v12[3] = {
                    display = "Neo Tap Lift",
                    fn = u1.TapLift
                };
            else
                v12[3] = {
                    display = "Neo Serpent Redirect",
                    fn = u1.SerpentRedirect
                };
            end;
        end;
    end;

    for _, v in v12 do
        v.legacyId = v.display;
    end;

    return v12;
end;

return v2;