  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);
local environment = require(ReplicatedStorage.Shared.environment);
local RankedData = require(ReplicatedStorage.Shared.Ranked.RankedData);
local TweenService = game:GetService("TweenService");
local Popup = require(ReplicatedStorage.Shared.Popup);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local workspace_CurrentCamera = workspace.CurrentCamera;
local v1 = Knit.CreateController({
    Name = "RankedMatchController"
});

local function openPickTeamWithAnim(p2, p3) -- Line: 20
    -- upvalues: PlayerGui (copy), LocalPlayer (copy), workspace_CurrentCamera (copy), TweenService (copy), Debris (copy), Popup (copy)
    local PickTeam = PlayerGui:WaitForChild("PickTeam");
    local v4 = p2 == "Home" and "Away" or "Home";
    local v5 = PickTeam:FindFirstChild(p2);
    local v6 = PickTeam:FindFirstChild(v4);

    if v5 then
        v5.Visible = true;
    end;

    if v6 then
        v6.Visible = false;
    end;

    local v7 = PickTeam:FindFirstChild(v4 .. "Full");

    if v7 then
        v7.Visible = false;
    end;

    local v8 = PickTeam:FindFirstChild(p2 .. "Full");

    if v8 then
        v8.Visible = false;
    end;

    local v9 = PickTeam:FindFirstChild(v4 .. "BG");

    if v9 then
        v9.Visible = false;
    end;

    local Return = PickTeam:FindFirstChild("Return");

    if Return then
        Return.Visible = false;
    end;

    for _, child in v5:GetChildren() do
        if child:IsA("ImageButton") then
            child.Visible = table.find(p3, child.Name) ~= nil;
        end;
    end;

    LocalPlayer:SetAttribute("RankedPickPhase", true);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    task.spawn(function() -- Line: 47
        -- upvalues: TweenService (ref), Debris (ref)
        if game.Lighting:FindFirstChild("Blur") then
            local v10 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = 3
            });
            v10:Play();
            Debris:AddItem(v10, 0.1);
        end;
    end);
    local v11 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 70
    });
    v11:Play();
    Debris:AddItem(v11, 0.1);
    Popup.BlackoutLocal(LocalPlayer, "Tp1", "Tp2", nil, 2);
    Popup.BlackoutLocal(LocalPlayer, "Tp1", "Tp2", true, 2);
    local GK = PlayerGui.InGameUI:FindFirstChild("GK");

    if GK then
        GK.Visible = false;
    end;

    task.delay(0.375, function() -- Line: 67
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), Debris (ref), PlayerGui (ref), PickTeam (copy)
        local v12 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = workspace:WaitForChild("TeamSelect").CFrame
        });
        v12:Play();
        Debris:AddItem(v12, 0.25);
        PlayerGui.HUD.Enabled = false;
        PickTeam.Enabled = true;
    end);
end;

