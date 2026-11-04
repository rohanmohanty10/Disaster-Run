 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(script.Parent.Parent.AbilityController.Abilities);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Visitor = game.Teams.Visitor;
local v3 = Knit.CreateController({
    Name = "PassController"
});
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = false;
local u12 = tick();

function v3.GetTeammateFromKeybind(p13: table, p14: number) -- Line: 37
    -- upvalues: LocalPlayer (copy), u8 (ref), ReplicatedStorage (copy), Essentials (copy)
    if LocalPlayer.Team then
        if (u8.Gamemode == "Match-2v2" or u8.Gamemode == "Match-1v1") and workspace.BARRIER.CanCollide then
            if p14 == 1 then
                return ReplicatedStorage.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)].CB.Value or ReplicatedStorage.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)].CM.Value;
            end;

            return nil;
        end;

        local Players2 = Essentials:GetPlayers(LocalPlayer.Team);
        table.remove(Players2, table.find(Players2, LocalPlayer));

        return Players2[p14];
    end;
end;

function v3.Anim(p15: table, p16: userdata?) -- Line: 59
    -- upvalues: u8 (ref), u5 (ref), u7 (ref), HumanoidRootPart (ref), u4 (ref), ReplicatedStorage (copy), Essentials (copy), LocalPlayer (copy), u1 (ref), u11 (ref)
    if not p16 and p15.LookingAt == nil then
        return;
    end;

    if not u8.CharValues.HasBall then
        return;
    end;

    local v17 = p16 or p15.LookingAt;
    u5:StopAll();

    if u7.States.Shooting then
        u5:StopAll();
        local Unit = (Vector3.new(v17.HumanoidRootPart.Position.X, HumanoidRootPart.Position.Y, v17.HumanoidRootPart.Position.Z) - HumanoidRootPart.Position).Unit;
        local v18 = HumanoidRootPart.CFrame.LookVector:Dot(Unit);
        local v19 = v18 <= -0.25 and "JumpPassR" or (v18 >= 0.25 and "JumpPassL" or "JumpPassF");
        local v20 = u5:PlayChar("Passes", v19, Enum.AnimationPriority.Action3, true);
        local v21 = u5:PlayBall("Passes", v19, Enum.AnimationPriority.Action3, true);
        v20.TimePosition = workspace:GetServerTimeNow() - u4.ShootStarted;
        v21.TimePosition = workspace:GetServerTimeNow() - u4.ShootStarted;

        return;
    end;

    local _ = ReplicatedStorage.Basketball.Value;
    local v22 = {};

    for _, v in Essentials:GetPlayers() do
        if v.Character ~= nil and (v.Team ~= LocalPlayer.Team and v ~= LocalPlayer) then
            table.insert(v22, v.Character);
        end;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { u1:GetDescendants(), ReplicatedStorage.Basketball.Value, v17 };
    local HumanoidRootPart2 = u4:GetLastCharacterToPossessBall().HumanoidRootPart;

    for _, _ in v22 do
        local v23 = false;

        for i = -2, 2 do
            local Position = (HumanoidRootPart2.CFrame * CFrame.new(i, 0, 0)).Position;
            local v24 = workspace:Raycast(Position, (v17.HumanoidRootPart.Position - Position).Unit * 9999, RaycastParams_new_ret);

            if v24 and v24.Instance.Parent:FindFirstChild("Humanoid") then
                v23 = true;
                break;
            end;

            local _ = i;
        end;

        if v23 then
            u11 = false;
        end;

        u11 = true;
    end;

    if (HumanoidRootPart.Position - v17.HumanoidRootPart.Position).Magnitude >= 70 then
        u11 = false;
    end;

    local math_random_ret = math.random(1, 2);

    if u11 then
        u5:PlayChar("Passes", `StraightPass{tostring(math_random_ret)}`, Enum.AnimationPriority.Action2);
        u5:PlayBall("Passes", `StraightPass{tostring(math_random_ret)}`, Enum.AnimationPriority.Action2);

        return;
    end;

    u5:PlayChar("Passes", `Pass{math_random_ret}{Essentials:ReturnRorL(u8.CharValues)}`, Enum.AnimationPriority.Action2);
    u5:PlayBall("Passes", `Pass{math_random_ret}{Essentials:ReturnRorL(u8.CharValues)}`, Enum.AnimationPriority.Action2);
