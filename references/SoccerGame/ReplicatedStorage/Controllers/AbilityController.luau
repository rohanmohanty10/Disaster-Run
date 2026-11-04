  

game:GetService("UserInputService");
local Teams = game:GetService("Teams");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Trove);
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local ChemicalReactionController = require(ReplicatedStorage.Controllers.ChemicalReactionController);
local getCurrentStyle = require(ReplicatedStorage.ClientModules.getCurrentStyle);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
require(ReplicatedStorage.Shared.repr);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local environment = require(ReplicatedStorage.Shared.environment);
local Popup = require(ReplicatedStorage.Shared.Popup);
local script_interface = require(script.interface);
local script_SwapAbilityNames = require(script.SwapAbilityNames);
local script_LegacyFunctions = require(script.LegacyFunctions);
local u1 = nil;
local LocalPlayer = Players.LocalPlayer;
local _ = ClientGlobals.PlayerData;
local UserInput = ReplicatedFirst.UserInput;
local Abilities = LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities;
local u2 = { Abilities["1"], Abilities["2"], Abilities["3"] };
local u3 = {
    ["1"] = "AbilityOne",
    ["2"] = "AbilityTwo",
    ["3"] = "AbilityThree"
};
local u4 = {};
local u5 = {};
local u6 = {
    Name = "AbilityController",
    AbilitiesModule = nil
};

local function convertLegacyAbility(p7) -- Line: 80
    return p7 ~= nil and {
        display = p7[2],
        cutscene = p7.Cutscene == true,
        legacyId = p7[3],
        legacyFn = p7[1]
    } or nil;
end;

local function getKit() -- Line: 96
    -- upvalues: getCurrentStyle (copy), u4 (copy), StatesController (copy), u6 (copy), LocalPlayer (copy), script_interface (copy), RunService (copy)
    local v8 = getCurrentStyle();
    local v9 = u4[v8];

    if not v9 then
        warn((`no style kit for style "{v8}"`));

        return {};
    end;

    local v10 = v9(StatesController:IsAwakened(), u6.legacy);

    if LocalPlayer:GetAttribute("GrantedTwoStepsBehindShot") and script_interface.UngroupedAbilities.TwoStepsBehindShot then
        v10[3] = {
            display = "Two Steps Behind",
            legacyId = "Two Steps Behind Shot",
            fn = script_interface.UngroupedAbilities.TwoStepsBehindShot
        };
    end;

    if LocalPlayer:GetAttribute("GrantedFastShot") then
        if script_interface.UngroupedAbilities.FastShot then
            v10[3] = {
                display = "Fast Shot",
                legacyId = "Fast Shot",
                fn = script_interface.UngroupedAbilities.FastShot
            };
        elseif RunService:IsStudio() and not u6._fastShotMissingWarned then
            u6._fastShotMissingWarned = true;
            warn("[FastShot][getKit] GrantedFastShot is set but UngroupedAbilities.FastShot is missing — the client module didn\'t load!");
        end;
    end;

    if LocalPlayer:GetAttribute("GrantedNikoLionShot") then
        if script_interface.UngroupedAbilities.NikoLionShot then
            v10[3] = {
                display = "Lion Shot",
                legacyId = "Lion Shot",
                fn = script_interface.UngroupedAbilities.NikoLionShot
            };
        elseif RunService:IsStudio() and not u6._nikoLionShotMissingWarned then
            u6._nikoLionShotMissingWarned = true;
            warn("[NikoLionShot][getKit] grant is set but the client module did not load");
        end;
    end;

    local v11 = v8 == "Kaiser" and LocalPlayer:GetAttribute("CRRequest") == "KaiserXNess" and script_interface.UngroupedAbilities.KaiserXNessReceiver;

    if v11 then
        v10[1] = {
            display = "Kaiser Impact",
            legacyId = "KaiserXNessReceiver",
            legacyFn = v11
        };
    end;

    local v12 = v8 == "Kaiser" and LocalPlayer:GetAttribute("CRRequest") == "KaiserKiyoraCR" and script_interface.UngroupedAbilities.KaiserVolley;

    if v12 then
        v10[3] = {
            display = "Kaiser Magnus",
            legacyId = "KaiserVolley",
            legacyFn = v12
        };
    end;

    for i, v in v10 do
        if type(v.fn) ~= "function" and not v.legacyFn then
            warn((`move {i} / {v.legacyId} has no fn`));
        end;
    end;

    return v10;