function v1.KnitStart(p13) -- Line: 77
    -- upvalues: environment (copy), LocalPlayer (copy), PlayerGui (copy), Knit (copy), openPickTeamWithAnim (copy), workspace_CurrentCamera (copy), TweenService (copy), ReplicatedStorage (copy), Players (copy)
    p13:SetupPostMatch();
    p13:SetupPostMatchButtons();

    if environment.mode ~= "Ranked" then
        return;
    end;

    LocalPlayer:SetAttribute("RankedPickPhase", true);
    local WaitingForPlayers = PlayerGui:WaitForChild("WaitingForPlayers");
    local u14 = nil;

    if not (u14 or LocalPlayer:GetAttribute("SkipRankedWaiting")) then
        WaitingForPlayers.Enabled = true;
    end;

    task.spawn(function() -- Line: 89
        -- upvalues: PlayerGui (ref)
        local InGameUI = PlayerGui:WaitForChild("InGameUI", 10);
        local v15 = InGameUI and InGameUI:WaitForChild("Return", 10);

        if v15 then
            v15.Visible = false;
            v15.Active = false;
        end;
    end);
    local StarterGui = game:GetService("StarterGui");
    pcall(function() -- Line: 101
        -- upvalues: StarterGui (copy)
        StarterGui:SetCore("ResetButtonCallback", false);
    end);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 104
        -- upvalues: StarterGui (copy)
        pcall(function() -- Line: 105
            -- upvalues: StarterGui (ref)
            StarterGui:SetCore("ResetButtonCallback", false);
        end);
    end);
    local Service = Knit.GetService("RankedMatchService");
    local PickTeam = PlayerGui:WaitForChild("PickTeam");
    local InGameUI = PlayerGui:FindFirstChild("InGameUI");
    local v16 = InGameUI and InGameUI:FindFirstChild("Return");

    if v16 then
        v16.Visible = false;
        v16.Active = false;
    end;

    PlayerGui.HUD:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 122
        -- upvalues: LocalPlayer (ref), PlayerGui (ref)
        if LocalPlayer:GetAttribute("RankedPickPhase") and PlayerGui.HUD.Enabled then
            PlayerGui.HUD.Enabled = false;
        end;
    end);
    Service.ShowPositionPick:Connect(function(p17, p18, p19) -- Line: 128
        -- upvalues: LocalPlayer (ref), PlayerGui (ref), openPickTeamWithAnim (ref)
        LocalPlayer:SetAttribute("RankedPickPhase", true);
        PlayerGui.HUD.Enabled = false;
        openPickTeamWithAnim(p17, p18);
    end);
    Service.PickCountdown:Connect(function(p20) -- Line: 134
        -- upvalues: PickTeam (copy)
        if PickTeam.Enabled then
            PickTeam:SetAttribute("Countdown", p20);
        end;
    end);
    Service.HidePositionPick:Connect(function() -- Line: 140
        -- upvalues: LocalPlayer (ref), Knit (ref), PickTeam (copy), workspace_CurrentCamera (ref), TweenService (ref), PlayerGui (ref)
        LocalPlayer:SetAttribute("RankedPickPhase", nil);
        local Controller = Knit.GetController("RankedController");

        if Controller then
            Controller:HideQueueUI();
        end;

        PickTeam.Enabled = false;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

        if game.Lighting:FindFirstChild("Blur") then
            TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
        end;

        PlayerGui.HUD.Enabled = true;
    end);
    task.spawn(function() -- Line: 159
        -- upvalues: ReplicatedStorage (ref), Service (copy), PlayerGui (ref), LocalPlayer (ref), WaitingForPlayers (copy), u14 (ref)
        local KnitClient = ReplicatedStorage:FindFirstChild("KnitClient");

        if KnitClient and KnitClient:FindFirstChild("Loaded") then
            KnitClient.Loaded.Event:Wait();
        end;

        task.wait(0.5);
        Service:ClientReady();
        task.spawn(function() -- Line: 167
            -- upvalues: PlayerGui (ref)
            local InGameUI2 = PlayerGui:WaitForChild("InGameUI", 10);
            local v21 = InGameUI2 and InGameUI2:WaitForChild("Return", 10);

            if v21 then
                v21.Visible = false;
                v21.Active = false;
            end;
        end);
        Service.ShowWaiting:Connect(function(p22, p23) -- Line: 180
            -- upvalues: LocalPlayer (ref), WaitingForPlayers (ref)
            if LocalPlayer:GetAttribute("SkipRankedWaiting") then
                return;
            end;

            WaitingForPlayers.Enabled = true;
            WaitingForPlayers.Frame.Counter.Text = p22 .. " / " .. p23;
        end);
        Service.UpdateWaiting:Connect(function(p24, p25) -- Line: 186
            -- upvalues: WaitingForPlayers (ref)
            if WaitingForPlayers.Enabled then
                WaitingForPlayers.Frame.Counter.Text = p24 .. " / " .. p25;
            end;
        end);
        Service.HideWaiting:Connect(function() -- Line: 192
            -- upvalues: u14 (ref), WaitingForPlayers (ref)
            u14 = true;
            WaitingForPlayers.Enabled = false;
        end);
    end);
    Service.UpdatePositionPick:Connect(function(u26, p27, p28) -- Line: 199
        -- upvalues: LocalPlayer (ref), PickTeam (copy), Players (ref)
        if p27 ~= LocalPlayer:GetAttribute("RankedTeam") then
            return;
        end;

        local v29 = PickTeam:FindFirstChild(p27);

        if not v29 then
            return;
        end;

        local u30 = v29:FindFirstChild(p28);

        if not u30 then
            return;
        end;

        if u30:FindFirstChild("plr") then
            u30.plr.Text = u26;
        end;

        task.spawn(function() -- Line: 213
            -- upvalues: Players (ref), u26 (copy), u30 (copy)
            local u31 = Players:FindFirstChild(u26);

            if u31 and u30:FindFirstChild("Png") then
                local success, result = pcall(function() -- Line: 216
                    -- upvalues: Players (ref), u31 (copy)
                    return Players:GetUserThumbnailAsync(u31.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
                end);

                if success then
                    u30.Png.Image = result;
                end;
            end;
        end);
    end);
end;

function v1.SetupPostMatch(p32) -- Line: 227
    -- upvalues: Knit (copy), PlayerGui (copy), RankedData (copy), TweenService (copy), workspace_CurrentCamera (copy), LocalPlayer (copy)
    Knit.GetService("RankedService").RankedPostMatch:Connect(function(p33) -- Line: 230
        -- upvalues: PlayerGui (ref), RankedData (ref), TweenService (ref), workspace_CurrentCamera (ref), LocalPlayer (ref)
        warn("[RankedMatchController] RankedPostMatch received, showing UI");
        local RankedPostMatch = PlayerGui:FindFirstChild("RankedPostMatch");

        if not RankedPostMatch then
            warn("[RankedMatchController] RankedPostMatch GUI not found!");

            return;
        end;

        local PostMatch = PlayerGui:FindFirstChild("PostMatch");

        if PostMatch then
            PostMatch.Enabled = false;
        end;

        local PostMatch2 = RankedPostMatch.PostMatch;
        local EloChange = PostMatch2.EloBG.EloChange;
        local Rank = PostMatch2.Rank;
        local RealBar = PostMatch2.totalbg.Bar.RealBar;
        local Old = PostMatch2.totalbg.Old;
        local New = PostMatch2.totalbg.New;
        local OldElo = p33.OldElo;
        local NewElo = p33.NewElo;
        local EloDelta = p33.EloDelta;
        local Rank2, v34, v35 = RankedData.GetRank(OldElo);
        local Rank3, v36, v37 = RankedData.GetRank(NewElo);
        local NextRank, v38, v39 = RankedData.GetNextRank(OldElo);

        local function getDivisionBounds(p40) -- Line: 259
            -- upvalues: RankedData (ref)
            local _, v41, v42 = RankedData.GetRank(p40);

            if not v42 then
                return 0, 500;
            end;

            local DivisionEloRanges = RankedData.DivisionEloRanges;
            local v43 = DivisionEloRanges[1];
            local v44 = DivisionEloRanges[2];
            local v45 = v42.__rankName == "Rookie" and (RankedData.DisplayMinElo or 1000) or v42.MinElo;

            if v41 == 1 then
                return v45, v45 + v43;
            end;

            if v41 == 2 then
                return v45 + v43, v45 + v43 + v44;
            end;

            return v45 + v43 + v44, v45 + v43 + v44 + DivisionEloRanges[3];
        end;

        local v46, v47 = getDivisionBounds(OldElo);
        local v48 = (OldElo - v46) / math.max(1, v47 - v46);
        local math_clamp_ret = math.clamp(v48, 0, 1);

        if v35 and v35.DivisionImages then
            Rank.Image = v35.DivisionImages[v34] or "";
        end;

        Old.rank.Text = Rank2 .. " " .. v34;
        local points = Old.points;
        local math_floor_ret = math.floor(v46);
        points.Text = tostring(math_floor_ret);

        if v35 and v35.DivisionImages then
            Old.OldRank.Image = v35.DivisionImages[v34] or "";
        end;

        if NextRank then
            New.rank.Text = NextRank .. " " .. (v38 or "");
            local points2 = New.points;
            local math_floor_ret2 = math.floor(v47);
            points2.Text = tostring(math_floor_ret2);

            if v39 and v39.DivisionImages then
                New.OldRank.Image = v39.DivisionImages[v38] or "";
            end;
        else
            New.rank.Text = Rank2 .. " " .. v34;
            local points2 = New.points;
            local math_floor_ret2 = math.floor(v47);
            points2.Text = tostring(math_floor_ret2);
        end;

        local YourElo = PostMatch2.totalbg:FindFirstChild("YourElo");

        if YourElo then
            local math_floor_ret2 = math.floor(NewElo);
            YourElo.Text = tostring(math_floor_ret2);
        end;

        RealBar.Size = UDim2.fromScale(math_clamp_ret, 1);
        EloChange.Text = "+0";
        local v49 = game:GetService("Lighting"):FindFirstChildWhichIsA("BlurEffect");

        if v49 then
            TweenService:Create(v49, TweenInfo.new(0.5), {
                Size = 15
            }):Play();
        else
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 0;
            BlurEffect.Parent = game:GetService("Lighting");
            TweenService:Create(BlurEffect, TweenInfo.new(0.5), {
                Size = 15
            }):Play();
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local TeamSelect = workspace:FindFirstChild("TeamSelect");

        if TeamSelect then
            workspace_CurrentCamera.CFrame = TeamSelect.CFrame;
        end;

        RankedPostMatch.Enabled = true;
        PlayerGui.HUD.Enabled = false;
        LocalPlayer:SetAttribute("RankedPostMatch", true);
        PlayerGui.InGameUI.Enabled = false;
        LocalPlayer:SetAttribute("ForceCursor", true);
        game:GetService("UserInputService").MouseIconEnabled = true;
        game:GetService("UserInputService").MouseBehavior = Enum.MouseBehavior.Default;
        local v50 = PlayerGui:FindFirstChild("Misc") and PlayerGui.Misc:FindFirstChild("Cursor");

        if v50 then
            v50.Visible = true;
        end;

        task.wait(0.5);
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        local v51;

        if EloDelta >= 0 then
            v51 = Color3.fromRGB(100, 255, 100);
        else
            v51 = Color3.fromRGB(255, 100, 100);
        end;

        EloChange.TextColor3 = v51;
        local v52 = TweenService:Create(NumberValue, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Value = EloDelta
        });
        NumberValue.Changed:Connect(function(p53) -- Line: 351
            -- upvalues: EloChange (copy)
            local math_round_ret = math.round(p53);
            EloChange.Text = (math_round_ret >= 0 and "+" or "") .. tostring(math_round_ret);
        end);
        v52:Play();
        local v54 = Rank2 ~= Rank3 and true or v34 ~= v36;

        if v54 and EloDelta > 0 then
            local v55 = TweenService:Create(RealBar, TweenInfo.new(0.8999999999999999, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1, 1)
            });
            v55:Play();
            v55.Completed:Wait();
            task.wait(0.3);

            if v37 and v37.DivisionImages then
                Rank.Image = v37.DivisionImages[v36] or "";
            end;

            Old.rank.Text = Rank3 .. " " .. v36;

            if v37 and v37.DivisionImages then
                Old.OldRank.Image = v37.DivisionImages[v36] or "";
            end;

            local NextRank2, v56, v57 = RankedData.GetNextRank(NewElo);
            local v58, v59 = getDivisionBounds(NewElo);

            if NextRank2 then
                New.rank.Text = NextRank2 .. " " .. (v56 or "");
                local points2 = New.points;
                local math_floor_ret2 = math.floor(v59);
                points2.Text = tostring(math_floor_ret2);

                if v57 and v57.DivisionImages then
                    New.OldRank.Image = v57.DivisionImages[v56] or "";
                end;
            end;

            local points2 = Old.points;
            local math_floor_ret2 = math.floor(v58);
            points2.Text = tostring(math_floor_ret2);
            RealBar.Size = UDim2.fromScale(0, 1);
            local v60 = (NewElo - v58) / math.max(1, v59 - v58);
            local math_clamp_ret2 = math.clamp(v60, 0, 1);
            TweenService:Create(RealBar, TweenInfo.new(0.6000000000000001, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(math_clamp_ret2, 1)
            }):Play();
        elseif v54 and EloDelta < 0 then
            local v61 = TweenService:Create(RealBar, TweenInfo.new(0.8999999999999999, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0, 1)
            });
            v61:Play();
            v61.Completed:Wait();
            task.wait(0.3);

            if v37 and v37.DivisionImages then
                Rank.Image = v37.DivisionImages[v36] or "";
            end;

            Old.rank.Text = Rank3 .. " " .. v36;

            if v37 and v37.DivisionImages then
                Old.OldRank.Image = v37.DivisionImages[v36] or "";
            end;

            local NextRank2, v62, v63 = RankedData.GetNextRank(NewElo);
            local v64, v65 = getDivisionBounds(NewElo);

            if NextRank2 then
                New.rank.Text = NextRank2 .. " " .. (v62 or "");
                local points2 = New.points;
                local math_floor_ret2 = math.floor(v65);
                points2.Text = tostring(math_floor_ret2);

                if v63 and v63.DivisionImages then
                    New.OldRank.Image = v63.DivisionImages[v62] or "";
                end;
            end;

            local points2 = Old.points;
            local math_floor_ret2 = math.floor(v64);
            points2.Text = tostring(math_floor_ret2);
            RealBar.Size = UDim2.fromScale(1, 1);
            local v66 = (NewElo - v64) / math.max(1, v65 - v64);
            local math_clamp_ret2 = math.clamp(v66, 0, 1);
            TweenService:Create(RealBar, TweenInfo.new(0.6000000000000001, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(math_clamp_ret2, 1)
            }):Play();
        else
            local v67 = (NewElo - v46) / math.max(1, v47 - v46);
            local math_clamp_ret2 = math.clamp(v67, 0, 1);
            TweenService:Create(RealBar, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(math_clamp_ret2, 1)
            }):Play();
        end;

        v52.Completed:Wait();
        NumberValue:Destroy();
    end);
