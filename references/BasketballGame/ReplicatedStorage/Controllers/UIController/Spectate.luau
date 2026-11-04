 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Teams = game:GetService("Teams");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Effects);
local TopbarPlus = require(ReplicatedStorage.Shared.Utility.TopbarPlus);
local Jerseys = require(ReplicatedStorage.Shared.Tables.Jerseys);
local u1 = Knit.CreateController({
    Name = "SpectateController"
});
u1.CameraSubjectEnum = {
    Ball = 1,
    LocalPlayer = 2,
    OtherPlayer = 3
};

function u1.SetCameraSubject(p2, p3, p4) -- Line: 24
    -- upvalues: u1 (copy), LocalPlayer (copy)
    print("SetCameraSubject", p3);

    if typeof(p3) ~= "number" or math.floor(p3) ~= p3 then
        error((`{p3} is not an integer!`));
    end;

    local v5 = p3 == u1.CameraSubjectEnum.LocalPlayer;
    local v6 = p3 == u1.CameraSubjectEnum.OtherPlayer;

    if not (v5 or (p3 == u1.CameraSubjectEnum.Ball or v6)) then
        error((`CameraSubjectEnum: {p3} is not supported`));
    end;

    if v6 and (typeof(p4) ~= "Instance" or not p4:IsA("Player")) then
        error((`{p4} is not a Player Instance!`));
    end;

    local v7 = nil;

    if v5 then
        p4 = LocalPlayer;
    elseif not v6 then
        p4 = v7;
    end;

    p2.CurrentCameraSubjectEnum = p3;
    p2.CurrentlySpectatingPlayer = p4;

    if v5 then
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
    end;
end;