end;

function v3.Pass(p25, u26, p27) -- Line: 142
    -- upvalues: u4 (ref), ReplicatedStorage (copy), HumanoidRootPart (ref), u8 (ref), Zones (copy), LocalPlayer (copy), RunService (copy)
    local LastPlayerToPossessBall = u4:GetLastPlayerToPossessBall();
    local Character = LastPlayerToPossessBall.Character;

    if Character == nil then
        return warn("LastPlayer to possess ball", LastPlayerToPossessBall, "has no Character!");
    end;

    local HumanoidRootPart2 = Character.HumanoidRootPart;
    local Value = ReplicatedStorage.Basketball.Value;
    Value.CFrame = Character.PlrBall.Anims.BALL.CFrame;
    local u28 = true;

    if (HumanoidRootPart.Position - u26.Position).Magnitude >= 70 then
        u28 = false;
    else
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { HumanoidRootPart2.Parent, ReplicatedStorage.Basketball.Value, u26 };

        for i = -2, 2 do
            local Position = (HumanoidRootPart2.CFrame * CFrame.new(i, 0, 0)).Position;
            local v29 = workspace:Raycast(Position, u26.Position - Position, RaycastParams_new_ret);

            if v29 and v29.Instance.Parent:FindFirstChild("Humanoid") then
                u28 = false;
                break;
            end;

            local _ = i;
        end;
    end;

    local u30 = 1;

    if u8.CharValues.InZone then
        if Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value] then
            u30 = u30 + Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value];
        end;

        if LocalPlayer.Zone.Value == "GoldenSpin" then
            u30 = u30 + (1.5 - 1.5 / math.pow(1.618033988749895, u8.CharValues.ZoneStackable or 0));
        end;
    end;

    local Position = Value.Position;
    local u31 = u26.Position + u26.AssemblyLinearVelocity * 0.1;
    local v32 = u31 - Position;
    local Magnitude = v32.Magnitude;
    local Unit = v32.Unit;
    Value.AssemblyLinearVelocity = (Unit * u30 + Vector3.new(0, 0.62, 0)) * (Magnitude <= 8 and 10 or Magnitude);

    if Magnitude <= 8 then
        return;
    end;

    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = Value.Root;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = (Unit * u30 + Vector3.new(0, 0.62, 0)) * Magnitude;
    task.delay(0.05, function() -- Line: 252
        -- upvalues: LinearVelocity (copy), Value (copy), Magnitude (ref), RunService (ref), Position (ref), u31 (ref), u26 (copy), HumanoidRootPart (ref), u4 (ref), u28 (ref), u30 (ref)
        local u33 = nil;
        LinearVelocity.Parent = Value;
        local u34 = tick();
        local math_clamp_ret = math.clamp(Magnitude, 65, 120);
        u33 = RunService.Heartbeat:Connect(function(p35) -- Line: 258
            -- upvalues: Position (ref), Value (ref), u31 (ref), u26 (ref), Magnitude (ref), u34 (copy), HumanoidRootPart (ref), u4 (ref), u33 (ref), LinearVelocity (ref), u28 (ref), u30 (ref), math_clamp_ret (ref)
            Position = Value.Position;
            u31 = u26.Position;
            Magnitude = (u31 - Position).Magnitude;

            if u34 + 3 < tick() or Magnitude <= 8 and u26 == HumanoidRootPart or (Magnitude <= 3 or (Value.Parent == nil or (u4:GetPlayerPossessingBall() or not u4:LocalPlayerIsBallNetworkOwner()))) then
                u33:Disconnect();
                LinearVelocity:Destroy();
                Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                return;
            end;

            local Unit2 = (u26.Position - Value.Position).Unit;

            if u28 then
                LinearVelocity.VectorVelocity = (Unit2 * u30 + Vector3.new(0, Magnitude / math_clamp_ret / 2.9 - 0.05, 0)) * (math_clamp_ret * 1.5);

                return;
            end;

            LinearVelocity.VectorVelocity = (Unit2 * u30 + Vector3.new(0, Magnitude / math_clamp_ret / 2.2 - 0.05, 0)) * (math_clamp_ret * 1.45);
        end);
    end);
