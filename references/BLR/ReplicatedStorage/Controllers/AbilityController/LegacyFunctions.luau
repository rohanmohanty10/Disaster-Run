  

local Teams = game:GetService("Teams");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local ChemicalReactionController = require(ReplicatedStorage.Controllers.ChemicalReactionController);
local getCurrentStyle = require(ReplicatedStorage.ClientModules.getCurrentStyle);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local Popup = require(ReplicatedStorage.Shared.Popup);
local getCooldownSpeed = require(ReplicatedStorage.Shared.utils.getCooldownSpeed);
local u1 = nil;
KnitClient.OnStart():andThen(function() -- Line: 22
    -- upvalues: u1 (ref), KnitClient (copy)
    u1 = KnitClient.GetService("AbilityService");
end);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local ServerSettings = workspace:WaitForChild("ServerSettings");
local u2 = {
    ["1"] = "AbilityOne",
    ["2"] = "AbilityTwo",
    ["3"] = "AbilityThree"
};
local u3 = {};

local function _(p4: string) -- Line: 37
    -- upvalues: getCooldownSpeed (copy), LocalPlayer (copy)
    return getCooldownSpeed(LocalPlayer, LocalPlayer.PlayerStats.Style.Value, p4, LocalPlayer.PlayerStats.InFlow.Value);
end;

local function replicateCooldowns(p5) -- Line: 46
    -- upvalues: u2 (copy), LocalPlayer (copy), u1 (ref)
    local v6 = {};

    for i = 1, 3 do
        local v7 = u2[tostring(i)];
        local v8 = LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild((tostring(i)));
        local v9;

        if v8.Visible then
            table.insert(v6, {
                name = v8.AbilityLabel.Text,
                cooldown = p5[v7]
            });
            v9 = i;
        else
            v9 = i;
        end;
    end;

    u1.UpdateMyCooldowns:Fire(v6);
end;

local u10 = nil;

function u3.AutoCharacterRotateToCamera(p11) -- Line: 59
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), u10 (ref), RunService (copy), workspace_CurrentCamera (copy)
    local _, u12 = AbilityUtils.getCharacter(LocalPlayer);

    if not u12 then
        return;
    end;

    if p11 then
        if not u10 then
            u10 = true;
            RunService:BindToRenderStep("autoRotateCharacter", Enum.RenderPriority.Last.Value, function() -- Line: 72
                -- upvalues: u12 (copy), workspace_CurrentCamera (ref)
                if u12 then
                    u12.CFrame = CFrame.lookAlong(u12.CFrame.Position, workspace_CurrentCamera.CFrame.LookVector * (Vector3.new(1, 0, 1)).Unit);
                end;
            end);
        end;
    elseif u10 then
        RunService:UnbindFromRenderStep("autoRotateCharacter");
        u10 = false;
    end;
end;

function u3.AbilityCooldown(p13: any, p14: string, u15: table, p16: number, p17: number?) -- Line: 82
    -- upvalues: ReplicatedStorage (copy), getCooldownSpeed (copy), LocalPlayer (copy), ServerSettings (copy), u2 (copy), replicateCooldowns (copy), TweenService (copy)
    local u18 = tostring(p13);

    if p16 > 1 and (p14 ~= "ItsSlow" and not p17) then
        p16 = ReplicatedStorage.AbilityCooldowns:GetAttribute(p14) or p16;
    end;

    local v19 = getCooldownSpeed(LocalPlayer, LocalPlayer.PlayerStats.Style.Value, p14, LocalPlayer.PlayerStats.InFlow.Value);

    if not p17 then
        p16 = p16 * v19;
    end;

    local v20 = ServerSettings:GetAttribute("NoAbilityCooldown") and not p17 and 1 or p16;
    local v21 = LocalPlayer:GetAttribute("NoCooldowns") and 1 or v20;
    u15[u2[u18]] = tick() + v21;
    replicateCooldowns(u15);
    local u22 = LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild(u18);

    if not u22 then
        return;
    end;

    u22.Cooldown.UIGradient.Offset = Vector2.new(0, 1 - v21 / (p17 or v21));
    local u23 = TweenService:Create(u22.Cooldown.UIGradient, TweenInfo.new(v21, Enum.EasingStyle.Linear), {
        Offset = Vector2.new(0, 1)
    });
    u23:Play();
    task.spawn(function() -- Line: 122
        -- upvalues: u23 (copy), u15 (copy), u2 (ref), u18 (ref), u22 (copy)
        while u23.PlaybackState == Enum.PlaybackState.Playing do
            local v24 = u15[u2[u18]] - tick();

            if v24 <= 0 then
                break;
            end;

            u22.ActualTimer.Text = string.format("%.1fs", v24);
            task.wait();
        end;

        u22.ActualTimer.Text = "";
        u23:Cancel();
        u22.Cooldown.UIGradient.Offset = Vector2.new(0, 1);
    end);
