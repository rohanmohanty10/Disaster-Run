 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local ScriptableEmotes = require(ReplicatedStorage.Shared.Tables.ScriptableEmotes);
local TopbarPlus = require(ReplicatedStorage.Shared.Utility.TopbarPlus);
local GetHumDescription = require(ReplicatedStorage.Shared.Utility.GetHumDescription);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Assets = ReplicatedStorage.Assets;
local EmoteAnimations = Assets.EmoteAnimations;
local TemplateRig = Assets.Misc.TemplateRig;
local Camera = Instance.new("Camera");
Camera.CameraType = Enum.CameraType.Scriptable;
Camera.CFrame = CFrame.lookAt(Vector3.new(-0, -0, -5), Vector3.new(0, 0, 0));
local u1 = Trove.new();
local u2 = Trove.new();
local u3 = nil;
local u4 = {};
local u5 = {
    [Enum.KeyCode.One] = 1,
    [Enum.KeyCode.Two] = 2,
    [Enum.KeyCode.Three] = 3,
    [Enum.KeyCode.Four] = 4,
    [Enum.KeyCode.Five] = 5,
    [Enum.KeyCode.Six] = 6,
    [Enum.KeyCode.Seven] = 7,
    [Enum.KeyCode.Eight] = 8
};
local u6 = nil;
local u7 = tick();
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = Knit.CreateController({
    Name = "EmotesController"
});

function u11.ToggleGui(p12: table, p13: boolean?, p14: boolean?) -- Line: 53
    -- upvalues: LocalPlayer (copy), u6 (ref), Trove (copy), u9 (ref), Knit (copy)
    local Emotes = LocalPlayer.PlayerGui.Emotes;

    if u6.Player.Emotes8x then
        Emotes.Enabled = false;
        Emotes = LocalPlayer.PlayerGui.Emotes8x;
    elseif LocalPlayer.PlayerGui.Locker.Enabled then
        Emotes.Emotes8x.Visible = true;
    else
        Emotes.Emotes8x.Visible = false;
    end;

    if p13 == nil then
        p13 = not Emotes.Enabled;
    end;

    if p13 == Emotes.Enabled and not p14 then
        return;
    end;

    if p12.EmoteTrove then
        p12.EmoteTrove:Clean();
    else
        p12.EmoteTrove = Trove.new();
    end;

    Emotes.Enabled = p13;

    if p13 then
        p12.LastShiftock = u9.Shiftlock;
    end;

    if not Emotes.Enabled then
        if p12.LastShiftlock then
            u9:SetShiftlock(p12.LastShiftlock);
        end;

        return;
    end;

    u9:SetShiftlock(false);

    if LocalPlayer.PlayerGui.Locker.Enabled then
        Emotes.BG.CloseText.Visible = false;
        Emotes.BG.Position = UDim2.fromScale(0.4, 0.5);

        return;
    end;

    local Controller = Knit.GetController("KeybindsController");

    if Controller.GetPlatform() == "Touchscreen" then
        Emotes.BG.CloseText.Key.Text = "Press The Top-Left Icon To Close!";
        Emotes.BG.CloseText.Key2.Text = "";
        Emotes.BG.CloseText.Input.Visible = false;
    else
        Emotes.BG.CloseText.Key.Text = "Press";
        Emotes.BG.CloseText.Key2.Text = "To Close!";
        Emotes.BG.CloseText.Input.Visible = true;
        Emotes.BG.CloseText.Input.Image = Controller.GetKeybindIcon("Emotes Wheel");
    end;

    Emotes.BG.CloseText.Visible = true;
    Emotes.BG.Position = UDim2.fromScale(0.5, 0.5);
end;

