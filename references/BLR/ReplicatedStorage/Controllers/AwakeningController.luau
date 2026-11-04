  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("PathfindingService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("Debris");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local ClientGlobals = require(ReplicatedStorage2.ClientModules.ClientGlobals);
local getCurrentStyle = require(ReplicatedStorage2.ClientModules.getCurrentStyle);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local countStyleMastery = require(ReplicatedStorage2.Shared.utils.countStyleMastery);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local u1 = nil;
local PlayerData = ClientGlobals.PlayerData;
local LocalPlayer = game.Players.LocalPlayer;
local u2 = { "NEL King", "NEL Shidou", "Kiyora", "NEL Reo", "Reo", "NEL Chigiri", "Otoya", "Easter Yukimiya", "Karasu", "Raichi", "Rin", "Ness", "Kurona", "Firework Bachira", "Santa Lavinho", "Subzero Loki", "Gingerbread Charles", "Krampus Barou", "Elf Emperor", "Igaguri", "King", "NEL Rin", "Loki", "Reo", "NEL Nagi", "McNagi Fryshiro", "Sae", "Shidou", "Charles", "Bunny", "Lavinho", "Reaper Sae", "Demon Shidou", "Blood Moon Rin", "Phantom Isagi", "Skeleton Nagi", "Aiku", "Niko", "Snuffy", "Sendou", "Zantetsu" };
local u3 = { "Gagamaru", "Aiku", "Karasu", "Reo", "Don Lorenzo" };
local u4 = { "Gagamaru" };
local LorenzoAwakeningRules = require(ReplicatedStorage2.Shared.LorenzoAwakeningRules);

local function canUseAwakeningInGoal() -- Line: 29
    -- upvalues: u4 (copy), getCurrentStyle (copy), LorenzoAwakeningRules (copy), LocalPlayer (copy)
    local table_find_ret = table.find(u4, getCurrentStyle());

    if not table_find_ret then
        if getCurrentStyle() == "Don Lorenzo" then
            table_find_ret = LorenzoAwakeningRules.inOwnBox(LocalPlayer);
        else
            table_find_ret = false;
        end;
    end;

    return table_find_ret;
end;

local NELQuests = require(ReplicatedStorage2.Shared.Configs.NELQuests);
local u5 = {
    Charles = "Charles",
    ["Don Lorenzo"] = "Don",
    Isagi = "Isagi",
    Kaiser = "Kaiser",
    Karasu = "Karasu",
    ["NEL Rin"] = "NELRin",
    Otoya = "Otoya",
    Rin = "Rin",
    Sae = "Sae",
    Shidou = "Shidou"
};
local u6 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u6:WaitForChild("Humanoid");
local HumanoidRootPart = u6:WaitForChild("HumanoidRootPart");
local workspace_CurrentCamera = workspace.CurrentCamera;
local u7 = tick();
local v8 = Knit.CreateController({
    Name = "AwakeningController"
});

function v8.Awakening(u9) -- Line: 63
    -- upvalues: Knit (copy), ReplicatedStorage2 (copy), u6 (ref), u4 (copy), getCurrentStyle (copy), LorenzoAwakeningRules (copy), LocalPlayer (copy), u7 (ref), Popup (copy), AbilityUtils (copy), u3 (copy), PlayerData (copy), countStyleMastery (copy), NELQuests (copy), u2 (copy)
    local Controller = Knit.GetController("StatesController");
    local Controller2 = Knit.GetController("BallController");

    if ReplicatedStorage2.GameValues.AwakeningCutscene.Value then
        return;
    end;

    if u6.Values.IsInPenalty.Value then
        local table_find_ret = table.find(u4, getCurrentStyle());

        if not table_find_ret then
            if getCurrentStyle() == "Don Lorenzo" then
                table_find_ret = LorenzoAwakeningRules.inOwnBox(LocalPlayer);
            else
                table_find_ret = false;
            end;
        end;

        if not table_find_ret then
            return;
        end;
    end;

    if Controller2.HoldingShoot then
        return;
    end;

    if Controller.States.Ability then
        return;
    end;

    if u7 > tick() then
        return;
    end;

    if LocalPlayer.PlayerStats.InAwakening.Value then
        return;
    end;

    if LocalPlayer.PlayerStats.AwakeningBar.Value < 99 then
        return;
    end;

    local Timer = ReplicatedStorage2.GameValues:FindFirstChild("Timer");
    local v10 = ReplicatedStorage2.Goals and ReplicatedStorage2.Goals:FindFirstChild("Home");
    local v11 = ReplicatedStorage2.Goals and ReplicatedStorage2.Goals:FindFirstChild("Away");

    if Timer and (v10 and (v11 and (Timer.Value <= 5 and v10.Value ~= v11.Value))) then
        Popup.Popup(LocalPlayer, "Can\'t awaken in the final 5 seconds!");

        return;
    end;

    if u6.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or u6.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        Popup.Popup(LocalPlayer, "Stay On the Ground Bruh!");

        return;
    end;

    local v12 = getCurrentStyle();

    if v12 == "Don Lorenzo" and LorenzoAwakeningRules.inOwnBox(LocalPlayer) then
        if not LorenzoAwakeningRules.isAirBall(ReplicatedStorage2.Football.Value) then
            Popup.Popup(LocalPlayer, "Ball must be in the air!");

            return;
        end;

        u7 = tick() + 0.4;
        u9.AwakeningService.StartAwakening:Fire("LorenzoHeader");
        local u13 = u6;
        local Team = LocalPlayer.Team;
        task.spawn(function() -- Line: 101
            -- upvalues: LocalPlayer (ref), u13 (copy), Team (copy), getCurrentStyle (ref), u9 (copy)
            local v14 = os.clock() + 20;

            repeat
                task.wait();
            until LocalPlayer.PlayerStats.InAwakening.Value or (v14 <= os.clock() or (LocalPlayer.Character ~= u13 or (LocalPlayer.Team ~= Team or getCurrentStyle() ~= "Don Lorenzo")));

            if LocalPlayer.Character ~= u13 or (LocalPlayer.Team ~= Team or (getCurrentStyle() ~= "Don Lorenzo" or not LocalPlayer.PlayerStats.InAwakening.Value)) then
                return;
            end;

            u9.Ability.AbilityOne = tick();
            u9.Ability.AbilityTwo = tick();
            u9.Ability.AbilityThree = tick();
            u9.Ability.legacy:AbilityCooldown(tostring(1), 1);
            u9.Ability.legacy:AbilityCooldown(tostring(2), 1);
            u9.Ability.legacy:AbilityCooldown(tostring(3), 1);
        end);

        return;
    end;

    local v15;

    if v12 == "Sae" then
        v15 = AbilityUtils.findAirBallAboveCharacter(u6) ~= nil;
    else
        v15 = false;
    end;

    local v16;

    if v12 == "Snuffy" then
        v16 = require(ReplicatedStorage2.Shared.SnuffyCutsceneRules).airBall(LocalPlayer, require(ReplicatedStorage2.AbilityBalancing).SnuffyAwakening.BallRange) ~= nil;
    else
        v16 = false;
    end;

    if u6.Values.HasBall.Value == false then
        if not (table.find(u3, v12) or (v15 or v16)) then
            return;
        end;

        if v12 == "Reo" and u6:GetAttribute("StrikeMode") then
            return;
        end;

        if v15 then
            local u17 = false;
            local u18 = nil;

            local function finishSaeAirSecretAwakening() -- Line: 134
                -- upvalues: u17 (ref), u18 (ref), LocalPlayer (ref), u6 (ref)
                if u17 then
                    return;
                end;

                u17 = true;

                if u18 then
                    u18:Disconnect();
                end;

                if LocalPlayer.Character ~= u6 or not u6.Parent then
                    return;
                end;

                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
                u6.Values.InCutscene.Value = false;
                u6.HumanoidRootPart.Anchored = false;
            end;

            u18 = u6.Values.HasBall.Changed:Connect(function(p19) -- Line: 147
                -- upvalues: u17 (ref), u18 (ref), LocalPlayer (ref), u6 (ref)
                if p19 then
                    if u17 then
                        return;
                    end;

                    u17 = true;

                    if u18 then
                        u18:Disconnect();
                    end;

                    if LocalPlayer.Character == u6 then
                        if not u6.Parent then
                            return;
                        end;

                        LocalPlayer.PlayerGui.InGameUI.Enabled = true;
                        u6.Values.InCutscene.Value = false;
                        u6.HumanoidRootPart.Anchored = false;
                    end;
                end;
            end);
            task.delay(8, finishSaeAirSecretAwakening);
        end;
    else
        local u20 = u6.Values.HasBall.Changed:Once(function() -- Line: 158
            -- upvalues: LocalPlayer (ref)
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            LocalPlayer.Character.Values.InCutscene.Value = false;
            LocalPlayer.Character.HumanoidRootPart.Anchored = false;
        end);
        task.delay(5, function() -- Line: 163
            -- upvalues: u20 (ref)
            u20:Disconnect();
        end);
    end;

    if getCurrentStyle() == "Reo" then
        LocalPlayer.Character:SetAttribute("LastV", nil);
        LocalPlayer.Character:SetAttribute("LastB", nil);
    end;

    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    u7 = tick() + 10;
    LocalPlayer.Character.Values.InCutscene.Value = true;
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;

    if u9.CurrentUlt then
        u9.CurrentUlt:Destroy();
    end;

    local v21 = getCurrentStyle();
    local v22;

    if PlayerData.Data.DisabledMasteryLevels[v21] then
        v22 = countStyleMastery(PlayerData.Data, v21);

        if v22 >= 4 and not PlayerData.Data.DisabledMasteryLevels[v21][4] then
            v21 = NELQuests[v21].NELName;
        end;
    else
        v22 = 0;
    end;

    print(v21);
    local Aiku = PlayerData.Data.DisabledMasteryLevels.Aiku;
    local v23;

    if getCurrentStyle() == "Aiku" and v22 >= 4 then
        v23 = not (Aiku and Aiku[4]);
    else
        v23 = false;
    end;

    if not (v23 or table.find(u2, v21)) then
        u9.Animations:StopAnims();
        u9.AwakeningPlrAnimation.Priority = Enum.AnimationPriority.Action4;
        u9.AwakeningPlrAnimation:Play();
    end;

    local v24 = script:FindFirstChild(v21) or script:FindFirstChild(getCurrentStyle());
    print(v24);
    u9.CurrentUlt = require(v24).new(nil, u9.AwakeningPlrAnimation);
    task.spawn(function() -- Line: 211
        -- upvalues: LocalPlayer (ref), u9 (copy)
        local os_clock_ret = os.clock();

        repeat
            task.wait();
        until LocalPlayer.PlayerStats.InAwakening.Value or os.clock() - os_clock_ret > 1;

        if LocalPlayer.PlayerStats.InAwakening.Value then
            u9.Ability.AbilityOne = tick();
            u9.Ability.AbilityTwo = tick();
            u9.Ability.legacy:AbilityCooldown("1", 1);
            u9.Ability.legacy:AbilityCooldown("2", 1);
            u9.Ability.AbilityThree = tick();
            u9.Ability.legacy:AbilityCooldown("3", 1);
        end;
    end);
end;

function v8.KnitStart(u25) -- Line: 232
    -- upvalues: Trove (copy), Knit (copy), LocalPlayer (copy), getCurrentStyle (copy), NELQuests (copy), PlayerData (copy), countStyleMastery (copy), u2 (copy), ReplicatedStorage (copy), StatesController (ref), UserInputService (copy), u6 (ref), u4 (copy), LorenzoAwakeningRules (copy), workspace_CurrentCamera (copy), RunService (copy), u5 (copy)
    u25.BaseTrove = Trove.new();
    u25.AwakeningService = Knit.GetService("AwakeningService");
    u25.Spectator = Knit.GetController("SpectatorController");
    u25.Ability = Knit.GetController("AbilityController");
    u25.Animations = require(script.Parent.AnimationController);
    u25.State = require(script.Parent.StatesController);
    u25.Camera = require(script.Parent.CameraController);
    u25.Settings = Knit.GetController("Settings");
    u25.AwakeningService = Knit.GetService("AwakeningService");
    u25.CurrentUlt = nil;

    local function updAwakeningAnim(p26) -- Line: 249
        -- upvalues: LocalPlayer (ref), getCurrentStyle (ref), NELQuests (ref), PlayerData (ref), countStyleMastery (ref), u2 (ref), ReplicatedStorage (ref), u25 (copy)
        local v27 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
        local v28 = p26 or getCurrentStyle();

        if v28 ~= "" and (NELQuests[v28] and (PlayerData.Data.DisabledMasteryLevels[v28] and (countStyleMastery(PlayerData.Data, v28) >= 4 and not PlayerData.Data.DisabledMasteryLevels[v28][4]))) then
            v28 = NELQuests[v28].NELName;
        end;

        if v27 and (v28 ~= "" and not table.find(u2, v28)) then
            local v29 = ReplicatedStorage.Assets.ReplicatedAnims.Awakening:FindFirstChild(v28);

            if not v29 then
                return;
            end;

            u25.AwakeningPlrAnimation = v27:LoadAnimation(v29);
        end;
    end;

    updAwakeningAnim();
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 269
        -- upvalues: updAwakeningAnim (copy)
        updAwakeningAnim();
    end);
    PlayerData:Observe({ "StyleQuestData" }, function() -- Line: 274
        -- upvalues: updAwakeningAnim (copy)
        updAwakeningAnim();
    end);
    StatesController.CharacterEvents.StyleChanged:Connect(updAwakeningAnim);
    u25.BaseTrove:Connect(UserInputService.InputBegan, function(p30, p31) -- Line: 280
        -- upvalues: LocalPlayer (ref), u6 (ref), u4 (ref), getCurrentStyle (ref), LorenzoAwakeningRules (ref), PlayerData (ref), u25 (copy)
        if p31 then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if u6.Values.IsInPenalty.Value then
            local table_find_ret = table.find(u4, getCurrentStyle());

            if not table_find_ret then
                if getCurrentStyle() == "Don Lorenzo" then
                    table_find_ret = LorenzoAwakeningRules.inOwnBox(LocalPlayer);
                else
                    table_find_ret = false;
                end;
            end;

            if not table_find_ret then
                return;
            end;
        end;

        if p30.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.PC.Awaken] or p30.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Awaken] then
            u25:Awakening();
        end;
    end);
    local os_time_ret = os.time();
    u25.BaseTrove:Connect(u25.AwakeningService.AwakenEveryone, function(p32, p33) -- Line: 295
        -- upvalues: LocalPlayer (ref), u25 (copy), workspace_CurrentCamera (ref), os_time_ret (ref), RunService (ref)
        if LocalPlayer.Team == game.Teams.Visitor and not u25.Spectator.IsSpectating then
            return;
        end;

        if p32 == LocalPlayer then
            return;
        end;

        u25.Camera.Cutscene = true;
        local u34 = nil;
        local CFrame = workspace_CurrentCamera.CFrame;

        local function reset() -- Line: 303
            -- upvalues: u25 (ref), u34 (ref), workspace_CurrentCamera (ref), CFrame (copy), LocalPlayer (ref)
            u25.Camera.Cutscene = false;
            u34:Disconnect();
            workspace_CurrentCamera.CFrame = CFrame;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            if u25.Spectator.IsSpectating then
                LocalPlayer.PlayerGui.Spectate.Enabled = true;
            end;

            if not workspace_CurrentCamera.CameraSubject.Parent then
                workspace_CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
            end;
        end;

        local u35 = 0;
        local u36 = false;
        os_time_ret = os.time();
        u34 = RunService.Heartbeat:Connect(function() -- Line: 330
            -- upvalues: os_time_ret (ref), reset (copy), u35 (ref), u36 (ref), LocalPlayer (ref), workspace_CurrentCamera (ref)
            if os_time_ret + 15 < os.time() then
                reset();

                return;
            end;

            if workspace:FindFirstChild("AwakeningCam") == nil then
                u35 = u35 + 1;

                if u35 < 120 and not u36 then
                    return;
                end;

                reset();

                return;
            end;

            LocalPlayer.PlayerGui.InGameUI.Enabled = false;
            LocalPlayer.PlayerGui.Spectate.Enabled = false;
            local workspace_AwakeningCam = workspace.AwakeningCam;
            local v37 = workspace_AwakeningCam:FindFirstChild("Torso") or (workspace_AwakeningCam:FindFirstChild("camera") or workspace_AwakeningCam:FindFirstChild("CamPart"));
            u36 = true;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            workspace_CurrentCamera.CFrame = v37.CFrame;
        end);
    end);
    local InGameUI = LocalPlayer.PlayerGui:WaitForChild("InGameUI");
    local Awakening = InGameUI.Bottom.Awakening;
    local BG = Awakening.BG;
    local u38 = {};
    local u39 = {};

    for i, v in u5 do
        local v40 = Awakening:FindFirstChild(v);
        local v41;

        if v40 then
            v41 = v40:FindFirstChild("BG");
        else
            v41 = v40;
        end;

        local v42;

        if v40 then
            v42 = v40:FindFirstChild("Bar");
        else
            v42 = v40;
        end;

        local v43 = v41 and v41:FindFirstChild("Fill");

        if v43 then
            v42 = v43;
        elseif v42 then
            v42 = v42:FindFirstChild("Fill");
        end;

        local v44;

        if v40 then
            v44 = v40:FindFirstChild("Keybind");
        else
            v44 = v40;
        end;

        if v40 and (v40:IsA("Frame") and (v42 and (v42:IsA("GuiObject") and (not v44 or v44:IsA("TextLabel"))))) then
            u38[i] = v40;
            u39[v40] = {
                fill = v42,
                keybind = v44,
                fullPosition = v42.Position,
                fullSize = v42.Size
            };
        else
            warn((`[AwakeningController] Missing or malformed custom awakening bar "{v}" for style "{i}"; using legacy bar.`));
        end;
    end;

    for _, child in Awakening:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = false;
        end;
    end;

    local u45 = nil;

    local function selectAwakeningBar(p46) -- Line: 393
        -- upvalues: Awakening (copy), u45 (ref), u38 (copy), BG (copy), Awakening (copy)
        for _, child in Awakening:GetChildren() do
            if child:IsA("Frame") then
                child.Visible = false;
            end;
        end;

        u45 = u38[p46];
        BG.Visible = u45 == nil;
        Awakening.Visible = false;
    end;

    local function setCustomBarFill(p47, p48) -- Line: 405
        -- upvalues: u39 (copy)
        local v49 = u39[p47];

        if not v49 then
            return;
        end;

        local fill = v49.fill;
        local fullPosition = v49.fullPosition;
        local fullSize = v49.fullSize;
        local math_clamp_ret = math.clamp(p48, 0, 1);
        local X = fill.AnchorPoint.X;
        local v50 = fullPosition.X.Scale - fullSize.X.Scale * X;
        local v51 = fullPosition.X.Offset - fullSize.X.Offset * X;
        local v52 = fullSize.X.Scale * math_clamp_ret;
        local v53 = fullSize.X.Offset * math_clamp_ret;
        fill.Size = UDim2.new(v52, v53, fullSize.Y.Scale, fullSize.Y.Offset);
        fill.Position = UDim2.new(v50 + v52 * X, v51 + v53 * X, fullPosition.Y.Scale, fullPosition.Y.Offset);
    end;

    selectAwakeningBar(LocalPlayer.PlayerStats.Style.Value);
    u25.BaseTrove:Connect(LocalPlayer.PlayerStats.Style.Changed, selectAwakeningBar);
    u25.BaseTrove:Connect(RunService.Heartbeat, function() -- Line: 431
        -- upvalues: LocalPlayer (ref), u45 (ref), BG (copy), Awakening (copy), InGameUI (copy), u39 (copy), setCustomBarFill (copy)
        local Value = LocalPlayer.PlayerStats.AwakeningBar.Value;
        local Value2 = LocalPlayer.PlayerStats.InAwakening.Value;
        BG.Visible = u45 == nil;

        if Value <= 90 and not Value2 then
            Awakening.Visible = false;

            if u45 then
                u45.Visible = false;
            end;

            InGameUI.Bottom.Flow.Position = UDim2.new(0.5, 0, 0.35, 0);

            return;
        end;

        if not Value2 then
            Awakening.Visible = true;
            InGameUI.Bottom.Flow.Position = UDim2.new(0.5, 0, 0.05, 0);

            if not u45 then
                Awakening.BG.Activation.Visible = true;
                Awakening.BG.Bar.Size = UDim2.fromScale(1, 1);

                return;
            end;

            u45.Visible = true;
            local v54 = u39[u45];

            if v54.keybind then
                v54.keybind.Visible = true;
            end;

            setCustomBarFill(u45, 1);

            return;
        end;

        Awakening.Visible = true;
        InGameUI.Bottom.Flow.Position = UDim2.new(0.5, 0, 0.05, 0);

        if not u45 then
            Awakening.BG.Activation.Visible = false;
            Awakening.BG.Bar.Size = UDim2.fromScale(math.min(1, Value / 100), 1);

            return;
        end;

        u45.Visible = true;
        local v55 = u39[u45];
        local math_round_ret = math.round(Value);
        local math_clamp_ret = math.clamp(math_round_ret, 0, 100);

        if v55.keybind then
            v55.keybind.Visible = true;
            v55.keybind.Text = `{math_clamp_ret}%`;
        end;

        setCustomBarFill(u45, Value / 100);
    end);
end;

function v8.KnitInit(u56) -- Line: 480
    -- upvalues: Trove (copy), u1 (ref), Knit (copy), StatesController (ref), LocalPlayer (copy), u6 (ref), Humanoid (ref), HumanoidRootPart (ref)
    u56.Trove = Trove.new();
    u1 = Knit.GetController("AbilityController");
    StatesController = Knit.GetController("StatesController");
    u56.Trove:Connect(LocalPlayer.CharacterAdded, function(p57) -- Line: 485
        -- upvalues: u6 (ref), Humanoid (ref), HumanoidRootPart (ref), u56 (copy)
        u6 = p57;
        Humanoid = u6:WaitForChild("Humanoid");
        HumanoidRootPart = u6:WaitForChild("HumanoidRootPart");

        if u56.CurrentUlt then
            u56.CurrentUlt:Destroy();
        end;
    end);
    u56.Trove:Connect(game.Players.PlayerRemoving, function(p58) -- Line: 493
        -- upvalues: LocalPlayer (ref), u6 (ref), HumanoidRootPart (ref), Humanoid (ref), u56 (copy)
        if p58 == LocalPlayer then
            u6 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u56.Trove:Destroy();
            u56.BaseTrove:Destroy();
        end;
    end);
end;

return v8;