end;

local function canUseAbility(p13) -- Line: 170
    -- upvalues: AbilityUtils (copy), StatesController (copy), ReplicatedStorage (copy), CameraController (copy), getCurrentStyle (copy), LocalPlayer (copy), Teams (copy), environment (copy), Popup (copy)
    local Character, _, _, v14 = AbilityUtils.getCharacter();

    if StatesController.States.AllowedAbility and not table.find(StatesController.States.AllowedAbility, p13) then
        return;
    end;

    if ReplicatedStorage.GameValues.AwakeningCutscene.Value then
        return;
    end;

    if Character.Values.InCutscene.Value then
        return;
    end;

    if CameraController.Cutscene then
        return;
    end;

    if Character.IsRagdoll.Value then
        return;
    end;

    if v14.Dribbling.Value then
        return;
    end;

    if v14.Sliding.Value and (not v14.Diving.Value or getCurrentStyle() ~= "Gagamaru") then
        return;
    end;

    if StatesController.States.Ability and not ((not StatesController.States.AllowedAbility or table.find(StatesController.States.AllowedAbility, p13)) and StatesController.States.AllowedAbility) then
        return;
    end;

    if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
        return;
    end;

    if ReplicatedStorage.GameValues.Scored.Value then
        return;
    end;

    if LocalPlayer.Team == Teams.Visitor then
        return;
    end;

    if not environment.config.AbilitiesDisabled then
        local Attribute = workspace:GetAttribute("KickoffAbilityBlocked");

        if Attribute == true then
            Popup.Popup(LocalPlayer, "Kickoff has not ended!");

            return false;
        end;

        local ServerTimeNow = workspace:GetServerTimeNow();

        if type(Attribute) ~= "number" or ServerTimeNow >= Attribute then
            return true;
        end;

        Popup.Popup(LocalPlayer, (`Abilities will become usable in {math.floor((Attribute - ServerTimeNow) * 10) / 10}s`));

        return false;
    end;
end;

function u6.CanActivateAbility(p15) -- Line: 202
    -- upvalues: canUseAbility (copy)
    return canUseAbility();
end;

