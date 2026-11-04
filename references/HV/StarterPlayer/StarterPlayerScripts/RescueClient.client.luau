 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local RescueConfig = require(Game:WaitForChild("RescueConfig"));
local RescueEvent = Game:WaitForChild("RescueEvent");
local Session = Game:WaitForChild("Session");
local ParticipantDirectory = require(ChickenOrHero.Presentation:WaitForChild("ParticipantDirectory"));
local VerifiedName = require(ChickenOrHero.Presentation:WaitForChild("VerifiedName"));
local ControlGate = require(ChickenOrHero.Movement:WaitForChild("ControlGate"));
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "RescueStatus";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 24;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Status";
TextLabel.AnchorPoint = Vector2.new(0.5, 1);
TextLabel.Position = UDim2.fromScale(0.5, 0.8);
TextLabel.Size = UDim2.fromScale(0.65, 0.065);
TextLabel.BackgroundTransparency = 1;
TextLabel.TextColor3 = Color3.fromRGB(245, 243, 231);
TextLabel.Font = Enum.Font.GothamBold;
TextLabel.TextScaled = true;
TextLabel.TextStrokeTransparency = 0.5;
TextLabel.Visible = false;
TextLabel.Parent = ScreenGui;
local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
UITextSizeConstraint.MinTextSize = 12;
UITextSizeConstraint.MaxTextSize = 20;
UITextSizeConstraint.Parent = TextLabel;
local Frame = Instance.new("Frame");
Frame.Name = "NearbyRescue";
Frame.BackgroundTransparency = 1;
Frame.Size = UDim2.fromScale(0.22, 0.1);
Frame.AnchorPoint = Vector2.new(0.5, 1);
Frame.Position = UDim2.fromScale(0.5, 0.78);
Frame.Visible = false;
Frame.Parent = ScreenGui;
local UISizeConstraint = Instance.new("UISizeConstraint");
UISizeConstraint.MinSize = Vector2.new(180, 60);
UISizeConstraint.MaxSize = Vector2.new(240, 74);
UISizeConstraint.Parent = Frame;
local TextButton = Instance.new("TextButton");
TextButton.Name = "Hold";
TextButton.Size = UDim2.fromScale(1, 1);
TextButton.BackgroundColor3 = Color3.fromRGB(12, 27, 30);
TextButton.BackgroundTransparency = 0.16;
TextButton.BorderSizePixel = 0;
TextButton.Text = "";
TextButton.AutoButtonColor = false;
TextButton.Parent = Frame;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0, 5);
UICorner.Parent = TextButton;
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.BackgroundTransparency = 1;
TextLabel2.Position = UDim2.fromScale(0.05, 0.08);
TextLabel2.Size = UDim2.fromScale(0.9, 0.32);
TextLabel2.Font = Enum.Font.Gotham;
TextLabel2.TextColor3 = Color3.fromRGB(187, 199, 194);
TextLabel2.TextSize = 12;
TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
TextLabel2.Parent = TextButton;
local TextLabel3 = Instance.new("TextLabel");
TextLabel3.BackgroundTransparency = 1;
TextLabel3.Position = UDim2.fromScale(0.03, 0.39);
TextLabel3.Size = UDim2.fromScale(0.94, 0.4);
TextLabel3.Font = Enum.Font.GothamBold;
TextLabel3.TextSize = 14;
TextLabel3.TextColor3 = Color3.fromRGB(245, 238, 208);
TextLabel3.Parent = TextButton;
local Frame2 = Instance.new("Frame");
Frame2.BorderSizePixel = 0;
Frame2.BackgroundColor3 = Color3.fromRGB(85, 100, 96);
Frame2.BackgroundTransparency = 0.4;
Frame2.Position = UDim2.fromScale(0.04, 0.89);
Frame2.Size = UDim2.fromScale(0.92, 0.045);
Frame2.Parent = TextButton;
local Frame3 = Instance.new("Frame");
Frame3.BorderSizePixel = 0;
Frame3.BackgroundColor3 = Color3.fromRGB(225, 209, 148);
Frame3.Size = UDim2.fromScale(0, 1);
Frame3.Parent = Frame2;
local u1 = require(ChickenOrHero.Presentation:WaitForChild("ReviveMarkers")).new(LocalPlayer.PlayerGui);
local u2 = nil;
local u3 = nil;
local u4 = nil;

local function cancel() -- Line: 41
    -- upvalues: u3 (ref), RescueEvent (copy), u4 (ref), Frame3 (copy)
    if u3 and not u3.sent then
        RescueEvent:FireServer("Cancel", u3.id);
    end;

    u3 = nil;
    u4 = nil;
    Frame3.Size = UDim2.fromScale(0, 1);
end;

