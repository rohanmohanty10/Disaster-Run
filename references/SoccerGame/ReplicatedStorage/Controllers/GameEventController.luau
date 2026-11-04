  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local SoundService = game:GetService("SoundService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "GameEventController"
});
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = false;
local u8 = nil;

function v1.KnitStart(p9) -- Line: 23
    -- upvalues: Knit (copy), Players (copy), u7 (ref), u6 (ref), u3 (ref), u4 (ref), u5 (ref), u8 (ref), SoundService (copy), ReplicatedStorage (copy), u2 (ref), CollectionService (copy), TweenService (copy), TweenInfo_new_ret (copy)
    local Service = Knit.GetService("GameEventService");
    p9:CreateStatusHUD();
    local HUD = Players.LocalPlayer.PlayerGui:WaitForChild("HUD");

    local function restoreLobbyHud() -- Line: 30
        -- upvalues: u7 (ref), u6 (ref), HUD (copy)
        if not u7 then
            return;
        end;

        u7 = false;
        u6.Visible = false;
        HUD.Enabled = true;
    end;

    HUD:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 39
        -- upvalues: u7 (ref), HUD (copy)
        if u7 and HUD.Enabled then
            HUD.Enabled = false;
        end;
    end);
    u6.Activated:Connect(function() -- Line: 45
        -- upvalues: Service (copy)
        Service.LeaveEvent:Fire();
    end);
    Service.UpdateHUD:Connect(function(p10, p11) -- Line: 49
        -- upvalues: u3 (ref), u4 (ref), u5 (ref), u7 (ref), u6 (ref), HUD (copy)
        if not u3 then
            return;
        end;

        u3.Enabled = p11;

        if p10 then
            u4.Text = p10;
        end;

        if not p11 and u5 then
            u5.Visible = false;
        end;

        if not p11 then
            if not u7 then
                return;
            end;

            u7 = false;
            u6.Visible = false;
            HUD.Enabled = true;
        end;
    end);
    Service.UpdateQuestion:Connect(function(p12, p13) -- Line: 65
        -- upvalues: u3 (ref), u5 (ref)
        if not (u3 and u5) then
            return;
        end;

        u5.Text = p12 or "";
        local v14;

        if p13 == true then
            v14 = u5.Text ~= "";
        else
            v14 = false;
        end;

        u5.Visible = v14;

        if u5.Visible then
            u3.Enabled = true;
        end;
    end);
    Service.StopAudio:Connect(function() -- Line: 76
        -- upvalues: u7 (ref), u6 (ref), HUD (copy), u5 (ref), u8 (ref), SoundService (ref)
        if u7 then
            u7 = false;
            u6.Visible = false;
            HUD.Enabled = true;
        end;

        if u5 then
            u5.Visible = false;
        end;

        if u8 then
            u8:Stop();
            u8:Destroy();
            u8 = nil;
        end;

        local v15 = SoundService:FindFirstChild("SoundGroup") and SoundService.SoundGroup:FindFirstChild("OST");

        if v15 then
            v15.Volume = 0.35;
        end;
    end);
    Service.GameJoined:Connect(function(p16) -- Line: 93
        -- upvalues: u7 (ref), HUD (copy), u6 (ref), u3 (ref), SoundService (ref), u8 (ref), ReplicatedStorage (ref)
        if p16 == "UbersMatching" then
            u7 = true;
            HUD.Enabled = false;
            u6.Visible = true;
            u3.Enabled = true;
        end;

        if p16 == "LavinhoTiles" then
            local OST = SoundService:WaitForChild("SoundGroup"):WaitForChild("OST");

            if OST then
                OST.Volume = 0;
            end;

            if u8 then
                u8:Destroy();
            end;

            u8 = Instance.new("Sound");
            u8.Name = "LavinhoGameMusic";
            u8.SoundId = "rbxassetid://128611181423512";
            u8.Volume = 0.15;
            u8.Looped = true;
            u8.Parent = SoundService;
            u8:Play();
            local success, result = pcall(function() -- Line: 118
                -- upvalues: ReplicatedStorage (ref)
                return require(ReplicatedStorage.Effects.LavinhoTilesIntro);
            end);

            if success and result then
                result();
            end;
        end;
    end);

    local function setupEgoModel(p17) -- Line: 128
        -- upvalues: u2 (ref)
        local Ego = p17:WaitForChild("Ego", 10);

        if not Ego then
            return;
        end;

        local PrimaryPart = Ego.PrimaryPart;

        if not PrimaryPart then
            return;
        end;

        local CFrame2 = PrimaryPart.CFrame;
        u2 = {
            part = PrimaryPart,
            default = CFrame2,
            rotated = CFrame2 * CFrame.Angles(0, 3.141592653589793, 0)
        };
    end;

    CollectionService:GetInstanceAddedSignal("EgoGames"):Connect(setupEgoModel);

    for _, v in ipairs(CollectionService:GetTagged("EgoGames")) do
        task.spawn(function() -- Line: 151
            -- upvalues: setupEgoModel (copy), v (copy)
            setupEgoModel(v);
        end);
    end;

    Service.StateChanged:Connect(function(p18) -- Line: 156
        -- upvalues: u2 (ref), TweenService (ref), TweenInfo_new_ret (ref)
        if not u2 then
            return;
        end;

        TweenService:Create(u2.part, TweenInfo_new_ret, {
            CFrame = p18 and u2.rotated or u2.default
        }):Play();
    end);
    p9:SetupCamera();
