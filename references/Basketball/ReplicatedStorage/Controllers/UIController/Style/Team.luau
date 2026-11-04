 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local IsMatch = require(ReplicatedStorage.Shared.Functions.IsMatch);
local v3 = Knit.CreateController({
    Name = "Team"
});
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = tick();
local u8 = tick();

function v3.TimeSinceLastButtonClick(p9) -- Line: 28
    -- upvalues: u8 (ref)
    return tick() - u8;
end;

function v3.SpawnRing(p10) -- Line: 32
    -- upvalues: ReplicatedStorage (copy), RunService (copy), LocalPlayer (copy), u6 (ref), Players (copy), Essentials (copy), u5 (ref), HumanoidRootPart (ref), Effects (copy)
    local u11 = nil;
    local u12 = ReplicatedStorage.Assets.Misc.Ring:Clone();
    local u13 = ReplicatedStorage.Assets.Misc.BallRing:Clone();
    u12.Anchored = true;
    local u14 = 1;
    local u15 = 0;
    local u16 = tick();
    local u17 = nil;
    local u18 = nil;
    RunService.RenderStepped:Connect(function(p19) -- Line: 45
        -- upvalues: ReplicatedStorage (ref), u11 (ref), LocalPlayer (ref), u17 (ref), u18 (ref), u12 (copy), u14 (ref), u6 (ref), u13 (copy), Players (ref), Essentials (ref)
        local Value = ReplicatedStorage.Basketball.Value;

        if Value == nil then
            u11 = nil;

            return;
        end;

        if Value.Parent == nil then
            u11 = nil;

            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor and not LocalPlayer.PlayerGui.Spectate.Enabled then
            return;
        end;

        local v20 = nil;

        if u11 then
            if u17 ~= u11 or not (u18 and u18:IsDescendantOf(u11)) then
                u17 = u11;
                u18 = u11:FindFirstChild("BALL", true);
            end;

            if u18 then
                v20 = u18.LocalTransparencyModifier;
            end;
        end;

        if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            u12.Transparency = 1;
        else
            u12.Transparency = v20 or 0;
        end;

        u14 = u14 + p19 * 25;

        if u14 >= 360 then
            u14 = 0;
        end;

        if Value then
            if u6:GetCharacterPossessingBall() == nil then
                u11 = nil;

                if u6:BallSpeedIsLessThan(40) then
                    u13.Parent = ReplicatedStorage;
                else
                    u13.Parent = workspace;
                end;

                local ServerBallPosition = u6:GetServerBallPosition();
                u13.CFrame = CFrame.new(ServerBallPosition.X, 1, ServerBallPosition.Z);
            else
                u13.Parent = ReplicatedStorage;
            end;

            local CharacterPossessingBall = u6:GetCharacterPossessingBall();

            if CharacterPossessingBall then
                u11 = CharacterPossessingBall;
            end;
        end;

        if u11 then
            local v21 = Players:FindFirstChild(u11.Name) or Essentials:GetBotFromRig(u11);
            u12.Parent = workspace;
            u12.CFrame = CFrame.new(u11.HumanoidRootPart.Position.X, 1, u11.HumanoidRootPart.Position.Z) * CFrame.fromEulerAnglesXYZ(0, math.rad(u14), 0);

            if v21 and v21.Team then
                u12.Color = v21.Team:GetAttribute("Color");
            end;
        else
            u12.Parent = ReplicatedStorage;
        end;
    end);
    RunService.RenderStepped:Connect(function(p22) -- Line: 110
        -- upvalues: ReplicatedStorage (ref), u11 (ref), LocalPlayer (ref), u5 (ref), u16 (ref), Essentials (ref), HumanoidRootPart (ref), u15 (ref), Effects (ref)
        local Value = ReplicatedStorage.Basketball.Value;

        if Value == nil then
            u11 = nil;

            return;
        end;

        if Value.Parent == nil then
            u11 = nil;

            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if u5.CharValues.HasBall and u16 < tick() then
            u16 = tick() + 1.5;
            local v23 = workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position.X - HumanoidRootPart.Position.X;
            local math_abs_ret = math.abs(v23);

            if math_abs_ret <= 120 and (u5.Gamemode ~= "Match-2v2" and (u5.Gamemode ~= "Match-1v1" and math_abs_ret < u15 - 20)) then
                Effects:Popup("Wrong side of court!", 1, Color3.new(1, 0.458824, 0.466667));
            end;

            u15 = math_abs_ret;
        end;
    end);
end;