local function begin(p5) -- Line: 45
    -- upvalues: u3 (ref), u2 (ref), Frame (copy), u4 (ref), RescueEvent (copy)
    if u3 or not (u2 and Frame.Visible) then
        return;
    end;

    u4 = p5;
    u3 = {
        id = u2.UserId,
        character = u2.Character,
        started = os.clock()
    };
    RescueEvent:FireServer("Begin", u3.id);
end;

TextButton.InputBegan:Connect(function(p6) -- Line: 50
    -- upvalues: begin (copy)
    if p6.UserInputType == Enum.UserInputType.Touch or p6.UserInputType == Enum.UserInputType.MouseButton1 then
        begin(p6);
    end;
end);
UserInputService.InputBegan:Connect(function(p7, p8) -- Line: 53
    -- upvalues: UserInputService (copy), begin (copy)
    if not (p8 or (UserInputService:GetFocusedTextBox() or p7.KeyCode ~= Enum.KeyCode.F and p7.KeyCode ~= Enum.KeyCode.ButtonX)) then
        begin(p7);
    end;
end);
UserInputService.InputEnded:Connect(function(p9) -- Line: 56
    -- upvalues: u4 (ref), u3 (ref), RescueEvent (copy), Frame3 (copy)
    if u4 and (p9 == u4 or p9.KeyCode ~= Enum.KeyCode.None and p9.KeyCode == u4.KeyCode) then
        if u3 and not u3.sent then
            RescueEvent:FireServer("Cancel", u3.id);
        end;

        u3 = nil;
        u4 = nil;
        Frame3.Size = UDim2.fromScale(0, 1);
    end;
end);
RescueEvent.OnClientEvent:Connect(function(p10, p11) -- Line: 59
    -- upvalues: u3 (ref), u4 (ref), Frame3 (copy)
    if p10 == "Cancelled" and (u3 and u3.id == p11) then
        u3 = nil;
        u4 = nil;
        Frame3.Size = UDim2.fromScale(0, 1);
    end;
end);

local function characterAdded(u12) -- Line: 64
    local Humanoid = u12:WaitForChild("Humanoid", 10);

    if not Humanoid then
        return;
    end;

    local StateEnabled = Humanoid:GetStateEnabled(Enum.HumanoidStateType.GettingUp);
    local u13 = false;

    local function update() -- Line: 68
        -- upvalues: u12 (copy), u13 (ref), Humanoid (copy), StateEnabled (copy)
        if u12:GetAttribute("Ragdolled") ~= true then
            if u13 then
                u13 = false;
                Humanoid.EvaluateStateMachine = true;
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, StateEnabled);
                Humanoid.PlatformStand = false;

                if Humanoid.Health > 0 then
                    Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp);
                end;
            end;

            return;
        end;

        u13 = true;
        Humanoid.EvaluateStateMachine = false;
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false);
        Humanoid.PlatformStand = true;
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics);
    end;

    local u14 = u12:GetAttributeChangedSignal("Ragdolled"):Connect(update);
    u12.Destroying:Once(function() -- Line: 80
        -- upvalues: u14 (copy)
        u14:Disconnect();
    end);
    update();
end;

LocalPlayer.CharacterAdded:Connect(characterAdded);

if LocalPlayer.Character then
    task.spawn(characterAdded, LocalPlayer.Character);
end;