end;

function v1.CreateStatusHUD(p19) -- Line: 172
    -- upvalues: Players (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
    u3 = Instance.new("ScreenGui");
    u3.Name = "GameEventHUD";
    u3.ResetOnSpawn = false;
    u3.Enabled = false;
    u3.Parent = PlayerGui;
    u4 = Instance.new("TextLabel");
    u4.Name = "StatusLabel";
    u4.Size = UDim2.new(0.4, 0, 0.075, 0);
    u4.Position = UDim2.new(0.5, 0, 0.15, 0);
    u4.AnchorPoint = Vector2.new(0.5, 0);
    u4.BackgroundTransparency = 1;
    u4.TextColor3 = Color3.new(1, 1, 1);
    u4.TextStrokeTransparency = 0;
    u4.TextStrokeColor3 = Color3.new(0, 0, 0);
    u4.TextScaled = true;
    u4.Font = Enum.Font.BuilderSans;
    u4.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);
    u4.Parent = u3;
    u5 = Instance.new("TextLabel");
    u5.Name = "QuestionLabel";
    u5.Size = UDim2.new(0.8, 0, 0.12, 0);
    u5.Position = UDim2.new(0.5, 0, 0.02, 0);
    u5.AnchorPoint = Vector2.new(0.5, 0);
    u5.BackgroundColor3 = Color3.fromRGB(28, 16, 52);
    u5.BackgroundTransparency = 0.2;
    u5.TextColor3 = Color3.new(1, 1, 1);
    u5.TextStrokeTransparency = 0.3;
    u5.TextStrokeColor3 = Color3.new(0, 0, 0);
    u5.TextScaled = true;
    u5.TextWrapped = true;
    u5.Text = "";
    u5.Visible = false;
    u5.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);
    u5.Parent = u3;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 12);
    UICorner.Parent = u5;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0.03, 0);
    UIPadding.PaddingRight = UDim.new(0.03, 0);
    UIPadding.PaddingTop = UDim.new(0.08, 0);
    UIPadding.PaddingBottom = UDim.new(0.08, 0);
    UIPadding.Parent = u5;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 44;
    UITextSizeConstraint.Parent = u5;
    u6 = Instance.new("TextButton");
    u6.Name = "ExitButton";
    u6.AnchorPoint = Vector2.new(1, 0);
    u6.Position = UDim2.new(0.98, 0, 0.16, 0);
    u6.Size = UDim2.new(0.1, 0, 0.07, 0);
    u6.BackgroundColor3 = Color3.fromRGB(205, 45, 45);
    u6.TextColor3 = Color3.new(1, 1, 1);
    u6.TextStrokeTransparency = 0.4;
    u6.TextScaled = true;
    u6.Text = "EXIT";
    u6.Visible = false;
    u6.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);
    u6.Parent = u3;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(0, 10);
    UICorner2.Parent = u6;
    local UISizeConstraint = Instance.new("UISizeConstraint");
    UISizeConstraint.MinSize = Vector2.new(90, 36);
    UISizeConstraint.Parent = u6;
    local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint2.MaxTextSize = 30;
    UITextSizeConstraint2.Parent = u6;
end;

function v1.SetupCamera(p20) -- Line: 258
    -- upvalues: Players (copy), CollectionService (copy)
    local LocalPlayer = Players.LocalPlayer;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    local function onPromptTriggered(p21) -- Line: 262
        -- upvalues: LocalPlayer (copy), workspace_CurrentCamera (copy)
        if p21 ~= LocalPlayer then
            return;
        end;

        task.wait(0.8);
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("Head");
        end;

        if Character then
            workspace_CurrentCamera.CFrame = CFrame.lookAt(Character.Position + Vector3.new(0, 3, 0) - Character.CFrame.LookVector * 12, Character.Position);
        end;
    end;

    local function setupPrompt(p22) -- Line: 278
        -- upvalues: onPromptTriggered (copy)
        p22.Triggered:Connect(onPromptTriggered);
    end;

    for _, v in CollectionService:GetTagged("EnterEgoGames") do
        v.Triggered:Connect(onPromptTriggered);
    end;

    CollectionService:GetInstanceAddedSignal("EnterEgoGames"):Connect(setupPrompt);
end;

return v1;