function u6.LoadAbilities(p16, p17) -- Line: 206
    -- upvalues: u4 (copy), script_SwapAbilityNames (copy), script_interface (copy), LocalPlayer (copy), u6 (copy)
    table.clear(u4);
    local u18 = require(p17);

    local function loadLegacyStyle(u19: string) -- Line: 211
        -- upvalues: u18 (copy), u4 (ref), script_SwapAbilityNames (ref), script_interface (ref), LocalPlayer (ref)
        local u20 = {};
        local BaseC = u18[u19].BaseC;
        u20.BaseC = BaseC ~= nil and {
            display = BaseC[2],
            cutscene = BaseC.Cutscene == true,
            legacyId = BaseC[3],
            legacyFn = BaseC[1]
        } or nil;
        local BaseV = u18[u19].BaseV;
        u20.BaseV = BaseV ~= nil and {
            display = BaseV[2],
            cutscene = BaseV.Cutscene == true,
            legacyId = BaseV[3],
            legacyFn = BaseV[1]
        } or nil;
        local BaseB = u18[u19].BaseB;
        u20.BaseB = BaseB ~= nil and {
            display = BaseB[2],
            cutscene = BaseB.Cutscene == true,
            legacyId = BaseB[3],
            legacyFn = BaseB[1]
        } or nil;
        local AwkC = u18[u19].AwkC;
        u20.AwkC = AwkC ~= nil and {
            display = AwkC[2],
            cutscene = AwkC.Cutscene == true,
            legacyId = AwkC[3],
            legacyFn = AwkC[1]
        } or nil;
        local AwkV = u18[u19].AwkV;
        u20.AwkV = AwkV ~= nil and {
            display = AwkV[2],
            cutscene = AwkV.Cutscene == true,
            legacyId = AwkV[3],
            legacyFn = AwkV[1]
        } or nil;
        local AwkB = u18[u19].AwkB;
        u20.AwkB = AwkB ~= nil and {
            display = AwkB[2],
            cutscene = AwkB.Cutscene == true,
            legacyId = AwkB[3],
            legacyFn = AwkB[1]
        } or nil;
        local u21 = {};

        u4[u19] = function(p22: boolean, p23: boolean) -- Line: 223
            -- upvalues: u21 (copy), u20 (copy), script_SwapAbilityNames (ref), u19 (copy), script_interface (ref), LocalPlayer (ref)
            if p22 then
                u21[1] = u20.AwkC or u20.BaseC;
                u21[2] = u20.AwkV or u20.BaseV;
                u21[3] = u20.AwkB or u20.BaseB;
            else
                u21[1] = u20.BaseC;
                u21[2] = u20.BaseV;
                u21[3] = u20.BaseB;
            end;

            if p23 then
                for i = 1, 3 do
                    local v24;

                    if u21[i] then
                        local v25 = tostring(i);
                        local v26 = script_SwapAbilityNames[u19] and script_SwapAbilityNames[u19].Abilities[v25];

                        if v26 then
                            u21[i].display = v26(script_interface, LocalPlayer, LocalPlayer.Character);
                            v24 = i;
                        elseif script_interface.OverwriteText[v25] and script_interface.OverwriteText[v25] ~= "" then
                            u21[i].display = script_interface.OverwriteText[v25];
                            v24 = i;
                        else
                            v24 = i;
                        end;
                    else
                        v24 = i;
                    end;
                end;
            end;

            return u21;
        end;
    end;

    local function loadStyle(p27: userdata) -- Line: 258
        -- upvalues: u4 (ref)
        local v28 = require(p27);
        u4[p27.Name] = v28.getKit;
    end;

    table.clear(script_interface.UngroupedAbilities);

    for _, v in p17:QueryDescendants("ModuleScript") do
        script_interface.UngroupedAbilities[v.Name] = require(v);
    end;

    for _, child in p17:GetChildren() do
        if child:IsA("ModuleScript") then
            local v29 = require(child);
            u4[child.Name] = v29.getKit;
        end;
    end;

    for i in u18 do
        loadLegacyStyle(i);
    end;

    u6.AbilitiesModule = p17;
end;

function u6.ExecuteAbilitySlot(p30: table, p31: number, p32: any) -- Line: 283
    -- upvalues: canUseAbility (copy), getKit (copy), script_interface (copy), LocalPlayer (copy)
    if not canUseAbility(p31) then
        return;
    end;

    local v33 = getKit();

    if not v33[p31] then
        print("nothing in this slot", p31);

        return;
    end;

    local v34 = v33[p31];

    if v34.legacyFn then
        return v34.legacyFn(v34.customInterface or script_interface, LocalPlayer, LocalPlayer.Character, p32, -1);
    end;

    local fn = v34.fn;
    local v35 = `no function for ability with display "{v34.display}"`;
    assert(fn, v35);
    v34.fn(p32);
end;