function u11.CreatePreview(p15: table, p16: string, p17: userdata, p18: userdata, p19: string) -- Line: 120
    -- upvalues: Camera (copy), EmoteAnimations (copy)
    if p17:FindFirstChild("WorldModel") then
        p17:FindFirstChild("WorldModel"):Destroy();
    end;

    p17.CurrentCamera = Camera;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = p17;
    local v20 = p18:Clone();

    if v20:FindFirstChild("Animate") then
        v20.Animate:Destroy();
    end;

    v20.Parent = WorldModel;
    v20.HumanoidRootPart.CFrame = CFrame.identity;
    local v21 = v20.Humanoid.Animator:LoadAnimation(p19 and EmoteAnimations:FindFirstChild(p19) or EmoteAnimations:FindFirstChild(p16));
    v21.Looped = true;
    v21:Play();
end;

function u11.CancelPlayingEmote(p22) -- Line: 142
    -- upvalues: u2 (copy)
    u2:Clean();
end;

function u11.PlayEmoteFromName(p23: table, u24: userdata, p25: string, p26: number?, p27: userdata?) -- Line: 146
    -- upvalues: EmoteAnimations (copy), Customization (copy), u6 (ref), Effects (copy), ReplicatedStorage (copy), u2 (copy), Knit (copy), u3 (ref), RunService (copy), LocalPlayer (copy), ScriptableEmotes (copy)
    local v28 = EmoteAnimations:FindFirstChild(p25);
    local v29 = Customization.Emotes[p25];
    local v30 = p27 and true or v28:GetAttribute("CanMoveWhilePlaying");

    if not v30 and u24.MoveDirection.Magnitude > 0.1 then
        return false;
    end;

    if v29 ~= nil and (v29.CannotPlayInRanked == true and u6.Gamemode ~= "Normal") then
        Effects:Popup("Cannot Play This Emote In Ranked!");

        return false;
    end;

    if v29 ~= nil and (v29.DuoCallback ~= nil and u6.Gamemode ~= "Normal") then
        Effects:Popup("Cannot play Duo Emotes in Ranked!");

        return false;
    end;

    if v29 ~= nil and (v29.CannotHoldBall and u6.CharValues.HasBall) then
        Effects:Popup("Cannot play this emote while holding the ball!");

        return false;
    end;

    if v29 ~= nil and (v29.CannotPlayOnScore and ReplicatedStorage.GameValues.Scoring.Value == true) then
        Effects:Popup("Cannot play this while scoring!");

        return false;
    end;

    u2:Clean();
    local Controller = Knit.GetController("AnimationController");

    if Customization.Emotes[p25] and not Customization.Emotes[p25].DontPlay then
        local u31 = nil;

        if Customization.Emotes[p25].ID2 then
            local v32;

            if p26 == 2 then
                v32 = p25 .. "2" or p25;
            else
                v32 = p25;
            end;

            u31 = Controller.Anims.Emotes[v32];
            u31.Priority = Enum.AnimationPriority.Action2;
            u31:Play();
        elseif Customization.Emotes[p25].ID then
            u31 = Controller.Anims.Emotes[p25];
            u31.Priority = Enum.AnimationPriority.Action2;
            u31:Play();
        end;

        if u31 then
            u2:Add(function() -- Line: 198
                -- upvalues: u31 (ref)
                u31:Stop();
                u31:Destroy();
            end);
        end;
    end;

    u2:Add(function() -- Line: 205
        -- upvalues: u3 (ref)
        u3 = nil;
    end);
    u3 = p25;

    if v29 and not v29.DisableAirChecks then
        u2:Add(u24:GetPropertyChangedSignal("FloorMaterial"):Connect(function() -- Line: 212
            -- upvalues: u24 (copy), u2 (ref)
            if u24.FloorMaterial == Enum.Material.Air then
                u2:Clean();
            end;
        end));
    end;

    u2:Add(u24.Jumping:Once(function() -- Line: 219
        -- upvalues: u2 (ref)
        u2:Clean();
    end));
    u2:Add(workspace.ChildAdded:Connect(function(p33) -- Line: 223
        -- upvalues: u2 (ref)
        if p33.Name == "CamRig" then
            u2:Clean();
        end;
    end));
    local HasBall = u6.CharValues.HasBall;
    u2:Add(RunService.Heartbeat:Connect(function() -- Line: 230
        -- upvalues: u6 (ref), HasBall (copy), u2 (ref)
        if u6.CharValues.HasBall ~= HasBall then
            u2:Clean();
        end;
    end));

    if v30 then
        u2:Connect(RunService.Heartbeat, function() -- Line: 237
            -- upvalues: LocalPlayer (ref), u2 (ref)
            if LocalPlayer.Team == game.Teams.Visitor then
                return;
            end;

            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local math_round_ret = math.round(LocalPlayer.Character.HumanoidRootPart.Position.Y);

                if math_round_ret > -100 and math_round_ret < 4 then
                    u2:Clean();
                end;
            end;
        end);
    else
        u2:Add(u24:GetPropertyChangedSignal("MoveDirection"):Once(function() -- Line: 247
            -- upvalues: u2 (ref)
            u2:Clean();
        end));
    end;

    if ScriptableEmotes[p25] and (v29 == nil or not v29.IsCutscene) then
        if p27 then
            task.spawn(ScriptableEmotes[p25], LocalPlayer, p27, u2);
        else
            task.spawn(ScriptableEmotes[p25], LocalPlayer, u2, p26);
        end;
    end;

    return true;