function v3.KnitStart(p24) -- Line: 133
    -- upvalues: u6 (ref), Knit (copy), u4 (ref), u5 (ref), LocalPlayer (copy), u7 (ref), IsMatch (copy), ReplicatedStorage (copy), u8 (ref), TweenService (copy), Essentials (copy), Effects (copy)
    u6 = Knit.GetController("BallController");
    u4 = Knit.GetService("TeamService");
    u5 = Knit.GetController("Network");
    local Service = Knit.GetService("MatchmakingService");
    local Controller = Knit.GetController("UIController");
    local Service2 = Knit.GetService("CustomServerService");
    local Gamemode = Service2:GetGamemode();
    local ServerType = Service2:GetServerType();
    local Environment = Service2:GetEnvironment();
    local PickTeam = LocalPlayer.PlayerGui:WaitForChild("PickTeam");

    while not Controller:IsLoaded() do
        task.wait();
    end;

    local function v27(u25) -- Line: 153
        -- upvalues: u7 (ref), IsMatch (ref), Gamemode (copy), LocalPlayer (ref), ReplicatedStorage (ref), u4 (ref), u8 (ref), PickTeam (copy), TweenService (ref)
        for _, descendant in u25:GetDescendants() do
            if descendant:IsA("ImageButton") ~= false then
                descendant.MouseButton1Click:Connect(function() -- Line: 156
                    -- upvalues: u7 (ref), IsMatch (ref), Gamemode (ref), LocalPlayer (ref), u25 (copy), ReplicatedStorage (ref), descendant (copy), u4 (ref), u8 (ref), PickTeam (ref), TweenService (ref)
                    if u7 > tick() then
                        return;
                    end;

                    if IsMatch(Gamemode) then
                        if LocalPlayer.Team.Name ~= u25.Name then
                            return;
                        end;
                    elseif LocalPlayer.Team ~= game.Teams.Visitor then
                        return;
                    end;

                    if ReplicatedStorage.Teams[u25.Name][descendant.Name].Value ~= nil then
                        return;
                    end;

                    if not u4:Select(u25.Name, descendant.Name) then
                        return;
                    end;

                    local workspace_CurrentCamera = workspace.CurrentCamera;
                    u8 = tick();
                    u7 = tick() + 1;
                    PickTeam.Enabled = false;
                    task.delay(0.65, function() -- Line: 177
                        -- upvalues: LocalPlayer (ref)
                        if LocalPlayer.Team == game.Teams.Visitor then
                            LocalPlayer.PlayerGui.HUD.Enabled = true;
                        end;
                    end);

                    if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
                        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

                        return;
                    end;

                    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                    local v26 = workspace.PlayCamera.CFrame * CFrame.new(0, 0, -40);
                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        CFrame = v26
                    }):Play();
                    task.delay(0.23, function() -- Line: 187
                        -- upvalues: workspace_CurrentCamera (copy)
                        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
                    end);
                end);
            end;
        end;
    end;

    local function changePos(p28, p29) -- Line: 204
        -- upvalues: Essentials (ref), LocalPlayer (ref), Gamemode (copy), IsMatch (ref), ServerType (copy), Environment (copy), Controller (copy)
        local Players2 = game.Teams[p28.Name]:GetPlayers();
        local Players3 = game.Teams[Essentials:ActualTeam(p28.Name)]:GetPlayers();

        if p29.Value == nil then
            LocalPlayer.PlayerGui.PickTeam[p28.Name][Gamemode][p29.Name].Image = "rbxassetid://80708336230930";
            LocalPlayer.PlayerGui.PickTeam[p28.Name][Gamemode][p29.Name].ImageTransparency = 0.25;
            LocalPlayer.PlayerGui.PickTeam[p28.Name][Gamemode][p29.Name].plr.Text = "None";
        else
            local Value = p29.Value;

            if Value:IsA("ObjectValue") then
                Value = Essentials:GetBotFromRig(Value.Value);
            end;

            local v30 = `rbxthumb://type=AvatarHeadShot&id={Value.UserId}&w=180&h=180`;
            LocalPlayer.PlayerGui.PickTeam[p28.Name][Gamemode][p29.Name].Image = v30;
            LocalPlayer.PlayerGui.PickTeam[p28.Name][Gamemode][p29.Name].ImageTransparency = 0;
            LocalPlayer.PlayerGui.PickTeam[p28.Name][Gamemode][p29.Name].plr.Text = Value.Name;
        end;

        if not (IsMatch(Gamemode) or (ServerType == "Custom" or Environment == "Dev")) then
            if #Players2 > #Players3 then
                LocalPlayer.PlayerGui.PickTeam[p28.Name].Visible = false;
                LocalPlayer.PlayerGui.PickTeam[`{p28.Name}Full`].Visible = true;
            else
                LocalPlayer.PlayerGui.PickTeam[p28.Name].Visible = true;
                LocalPlayer.PlayerGui.PickTeam[`{p28.Name}Full`].Visible = false;
            end;

            if #Players3 > #Players2 then
                LocalPlayer.PlayerGui.PickTeam[Essentials:ActualTeam(p28.Name)].Visible = false;
                LocalPlayer.PlayerGui.PickTeam[`{Essentials:ActualTeam(p28.Name)}Full`].Visible = true;
            else
                LocalPlayer.PlayerGui.PickTeam[Essentials:ActualTeam(p28.Name)].Visible = true;
                LocalPlayer.PlayerGui.PickTeam[`{Essentials:ActualTeam(p28.Name)}Full`].Visible = false;
            end;
        end;

        if p29.Value == LocalPlayer then
            Controller:TeamCheck();
        end;
    end;

    local function PickedTeam(u31) -- Line: 248
        -- upvalues: changePos (copy), IsMatch (ref), Gamemode (copy), LocalPlayer (ref), PickTeam (copy)
        for _, child in u31:GetChildren() do
            task.spawn(changePos, u31, child);
            child:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 251
                -- upvalues: changePos (ref), u31 (copy), child (copy)
                changePos(u31, child);
            end);
        end;

        if IsMatch(Gamemode) then
            for _, child in LocalPlayer.PlayerGui.PickTeam[u31.Name].Normal:GetChildren() do
                child.Visible = false;
            end;

            for _, child in LocalPlayer.PlayerGui.PickTeam[u31.Name][Gamemode]:GetChildren() do
                child.Visible = true;
            end;

            PickTeam.Close.Visible = false;
        end;
    end;

    if IsMatch(Gamemode) then
        LocalPlayer.PlayerGui.PickTeam[Essentials:ActualTeam(LocalPlayer.Team.Name)].Visible = false;
        LocalPlayer.PlayerGui.PickTeam[`{Essentials:ActualTeam(LocalPlayer.Team.Name)}Full`].Visible = true;
    end;

    if Gamemode ~= "Match-2v2" and Gamemode ~= "Match-1v1" then
        v27(PickTeam.Away);
        v27(PickTeam.Home);
        PickedTeam(ReplicatedStorage.Teams.Home);
        PickedTeam(ReplicatedStorage.Teams.Away);
    end;

    LocalPlayer.PlayerGui.InGame.BG.Return.MouseButton1Click:Connect(function() -- Line: 288
        -- upvalues: Knit (ref), Effects (ref), u7 (ref), u8 (ref), u4 (ref)
        if Knit.GetController("MovementController").States.Ability then
            Effects:Popup("Must not be using an ability!");

            return;
        end;

        if u7 > tick() then
            return;
        end;

        u7 = tick() + 0.5;
        u8 = tick();
        u4.Return:Fire();
    end);

    if IsMatch(Gamemode) then
        LocalPlayer.PlayerGui.InGame.BG.Return.Visible = false;
        ReplicatedStorage.GameValues.State:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 304
            -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref)
            if ReplicatedStorage.GameValues.State.Value == "Playing" then
                LocalPlayer.PlayerGui.InGame.BG.Surrender.Visible = true;
            end;

            if ReplicatedStorage.GameValues.State.Value == "Ending" then
                LocalPlayer.PlayerGui.InGame.BG.Surrender.Visible = false;
            end;
        end);
        LocalPlayer.PlayerGui.InGame.BG.Surrender.Activated:Connect(function() -- Line: 314
            -- upvalues: Service (copy), LocalPlayer (ref)
            Service:SurrenderVote();
            LocalPlayer.PlayerGui.InGame.BG.Surrender.Visible = false;
        end);
        Service.SurrenderReset:Connect(function(p32) -- Line: 319
            -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref)
            if ReplicatedStorage.GameValues.State.Value == "Playing" then
                LocalPlayer.PlayerGui.InGame.BG.Surrender.Visible = p32;
            end;
        end);
        Service.SafeToLeave:Connect(function() -- Line: 325
            -- upvalues: LocalPlayer (ref)
            LocalPlayer.PlayerGui.InGame.BG.Return.Visible = true;
        end);
    end;

    p24:SpawnRing();
end;

function v3.KnitInit(p33) -- Line: 333
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    LocalPlayer.CharacterAdded:Connect(function(p34) -- Line: 334
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p34;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
end;

return v3;