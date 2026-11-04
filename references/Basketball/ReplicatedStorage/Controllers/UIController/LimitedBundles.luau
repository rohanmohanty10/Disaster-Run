 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local u1 = {
    WhaleBundle = 3565189047
};
local u2 = {
    WhaleBundle = 3565189217
};
local u3 = "WhaleBundle";
local v4 = Knit.CreateController({
    Name = u3
});

function v4.KnitInit(p5) -- Line: 26
end;

function v4.KnitStart(p6) -- Line: 30
    -- upvalues: Knit (copy), Trove (copy), LocalPlayer (copy), u3 (ref), ReplicatedStorage (copy), u1 (copy), u2 (copy), GetUnixTime (copy), RunService (copy), NumberUtil (copy), TweenService (copy)
    local Service = Knit.GetService("MarketService");
    Knit.GetController("Network");
    local Controller = Knit.GetController("UIController");
    local Controller2 = Knit.GetController("PromptController");
    Knit.GetController("LobbyController");
    local Controller3 = Knit.GetController("LockerController");
    local Controller4 = Knit.GetController("EmotesController");
    local u7 = Trove.new();
    local LimitedBundles = LocalPlayer.PlayerGui:WaitForChild("LimitedBundles");
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
    local u8 = HUD.Bundles:WaitForChild(u3);

    local function SelectItem(p9, u10) -- Line: 45
        -- upvalues: Controller3 (copy), ReplicatedStorage (ref), LocalPlayer (ref)
        Controller3:UpdateSubMenu(p9);
        task.spawn(function() -- Line: 48
            -- upvalues: ReplicatedStorage (ref), u10 (copy), Controller3 (ref), LocalPlayer (ref)
            if ReplicatedStorage.Effects.GoalEffects.Client:FindFirstChild(u10) then
                require(ReplicatedStorage.Effects.GoalEffects.Client[u10])(Controller3, {
                    Locker = true,
                    Player = LocalPlayer,
                    Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(u10),
                    CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
                });

                return;
            end;

            require(ReplicatedStorage.Effects.GoalEffects.Client.EmitEffects)(Controller3, {
                Locker = true,
                Player = LocalPlayer,
                Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(u10),
                CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
            });
        end);
    end;

    (function(p11) -- Line: 73, Name: SelectBundle
        -- upvalues: u3 (ref), LimitedBundles (copy), Controller2 (copy), u1 (ref)
        u3 = p11;
        LimitedBundles.Frame.BundleName.Text = `{string.upper(string.gsub(p11, "(.)(%u)", "%1 %2"))}!`;
        LimitedBundles.Frame.BundleShadow.Text = LimitedBundles.Frame.BundleName.Text;
        local v12 = Controller2.RepeatGetProductInfo(u1[u3], Enum.InfoType.Product);
        LimitedBundles.Frame.Buy.TextLabel.Text = v12.PriceInRobux;

        for _, child in pairs(LimitedBundles.Bundles:GetChildren()) do
            if child.Name == p11 then
                child.Visible = true;
            else
                child.Visible = false;
            end;
        end;
    end)(u3);
    LimitedBundles.Frame.Buy.MouseButton1Down:Connect(function() -- Line: 93
        -- upvalues: Service (copy), u3 (ref)
        Service.PromptLimitedBundles(Service, u3);
    end);
    LimitedBundles.Frame.Gift.MouseButton1Down:Connect(function() -- Line: 97
        -- upvalues: LimitedBundles (copy), Controller (copy), Knit (ref), u2 (ref), u3 (ref)
        LimitedBundles.Enabled = false;
        Controller:Focus(false);
        Knit.GetController("GiftingController").PromptGiftPlayer(u2[u3]);
    end);

    local function IsElegible() -- Line: 105
        -- upvalues: GetUnixTime (ref), u3 (ref)
        return GetUnixTime() < workspace:GetAttribute((`{u3}Time`));
    end;

    local u13 = nil;

    local function OnDataChanged() -- Line: 111
        -- upvalues: u7 (copy), GetUnixTime (ref), u3 (ref), LimitedBundles (copy), Controller (copy), u8 (copy), RunService (ref), u13 (ref), OnDataChanged (copy), NumberUtil (ref), TweenService (ref)
        u7:Clean();

        if GetUnixTime() < workspace:GetAttribute((`{u3}Time`)) then
            u7:Add(RunService.Heartbeat:Connect(function() -- Line: 125
                -- upvalues: GetUnixTime (ref), u13 (ref), u3 (ref), OnDataChanged (ref), LimitedBundles (ref), NumberUtil (ref), u8 (ref), TweenService (ref)
                local v14 = GetUnixTime();

                if u13 == v14 then
                    return;
                end;

                u13 = v14;
                local v15 = workspace:GetAttribute((`{u3}Time`)) - v14;

                if v15 <= 0 then
                    task.spawn(OnDataChanged);

                    return;
                end;

                LimitedBundles.Buttons:FindFirstChildOfClass("ImageButton").Timer.Text = NumberUtil.AdaptiveClockString(v15);
                u8.Timer.Text = NumberUtil.AdaptiveClockString(v15);
                u8.Timer.TextColor3 = Color3.fromRGB(255, 0, 0);
                u8.Timer.Size = UDim2.fromScale(1, 0.45);
                TweenService:Create(u8.Timer, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Size = UDim2.fromScale(1, 0.293)
                }):Play();
            end));
            u8.Visible = true;

            return;
        end;

        if LimitedBundles.Enabled == true then
            Controller:Focus(false, LimitedBundles);
        end;

        LimitedBundles.Enabled = false;
        u8.Visible = false;
    end;

    task.spawn(OnDataChanged);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 158
        -- upvalues: OnDataChanged (copy)
        OnDataChanged();
    end);

    for _, child in pairs(LimitedBundles.Bundles:GetChildren()) do
        if child:IsA("Frame") then
            for _, child2 in pairs(child:GetChildren()) do
                if child2:IsA("Frame") and child2.Name == "GoalEffects" then
                    local u16 = child2;

                    for _, child3 in pairs(child2:GetChildren()) do
                        if child3:IsA("ImageButton") then
                            child3.MouseButton1Down:Connect(function() -- Line: 168
                                -- upvalues: u16 (copy), child3 (copy), Controller3 (copy), ReplicatedStorage (ref), LocalPlayer (ref)
                                local Name = child3.Name;
                                Controller3:UpdateSubMenu(u16.Name);
                                task.spawn(function() -- Line: 48
                                    -- upvalues: ReplicatedStorage (ref), Name (copy), Controller3 (ref), LocalPlayer (ref)
                                    if ReplicatedStorage.Effects.GoalEffects.Client:FindFirstChild(Name) then
                                        require(ReplicatedStorage.Effects.GoalEffects.Client[Name])(Controller3, {
                                            Locker = true,
                                            Player = LocalPlayer,
                                            Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(Name),
                                            CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
                                        });

                                        return;
                                    end;

                                    require(ReplicatedStorage.Effects.GoalEffects.Client.EmitEffects)(Controller3, {
                                        Locker = true,
                                        Player = LocalPlayer,
                                        Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(Name),
                                        CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
                                    });
                                end);
                            end);
                        end;
                    end;
                end;
            end;
        end;
    end;

    u8.Button.MouseButton1Down:Connect(function() -- Line: 178
        -- upvalues: LimitedBundles (copy)
        LimitedBundles.Enabled = not LimitedBundles.Enabled;
    end);
    LimitedBundles.CloseButton.MouseButton1Down:Connect(function() -- Line: 182
        -- upvalues: LimitedBundles (copy)
        LimitedBundles.Enabled = false;
    end);
    LimitedBundles:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 186
        -- upvalues: HUD (copy), LimitedBundles (copy), Controller4 (copy), Controller3 (copy), ReplicatedStorage (ref), LocalPlayer (ref)
        HUD.Enabled = not LimitedBundles.Enabled;
        workspace.CurrentCamera.CameraType = LimitedBundles.Enabled and Enum.CameraType.Scriptable or Enum.CameraType.Custom;

        if LimitedBundles.Enabled then
            for _, child in pairs(LimitedBundles.Bundles:GetChildren()) do
                if child:IsA("Frame") then
                    for _, child2 in pairs(child:GetChildren()) do
                        if child2:IsA("Frame") and child2.Name == "Emotes" then
                            for _, child3 in pairs(child2:GetChildren()) do
                                if child3:IsA("ImageLabel") and Controller4.CharacterRig then
                                    Controller4:CreatePreview(child3.Name, child3.ViewportFrame, Controller4.CharacterRig);
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            for _, child in pairs(LimitedBundles.Bundles:GetChildren()) do
                if child:IsA("Frame") then
                    for _, child2 in pairs(child:GetChildren()) do
                        if child2:IsA("Frame") and child2.Name == "GoalEffects" then
                            local v17 = child2;

                            for _, child3 in pairs(child2:GetChildren()) do
                                if child3:IsA("ImageButton") then
                                    local Name = child3.Name;
                                    Controller3:UpdateSubMenu(v17.Name);
                                    task.spawn(function() -- Line: 48
                                        -- upvalues: ReplicatedStorage (ref), Name (copy), Controller3 (ref), LocalPlayer (ref)
                                        if ReplicatedStorage.Effects.GoalEffects.Client:FindFirstChild(Name) then
                                            require(ReplicatedStorage.Effects.GoalEffects.Client[Name])(Controller3, {
                                                Locker = true,
                                                Player = LocalPlayer,
                                                Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(Name),
                                                CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
                                            });

                                            return;
                                        end;

                                        require(ReplicatedStorage.Effects.GoalEffects.Client.EmitEffects)(Controller3, {
                                            Locker = true,
                                            Player = LocalPlayer,
                                            Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(Name),
                                            CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
                                        });
                                    end);

                                    return;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
end;

return v4;