local u15 = 0;
local u29 = RunService.Heartbeat:Connect(function(p16) -- Line: 85
    -- upvalues: u15 (ref), LocalPlayer (copy), Session (copy), TextLabel (copy), RescueConfig (copy), ControlGate (copy), ParticipantDirectory (copy), u1 (copy), u3 (ref), RescueEvent (copy), u4 (ref), Frame3 (copy), u2 (ref), Frame (copy), TextLabel2 (copy), VerifiedName (copy), UserInputService (copy), TextLabel3 (copy)
    u15 = u15 + p16;

    if u15 >= 0.1 then
        u15 = 0;
        local Character = LocalPlayer.Character;
        local v17;

        if Character then
            v17 = Character:FindFirstChildOfClass("Humanoid");
        else
            v17 = Character;
        end;

        local v18;

        if Character then
            v18 = Character:FindFirstChild("HumanoidRootPart");
        else
            v18 = Character;
        end;

        local Attribute = Session:GetAttribute("GlobalPaused");
        local v19;

        if LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Caught" then
            if Character then
                v19 = Character:GetAttribute("Ragdolled");
            else
                v19 = Character;
            end;
        else
            v19 = false;
        end;

        local v20;

        if v19 then
            v20 = not Attribute or false;
        else
            v20 = false;
        end;

        TextLabel.Visible = v20;

        if TextLabel.Visible then
            local v21;

            if Character:GetAttribute("VowMarked") then
                v21 = Character:GetAttribute("RescueHelperId") and "GETTING YOU BACK UP…" or (Character:GetAttribute("RescueAvailable") and "VOW BROKEN · Get revived before the Chaser seals it" or "VOW BROKEN · The Chaser can turn you");
            else
                v21 = Character:GetAttribute("RescueAvailable") and (Character:GetAttribute("RescueHelperId") and "GETTING YOU BACK UP…" or "DOWNED · A crossing runner can revive you") or "CAUGHT · Joining the catchers next crossing";
            end;

            TextLabel.Text = v21;
        end;

        local v22 = RescueConfig.Enabled and not (Attribute or ControlGate.reason(LocalPlayer));

        if v22 then
            if LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active" then
                if v18 then
                    if v17 then
                        if v17.Health > 0 then
                            v17 = not Character:GetAttribute("MovementLocked");
                        else
                            v17 = false;
                        end;
                    end;
                else
                    v17 = v18;
                end;
            else
                v17 = false;
            end;
        else
            v17 = v22;
        end;

        local v23 = v17 and ParticipantDirectory.list() or {};
        u1:update(v23, LocalPlayer, v17);
        local v24 = nil;
        local v25 = RescueConfig.Range - 0.25;

        if v17 then
            for _, v in v23 do
                local Character2 = v.Character;
                local v26;

                if Character2 then
                    v26 = Character2:FindFirstChild("HumanoidRootPart");
                else
                    v26 = Character2;
                end;

                if v26 and (Character2 ~= Character and (Character2:GetAttribute("RescueAvailable") and Character2:GetAttribute("Ragdolled"))) then
                    local Attribute2 = Character2:GetAttribute("RescueHelperId");
                    local Magnitude = (v18.Position - v26.Position).Magnitude;

                    if Magnitude <= v25 and (not Attribute2 or Attribute2 == LocalPlayer.UserId) then
                        local RaycastParams_new_ret = RaycastParams.new();
                        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
                        RaycastParams_new_ret.FilterDescendantsInstances = { Character, Character2 };
                        RaycastParams_new_ret.RespectCanCollide = true;
                        RaycastParams_new_ret.CollisionGroup = "CoHRunner";

                        if not workspace:Raycast(v18.Position, v26.Position - v18.Position, RaycastParams_new_ret) then
                            v24 = v;
                            v25 = Magnitude;
                        end;
                    end;
                end;
            end;
        end;

        if u3 and not (v24 and (v24.UserId == u3.id and v24.Character == u3.character)) then
            if u3 and not u3.sent then
                RescueEvent:FireServer("Cancel", u3.id);
            end;

            u3 = nil;
            u4 = nil;
            Frame3.Size = UDim2.fromScale(0, 1);
        end;

        u2 = v24;
        Frame.Visible = u2 ~= nil;

        if u2 then
            TextLabel2.RichText = true;
            TextLabel2.Text = VerifiedName.player(u2) .. (" · %.1fs"):format(RescueConfig.HoldSeconds);
            local PreferredInput = UserInputService.PreferredInput;
            local v27;

            if u3 then
                v27 = u3.sent and "HELPING…" or "HOLD…";
            else
                v27 = PreferredInput == Enum.PreferredInput.Touch and "HOLD TO REVIVE" or (PreferredInput == Enum.PreferredInput.Gamepad and "HOLD X · REVIVE" or "HOLD F · REVIVE");
            end;

            TextLabel3.Text = v27;
        end;
    end;

    if u3 then
        local v28 = (os.clock() - u3.started) / RescueConfig.HoldSeconds;
        local math_clamp_ret = math.clamp(v28, 0, 1);
        Frame3.Size = UDim2.fromScale(math_clamp_ret, 1);

        if math_clamp_ret >= 1 and not u3.sent then
            u3.sent = true;
            RescueEvent:FireServer("Finish", u3.id);
        end;

        if u3.sent and os.clock() - u3.started > RescueConfig.HoldSeconds + RescueConfig.FinishGrace + 0.5 then
            if u3 and not u3.sent then
                RescueEvent:FireServer("Cancel", u3.id);
            end;

            u3 = nil;
            u4 = nil;
            Frame3.Size = UDim2.fromScale(0, 1);
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 134
    -- upvalues: u29 (copy), u3 (ref), RescueEvent (copy), u4 (ref), Frame3 (copy), u1 (copy), ScreenGui (copy)
    u29:Disconnect();

    if u3 and not u3.sent then
        RescueEvent:FireServer("Cancel", u3.id);
    end;

    u3 = nil;
    u4 = nil;
    Frame3.Size = UDim2.fromScale(0, 1);
    u1:destroy();
    ScreenGui:Destroy();
end);