end;

local u34 = false;

function u11.PlayEmote(p35: table, p36: userdata, p37: number) -- Line: 264
    -- upvalues: u6 (ref), u7 (ref), u8 (ref), u3 (ref), u2 (copy), u11 (copy), ScriptableEmotes (copy), u34 (ref), Knit (copy)
    if p37 > 4 and not u6.Player.Emotes8x then
        return;
    end;

    if u7 > tick() then
        return;
    end;

    if u8.States.Ability then
        return;
    end;

    if workspace:FindFirstChild("CamRig") then
        return;
    end;

    u7 = tick() + 0.5;
    local u38 = u6.Player.Customization.Equipped.Emotes[`Emotes{p37}`];

    if u38 == nil or (u38 == "" or u3 == u38) then
        u2:Clean();

        return;
    end;

    u11:ToggleGui(false);
    local math_random_ret = math.random(1, 2);

    if u11:PlayEmoteFromName(p36, u38, math_random_ret) == false then
        return;
    end;

    u2:Add(function() -- Line: 290
        -- upvalues: ScriptableEmotes (ref), u38 (copy), u34 (ref), Knit (ref)
        if ScriptableEmotes[u38] and not u34 then
            task.spawn(function() -- Line: 292
                -- upvalues: Knit (ref)
                Knit.GetService("CustomizationService"):StopEmote();
            end);
        end;

        u34 = false;
    end);

    if ScriptableEmotes[u38] then
        Knit.GetService("CustomizationService"):StartEmote(u38, math_random_ret);
    end;
end;

local u39 = {};
local u40 = {};