end;

function v1.SetupPostMatchButtons(p68) -- Line: 438
    -- upvalues: Knit (copy), PlayerGui (copy), LocalPlayer (copy), workspace_CurrentCamera (copy), TweenService (copy)
    local Service = Knit.GetService("RankedMatchService");
    local Service2 = Knit.GetService("RankedService");
    local Right = PlayerGui:WaitForChild("RankedPostMatch"):WaitForChild("MatchMakingButtons"):WaitForChild("Right");
    local Leave = Right:WaitForChild("Leave");
    local Rematch = Right:WaitForChild("Rematch");
    local PlayAgain = Right:WaitForChild("PlayAgain");
    local u69 = nil;

    for _, child in Rematch:GetChildren() do
        if child:IsA("TextLabel") and child.Text:find("/") then
            u69 = child;
        end;
    end;

    local v70 = #game.Players:GetPlayers();

    if u69 then
        u69.Text = "0/" .. v70;
    end;

    Leave.Activated:Connect(function() -- Line: 460
        -- upvalues: Service (copy)
        Service:RequestLeave();
    end);
    Rematch.Activated:Connect(function() -- Line: 464
        -- upvalues: Service (copy), Rematch (copy)
        Service:RequestRematch();
        Rematch.Active = false;
    end);
    PlayAgain.Activated:Connect(function() -- Line: 469
        -- upvalues: Service (copy), PlayAgain (copy)
        Service:RequestPlayAgain();
        PlayAgain.Active = false;
    end);
    Service.PostMatchCountdown:Connect(function(p71) -- Line: 474
        -- upvalues: PlayerGui (ref)
        local RankedPostMatch = PlayerGui:FindFirstChild("RankedPostMatch");
        local v72 = RankedPostMatch and (RankedPostMatch.Enabled and RankedPostMatch.PostMatch:FindFirstChild("Timer"));

        if v72 then
            v72.Text = "Returning to lobby in " .. p71 .. "s";
        end;
    end);
    Service.EnterGameUI:Connect(function() -- Line: 484
        -- upvalues: PlayerGui (ref), LocalPlayer (ref), workspace_CurrentCamera (ref)
        local WaitingForPlayers = PlayerGui:FindFirstChild("WaitingForPlayers");

        if WaitingForPlayers then
            WaitingForPlayers.Enabled = false;
        end;

        pickTeamGui.Enabled = false;
        LocalPlayer:SetAttribute("RankedPickPhase", nil);
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        PlayerGui.HUD.Enabled = true;
        local InGameUI = PlayerGui:FindFirstChild("InGameUI");

        if InGameUI then
            InGameUI.Enabled = true;
        end;

        if InGameUI then
            InGameUI = InGameUI:FindFirstChild("Return");
        end;

        if InGameUI then
            InGameUI.Visible = false;
            InGameUI.Active = false;
        end;
    end);
    Service.HidePostMatch:Connect(function() -- Line: 500
        -- upvalues: PlayerGui (ref), Knit (ref), TweenService (ref), LocalPlayer (ref)
        local RankedPostMatch = PlayerGui:FindFirstChild("RankedPostMatch");

        if RankedPostMatch then
            RankedPostMatch.Enabled = false;
        end;

        local Controller = Knit.GetController("RankedController");

        if Controller then
            Controller:HideQueueUI();
        end;

        local v73 = game:GetService("Lighting"):FindFirstChildWhichIsA("BlurEffect");

        if v73 then
            TweenService:Create(v73, TweenInfo.new(0.5), {
                Size = 0
            }):Play();
        end;

        LocalPlayer:SetAttribute("ForceCursor", nil);
        LocalPlayer:SetAttribute("RankedPostMatch", nil);
        PlayerGui.HUD.Enabled = false;
        PlayerGui.InGameUI.Enabled = false;
        local Controller2 = Knit.GetController("RankedController");

        if Controller2 and Controller2.HideQueueUI then
            Controller2:HideQueueUI();
        end;

        local Character = LocalPlayer.Character;
        local v74 = Character and Character:FindFirstChildWhichIsA("Humanoid");

        if v74 then
            v74.WalkSpeed = 16;
            v74.JumpPower = 50;
            v74.JumpHeight = 7.2;
        end;

        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    end);
    Service.RematchUpdate:Connect(function(p75, p76) -- Line: 537
        -- upvalues: Rematch (copy), u69 (ref)
        if p75 == -1 then
            Rematch.Active = false;

            if u69 then
                u69.Text = "Unavailable";
            end;

            return;
        end;

        Rematch.Active = true;

        if u69 then
            u69.Text = p75 .. "/" .. p76;
        end;
    end);
    Service.PlayAgainStatus:Connect(function(p77) -- Line: 551
        -- upvalues: PlayAgain (copy), Knit (ref), LocalPlayer (ref)
        local option = PlayAgain:FindFirstChild("option");

        if p77 == "Queueing" then
            if option then
                option.Text = "Searching...";
            end;

            local Controller = Knit.GetController("RankedController");

            if Controller and Controller.ShowQueueUI then
                Controller:ShowQueueUI(LocalPlayer:GetAttribute("RankedMode") or "2v2");
            end;
        elseif p77 == "Failed" then
            if option then
                option.Text = "Play Again";
            end;

            PlayAgain.Active = true;
        end;
    end);
    Service2.QueueStatus:Connect(function(p78, p79) -- Line: 569
        -- upvalues: PlayAgain (copy), Knit (ref)
        if p78 == "MatchFound" then
            local option = PlayAgain:FindFirstChild("option");

            if option then
                option.Text = "Match Found!";
            end;
        elseif p78 == "Cancelled" then
            local option = PlayAgain:FindFirstChild("option");

            if option then
                option.Text = "Play Again";
            end;

            PlayAgain.Active = true;
            local Controller = Knit.GetController("RankedController");

            if Controller and Controller.HideQueueUI then
                Controller:HideQueueUI();
            end;
        elseif p78 == "Failed" then
            PlayAgain.Active = true;
            local option = PlayAgain:FindFirstChild("option");

            if option then
                option.Text = "Play Again";
            end;

            local Controller = Knit.GetController("RankedController");

            if Controller and Controller.HideQueueUI then
                Controller:HideQueueUI();
            end;
        end;
    end);
end;

return v1;