end;

function u3.CamAnim(u25: any, u26: any, p27: any, p28: userdata) -- Line: 137
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), workspace_CurrentCamera (copy), RunService (copy)
    local Character, _, _, _ = AbilityUtils.getCharacter(u26);

    if not Character then
        return;
    end;

    if LocalPlayer.Team == game.Teams.Visitor and not u25.Spectator.IsSpectating then
        return;
    end;

    local _, _, _, v29 = AbilityUtils.getCharacter(LocalPlayer);

    if v29 and (v29.Goalie.Value and (v29.IsInPenalty.Value and LocalPlayer.Team ~= u26.Team)) then
        return;
    end;

    print("play cam anim");
    u25.Camera.Cutscene = true;
    local v30 = 60;

    if u26 == LocalPlayer and not p27 then
        if u26.PlayerStats.Style.Value == "Nagi" then
            u25.Animations.Ball.IAmNagi.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Ball.IAmNagi:Play();
            u25.Animations.Abilities.IAmNagi.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Abilities.IAmNagi:Play();
        elseif u26.PlayerStats.Style.Value == "Sae" then
            u25.Animations.Ball.Surpass.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Ball.Surpass:Play();
            u25.Animations.Abilities.Surpass.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Abilities.Surpass:Play();
            v30 = 17;
        elseif u26.PlayerStats.Style.Value == "Shidou" then
            u25.Animations.Ball.ShidouBigBang.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Ball.ShidouBigBang:Play();
            u25.Animations.Abilities.ShidouBigBang.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Abilities.ShidouBigBang:Play();
            v30 = 21;
        elseif u26.PlayerStats.Style.Value == "Isagi" then
            u25.Animations.Abilities.FinalShot.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Abilities.FinalShot:Play();
        elseif u26.PlayerStats.Style.Value == "Rin" then
            u25.Animations.Ball.OPCurve.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Ball.OPCurve:Play();
            u25.Animations.Abilities.OPCurve.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Abilities.OPCurve:Play();
        elseif u26.PlayerStats.Style.Value == "Karasu" then
            u25.Animations.Ball.CrowClearance.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Ball.CrowClearance:Play();
            u25.Animations.Abilities.CrowClearance.Priority = Enum.AnimationPriority.Action4;
            u25.Animations.Abilities.CrowClearance:Play();
            v30 = 5;
        end;
    end;

    local u31 = u26.PlayerStats.Style.Value == "Shidou" and 21 or v30;

    if u26.PlayerStats.Style.Value == "King" then
        u25.Animations.Ball.Devour.Priority = Enum.AnimationPriority.Action4;
        u25.Animations.Ball.Devour:Play();
    end;

    local u32 = nil;
    local CFrame2 = workspace_CurrentCamera.CFrame;

    local function reset() -- Line: 200
        -- upvalues: u25 (copy), u32 (ref), workspace_CurrentCamera (ref), CFrame2 (copy), u26 (copy), LocalPlayer (ref)
        u25.Camera.Cutscene = false;
        u32:Disconnect();
        workspace_CurrentCamera.CFrame = CFrame2;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CFrame = CFrame2;
        local _ = u26.PlayerStats.Style.Value == "Gagamaru";

        if LocalPlayer.Team ~= game.Teams.Visitor then
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        end;

        if u25.Spectator.IsSpectating then
            LocalPlayer.PlayerGui.Spectate.Enabled = true;
        end;
    end;

    local _ = u26.PlayerStats.Style.Value == "Gagamaru";
    local u33 = 0;
    local u34 = 0;
    local u35 = false;
    local os_time_ret = os.time();
    local u36;

    if p28 then
        u36 = {};

        for _, child in p28:GetChildren() do
            u36[tonumber(child.Name) + 1] = child.Value;
        end;
    else
        u36 = nil;
    end;

    u32 = RunService.RenderStepped:Connect(function() -- Line: 237
        -- upvalues: os_time_ret (copy), u31 (ref), reset (copy), u33 (ref), u35 (ref), u34 (ref), LocalPlayer (ref), workspace_CurrentCamera (ref), u36 (ref)
        if os_time_ret + u31 < os.time() then
            reset();

            return;
        end;

        if workspace:FindFirstChild("NagiCam") == nil then
            u33 = u33 + 1;

            if u33 < 120 and not u35 then
                return;
            end;

            reset();

            return;
        end;

        if u34 > 120 then
            reset();

            return;
        end;

        LocalPlayer.PlayerGui.InGameUI.Enabled = false;
        LocalPlayer.PlayerGui.Spectate.Enabled = false;
        u35 = true;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local v37 = workspace.NagiCam:FindFirstChild("camera") or (workspace.NagiCam:FindFirstChild("Torso") or workspace.NagiCam:FindFirstChild("CamPart"));

        if v37 then
            local v38 = (workspace.NagiCam:FindFirstChild("AnimationController") or workspace.NagiCam:FindFirstChild("Humanoid").Animator):GetPlayingAnimationTracks()[1];

            if u36 and v38 then
                local v39 = math.floor(v38.TimePosition * 60) + 1;

                for i, v in u36 do
                    if i >= v39 then
                        break;
                    end;

                    workspace_CurrentCamera.FieldOfView = v;
                end;
            end;

            if not v38 then
                u34 = u34 + 1;

                return;
            end;

            if v38.TimePosition > 0 then
                workspace_CurrentCamera.CFrame = v37.CFrame;
            end;
        end;
    end);