function u11.InitializeEmoteButton(p41: table, u42: userdata, u43: userdata) -- Line: 309
    -- upvalues: LocalPlayer (copy), u6 (ref), Customization (copy), u11 (copy), u40 (copy), u1 (copy), u39 (ref), Knit (copy), TweenService (copy)
    local BG = LocalPlayer.PlayerGui:WaitForChild(u6.Player.Emotes8x and "Emotes8x" or "Emotes"):WaitForChild("BG");
    local string_sub_ret = string.sub(u42.Name, -1, -1);
    local u44 = tonumber(string_sub_ret);
    local u45 = u6.Player.Customization.Equipped.Emotes[`{u44}`];

    local function UpdatePreview() -- Line: 314
        -- upvalues: u45 (ref), u6 (ref), u44 (copy), Customization (ref), BG (copy), u11 (ref), u42 (copy), u43 (copy)
        u45 = u6.Player.Customization.Equipped.Emotes[`Emotes{u44}`];
        local v46 = Customization.Emotes[u45];

        if not u45 or u45 == "" then
            BG:FindFirstChild((`Text{u44}`)).Text = "None";
            BG:FindFirstChild((`Caption{u44}`)).Visible = false;

            if u42:FindFirstChild("WorldModel") then
                u42:FindFirstChild("WorldModel"):Destroy();
            end;

            return;
        end;

        BG:FindFirstChild((`Text{u44}`)).Text = u45;
        local v47;

        if v46.Caption then
            v47 = v46.Caption;
        else
            v47 = v46.IsCutscene and "CUTSCENE" or "";
        end;

        BG:FindFirstChild((`Caption{u44}`)).Text = v47;
        BG:FindFirstChild((`Caption{u44}`)).Visible = v47 ~= "";
        u11:CreatePreview(u45, u42, u43);
    end;

    local function UpdateAllPreviews() -- Line: 340
        -- upvalues: u40 (ref)
        for _, v in u40 do
            task.spawn(v);
        end;
    end;

    UpdatePreview();
    table.insert(u40, UpdatePreview);
    u1:Connect(BG.Parent:GetPropertyChangedSignal("Enabled"), UpdatePreview);
    local v48 = BG:WaitForChild((`Button{u44}`));

    if u39[v48] then
        return;
    end;

    u39[v48] = true;
    u1:Connect(v48.MouseButton1Click, function() -- Line: 357
        -- upvalues: LocalPlayer (ref), Knit (ref), u6 (ref), u44 (copy), u40 (ref), u45 (ref), u11 (ref)
        if not LocalPlayer.PlayerGui.Locker.Enabled then
            local v49 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid");

            if not v49 or u45 == "" then
                return;
            end;

            u11:PlayEmote(v49, u44);

            return;
        end;

        local Controller = Knit.GetController("LockerController");
        local Service = Knit.GetService("CustomizationService");
        local v50 = Controller.LastSelectedEmote or "";
        u6.Player.Customization.Equipped.Emotes[`Emotes{u44}`] = v50;
        Service.Equip:Fire(v50, "Emotes", u44);
        Controller.LastSelectedEmote = nil;
        Controller:UpdateEmoteItems();

        for _, v in u40 do
            task.spawn(v);
        end;
    end);
    local u51 = BG:WaitForChild((`EmoteFrame{u44}`));
    local TweenInfo_new_ret = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
    local Size = u51.Size;
    local Position = u51.Position;
    u1:Connect(v48.MouseEnter, function() -- Line: 386
        -- upvalues: TweenService (ref), u51 (copy), TweenInfo_new_ret (copy), Size (copy), Position (copy), BG (copy), u44 (copy)
        TweenService:Create(u51, TweenInfo_new_ret, {
            Size = UDim2.fromScale(Size.X.Scale * 1.1, Size.Y.Scale * 1.1),
            Position = Position + (BG.Name == "Emotes" and UDim2.fromScale(math.cos(6.283185307179586 * (u44 / 4) - 0.7853981633974483) * -0.05, math.sin(6.283185307179586 * (u44 / 4) - 0.7853981633974483) * -0.05) or UDim2.fromScale(0, 0))
        }):Play();
    end);
    u1:Connect(v48.MouseLeave, function() -- Line: 395
        -- upvalues: TweenService (ref), u51 (copy), TweenInfo_new_ret (copy), Size (copy), Position (copy)
        TweenService:Create(u51, TweenInfo_new_ret, {
            Size = Size,
            Position = Position
        }):Play();
    end);
end;

function u11.InitializeEmotes(p52) -- Line: 403
    -- upvalues: u1 (copy), u39 (ref), u40 (copy), GetHumDescription (copy), LocalPlayer (copy), TemplateRig (copy), u11 (copy), u6 (ref)
    u1:Clean();
    u39 = {};
    table.clear(u40);
    local v53 = GetHumDescription.FromUserId(LocalPlayer.UserId);
    local v54 = u1:Add(TemplateRig:Clone());
    v54.HumanoidRootPart.Anchored = true;
    v54.Parent = workspace;
    v54.Humanoid:ApplyDescriptionReset(v53);
    v54.Parent = nil;
    u11.CharacterRig = v54;

    for _, child in LocalPlayer.PlayerGui:WaitForChild(u6.Player.Emotes8x and "Emotes8x" or "Emotes"):WaitForChild("BG"):GetChildren() do
        if child:IsA("ViewportFrame") then
            u11:InitializeEmoteButton(child, v54);
        end;
    end;