function u1.KnitStart(u8) -- Line: 57
    -- upvalues: Knit (copy), LocalPlayer (copy), TopbarPlus (copy), u1 (copy), TweenService (copy), Jerseys (copy), ReplicatedStorage (copy), Teams (copy), RunService (copy)
    u8.CurrentCameraSubjectEnum = 1;
    local Controller = Knit.GetController("BallController");
    local Controller2 = Knit.GetController("UIController");
    local Spectate = LocalPlayer.PlayerGui.Spectate;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u9 = TopbarPlus.new():setName("Spectate"):setLabel("👁️"):oneClick(true):setImageScale(0.7):setOrder(20);
    u8.Icon = u9;
    local u10 = false;
    local u11 = {};
    u9.toggled:Connect(function(p12) -- Line: 78
        -- upvalues: LocalPlayer (ref), Spectate (copy), Controller2 (copy), u8 (copy), u1 (ref), u10 (ref), workspace_CurrentCamera (copy), u11 (copy)
        if not (p12 and (LocalPlayer.Character ~= nil and LocalPlayer.Character:IsDescendantOf(workspace))) then
            return;
        end;

        Spectate.Enabled = not Spectate.Enabled;

        if not Spectate.Enabled then
            u8:SetCameraSubject(u1.CameraSubjectEnum.LocalPlayer);
            workspace_CurrentCamera:SetAttribute("Spectate", nil);
            u10 = false;

            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.InGame.Enabled = false;

        for _, v in Controller2.fromHUD do
            v[1].Enabled = false;
        end;

        Controller2:Focus(false);
        task.wait(0.01);
        u8:SetCameraSubject(u1.CameraSubjectEnum.Ball);
        u10 = true;
        Spectate.Spectate.Txt.Visible = false;
        workspace_CurrentCamera:SetAttribute("Spectate", true);

        for _, v in u11 do
            v.Enabled = true;
        end;
    end);
    Spectate:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 114
        -- upvalues: Spectate (copy), LocalPlayer (ref), u8 (copy), u1 (ref), u10 (ref)
        if not Spectate.Enabled then
            LocalPlayer.PlayerGui.HUD.Enabled = LocalPlayer.Team == game.Teams.Visitor;
            LocalPlayer.PlayerGui.InGame.Enabled = LocalPlayer.Team ~= game.Teams.Visitor;
            u8:SetCameraSubject(u1.CameraSubjectEnum.LocalPlayer);
            u10 = false;
        end;
    end);
    Spectate.Spectate.BG.Close.MouseButton1Click:Connect(function() -- Line: 125
        -- upvalues: Spectate (copy), u8 (copy), u1 (ref)
        Spectate.Enabled = false;
        u8:SetCameraSubject(u1.CameraSubjectEnum.LocalPlayer);
    end);
    Spectate.Spectate.BG.Ball.MouseButton1Click:Connect(function() -- Line: 131
        -- upvalues: u8 (copy), u1 (ref), u10 (ref), Spectate (copy), u11 (copy)
        u8:SetCameraSubject(u1.CameraSubjectEnum.Ball);
        u10 = true;
        Spectate.Spectate.Txt.Visible = false;

        for _, v in u11 do
            v.Enabled = true;
        end;
    end);
    local u13 = true;
    Spectate.Spectate.BG.ShowHide.Activated:Connect(function() -- Line: 149
        -- upvalues: u13 (ref), Spectate (copy), TweenService (ref)
        u13 = not u13;
        local UDim2_fromScale_ret = UDim2.fromScale(Spectate.Spectate.BG.Position.X.Scale, u13 and 1 or 1 + Spectate.Spectate.BG.Size.Y.Scale);
        TweenService:Create(Spectate.Spectate.BG, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Position = UDim2_fromScale_ret
        }):Play();
        Spectate.Spectate.BG.ShowHide.Rotation = u13 and 180 or 0;
        TweenService:Create(Spectate.Spectate.BG.ShowHide, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Rotation = u13 and 0 or -180
        }):Play();
    end);
    local u14 = {};

    local function spawnTeam(p15) -- Line: 166
        -- upvalues: u14 (copy), Spectate (copy), u8 (copy), u1 (ref), Jerseys (ref), ReplicatedStorage (ref), u11 (copy), u10 (ref)
        if u14[p15] then
            for _, v in u14[p15] do
                v:Disconnect();
            end;

            u14[p15] = nil;
            u14[p15] = {};
        else
            u14[p15] = {};
        end;

        for _, child in Spectate.Spectate.BG[p15]:GetChildren() do
            if child:IsA("TextButton") then
                child:Destroy();
            end;
        end;

        for _, v in game.Teams[p15]:GetPlayers() do
            local v16 = script.Plr:Clone();
            v16.Text = v.Name;
            v16.Parent = Spectate.Spectate.BG[p15];
            u14[p15][v.Name] = v16.MouseButton1Click:Connect(function() -- Line: 185
                -- upvalues: u8 (ref), u1 (ref), v (copy), Spectate (ref), Jerseys (ref), ReplicatedStorage (ref), u11 (ref), u10 (ref)
                u8:SetCameraSubject(u1.CameraSubjectEnum.OtherPlayer, v);
                local Txt = Spectate.Spectate.Txt;
                Txt.DisplayName.Text = v.DisplayName;
                Txt.Username.Text = `@{v.Name}`;
                local v17;

                if v.Team == game.Teams.Home then
                    v17 = Jerseys.Home[ReplicatedStorage.GameValues.HomeIndex.Value].Color;
                else
                    v17 = Jerseys.Away[ReplicatedStorage.GameValues.AwayIndex.Value].Color;
                end;

                local _, _, v18 = v17:ToHSV();

                for _, descendant in Txt:GetDescendants() do
                    if descendant:IsA("UIStroke") then
                        local v19;

                        if v18 <= 0.5 then
                            v19 = Color3.new(1, 1, 1);
                        else
                            v19 = Color3.new(0, 0, 0);
                        end;

                        descendant.Color = v19;
                    end;
                end;

                Txt.DisplayName.TextColor3 = v17;
                Txt.Username.TextColor3 = v17;
                Txt.Visible = true;

                for i, v2 in u11 do
                    v2.Enabled = v ~= i;
                end;

                u10 = false;
            end);
        end;
    end;

    local function spawnNametags() -- Line: 221
        -- upvalues: u11 (copy), Spectate (copy), Jerseys (ref), ReplicatedStorage (ref), LocalPlayer (ref)
        for i, v in u11 do
            if not i:IsDescendantOf(game) or i.Team == game.Teams.Visitor then
                v:Destroy();
                u11[i] = nil;
            end;
        end;

        if Spectate.Enabled then
            for _, v in game.Players:GetPlayers() do
                if v.Character ~= nil and v.Team ~= game.Teams.Visitor then
                    local v20 = u11[v] or script.SpectateNametag:Clone();
                    u11[v] = v20;
                    v20.DisplayName.Text = v.DisplayName;
                    v20.Username.Text = `@{v.Name}`;
                    v20.Adornee = v.Character.HumanoidRootPart;
                    local v21;

                    if v.Team == game.Teams.Home then
                        v21 = Jerseys.Home[ReplicatedStorage.GameValues.HomeIndex.Value].Color;
                    else
                        v21 = Jerseys.Away[ReplicatedStorage.GameValues.AwayIndex.Value].Color;
                    end;

                    local _, _, v22 = v21:ToHSV();

                    if v22 <= 0.5 then
                        for _, descendant in v20:GetDescendants() do
                            if descendant:IsA("UIStroke") then
                                descendant.Color = Color3.new(1, 1, 1);
                            end;
                        end;
                    end;

                    v20.DisplayName.TextColor3 = v21;
                    v20.Username.TextColor3 = v21;
                    v20.Parent = LocalPlayer.PlayerGui;
                end;
            end;

            return;
        end;

        for _, v in u11 do
            v.Enabled = false;
        end;
    end;

    spawnTeam("Home");
    spawnTeam("Away");
    game.Teams.Home.PlayerAdded:Connect(function() -- Line: 278
        -- upvalues: spawnTeam (copy), spawnNametags (copy)
        spawnTeam("Home");
        spawnNametags();
    end);
    game.Teams.Home.PlayerRemoved:Connect(function() -- Line: 282
        -- upvalues: spawnTeam (copy), spawnNametags (copy)
        spawnTeam("Home");
        spawnNametags();
    end);
    game.Teams.Away.PlayerAdded:Connect(function() -- Line: 286
        -- upvalues: spawnTeam (copy), spawnNametags (copy)
        spawnTeam("Away");
        spawnNametags();
    end);
    game.Teams.Away.PlayerRemoved:Connect(function() -- Line: 290
        -- upvalues: spawnTeam (copy), spawnNametags (copy)
        spawnTeam("Away");
        spawnNametags();
    end);
    Spectate:GetPropertyChangedSignal("Enabled"):Connect(spawnNametags);

    if LocalPlayer.Team ~= game.Teams.Visitor then
        u9:setEnabled(LocalPlayer.Team == nil and true or LocalPlayer.Team == Teams.Visitor);

        if Spectate.Enabled == true then
            Spectate.Enabled = false;

            if LocalPlayer.Character then
                u8:SetCameraSubject(u1.CameraSubjectEnum.LocalPlayer);
                u10 = false;
            end;
        end;
    end;

    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 309
        -- upvalues: u9 (copy), LocalPlayer (ref), Teams (ref), Spectate (copy), u8 (copy), u1 (ref), u10 (ref)
        u9:setEnabled(LocalPlayer.Team == nil and true or LocalPlayer.Team == Teams.Visitor);

        if Spectate.Enabled == true then
            Spectate.Enabled = false;

            if LocalPlayer.Character then
                u8:SetCameraSubject(u1.CameraSubjectEnum.LocalPlayer);
                u10 = false;
            end;
        end;
    end);
    RunService.Heartbeat:Connect(function(p23) -- Line: 323
        -- upvalues: Spectate (copy), u8 (copy), u1 (ref), Controller (copy), ReplicatedStorage (ref), workspace_CurrentCamera (copy)
        if not Spectate.Enabled then
            return;
        end;

        if u8.CurrentCameraSubjectEnum == u1.CameraSubjectEnum.LocalPlayer then
            return;
        end;

        local v24 = nil;

        if u8.CurrentCameraSubjectEnum == u1.CameraSubjectEnum.Ball then
            local CharacterPossessingBall = Controller:GetCharacterPossessingBall();
            v24 = ReplicatedStorage.Basketball.Value;

            if CharacterPossessingBall and CharacterPossessingBall:FindFirstChild("Head") then
                v24 = CharacterPossessingBall.Head;
            end;
        elseif u8.CurrentCameraSubjectEnum == u1.CameraSubjectEnum.OtherPlayer then
            local CurrentlySpectatingPlayer = u8.CurrentlySpectatingPlayer;

            if CurrentlySpectatingPlayer then
                local Character = CurrentlySpectatingPlayer.Character;

                if Character then
                    v24 = Character:FindFirstChild("Head") or Character:FindFirstChild("Humanoid");
                end;
            end;
        end;

        if v24 == nil then
            return;
        end;

        workspace_CurrentCamera.CameraSubject = v24;
    end);
end;

return u1;