end;

function v3.CallFor(p36) -- Line: 289
    -- upvalues: u12 (ref), LocalPlayer (copy), Visitor (copy), u4 (ref), Effects (copy), HumanoidRootPart (ref), u5 (ref), u10 (ref)
    if u12 > tick() then
        return;
    end;

    if LocalPlayer.Team == nil or LocalPlayer.Team == Visitor then
        return;
    end;

    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if PlayerPossessingBall == nil then
        Effects:Popup("No one has the ball!");

        return;
    end;

    if PlayerPossessingBall == LocalPlayer then
        Effects:Popup("You want to pass to... yourself?");

        return;
    end;

    local Magnitude = (u4:GetServerBallPosition() - HumanoidRootPart.Position).Magnitude;
    u12 = tick() + 2.2;

    if Magnitude <= 50 then
        u5:PlayChar("Passes", "CallPass2", Enum.AnimationPriority.Action2);
    else
        u5:PlayChar("Passes", "CallPass", Enum.AnimationPriority.Action2);
    end;

    u10.CallPass:Fire();
end;

function v3.KnitStart(u37) -- Line: 326
    -- upvalues: u4 (ref), Knit (copy), u5 (ref), u7 (ref), u6 (ref), u8 (ref), u9 (ref), u10 (ref), Trove (copy), UserInputService (copy), LocalPlayer (copy), RunService (copy), Essentials (copy), HumanoidRootPart (ref), GuiService (copy), Players (copy), ReplicatedStorage (copy), Styles (copy), Rarities (copy), Abilities (copy)
    u4 = Knit.GetController("BallController");
    u5 = Knit.GetController("AnimationController");
    u7 = Knit.GetController("MovementController");
    u6 = Knit.GetController("AbilityController");
    u8 = Knit.GetController("Network");
    u9 = Knit.GetService("CustomServerService");
    u10 = Knit.GetService("BallService");
    u37.LookingAt = nil;
    u37.LookingAtEnemy = nil;
    local u38 = Trove.new();
    local u39 = Trove.new();
    local Controller = Knit.GetController("KeybindsController");
    u9:GetServerType();
    UserInputService.InputBegan:Connect(function(p40, p41) -- Line: 346
        -- upvalues: Controller (copy), u37 (copy)
        if p41 then
            return;
        end;

        if Controller.IsInputValid(p40, "Call") then
            u37:CallFor();
        end;
    end);
    LocalPlayer.PlayerGui:WaitForChild("Mobile"):WaitForChild("NoBall"):WaitForChild("Call").MouseButton1Click:Connect(function() -- Line: 353
        -- upvalues: u37 (copy)
        u37:CallFor();
    end);
    local u42 = tick();
    u37.BarrierWasOn = tick();
    RunService.Heartbeat:Connect(function() -- Line: 359
        -- upvalues: u42 (ref), LocalPlayer (ref), u39 (copy), u38 (copy), Essentials (ref), u8 (ref), RunService (ref), HumanoidRootPart (ref), GuiService (ref), Players (ref), u37 (copy), ReplicatedStorage (ref), u4 (ref), u6 (ref), Styles (ref), Rarities (ref), Abilities (ref)
        if u42 > tick() then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            u39:Clean();
            u38:Clean();

            return;
        end;

        u42 = tick() + 0.1;
        local v43 = {};

        for _, v in Essentials:GetPlayers() do
            if v ~= LocalPlayer and v.Character ~= nil then
                if u8.Gamemode == "Match-1v1" or (u8.ServerType == "Tutorial" or (LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief")) then
                    if (not (workspace.BARRIER.CanCollide and (u8.Gamemode == "Match-2v2" or u8.Gamemode == "Match-1v1")) or v.Team ~= LocalPlayer.Team) and (workspace.BARRIER.CanCollide or (u8.Gamemode ~= (u8.Gamemode == "Match-2v2" and true or u8.Gamemode == "Match-1v1") or v.Team == LocalPlayer.Team)) then
                        table.insert(v43, v.Character);
                    end;
                elseif u8.Gamemode == "Match-2v2" and not workspace.BARRIER.CanCollide then
                    if v.Team == LocalPlayer.Team then
                        if (not (workspace.BARRIER.CanCollide and (u8.Gamemode == "Match-2v2" or u8.Gamemode == "Match-1v1")) or v.Team ~= LocalPlayer.Team) and (workspace.BARRIER.CanCollide or (u8.Gamemode ~= (u8.Gamemode == "Match-2v2" and true or u8.Gamemode == "Match-1v1") or v.Team == LocalPlayer.Team)) then
                            table.insert(v43, v.Character);
                        end;
                    end;
                elseif u8.Gamemode == "Match-2v2" or v.Team == LocalPlayer.Team then
                    if (not (workspace.BARRIER.CanCollide and (u8.Gamemode == "Match-2v2" or u8.Gamemode == "Match-1v1")) or v.Team ~= LocalPlayer.Team) and (workspace.BARRIER.CanCollide or (u8.Gamemode ~= (u8.Gamemode == "Match-2v2" and true or u8.Gamemode == "Match-1v1") or v.Team == LocalPlayer.Team)) then
                        table.insert(v43, v.Character);
                    end;
                end;
            end;
        end;

        RunService:IsStudio();
        local v44 = nil;
        local v45 = 999;
        local v46 = nil;
        local v47 = 999;

        for _, v in v43 do
            if v:FindFirstChild("HumanoidRootPart") ~= nil then
                local v48, v49 = workspace.CurrentCamera:WorldToScreenPoint(v.HumanoidRootPart.Position);

                if v49 and (HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 180 then
                    local Magnitude = (Vector2.new(v48.X, v48.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 - GuiService:GetGuiInset().Y / 2)).Magnitude;
                    local v50 = Players:FindFirstChild(v.Name);

                    if workspace.BARRIER.CanCollide and (u8.Gamemode ~= "Match-2v2" and u8.Gamemode ~= "Match-1v1") or not ((LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief") and (v50 and v50.Team ~= LocalPlayer.Team)) then
                        if v46 then
                            if Magnitude < v47 then
                                v47 = Magnitude;
                                v46 = v;
                            end;
                        else
                            v47 = Magnitude;
                            v46 = v;
                        end;
                    elseif not v.Torso:GetAttribute("Invis") then
                        if v44 then
                            if Magnitude < v45 then
                                v45 = Magnitude;
                                v44 = v;
                            end;
                        else
                            v45 = Magnitude;
                            v44 = v;
                        end;
                    end;
                end;
            end;
        end;

        if workspace:FindFirstChild("CamRig") then
            v44 = nil;
            v46 = nil;
        end;

        if workspace.BARRIER.CanCollide and (u8.Gamemode == "Match-2v2" or u8.Gamemode == "Match-1v1") then
            u37.BarrierWasOn = tick();
            local v51 = ReplicatedStorage.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)].CB.Value or ReplicatedStorage.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)].CM.Value;

            if v51 then
                v46 = v51.Character;
            end;
        end;

        if (u8.Gamemode == "Match-2v2" or u8.Gamemode == "Match-1v1") and (u37.BarrierWasOn + 0.5 > tick() and u4:GetLastPlayerToPossessBall() == LocalPlayer) then
            local v52 = ReplicatedStorage.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)].CB.Value or ReplicatedStorage.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)].CM.Value;

            if v52 then
                v46 = v52.Character;
            end;
        end;

        if LocalPlayer.Style.Value == "Copycat" and v47 < v45 then
            u37.LookingDirect = v46;
        else
            u37.LookingDirect = v44;
        end;

        if u37.LookingAtEnemy ~= v44 then
            if u39 then
                u39:Clean();
            end;

            local u53;

            if v44 then
                u53 = Players:FindFirstChild(v44.Name);
            else
                u53 = v44;
            end;

            if u53 and u53.Team ~= LocalPlayer.Team then
                u37.LookingAtEnemy = v44;

                if not workspace:FindFirstChild("CutTheLights") then
                    local Highlight = Instance.new("Highlight");
                    Highlight.FillTransparency = 0.5;
                    Highlight.FillColor = Color3.new(1, 0.796078, 0.54902);
                    Highlight.OutlineTransparency = 0;
                    Highlight.OutlineColor = Color3.new(0.207843, 0.239216, 0.701961);
                    Highlight.Parent = v44;
                    Highlight.Adornee = v44;

                    if v44.Torso.Transparency < 0.3 then
                        local u54 = script.PlrStyle:Clone();
                        u54.Parent = v44;

                        if LocalPlayer.Style.Value == "Copycat" then
                            if u6.FlowstepDash then
                                u54.Style.Text = Styles.Setting[u53.Style.Value];
                            else
                                u54.Style.Text = u53.Style.Value;
                            end;
                        elseif LocalPlayer.Style.Value == "Thief" then
                            u39:Connect(RunService.Heartbeat, function() -- Line: 495
                                -- upvalues: u53 (copy), u8 (ref), LocalPlayer (ref), Rarities (ref), Styles (ref), Abilities (ref), u54 (copy)
                                if not (u53.Style:GetAttribute("AbilityIndex") and (u53.Style.Value ~= "Copycat" and u53.Style.Value ~= "Thief") and (u8.CharValues.InZone and LocalPlayer.Zone.Value == "Devour" or (u8.CharValues.InAwakening or not table.find(Rarities.Limited, Styles.Styles[u53.Style.Value].Rarity)))) then
                                    u54.Style.Text = "X";

                                    return;
                                end;

                                local v55 = Abilities[u53.Style.Value][u53.Style:GetAttribute("AbilityIndex")];

                                if u8.CharValues.HasBall and v55.BallName then
                                    u54.Style.Text = v55.BallName;

                                    return;
                                end;

                                u54.Style.Text = v55.Name;
                            end);
                        end;

                        u54.Style.TextColor3 = Styles.Colors[u53.Style.Value];
                        u39:Add(u54);
                    end;

                    u39:Add(Highlight);
                end;
            else
                u37.LookingAtEnemy = nil;
            end;
        end;

        if u37.LookingAt ~= v46 then
            local v56 = Players:GetPlayerFromCharacter(v46) or Essentials:GetBotFromRig(v46);

            if v56 and v56.Team ~= LocalPlayer.Team then
                return;
            end;

            u37.LookingAt = v46;
            u38:Clean();
            local Highlight = Instance.new("Highlight");
            Highlight.FillTransparency = 0.5;
            Highlight.FillColor = Color3.new(1, 1, 1);
            Highlight.OutlineTransparency = 0;
            Highlight.OutlineColor = Color3.new(1, 1, 1);
            Highlight.Parent = v46;
            Highlight.Adornee = v46;

            if LocalPlayer.Style.Value == "Copycat" and (v56 and v46.Torso.Transparency < 0.3) then
                local v57 = script.PlrStyle:Clone();
                v57.Parent = v46;

                if u6.FlowstepDash then
                    v57.Style.Text = Styles.Setting[v56.Style.Value];
                else
                    v57.Style.Text = v56.Style.Value;
                end;

                v57.Style.TextColor3 = Styles.Colors[v56.Style.Value];
                u38:Add(v57);
            end;

            u38:Add(Highlight);
        end;
    end);
end;

function v3.KnitInit(p58) -- Line: 559
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    LocalPlayer.CharacterAdded:Connect(function(p59) -- Line: 560
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p59;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
end;

return v3;