end;

function u11.KnitStart(p55) -- Line: 430
    -- upvalues: u6 (ref), Knit (copy), u8 (ref), u9 (ref), u10 (ref), TopbarPlus (copy), u11 (copy), UserInputService (copy), LocalPlayer (copy), u5 (copy), u2 (copy), u4 (copy), Trove (copy), ScriptableEmotes (copy), u34 (ref), MarketplaceService (copy)
    u6 = Knit.GetController("Network");
    u8 = Knit.GetController("MovementController");
    u9 = Knit.GetController("CameraController");
    u10 = Knit.GetController("PromptController");
    local u56 = tick();
    TopbarPlus.new():setName("Emotes"):setImage(90948029601506):oneClick(true):setImageScale(0.7):setOrder(10).toggled:Connect(function(p57) -- Line: 445
        -- upvalues: u11 (ref)
        if not p57 then
            return;
        end;

        u11:ToggleGui();
    end);
    local Controller = Knit.GetController("KeybindsController");
    UserInputService.InputBegan:Connect(function(p58, p59) -- Line: 455
        -- upvalues: Controller (copy), u56 (ref), u11 (ref), LocalPlayer (ref), u5 (ref), u6 (ref)
        if p59 then
            return;
        end;

        if Controller.IsInputValid(p58, "Emotes Wheel") then
            if u56 > tick() then
                return;
            end;

            u11:ToggleGui();

            if not LocalPlayer.PlayerGui.Emotes.Enabled then
                u56 = tick() + 0.15;
            end;
        elseif u5[p58.KeyCode] and (not u6.Player.Customization.Settings.KeybindPassing or u5[p58.KeyCode] > 4) and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then
            u11:PlayEmote(LocalPlayer.Character:FindFirstChild("Humanoid"), u5[p58.KeyCode]);
        end;
    end);
    local Service = Knit.GetService("CustomizationService");
    Service.InitializeEmotes:Connect(function() -- Line: 474
        -- upvalues: u11 (ref)
        u11:InitializeEmotes();
    end);
    task.spawn(function() -- Line: 478
        -- upvalues: u11 (ref)
        u11:InitializeEmotes();
    end);
    Service.EmoteStarted:Connect(function(p60: any, p61: any, p62: any, p63: userdata?) -- Line: 482
        -- upvalues: LocalPlayer (ref), u11 (ref), u2 (ref), Knit (ref), u4 (ref), Trove (ref), ScriptableEmotes (ref)
        if p60 == LocalPlayer then
            u11:PlayEmoteFromName(LocalPlayer.Character.Humanoid, p61, p62, p63);
            u2:Add(function() -- Line: 489
                -- upvalues: Knit (ref)
                task.spawn(function() -- Line: 490
                    -- upvalues: Knit (ref)
                    Knit.GetService("CustomizationService"):StopEmote();
                end);
            end);

            return;
        end;

        if u4[p60] then
            u4[p60]:Destroy();
            u4[p60] = nil;
        end;

        u4[p60] = Trove.new();

        if p63 == nil then
            ScriptableEmotes[p61](p60, u4[p60], p62);

            return;
        end;

        ScriptableEmotes[p61](p60, p63, u4[p60]);
    end);
    Service.EmoteStopped:Connect(function(p64) -- Line: 514
        -- upvalues: LocalPlayer (ref), u34 (ref), u2 (ref), u4 (ref)
        if p64 ~= LocalPlayer then
            if u4[p64] then
                u4[p64]:Destroy();
                u4[p64] = nil;
            end;

            return;
        end;

        u34 = true;
        u2:Clean();
    end);
    local RobuxButton = LocalPlayer.PlayerGui:WaitForChild("Emotes"):WaitForChild("Emotes8x"):WaitForChild("RobuxButton");
    local v65 = u10.RepeatGetProductInfo(1893616619, Enum.InfoType.GamePass);
    RobuxButton.Text.Text = v65.PriceInRobux;
    RobuxButton.MouseButton1Click:Connect(function() -- Line: 536
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1893616619);
    end);
end;

return u11;