end;

function u3._setupReo(u40) -- Line: 276
    -- upvalues: LocalPlayer (copy), RunService (copy), getCurrentStyle (copy), Teams (copy), AbilityUtils (copy), Players (copy)
    u40.ClosestReo = nil;
    local AbilityReo = LocalPlayer.PlayerGui.AbilityReo;
    local Timer = LocalPlayer.PlayerGui.AbilityReo.Timer;
    RunService.Heartbeat:Connect(function(p41) -- Line: 282
        -- upvalues: getCurrentStyle (ref), LocalPlayer (ref), Teams (ref), AbilityUtils (ref), u40 (copy), AbilityReo (copy), Players (ref), Timer (copy)
        if getCurrentStyle() ~= "Reo" then
            return;
        end;

        if LocalPlayer.Team == Teams.Visitor then
            return;
        end;

        local v42 = AbilityUtils.checks.anyTarget(9999);

        if u40.ClosestReo and u40.ClosestReo ~= v42 then
            u40.ClosestReo:GetAttribute("ReoHighlight", nil);
        end;

        if v42 then
            v42:GetAttribute("ReoHighlight", true);
            AbilityReo.Adornee = v42;
            AbilityReo.Enabled = true;

            if u40.ClosestReo ~= v42 then
                local PlayerFromCharacter = Players:GetPlayerFromCharacter(v42);

                if PlayerFromCharacter then
                    Timer.Text = PlayerFromCharacter.PlayerStats.Style.Value;
                else
                    Timer.Text = "Nagi";
                end;
            end;
        else
            AbilityReo.Adornee = nil;
            AbilityReo.Enabled = false;
        end;

        u40.ClosestReo = v42;
    end);
end;

