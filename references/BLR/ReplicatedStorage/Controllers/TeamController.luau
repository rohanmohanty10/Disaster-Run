  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("PathfindingService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local Popup = require(ReplicatedStorage.Shared.Popup);
local TeamColors = require(ReplicatedStorage.Shared.TeamColors);
local TeamJerseys = require(ReplicatedStorage.Shared.TeamJerseys);
local environment = require(ReplicatedStorage.Shared.environment);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local workspace_CurrentCamera = workspace.CurrentCamera;
local u2 = tick();
local v3 = Knit.CreateController({
    Name = "TeamController"
});
local _ = {
    [Enum.KeyCode.DPadLeft] = {
        xbox = "rbxassetid://130042157262905",
        ps = "rbxassetid://79190327028247"
    },
    [Enum.KeyCode.DPadRight] = {
        xbox = "rbxassetid://89376419969117",
        ps = "rbxassetid://74919166333399"
    },
    [Enum.KeyCode.DPadUp] = {
        xbox = "rbxassetid://88998279874543",
        ps = "rbxassetid://123662468503587"
    },
    [Enum.KeyCode.DPadDown] = {
        xbox = "rbxassetid://134018649082145",
        ps = "rbxassetid://70776595537489"
    },
    [Enum.KeyCode.ButtonL3] = {
        xbox = "rbxassetid://139248240664581",
        ps = "rbxassetid://75139119820398"
    },
    [Enum.KeyCode.ButtonB] = {
        xbox = "rbxassetid://105312766601341",
        ps = "rbxassetid://70974133654990"
    },
    [Enum.KeyCode.ButtonX] = {
        xbox = "rbxassetid://91817919366170",
        ps = "rbxassetid://80479027436990"
    },
    [Enum.KeyCode.ButtonA] = {
        xbox = "rbxassetid://88719611220640",
        ps = "rbxassetid://71388027187114"
    },
    [Enum.KeyCode.ButtonR3] = {
        xbox = "rbxassetid://118167660085746",
        ps = "rbxassetid://84000904207269"
    },
    [Enum.KeyCode.ButtonY] = {
        xbox = "rbxassetid://130052377775011",
        ps = "rbxassetid://101128500176794"
    }
};
local u4 = {
    Home = {
        [Enum.KeyCode.DPadLeft] = "GK",
        [Enum.KeyCode.DPadRight] = "CM",
        [Enum.KeyCode.DPadUp] = "LW",
        [Enum.KeyCode.ButtonL3] = "CF",
        [Enum.KeyCode.DPadDown] = "RW"
    },
    Away = {
        [Enum.KeyCode.ButtonB] = "GK",
        [Enum.KeyCode.ButtonX] = "CM",
        [Enum.KeyCode.ButtonA] = "LW",
        [Enum.KeyCode.ButtonR3] = "CF",
        [Enum.KeyCode.ButtonY] = "RW"
    }
};

local function isPointInVolume(p5: vector, p6, p7: vector) -- Line: 65
    local v8 = p6:PointToObjectSpace(p5);
    local v9;

    if v8.X >= -p7.X / 2 and (v8.X <= p7.X / 2 and (v8.Y >= -p7.Y / 2 and (v8.Y <= p7.Y / 2 and v8.Z >= -p7.Z / 2))) then
        v9 = v8.Z <= p7.Z / 2;
    else
        v9 = false;
    end;

    return v9;
end;

local function isPointInPart(p10: vector, p11: userdata) -- Line: 75
    -- upvalues: isPointInVolume (copy)
    return isPointInVolume(p10, p11.CFrame, p11.Size);
end;

local function applyTeamColor(p12, p13, p14, p15) -- Line: 79
    local v16 = p12:FindFirstChildOfClass("UIGradient");

    if v16 then
        v16:Destroy();
    end;

    if not p14 or p15 ~= "BackgroundColor3" then
        p12[p15] = p13;

        return;
    end;

    p12.BackgroundColor3 = Color3.new(1, 1, 1);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = p14;
    UIGradient.Parent = p12;
end;

function v3.KnitStart(u17) -- Line: 95
    -- upvalues: Knit (copy), LocalPlayer (copy), ReplicatedStorage (copy), CollectionService (copy), TeamColors (copy), TeamJerseys (copy), applyTeamColor (copy), Popup (copy), u2 (ref), UserInputService (copy), u4 (copy), environment (copy), workspace_CurrentCamera (copy), RunService (copy), Players (copy), isPointInVolume (copy), TweenService (copy), HumanoidRootPart (ref), Debris (copy)
    game.Lighting.ColorCorrection.Brightness = 0.1;
    tick();
    local Service = Knit.GetService("TeamService");
    local PickTeam = LocalPlayer.PlayerGui:WaitForChild("PickTeam");
    local Vs = ReplicatedStorage.Assets.UI.Scoreboard.Vs;
    local u18 = {};
    local v19 = {};
    local v20 = {};
    local v21 = {
        Home = {
            Order = 1,
            Frame = ReplicatedStorage.Assets.UI.Scoreboard.LeftFrame
        },
        Away = {
            Order = 2,
            Frame = ReplicatedStorage.Assets.UI.Scoreboard.RightFrame
        }
    };

    for _, child in ReplicatedStorage.Goals:GetChildren() do
        u18[child.Name] = {};
        v19[child.Name] = 0;
        v20[child.Name] = PickTeam[child.Name]:GetChildren();
    end;

    local Scoreboard = LocalPlayer.PlayerGui.InGameUI.Scoreboard;

    for i, v in v21 do
        local v22 = #CollectionService:GetTagged("PlayingTeam");
        local v23 = v.Frame:Clone();
        v23.Name = i;

        if v.Order < v22 then
            Vs:Clone().Parent = v23;
        end;

        local v24 = ReplicatedStorage.GameValues:FindFirstChild(i .. "Index");
        local v25 = v24 and TeamColors[i][v24.Value] or TeamColors[i];
        local v26;

        if v24 and (TeamColors.Gradients and TeamColors.Gradients[i]) then
            v26 = TeamColors.Gradients[i][v24.Value] or nil;
        else
            v26 = nil;
        end;

        local v27;

        if v24 then
            v27 = TeamJerseys[i][tostring(v24.Value)].Logo or nil;
        else
            v27 = nil;
        end;

        v23.TeamName.Text = i;
        v23.ZIndex = v22 - v.Order;
        v23.LayoutOrder = v.Order;
        v23.Score.ImageColor3 = v25;
        applyTeamColor(v23.ScoreBG, v25, v26, "BackgroundColor3");
        v23.Logo.ImageColor3 = Color3.new(1, 1, 1);

        if v27 then
            v23.Logo.Image = v27;
        else
            v23.Logo.Image = "rbxassetid://130565143807690";
        end;

        applyTeamColor(LocalPlayer.PlayerGui.PickTeam[i .. "BG"], v25, v26, "BackgroundColor3");
        v23.Parent = Scoreboard.Frame;
    end;

    local function changeColors(p28) -- Line: 162
        -- upvalues: ReplicatedStorage (ref), TeamColors (ref), Scoreboard (copy), applyTeamColor (ref), TeamJerseys (ref), LocalPlayer (ref)
        local Value = ReplicatedStorage.GameValues[p28 .. "Index"].Value;
        local v29 = TeamColors[p28][Value];
        local v30;

        if TeamColors.Gradients and TeamColors.Gradients[p28] then
            v30 = TeamColors.Gradients[p28][Value] or nil;
        else
            v30 = nil;
        end;

        Scoreboard.Frame[p28].Score.ImageColor3 = v29;
        applyTeamColor(Scoreboard.Frame[p28].ScoreBG, v29, v30, "BackgroundColor3");
        Scoreboard.Frame[p28].Logo.ImageColor3 = Color3.new(1, 1, 1);
        local v31;

        if TeamJerseys[p28] and TeamJerseys[p28][tostring(Value)] then
            v31 = TeamJerseys[p28][tostring(Value)].Logo or nil;
        else
            v31 = nil;
        end;

        if v31 then
            Scoreboard.Frame[p28].Logo.Image = v31;
        else
            Scoreboard.Frame[p28].Logo.Image = "rbxassetid://130565143807690";
        end;

        applyTeamColor(LocalPlayer.PlayerGui.PickTeam[p28 .. "BG"], v29, v30, "BackgroundColor3");
    end;

    for _, v in CollectionService:GetTagged("PlayingTeam") do
        local v32 = ReplicatedStorage.GameValues:FindFirstChild(v.Name .. "Index");

        if v32 then
            changeColors(v.Name);
            u17.BaseTrove:Connect(v32:GetPropertyChangedSignal("Value"), function() -- Line: 186
                -- upvalues: changeColors (copy), v (copy)
                changeColors(v.Name);
            end);
        end;
    end;

    for _, descendant in pairs(PickTeam:GetDescendants()) do
        if descendant:IsA("ImageButton") and u18[descendant.Parent.Name] then
            u18[descendant.Parent.Name][descendant.Name] = {};
            u18[descendant.Parent.Name][descendant.Name].Hover = descendant.HoverImage;
            u18[descendant.Parent.Name][descendant.Name].Normal = descendant.Image;
        end;
    end;

    local function SelectPos(p33) -- Line: 207
        -- upvalues: LocalPlayer (ref), Popup (ref), u2 (ref), Service (copy)
        if LocalPlayer:GetAttribute("PackBusy") then
            Popup.Popup(LocalPlayer, "FINISH OPENING YOUR PACK FIRST");

            return;
        end;

        if u2 <= tick() then
            u2 = tick() + 3;
            Service.Select:Fire(p33.Parent.Name, p33.Name);

            return;
        end;

        local Popup2 = Popup.Popup;
        local v34 = u2 - tick();
        local math_round_ret = math.round(v34);
        Popup2(LocalPlayer, "TRY AGAIN IN " .. tostring(math_round_ret) .. " SECONDS");
    end;

    local u35 = {};

    local function updateConsoleKeybinds() -- Line: 216
        -- upvalues: u35 (ref), UserInputService (ref), LocalPlayer (ref), u17 (copy), u4 (ref), SelectPos (copy)
        for _, v in u35 do
            v:Disconnect();
        end;

        u35 = {};

        if UserInputService.GamepadEnabled then
            local _ = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonA";

            for _, child in LocalPlayer.PlayerGui.PickTeam.Away:GetChildren() do
                child.ConsoleIcon.Visible = true;
                local Attribute = child.ConsoleIcon:GetAttribute("Keybind");
                child.ConsoleIcon.Image = u17.Settings:GetConsoleKeybindImage(Enum.KeyCode[Attribute]);
            end;

            for _, child in LocalPlayer.PlayerGui.PickTeam.Home:GetChildren() do
                child.ConsoleIcon.Visible = true;
                local Attribute = child.ConsoleIcon:GetAttribute("Keybind");
                child.ConsoleIcon.Image = u17.Settings:GetConsoleKeybindImage(Enum.KeyCode[Attribute]);
            end;
        else
            for _, child in LocalPlayer.PlayerGui.PickTeam.Away:GetChildren() do
                child.ConsoleIcon.Visible = false;
            end;

            for _, child in LocalPlayer.PlayerGui.PickTeam.Home:GetChildren() do
                child.ConsoleIcon.Visible = false;
            end;
        end;

        for i, v in u4 do
            local u36 = i;

            for i2, v2 in v do
                table.insert(u35, UserInputService.InputBegan:Connect(function(p37, p38) -- Line: 253
                    -- upvalues: i2 (copy), LocalPlayer (ref), u36 (copy), v2 (copy), SelectPos (ref)
                    if p38 then
                        return;
                    end;

                    if p37.KeyCode ~= i2 then
                        return;
                    end;

                    if not LocalPlayer.PlayerGui.PickTeam[u36].Visible then
                        return;
                    end;

                    if not LocalPlayer.PlayerGui.PickTeam[u36][v2].Visible then
                        return;
                    end;

                    if not LocalPlayer.PlayerGui.PickTeam.Enabled then
                        return;
                    end;

                    SelectPos(LocalPlayer.PlayerGui.PickTeam[u36][v2]);
                end));
            end;
        end;
    end;

    updateConsoleKeybinds();
    UserInputService:GetPropertyChangedSignal("GamepadEnabled"):Connect(updateConsoleKeybinds);
    local u39 = nil;
    UserInputService.LastInputTypeChanged:Connect(function(p40) -- Line: 286
        -- upvalues: u39 (ref), updateConsoleKeybinds (copy)
        if p40 == Enum.UserInputType.TextInput then
            return;
        end;

        if u39 ~= p40 then
            u39 = p40;
            updateConsoleKeybinds();
        end;

        u39 = p40;
    end);

    for _, v in v20 do
        for _, v2 in v do
            if v2:IsA("ImageButton") ~= false then
                if table.find(environment.config.PositionChoices, v2.Name) then
                    v2.Visible = true;
                else
                    v2.Visible = false;
                end;

                u17.BaseTrove:Connect(v2.Activated, function() -- Line: 306
                    -- upvalues: SelectPos (copy), v2 (copy)
                    SelectPos(v2);
                end);
            end;
        end;
    end;

    u17.BaseTrove:Connect(LocalPlayer.PlayerGui.InGameUI.GK.Activated, function() -- Line: 312
        -- upvalues: LocalPlayer (ref), SelectPos (copy)
        if LocalPlayer.Character.Values.Goalie.Value then
            return;
        end;

        SelectPos(LocalPlayer.PlayerGui.PickTeam[LocalPlayer.Team.Name].GK);
    end);
    u17.BaseTrove:Connect(LocalPlayer.PlayerGui.InGameUI.Return.Activated, function() -- Line: 317
        -- upvalues: LocalPlayer (ref), Service (copy)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            Service.Return:Fire();

            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = true;
        LocalPlayer.PlayerGui.PickTeam.Enabled = false;
    end);
    u17.BaseTrove:Connect(LocalPlayer.PlayerGui.PickTeam.Return.Activated, function() -- Line: 326
        -- upvalues: LocalPlayer (ref), u17 (copy), workspace_CurrentCamera (ref)
        LocalPlayer.PlayerGui.HUD.Enabled = true;
        LocalPlayer.PlayerGui.PickTeam.Enabled = false;

        if u17._renderStepped then
            u17._renderStepped:Disconnect();
            u17._renderStepped = nil;
        end;

        if u17._renderStepped then
            u17._renderStepped:Disconnect();
            u17._renderStepped = nil;
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
    end);
    RunService.Heartbeat:Connect(function() -- Line: 343
        -- upvalues: environment (ref), LocalPlayer (ref), u17 (copy), ReplicatedStorage (ref)
        if environment.mode == "Ranked" then
            LocalPlayer.PlayerGui.InGameUI.Return.Visible = false;

            return;
        end;

        local v41 = u17.StatesController.States.Ability or (workspace:FindFirstChild("AwakeningCam") or workspace:FindFirstChild("NagiCam"));
        local v42 = LocalPlayer:GetAttribute("PositionPickTimestamp") or -1;
        local Value = ReplicatedStorage.GameValues.LastGoalTimestamp.Value;
        local ServerTimeNow = workspace:GetServerTimeNow();

        if v41 then
            LocalPlayer.PlayerGui.InGameUI.Return.Visible = false;

            return;
        end;

        local v43;

        if ServerTimeNow < Value + 15 then
            LocalPlayer.PlayerGui.InGameUI.Return.SubText.Text = "";
            v43 = true;
        elseif Value + 60 < ServerTimeNow then
            LocalPlayer.PlayerGui.InGameUI.Return.SubText.Text = "(You will be unable to rejoin for 15 seconds)";
            v43 = true;
        elseif ServerTimeNow < v42 + 10 then
            LocalPlayer.PlayerGui.InGameUI.Return.SubText.Text = "";
            v43 = true;
        else
            LocalPlayer.PlayerGui.InGameUI.Return.SubText.Text = "(Cannot do this right now.)";
            v43 = false;
        end;

        LocalPlayer.PlayerGui.InGameUI.Return.Visible = true;

        if v43 then
            LocalPlayer.PlayerGui.InGameUI.Return.ImageTransparency = 0;
            LocalPlayer.PlayerGui.InGameUI.Return.Active = true;

            return;
        end;

        LocalPlayer.PlayerGui.InGameUI.Return.ImageTransparency = 0.5;
        LocalPlayer.PlayerGui.InGameUI.Return.Active = false;
    end);
    LocalPlayer.PlayerGui.HUD:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 386
        -- upvalues: LocalPlayer (ref), environment (ref), workspace_CurrentCamera (ref)
        if LocalPlayer.PlayerGui.HUD.Enabled and LocalPlayer.PlayerGui.PickTeam.Enabled then
            if environment.mode == "Ranked" then
                return;
            end;

            LocalPlayer.PlayerGui.HUD.Enabled = true;
            LocalPlayer.PlayerGui.PickTeam.Enabled = false;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        end;
    end);
    tick();

    local function change() -- Line: 399
        -- upvalues: CollectionService (ref), ReplicatedStorage (ref), LocalPlayer (ref), u18 (copy), Players (ref), environment (ref)
        local v44 = {};

        for _, v in CollectionService:GetTagged("PlayingTeam") do
            local u45 = v;

            for _, child in (ReplicatedStorage.Teams:FindFirstChild(v.Name) or ReplicatedStorage.Teams:FindFirstChild((`{v.Name}Team`))):GetChildren() do
                if child.Value == nil then
                    LocalPlayer.PlayerGui.PickTeam[u45.Name][child.Name].Png.Image = "";
                    LocalPlayer.PlayerGui.PickTeam[u45.Name][child.Name].plr.Text = "";
                    LocalPlayer.PlayerGui.PickTeam[u45.Name][child.Name].Image = u18[u45.Name][child.Name].Normal;
                else
                    LocalPlayer.PlayerGui.PickTeam[u45.Name][child.Name].plr.Text = child.Value.Name;
                    LocalPlayer.PlayerGui.PickTeam[u45.Name][child.Name].Image = u18[u45.Name][child.Name].Hover;
                    task.spawn(function() -- Line: 410
                        -- upvalues: Players (ref), child (copy), LocalPlayer (ref), u45 (copy)
                        local UserThumbnailAsync = Players:GetUserThumbnailAsync(Players:FindFirstChild(child.Value.Name).UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
                        LocalPlayer.PlayerGui.PickTeam[u45.Name][child.Name].Png.Image = UserThumbnailAsync;
                    end);
                end;
            end;

            v44[u45.Name] = #u45:GetPlayers();
        end;

        local Players2 = game.Teams.Home:GetPlayers();
        local Players3 = game.Teams.Away:GetPlayers();
        local v46 = #Players2;
        local v47 = #Players3;

        if environment.mode == "Ranked" then
            return;
        end;

        if environment.env == "Dev" then
            LocalPlayer.PlayerGui.PickTeam.Home.Visible = true;
            LocalPlayer.PlayerGui.PickTeam.HomeFull.Visible = false;
            LocalPlayer.PlayerGui.PickTeam.Away.Visible = true;
            LocalPlayer.PlayerGui.PickTeam.AwayFull.Visible = false;

            return;
        end;

        if v46 <= v47 - 1 then
            LocalPlayer.PlayerGui.PickTeam.Away.Visible = false;
            LocalPlayer.PlayerGui.PickTeam.AwayFull.Visible = true;
        else
            LocalPlayer.PlayerGui.PickTeam.Away.Visible = true;
            LocalPlayer.PlayerGui.PickTeam.AwayFull.Visible = false;
        end;

        if v47 <= v46 - 1 then
            LocalPlayer.PlayerGui.PickTeam.Home.Visible = false;
            LocalPlayer.PlayerGui.PickTeam.HomeFull.Visible = true;

            return;
        end;

        LocalPlayer.PlayerGui.PickTeam.Home.Visible = true;
        LocalPlayer.PlayerGui.PickTeam.HomeFull.Visible = false;
    end;

    u17.BaseTrove:Connect(ReplicatedStorage.GameValues.State:GetPropertyChangedSignal("Value"), function() -- Line: 458
        -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref)
        if ReplicatedStorage.GameValues.State.Value == "Playing" and (LocalPlayer.Team ~= game.Teams.Visitor and workspace:FindFirstChild("Limited")) then
            workspace.Limited.Parent = ReplicatedStorage.Assets;
        end;
    end);

    for _, v in CollectionService:GetTagged("PlayingTeam") do
        for _, child in (ReplicatedStorage.Teams:FindFirstChild(v.Name) or ReplicatedStorage.Teams:FindFirstChild((`{v.Name}Team`))):GetChildren() do
            u17.BaseTrove:Connect(child:GetPropertyChangedSignal("Value"), function() -- Line: 469
                -- upvalues: change (copy)
                change();
            end);
        end;
    end;

    u17.BaseTrove:Connect(LocalPlayer.PlayerGui.PickTeam:GetPropertyChangedSignal("Enabled"), function() -- Line: 476
        -- upvalues: change (copy)
        change();
    end);
    local GK = LocalPlayer.PlayerGui.InGameUI:FindFirstChild("GK");

    if GK then
        u17.BaseTrove:Connect(RunService.Heartbeat, function() -- Line: 484
            -- upvalues: LocalPlayer (ref), GK (copy), ReplicatedStorage (ref), isPointInVolume (ref), environment (ref)
            local Team = LocalPlayer.Team;

            if Team == game.Teams.Visitor then
                GK.Visible = false;

                return;
            end;

            local GK2 = (ReplicatedStorage.Teams:FindFirstChild(Team.Name) or ReplicatedStorage.Teams:FindFirstChild((`{Team.Name}Team`))):FindFirstChild("GK");

            if GK2 and (GK2.Value and GK2:IsDescendantOf(game)) then
                GK.Visible = false;

                return;
            end;

            local GoalBox = workspace.AI[Team.Name].GoalBox;

            if isPointInVolume(LocalPlayer.Character.HumanoidRootPart.CFrame.Position, GoalBox.CFrame, GoalBox.Size) and environment.mode ~= "Ranked" then
                LocalPlayer.PlayerGui.InGameUI.GK.Visible = true;

                return;
            end;

            LocalPlayer.PlayerGui.InGameUI.GK.Visible = false;
        end);
    end;

    for _, v in CollectionService:GetTagged("PlayingTeam") do
        local GK2 = (ReplicatedStorage.Teams:FindFirstChild(v.Name) or ReplicatedStorage.Teams:FindFirstChild((`{v.Name}Team`))):FindFirstChild("GK");

        if GK2 then
            GK2.Changed:Connect(function(p48) -- Line: 514
                -- upvalues: LocalPlayer (ref), v (copy), Popup (ref)
                if LocalPlayer.Team ~= v or p48 then
                    return;
                end;

                Popup.Popup(LocalPlayer, "Goalkeeper position is available! (be in goal box)");
            end);
        end;
    end;

    u17.BaseTrove:Connect(Service.Select, function() -- Line: 520
        -- upvalues: PickTeam (copy), ReplicatedStorage (ref), Popup (ref), LocalPlayer (ref), u17 (copy), workspace_CurrentCamera (ref), TweenService (ref), HumanoidRootPart (ref), Debris (ref)
        PickTeam.Enabled = false;

        if ReplicatedStorage.GameValues.State.Value == "Intermission" then
            Popup.BlackoutLocal(LocalPlayer, "Tp3", "Tp4", nil, 2);
            Popup.BlackoutLocal(LocalPlayer, "Tp3", "Tp4", true, 2);
            task.delay(0.35, function() -- Line: 527
                -- upvalues: LocalPlayer (ref), u17 (ref), workspace_CurrentCamera (ref)
                LocalPlayer.PlayerGui.HUD.Enabled = false;
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;

                if u17._renderStepped then
                    u17._renderStepped:Disconnect();
                    u17._renderStepped = nil;
                end;

                workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            end);

            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        task.defer(function() -- Line: 542
            -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), HumanoidRootPart (ref), Debris (ref)
            local v49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 3.5, 8)
            });
            v49:Play();
            Debris:AddItem(v49, 0.625);
        end);

        if u17._renderStepped then
            u17._renderStepped:Disconnect();
            u17._renderStepped = nil;
        end;

        task.delay(0.625, function() -- Line: 555
            -- upvalues: workspace_CurrentCamera (ref)
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        end);
    end);
end;

function v3.KnitInit(u50) -- Line: 562
    -- upvalues: Trove (copy), Knit (copy), LocalPlayer (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
    u50.BaseTrove = Trove.new();
    u50.Settings = Knit.GetController("Settings");
    u50.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p51) -- Line: 567
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
        u1 = p51;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u50.BaseTrove:Connect(game.Players.PlayerRemoving, function(p52) -- Line: 574
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u50 (copy)
        if p52 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u50.BaseTrove:Destroy();
        end;
    end);
    u50.StatesController = Knit.GetController("StatesController");
end;

return v3;