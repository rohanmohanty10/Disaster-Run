 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local script_Abilities = require(script.Abilities);
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = Knit.CreateController({
    Name = "AbilityController",
    LastUsed = 1
});

function u13.ResetCopy(p14) -- Line: 39
    -- upvalues: LocalPlayer (copy), u11 (ref), script_Abilities (copy)
    if (LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief") and ((LocalPlayer.Style.Value ~= "Copycat" or not u11.CharValues.InAwakening) and p14.CopiedSetting) then
        local v15 = LocalPlayer.Style.Value == "Copycat" and script.Abilities.Copycat.Copy;

        if not v15 then
            if LocalPlayer.Style.Value == "Thief" then
                v15 = script.Abilities.Thief.Pillage;
            else
                v15 = false;
            end;
        end;

        script_Abilities[LocalPlayer.Style.Value][1].Ability = v15;
        script_Abilities[LocalPlayer.Style.Value][1].Name = LocalPlayer.Style.Value == "Copycat" and "Copy" or (LocalPlayer.Style.Value == "Thief" and "Pillage" or false);
        script_Abilities[LocalPlayer.Style.Value][1].BallName = nil;
        script_Abilities[LocalPlayer.Style.Value][1].AwakeningName = u11.CharValues.InAwakening and (LocalPlayer.Style.Value == "Thief" and "Total Theft" or false);
        script_Abilities[LocalPlayer.Style.Value][1].RequiresBall = "Both";
        p14.CopiedSetting = nil;
    end;

    if LocalPlayer.Style.Value == "Copycat" and (p14.AwakeningCopiedSetting and u11.CharValues.InAwakening) then
        script_Abilities[LocalPlayer.Style.Value][4].Ability = script.Abilities.Copycat.FullCopy;
        script_Abilities[LocalPlayer.Style.Value][4].Name = "100% Copy";
        script_Abilities[LocalPlayer.Style.Value][4].BallName = nil;
        script_Abilities[LocalPlayer.Style.Value][4].RequiresBall = "Both";
        p14.AwakeningCopiedSetting = nil;
    end;
end;

function u13.HoopDist(p16) -- Line: 57
    -- upvalues: LocalPlayer (copy), HumanoidRootPart (ref)
    return (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude;
end;

function u13.StillHasBall(p17) -- Line: 61
end;

function u13.CheckInfront(p18, p19, p20) -- Line: 90
    -- upvalues: Players (copy), LocalPlayer (copy), RunService (copy), HumanoidRootPart (ref)
    local v21 = {};
    local v22 = nil;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and (v.Team ~= game.Teams.Visitor and (p20 or (LocalPlayer:GetAttribute("TrueEmperor") or (LocalPlayer:GetAttribute("TrueAce") or (LocalPlayer:GetAttribute("TrueGiant") or (LocalPlayer:GetAttribute("TrueCopycat") or (LocalPlayer:GetAttribute("TrueSniper") or (LocalPlayer:GetAttribute("TrueSkarp") or v.Team ~= LocalPlayer.Team)))))))) and v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
            table.insert(v21, v.Character);
        end;
    end;

    if RunService:IsStudio() then
        table.insert(v21, workspace.DefenseRig);
    end;

    local v23 = 999;

    for _, v in v21 do
        local Magnitude = (HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude;

        if p19 > Magnitude then
            local v24 = HumanoidRootPart.CFrame.LookVector:Dot((v.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v24);

            if (math_acos_ret < 1.5707963267948966 or math_acos_ret < 1.9039955476301778) and Magnitude < v23 then
                v22 = v;
                v23 = Magnitude;
            end;
        end;
    end;

    return v22;
end;

function u13.LookingAtNet(p25) -- Line: 131
    -- upvalues: LocalPlayer (copy), HumanoidRootPart (ref)
    local Unit = (Vector3.new(workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X, HumanoidRootPart.Position.Y, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.Z) - HumanoidRootPart.Position).Unit;
    local _ = HumanoidRootPart.CFrame.LookVector;
    local v26 = HumanoidRootPart.CFrame.LookVector:Dot(Unit);
    local math_acos_ret = math.acos(v26);
    local _ = math_acos_ret < 1.9039955476301778;

    return math_acos_ret < 1.5707963267948966 and true or false;
end;

function u13.ResetCD(p27, p28) -- Line: 149
    -- upvalues: LocalPlayer (copy)
    p27.LastReset = { p28, tick() };

    if (LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief") and (p27.LastUsed == 1 and p28 ~= 1) then
        p27.CDS[1] = tick() - 1;

        return;
    end;

    if LocalPlayer.Style.Value == "Copycat" and (p27.LastUsed == 4 and p28 ~= 4) then
        p27.CDS[4] = tick() - 1;

        return;
    end;

    p27.CDS[p28] = tick() - 1;
end;

function u13.Input(u29) -- Line: 161
    -- upvalues: u11 (ref), script_Abilities (copy), LocalPlayer (copy), u7 (ref), Effects (copy), u10 (ref), u8 (ref), ReplicatedStorage (copy), Styles (copy), Players (copy), Zones (copy), Cooldowns (copy), Knit (copy), UserInputService (copy), RunService (copy)
    local function ReleaseHold(p30) -- Line: 162
        -- upvalues: u11 (ref), script_Abilities (ref), LocalPlayer (ref), u29 (copy)
        local v31 = p30 == 1 and (u11.CharValues.InAwakening and script_Abilities[LocalPlayer.Style.Value][4]) and 4 or p30;

        if not script_Abilities[LocalPlayer.Style.Value][v31].Holdable then
            return;
        end;

        if script_Abilities[LocalPlayer.Style.Value][v31].Holdable == "Ball" and u11.CharValues.HasBall == false then
            return;
        end;

        if script_Abilities[LocalPlayer.Style.Value][v31].Holdable == "NoBall" and u11.CharValues.HasBall == true then
            return;
        end;

        u29.AC:Clean();
    end;

    local function UseAbility(p32) -- Line: 176
        -- upvalues: u11 (ref), script_Abilities (ref), LocalPlayer (ref), u7 (ref), Effects (ref), u10 (ref), u8 (ref), ReplicatedStorage (ref), u29 (copy), Styles (ref), Players (ref), Zones (ref), Cooldowns (ref), Knit (ref)
        local v33 = p32 == 1 and (u11.CharValues.InAwakening and script_Abilities[LocalPlayer.Style.Value][4]) and 4 or p32;

        if u7:CutsceneEndedLessThanXSecondsAgo(1) then
            Effects:Popup("Can\'t use abilities during a cutscene!");

            return;
        end;

        if u10:NoActionFORABILITYCONTROLLER(script_Abilities[LocalPlayer.Style.Value][v33]) then
            Effects:Popup("Can\'t use abilities right now!");

            return;
        end;

        if u8.States.Ability and (u8.States.AbilitiesUsable ~= v33 and u8.States.AbilitiesUsable >= 0) then
            return;
        end;

        if u8.States.NoAbility then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if u11.CharValues.HasBall == false and (script_Abilities[LocalPlayer.Style.Value][v33].Steal and (ReplicatedStorage.GameValues.NoStealAbility.Value and u11.Gamemode ~= "Normal")) then
            Effects:Popup("Wait until the global steal cooldown is off!");

            return;
        end;

        if u29.CDS[v33] > tick() then
            return;
        end;

        if script_Abilities[LocalPlayer.Style.Value][v33].RequiresBall ~= "Both" then
            if script_Abilities[LocalPlayer.Style.Value][v33].RequiresBall and u11.CharValues.HasBall == false then
                Effects:Popup("Not usable without ball!");

                return;
            end;

            if script_Abilities[LocalPlayer.Style.Value][v33].RequiresBall == false and u11.CharValues.HasBall == true then
                Effects:Popup("Not usable with ball!");

                return;
            end;
        end;

        if (Styles.Styles[LocalPlayer.Style.Value].BaseMoveCount or (LocalPlayer.Style.Value == "ChrolloV2" and u29.ChosenStyle and 3 or 2)) + 1 <= v33 and u11.CharValues.InAwakening == false then
            return;
        end;

        if ReplicatedStorage.GameValues.TipOff.Value then
            return;
        end;

        local v34 = nil;
        local v35 = nil;
        local v36 = nil;

        for _, v in Players:GetPlayers() do
            if v.Team ~= game.Teams.Visitor and (v.Team ~= LocalPlayer.Team and (v.Character ~= nil and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50))) then
                if v.Zone.Value == "Technical" and v:GetAttribute("TechnicalZone") then
                    v34 = v;
                elseif v.Zone.Value == "HAHA" and v:GetAttribute("HAHAZone") then
                    v35 = v;
                elseif v.Zone.Value == "Justice" and v:GetAttribute("JusticeZone") then
                    v36 = v;
                end;
            end;
        end;

        if v34 and math.random(1, 3) == 1 then
            local v37 = u11.CharValues.HasBall and script_Abilities[LocalPlayer.Style.Value][v33].BallName or script_Abilities[LocalPlayer.Style.Value][v33].Name;
            Effects:Popup(v37 .. " ability has been disabled for 5 seconds.");
            ReplicatedStorage.Remotes.Zones.Technical:FireServer(v34.Name, v37);
            u29.CDS[v33] = tick() + 5;

            return;
        end;

        u29.LastUsed = v33;

        if not (LocalPlayer:GetAttribute("NoAbilityCooldowns") or (workspace:GetAttribute("NoAbilityCooldowns") or v33 == 1 and (LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or v33 == 1 and (LocalPlayer.Style.Value == "Thief" and u29.TotalTheft)) then
            local v38 = 1;
            local v39;

            if u11.CharValues.InZone and Zones.AbilityCooldown[LocalPlayer.Zone.Value] then
                v39 = Zones.AbilityCooldown[LocalPlayer.Zone.Value];
            else
                v39 = u11.CharValues.InZone and (LocalPlayer.Zone.Value == "Vampiric" and (LocalPlayer.Style.Value == "Vampire" or LocalPlayer.Style.Value == "ScaryMonster" and v33 ~= 4)) and 0.75 or v38;
            end;

            if v35 then
                v39 = v39 * 1.25;
            end;

            if v36 then
                v39 = v39 * 1.25;
            end;

            u29.CDS[v33] = tick() + Cooldowns.Abilities[script_Abilities[LocalPlayer.Style.Value][v33].Ability.Parent.Name][v33] * v39;
        end;

        u29.AC:Clean();
        Knit.GetController("EmotesController"):CancelPlayingEmote();
        require(script_Abilities[LocalPlayer.Style.Value][v33].Ability)(u29, v33);
    end;

    for i = 1, 3 do
        local Bottom = LocalPlayer.PlayerGui.InGame.BG.Bottom;
        Bottom[`Ability{tostring(i)}`].MouseButton1Down:Connect(function() -- Line: 284
            -- upvalues: script_Abilities (ref), LocalPlayer (ref), i (copy), UseAbility (copy)
            if script_Abilities[LocalPlayer.Style.Value][i].Holdable then
                UseAbility(i);
            end;
        end);
        Bottom[`Ability{tostring(i)}`].MouseButton1Up:Connect(function() -- Line: 289
            -- upvalues: script_Abilities (ref), LocalPlayer (ref), i (copy), ReleaseHold (copy)
            if script_Abilities[LocalPlayer.Style.Value][i].Holdable then
                ReleaseHold(i);
            end;
        end);
        Bottom[`Ability{tostring(i)}`].MouseButton1Click:Connect(function() -- Line: 294
            -- upvalues: script_Abilities (ref), LocalPlayer (ref), i (copy), UseAbility (copy)
            if not script_Abilities[LocalPlayer.Style.Value][i].Holdable then
                UseAbility(i);
            end;
        end);
        local _ = i;
    end;

    local Controller = Knit.GetController("KeybindsController");
    UserInputService.InputBegan:Connect(function(p40, p41) -- Line: 303
        -- upvalues: Controller (copy), UseAbility (copy), LocalPlayer (ref), RunService (ref), u29 (copy), ReplicatedStorage (ref)
        if p41 then
            return;
        end;

        if Controller.IsInputValid(p40, "Ability 1") then
            UseAbility(1);
        elseif Controller.IsInputValid(p40, "Ability 2") then
            UseAbility(2);
        elseif Controller.IsInputValid(p40, "Ability 3") then
            UseAbility(3);
        end;

        if p40.KeyCode == Enum.KeyCode.U then
            if LocalPlayer:GetRankInGroup(34852864) < 241 and not RunService:IsStudio() then
                return;
            end;

            u29.CDS[1] = tick();
            u29.CDS[2] = tick();
            u29.CDS[3] = tick();
            u29.CDS[4] = tick();
            ReplicatedStorage.Remotes.AdminCD:FireServer();
        end;
    end);
    UserInputService.InputEnded:Connect(function(p42, p43) -- Line: 324
        -- upvalues: Controller (copy), ReleaseHold (copy)
        if p43 then
            return;
        end;

        if Controller.IsInputValid(p42, "Ability 1") then
            ReleaseHold(1);

            return;
        end;

        if Controller.IsInputValid(p42, "Ability 2") then
            ReleaseHold(2);

            return;
        end;

        if Controller.IsInputValid(p42, "Ability 3") then
            ReleaseHold(3);
        end;
    end);

    local function OnNoAbilityCooldownsChanged() -- Line: 336
        -- upvalues: LocalPlayer (ref), u29 (copy)
        if LocalPlayer:GetAttribute("NoAbilityCooldowns") or workspace:GetAttribute("NoAbilityCooldowns") then
            u29.CDS[1] = tick();
            u29.CDS[2] = tick();
            u29.CDS[3] = tick();
            u29.CDS[4] = tick();
        end;
    end;

    task.spawn(OnNoAbilityCooldownsChanged);
    LocalPlayer:GetAttributeChangedSignal("NoAbilityCooldowns"):Connect(OnNoAbilityCooldownsChanged);
    workspace:GetAttributeChangedSignal("NoAbilityCooldowns"):Connect(OnNoAbilityCooldownsChanged);
end;

function u13.CooldownUI(u44) -- Line: 351
    -- upvalues: RunService (copy), script_Abilities (copy), LocalPlayer (copy), u11 (ref), u8 (ref), Effects (copy)
    local u45 = { 0, 0, 0, 0 };
    local u46 = {};
    RunService.PreRender:Connect(function() -- Line: 355
        -- upvalues: script_Abilities (ref), LocalPlayer (ref), u11 (ref), u44 (copy), u8 (ref), u46 (copy), u45 (copy), Effects (ref)
        if not script_Abilities[LocalPlayer.Style.Value] then
            return;
        end;

        local Value = LocalPlayer.Style.Value;
        local Bottom = LocalPlayer.PlayerGui.InGame.BG:WaitForChild("Bottom");

        if LocalPlayer.Style.Value == "Rubberman" and u11.CharValues.InAwakening then
            Bottom.Ability2.AbilityName.Text = u11.CharValues.HasBall and "Observe" or "Gum Block";
        end;

        for i = 1, 3 do
            local v47 = u44.CDS[i] - tick();
            local v48;

            if i == 1 and (u11.CharValues.InAwakening and script_Abilities[Value][4]) then
                v47 = u44.CDS[4] - tick();
                v48 = 4;
            else
                v48 = i;
            end;

            if not (u8.States.Ability or u8.States.NoWalk) then
                if u11.CharValues.InAwakening and (u11.CharValues.HasBall and script_Abilities[Value][v48].AwakeningBallName or script_Abilities[Value][v48].AwakeningName) then
                    if u11.CharValues.HasBall and script_Abilities[Value][v48].AwakeningBallName then
                        Bottom[`Ability{i}`].AbilityName.Text = script_Abilities[Value][v48].AwakeningBallName;
                    else
                        Bottom[`Ability{i}`].AbilityName.Text = script_Abilities[Value][v48].AwakeningName;
                    end;
                elseif u11.CharValues.HasBall and script_Abilities[Value][v48].BallName then
                    Bottom[`Ability{i}`].AbilityName.Text = script_Abilities[Value][v48].BallName;
                else
                    Bottom[`Ability{i}`].AbilityName.Text = script_Abilities[Value][v48].Name;
                end;
            end;

            if v47 <= 0 then
                u46[v48] = nil;

                if (v48 < 3 or u11.CharValues.InAwakening) and u45[v48] > 0 then
                    Effects:Popup((u11.CharValues.InAwakening and u11.CharValues.HasBall and script_Abilities[Value][v48].AwakeningBallName or u11.CharValues.InAwakening and script_Abilities[Value][v48].AwakeningName or (u11.CharValues.HasBall and script_Abilities[Value][v48].BallName or script_Abilities[Value][v48].Name)) .. " ability ready!");
                end;

                Bottom[`Ability{i}`].Cooldown.UIGradient.Offset = Vector2.new(0, 1);
                Bottom[`Ability{i}`].CooldownText.Text = "";
            else
                if not u46[v48] then
                    u46[v48] = v47;
                end;

                Bottom[`Ability{i}`].CooldownText.Text = string.format("%0.1f", v47) .. "s";
                Bottom[`Ability{i}`].Cooldown.UIGradient.Offset = Vector2.new(0, 1 - v47 / u46[v48]);
            end;

            u45[v48] = v47;
            local _ = i;
        end;
    end);
end;

function u13.KnitStart(u49) -- Line: 418
    -- upvalues: u3 (ref), Knit (copy), u4 (ref), u5 (ref), u7 (ref), u6 (ref), u8 (ref), u9 (ref), u10 (ref), u12 (ref), u11 (ref), u13 (copy), Trove (copy), script_Abilities (copy), LocalPlayer (copy), ReplicatedStorage (copy), Styles (copy)
    u3 = Knit.GetService("CustomServerService");
    u4 = Knit.GetService("AbilityService");
    u5 = Knit.GetService("BallService");
    u7 = Knit.GetController("AwakeningController");
    u6 = Knit.GetController("AnimationController");
    u8 = Knit.GetController("MovementController");
    u9 = Knit.GetController("CameraController");
    u10 = Knit.GetController("BallController");
    u12 = Knit.GetController("PassController");
    u11 = Knit.GetController("Network");
    u13.IndependantAbilityCleanup = Trove.new();
    u4.IndependantAbility:Connect(function(p50: string, p51: string, p52: table?) -- Line: 432
        -- upvalues: u13 (ref), Trove (ref)
        local v53 = script.Abilities:FindFirstChild(p50):FindFirstChild(p51);
        local v54 = `{p50} does not have a child ModuleScript named '{p51}'`;
        local v55 = assert(v53, v54);
        local v56 = require(v55);
        local v57 = u13.IndependantAbilityCleanup:Add(Trove.new());
        v57:Add(task.spawn(v56, u13, v57, p52));
    end);
    u4.Ability:Connect(function() -- Line: 444
    end);
    u5.BallTaken:Connect(function(p58: userdata) -- Line: 448
        -- upvalues: u8 (ref), u49 (copy), script_Abilities (ref), LocalPlayer (ref), u6 (ref)
        if u8.States.Ability ~= true or u49.LastUsed == nil then
            return;
        end;

        local v59 = script_Abilities[LocalPlayer.Style.Value][u49.LastUsed];

        if v59.RequiresBall ~= true then
            return;
        end;

        warn((`{LocalPlayer.Name}'s ball was taken by {p58.Name}, cancelling {LocalPlayer.Style.Value}'s {v59.Name} ability`));
        u49.AC:Clean();
        u8.States.Ability = false;
        u8.States.NoWalk = false;
        u8.Boost = 0;
        u6:StopAll();
    end);
    u49.MovementController = u8;
    u49.BallController = u10;
    u49.Animations = u6;
    u49.CameraController = u9;
    u49.Pass = u12;
    u49.Network = u11;
    u49.AbilityService = u4;
    u49.BallService = u5;
    u49.AC = Trove.new();
    local u60 = false;
    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 488
        -- upvalues: u11 (ref), u60 (ref), LocalPlayer (ref), u49 (copy), Styles (ref)
        if u11.CharValues.InAwakening == false then
            if u60 and LocalPlayer.Style.Value == "Thief" then
                u49.CDS[1] = 0;
            end;

            u60 = false;
            local v61 = Styles.Styles[LocalPlayer.Style.Value].BaseMoveCount or (LocalPlayer.Style.Value == "ChrolloV2" and u49.ChosenStyle and 3 or 2);

            for i = 1, 3 do
                LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{i}`].Visible = i <= v61;
                local _ = i;
            end;

            return;
        end;

        if not u60 then
            u60 = true;
            u49.CDS[1] = 0;
            u49.CDS[2] = 0;
            u49.CDS[3] = 0;
            u49.CDS[4] = 0;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{1}`].Visible = true;
        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{2}`].Visible = true;
        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{3}`].Visible = true;
    end);
    ReplicatedStorage.GameValues.State:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 519
        -- upvalues: u49 (copy), u8 (ref)
        u49:ResetCopy();
        u49.AwakeningCopiedSetting = nil;
        u49.ChuckRange = nil;
        u49.PerfectArcSpeed = nil;
        u49.PaintUses = nil;
        u49.StarDrive = nil;
        u49.SelfPassUses = nil;
        u49.PsychicBlitz = nil;
        u49.ArmImplant = nil;
        u49.CurrentImplant = nil;
        u49.InMoon = nil;
        u49.RubberGear = "Defensive";
        u8.ExtraBoosts = {};
        u49.CDS[1] = 0;
        u49.CDS[2] = 0;
        u49.CDS[3] = 0;
        u49.CDS[4] = 0;
    end);

    if u11.Gamemode == "Match-1v1" or u11.ServerType == "Tutorial" then
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Visible = false;
    else
        u49:Input();
        u49:CooldownUI();
    end;
end;

function u13.KnitInit(u62) -- Line: 546
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref), u8 (ref), ReplicatedStorage (copy), RunService (copy)
    u62.CDS = { 0, 0, 0, 0 };
    LocalPlayer.CharacterAdded:Connect(function(p63) -- Line: 554
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref), u62 (copy), u8 (ref)
        u1 = p63;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        u62.AC:Clean();
        u62.IndependantAbilityCleanup:Clean();
        u62.ArmImplant = nil;
        u62.InMoon = nil;
        u8.ExtraBoosts = {};
    end);
    ReplicatedStorage.Remotes.Zones.InfinityVision.OnClientEvent:Connect(function(u64) -- Line: 567
        -- upvalues: HumanoidRootPart (ref), RunService (ref), u2 (ref)
        if not (u64 and (u64.Character and u64.Character:FindFirstChild("HumanoidRootPart"))) then
            return;
        end;

        local HumanoidRootPart2 = u64.Character.HumanoidRootPart;

        if HumanoidRootPart2 == HumanoidRootPart then
            return;
        end;

        local u65 = nil;
        u65 = RunService.RenderStepped:Connect(function() -- Line: 573
            -- upvalues: HumanoidRootPart2 (copy), u64 (copy), u65 (ref), HumanoidRootPart (ref), u2 (ref)
            if not (HumanoidRootPart2 and (HumanoidRootPart2.Parent and (u64 and u64:GetAttribute("InfinityVisionZone")))) then
                u65:Disconnect();

                return;
            end;

            if HumanoidRootPart:FindFirstChild("LinearVelocity") or (HumanoidRootPart:FindFirstChild("BodyVelocity") or HumanoidRootPart:FindFirstChild("AlignPosition")) then
                return;
            end;

            local v66 = HumanoidRootPart.Position - HumanoidRootPart2.Position;

            if v66.Magnitude > 5 then
                return;
            end;

            if v66.Magnitude * Vector3.new(1, 0, 1) == 0 or (HumanoidRootPart2.AssemblyLinearVelocity.Magnitude > u2.WalkSpeed or u2.WalkSpeed == 0) then
                if HumanoidRootPart2.AssemblyLinearVelocity.Magnitude < 10 then
                    if v66.Magnitude * Vector3.new(1, 0, 1) == 0 then
                        HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart2.CFrame.LookVector * Vector3.new(50, 0, 50) + Vector3.new(0, HumanoidRootPart2.AssemblyLinearVelocity.Y, 0);
                    else
                        HumanoidRootPart.AssemblyLinearVelocity = v66.Unit * Vector3.new(50, 0, 50) + Vector3.new(0, HumanoidRootPart2.AssemblyLinearVelocity.Y, 0);
                    end;
                else
                    HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart2.AssemblyLinearVelocity.Unit * Vector3.new(1, 0, 1) * math.clamp(HumanoidRootPart2.AssemblyLinearVelocity.Magnitude * 2, 0, 100) + Vector3.new(0, HumanoidRootPart2.AssemblyLinearVelocity.Y, 0);
                end;
            else
                HumanoidRootPart.AssemblyLinearVelocity = v66.Unit * Vector3.new(1, 0, 1) * u2.WalkSpeed + Vector3.new(0, HumanoidRootPart2.AssemblyLinearVelocity.Y, 0);
            end;

            if HumanoidRootPart:FindFirstChild("DribbleVelocityBasketball") then
                HumanoidRootPart.DribbleVelocityBasketball:Destroy();
            end;
        end);
    end);
end;

return u13;