function u3.ability1CR() -- Line: 316
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), ChemicalReactionController (copy), Popup (copy)
    local Character = AbilityUtils.getCharacter(LocalPlayer);

    for _, _ in { "Sae-Shidou-CR", "Kurona-NELIsagi-CR", "Otoya-NELBachira-CR", "Hiori-Isagi-CR", "Loki-Charles-CR", "NEL Isagi-Kaiser-CR" } do
        if Character:HasTag("Sae-Shidou-CR") then
            local u43 = ChemicalReactionController.ChemicalReactions["Sae-Shidou-CR"];

            if u43.check() and not u43.cooldown then
                u43.cooldown = true;
                task.delay(u43.cooldownTime, function() -- Line: 333
                    -- upvalues: Popup (ref), LocalPlayer (ref), u43 (copy)
                    Popup.Popup(LocalPlayer, u43.readyText);
                    u43.cooldown = nil;
                end);
                u43.activate();

                return true;
            end;
        end;
    end;
end;

function u3.useChemicalReaction(p44) -- Line: 344
end;

function u3.clearCopy(p45) -- Line: 349
    p45.CopyingStyle = nil;
    p45.CopiedMove = nil;
    p45.CopiedMoveIndex = nil;
    p45.CopiedStyle = nil;
    p45.ExecutingCopiedMove = nil;
    p45.ExecutingCopiedStyle = nil;
    p45.ClearCopyTask = nil;

    if p45.OverwriteText then
        p45.OverwriteText["1"] = "";
        p45.OverwriteText["2"] = "";
        p45.OverwriteText["3"] = "";
    end;
end;

function u3._setupDependancies(p46, u47) -- Line: 366
    -- upvalues: KnitClient (copy), StatesController (copy), LocalPlayer (copy), u3 (copy), ReplicatedStorage (copy), Lighting (copy)
    u47.Animations = KnitClient.GetController("AnimationController");
    u47.BallController = KnitClient.GetController("BallController");
    u47.StatesController = KnitClient.GetController("StatesController");
    u47.AbilityController = KnitClient.GetController("AbilityController");
    u47.Camera = KnitClient.GetController("CameraController");
    u47.Spectator = KnitClient.GetController("SpectatorController");
    u47.ChemicalReactionController = KnitClient.GetController("ChemicalReactionController");
    u47.AbilityService = KnitClient.GetService("AbilityService");
    u47.BallService = KnitClient.GetService("BallService");
    u47.StaminaService = KnitClient.GetService("StaminaService");
    u47.EffectsService = KnitClient.GetService("EffectsService");
    u47.AbilityController = p46;

    function u47.TryActivateAbilityFromId(p48: string, p49: any) -- Line: 381
        -- upvalues: StatesController (ref), u47 (copy), LocalPlayer (ref)
        StatesController.CharacterEvents.OnAbilityUsed:Fire(p48);
        u47.UngroupedAbilities[p48](u47, LocalPlayer, LocalPlayer.Character, p49, -1);
    end;

    local function v50() -- Line: 387
        -- upvalues: u47 (copy), u3 (ref)
        u47.OverwriteText["1"] = "";
        u47.OverwriteText["2"] = "";
        u47.OverwriteText["3"] = "";
        u3.clearCopy(u47);
    end;

    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(v50);
    StatesController.CharacterEvents.StyleChanged:Connect(v50);
    local Configuration = Instance.new("Configuration");
    Configuration.Name = "MainLighting";
    Configuration.Parent = ReplicatedStorage.Assets;

    for _, v in { "Ambient", "Brightness", "ColorShift_Bottom", "ColorShift_Top", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "GlobalShadows", "OutdoorAmbient", "ShadowSoftness", "ClockTime", "GeographicLatitude", "TimeOfDay", "ExposureCompensation" } do
        Configuration:SetAttribute(v, Lighting[v]);
    end;

    for _, child in Lighting:GetChildren() do
        child:Clone().Parent = Configuration;
    end;

    u47.JustOne = tick();
    u47.AbilityUsed = tick();
    u47.InSuper = false;
    u47.InAbility = false;
    u47.Used = 0;
    u47.Mode = "Offensive Mode";
    u47.AwakenCopied = nil;
    u47.Copied = nil;
    u47._flowPassDribbled = nil;
end;

return u3;