function u6.KnitStart(p36) -- Line: 313
    -- upvalues: u1 (ref), KnitClient (copy), script_interface (copy), u5 (copy), script_LegacyFunctions (copy), UserInput (copy), u2 (copy), u6 (copy), Abilities (copy), ChemicalReactionController (copy), LocalPlayer (copy), Teams (copy), RunService (copy), getKit (copy), StatesController (copy), u3 (copy), ReplicatedStorage (copy), AbilityUtils (copy)
    u1 = KnitClient.GetService("AbilityService");
    script_interface.AbilitiesTable = u5;
    script_LegacyFunctions._setupDependancies(p36, script_interface);
    script_LegacyFunctions._setupReo(script_interface);

    for i = 1, 3 do
        local v37 = `Ability{i}`;
        local v38 = UserInput.GameplayContext:FindFirstChild(v37);
        v38.KeyboardAndMouse.UIButton = u2[i];
        u2[i].Activated:Connect(function() -- Line: 326
            -- upvalues: i (copy), script_LegacyFunctions (ref), u6 (ref)
            if i == 1 and script_LegacyFunctions.ability1CR() then
                return;
            end;

            u6:ExecuteAbilitySlot(i);
        end);
        v38.Pressed:Connect(function() -- Line: 338
            -- upvalues: i (copy), script_LegacyFunctions (ref), u6 (ref)
            if i == 1 and script_LegacyFunctions.ability1CR() then
                return;
            end;

            u6:ExecuteAbilitySlot(i);
        end);
        local _ = i;
    end;

    UserInput.GameplayContext.RequestCR.KeyboardAndMouse.UIButton = Abilities.CR;
    UserInput.GameplayContext.RequestCR.Pressed:Connect(function() -- Line: 353
        -- upvalues: ChemicalReactionController (ref), script_interface (ref)
        ChemicalReactionController:UseChemicalReaction(script_interface);
    end);
    Abilities.CR.Activated:Connect(function() -- Line: 357
        -- upvalues: ChemicalReactionController (ref), script_interface (ref)
        ChemicalReactionController:UseChemicalReaction(script_interface);
    end);
    UserInput.GameplayContext.Enabled = LocalPlayer.Team ~= Teams.Visitor;
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 362
        -- upvalues: UserInput (ref), LocalPlayer (ref), Teams (ref)
        UserInput.GameplayContext.Enabled = LocalPlayer.Team ~= Teams.Visitor;
    end);
    u6:LoadAbilities(script:WaitForChild("AbilitiesClient"));
    LocalPlayer:GetAttributeChangedSignal("GrantedTwoStepsBehindShot"):Connect(function() -- Line: 377
        -- upvalues: LocalPlayer (ref), script_interface (ref)
        if LocalPlayer:GetAttribute("GrantedTwoStepsBehindShot") then
            pcall(function() -- Line: 379
                -- upvalues: script_interface (ref)
                script_interface:AbilityCooldown("3", 0);
            end);
            script_interface.AbilityThree = 0;
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("GrantedFastShot"):Connect(function() -- Line: 386
        -- upvalues: LocalPlayer (ref), script_interface (ref), RunService (ref)
        local Attribute = LocalPlayer:GetAttribute("GrantedFastShot");

        if Attribute then
            pcall(function() -- Line: 389
                -- upvalues: script_interface (ref)
                script_interface:AbilityCooldown("3", 0);
            end);
            script_interface.AbilityThree = 0;
        end;

        if RunService:IsStudio() then
            print("[FastShot][client] GrantedFastShot changed →", Attribute, "| UngroupedAbilities.FastShot present =", script_interface.UngroupedAbilities.FastShot ~= nil);
        end;
    end);
    local u39 = nil;
    LocalPlayer:GetAttributeChangedSignal("GrantedNikoLionShot"):Connect(function() -- Line: 402
        -- upvalues: LocalPlayer (ref), u39 (ref), script_interface (ref)
        if not LocalPlayer:GetAttribute("GrantedNikoLionShot") then
            if u39 ~= nil then
                local v40 = u39;
                u39 = nil;
                local v41 = v40 - tick();
                local math_max_ret = math.max(0, v41);
                pcall(function() -- Line: 416
                    -- upvalues: script_interface (ref), math_max_ret (copy)
                    script_interface:AbilityCooldown("3", math_max_ret, math_max_ret);
                end);
                script_interface.AbilityThree = math_max_ret > 0 and v40 and v40 or 0;
            end;

            return;
        end;

        if u39 == nil then
            u39 = script_interface.AbilityThree;
        end;

        pcall(function() -- Line: 408
            -- upvalues: script_interface (ref)
            script_interface:AbilityCooldown("3", 0);
        end);
        script_interface.AbilityThree = 0;
    end);
    RunService.Heartbeat:Connect(function() -- Line: 424
        -- upvalues: getKit (ref), u2 (ref)
        local v42 = getKit();

        for i, v in u2 do
            local v43 = v42[i];

            if v43 then
                v.Visible = true;
                v.AbilityLabel.Text = v43.display;
            else
                v.Visible = false;
            end;
        end;
    end);
    u1.Ability:Connect(function() -- Line: 438
    end);
    u1.SetProperty:Connect(function(p44, p45) -- Line: 442
        -- upvalues: script_interface (ref)
        script_interface[p44] = p45;
    end);
    u1.CamAnim:Connect(function(...) -- Line: 446
        -- upvalues: script_LegacyFunctions (ref), script_interface (ref)
        print(...);
        script_LegacyFunctions.CamAnim(script_interface, ...);
    end);
    u1.CutCooldown:Connect(function(p46, p47) -- Line: 451
        -- upvalues: StatesController (ref), u3 (ref), script_interface (ref)
        if StatesController:IsAwakened() then
            return;
        end;

        local v48 = u3[tostring(p46)];

        if not v48 then
            return;
        end;

        local v49 = script_interface[v48] - tick();
        local math_max_ret = math.max(0, v49);
        script_interface:AbilityCooldown(tostring(p46), math_max_ret * p47, math_max_ret);
    end);
    require(ReplicatedStorage.Shared.DebugUtil).createGroup("Abilities").addButton("reset", "Reset Cooldowns", function() -- Line: 465
        -- upvalues: AbilityUtils (ref), LocalPlayer (ref), script_interface (ref), ReplicatedStorage (ref)
        local Character = AbilityUtils.getCharacter(LocalPlayer);
        Character:SetAttribute("LastV", nil);
        Character:SetAttribute("LastB", nil);

        for _, v in { "One", "Two", "Three" } do
            script_interface["Ability" .. v] = 0;
        end;

        script_interface.ExecutingCopiedMove = nil;
        script_interface.ExecutingCopiedStyle = nil;
        script_interface:AbilityCooldown(tostring(1), 0);
        script_interface:AbilityCooldown(tostring(2), 0);
        script_interface:AbilityCooldown(tostring(3), 0);
        ReplicatedStorage.AdmResetCDs:FireServer();
    end);
end;

u6.legacy = script_interface;

function script_interface.FireServerAbility(p50: table, p51: string, ...) -- Line: 484
    -- upvalues: u1 (ref)
    u1.Ability:Fire(p51, ...);
end;

function script_interface.GetKit(p52, p53, p54, p55) -- Line: 488
    -- upvalues: u4 (copy)
    return u4[p53](p54, p55);
end;

function script_interface.AbilityCooldown(p56: table, p57: string, p58: number, p59: any) -- Line: 492
    -- upvalues: script_interface (copy), getKit (copy), script_LegacyFunctions (copy)
    local ExecutingCopiedMove = script_interface.ExecutingCopiedMove;

    if ExecutingCopiedMove and coroutine.running() == ExecutingCopiedMove then
        p57 = tostring(script_interface.CopySlot or 1);
    end;

    local v60 = getKit()[tonumber(p57)];

    if not v60 then
        return;
    end;

    local legacyId = v60.legacyId;

    if not legacyId then
        warn("why is this being called? you called the old cooldown function with no legacyId? why?");
    end;

    assert(p58, "cooldown time not given for cooldown");
    assert((p57 == 1 or (p57 == 2 or (p57 == 3 or (p57 == "1" or p57 == "2")))) and true or p57 == "3", "invalid slot");
    script_LegacyFunctions.AbilityCooldown(p57, legacyId, script_interface, p58, p59);
end;

return KnitClient.CreateController(u6);