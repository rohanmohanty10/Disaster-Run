 

 

local u1 = { 0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75 };
local u2 = { 0.55, 0.65, 0.7, 0.75, 0.8, 0.85, 0.875 };
local u3 = #u1;
local Vector2_new_ret = Vector2.new(-1, -1);
local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local v4 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil");
local UserFlag = v4.getUserFlag("UserPlayerScriptsCCLIntegrationD");
local UserFlag2 = v4.getUserFlag("UserAllowAbilityControlsBonus");
local UserFlag3 = v4.getUserFlag("UserDoubleJumpButtonFix");
local UserFlag4 = v4.getUserFlag("UserPlayerScriptsResetDTTouchOnCreate");
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ThumbstickAction = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("TransformerContext"):WaitForChild("ThumbstickAction");
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
local u5;

if UserFlag then
    u5 = AvatarAbilitiesInterface.get(Players.LocalPlayer);
else
    u5 = nil;
end;

local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
    LocalPlayer = Players.LocalPlayer;
end;

local ActionController = require(script.Parent:WaitForChild("ActionController"));
local u6 = setmetatable({}, ActionController);
u6.__index = u6;

function u6.new(p7) -- Line: 67
    -- upvalues: ActionController (copy), u6 (copy)
    local v8 = ActionController.new();
    local v9 = setmetatable(v8, u6);
    v9.data = p7;
    v9.enabled = false;
    v9.isTouchActive = false;
    v9.moveTouchFirstChanged = false;
    v9.moveTouchStartPosition = nil;
    v9.startImage = nil;
    v9.endImage = nil;
    v9.endImageStroke = nil;
    v9.endImageCenter = nil;
    v9.middleImages = {};
    v9.startImageFadeTween = nil;
    v9.endImageFadeTween = nil;
    v9.endImageCenterFadeTween = nil;
    v9.middleImageFadeTweens = {};
    v9.isFirstTouch = true;
    v9.thumbstickFrame = nil;
    v9.onRenderSteppedConn = nil;
    v9.fadeInAndOutBalance = 0.5;
    v9.fadeInAndOutHalfDuration = 0.3;
    v9.hasFadedBackgroundInPortrait = false;
    v9.hasFadedBackgroundInLandscape = false;
    v9.tweenInAlphaStart = nil;
    v9.tweenOutAlphaStart = nil;
    v9.newStyle = false;

    return v9;
end;

function u6.GetIsJumping(p10) -- Line: 109
    local isJumping = p10.isJumping;
    p10.isJumping = false;

    return isJumping;
end;

local function setupThumbstickInput(p11) -- Line: 115
    -- upvalues: ThumbstickAction (copy)
    for _, child in ThumbstickAction:GetChildren() do
        if child.Name == "DynamicTouchBinding" or child.Name == "ClassicTouchBinding" then
            child:Destroy();
        end;
    end;

    local InputBinding = Instance.new("InputBinding");
    InputBinding.Name = "DynamicTouchBinding";
    InputBinding.KeyCode = Enum.KeyCode.TouchPosition;
    InputBinding.UIModifier = p11.thumbstickButton;
    InputBinding.Parent = ThumbstickAction;
end;

local function enableThumbstickInput(p12: any, p13: boolean) -- Line: 128
    -- upvalues: setupThumbstickInput (copy), ThumbstickAction (copy)
    if not p13 then
        ThumbstickAction.Enabled = false;

        if p12.thumbstickStateChangedConn then
            p12.thumbstickStateChangedConn:Disconnect();
            p12.thumbstickStateChangedConn = nil;
        end;

        return;
    end;

    setupThumbstickInput(p12);
    p12.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect(p12.onStateChanged);
    ThumbstickAction.Enabled = true;
end;

function u6.Enable(u14: table, p15: boolean?, u16: any) -- Line: 142
    -- upvalues: ActionController (copy), UserFlag (copy), u5 (copy), UserFlag4 (copy), setupThumbstickInput (copy), ThumbstickAction (copy)
    if p15 == nil then
        return false;
    end;

    local v17 = p15 and true or false;

    if u14.enabled == v17 then
        return true;
    end;

    ActionController.Enable(u14, v17);

    if v17 then
        if not u14.thumbstickFrame then
            u14:Create(u16);

            if UserFlag and not u14.avatarAbilitiesEnabledChangedConn then
                u14.avatarAbilitiesEnabledChangedConn = u5:GetEnabledChangedSignal():Connect(function() -- Line: 153
                    -- upvalues: u14 (copy), u16 (copy), UserFlag4 (ref), setupThumbstickInput (ref), ThumbstickAction (ref)
                    if u14.enabled then
                        u14:Create(u16);

                        if UserFlag4 then
                            local v18 = u14;
                            setupThumbstickInput(v18);
                            v18.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect(v18.onStateChanged);
                            ThumbstickAction.Enabled = true;
                        else
                            u14.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect(u14.onStateChanged);
                            ThumbstickAction.Enabled = true;
                        end;

                        u14.thumbstickFrame.Visible = true;
                    end;
                end);
            end;
        end;

        if UserFlag4 then
            setupThumbstickInput(u14);
            u14.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect(u14.onStateChanged);
            ThumbstickAction.Enabled = true;
        else
            u14.thumbstickStateChangedConn = ThumbstickAction.StateChanged:Connect(u14.onStateChanged);
            ThumbstickAction.Enabled = true;
        end;
    else
        if UserFlag4 then
            ThumbstickAction.Enabled = false;

            if u14.thumbstickStateChangedConn then
                u14.thumbstickStateChangedConn:Disconnect();
                u14.thumbstickStateChangedConn = nil;
            end;
        else
            ThumbstickAction.Enabled = false;

            if u14.thumbstickStateChangedConn then
                u14.thumbstickStateChangedConn:Disconnect();
                u14.thumbstickStateChangedConn = nil;
            end;
        end;

        u14:OnInputEnded();
    end;

    u14.enabled = v17;
    u14.thumbstickFrame.Visible = v17;

    return nil;
end;

function u6.OnInputEnded(p19) -- Line: 194
    p19.isTouchActive = false;
    local DynamicThumbstickScriptableBinding = p19.data.actions.MoveAction:FindFirstChild("DynamicThumbstickScriptableBinding");

    if DynamicThumbstickScriptableBinding then
        DynamicThumbstickScriptableBinding:Fire(Vector2.zero);
    end;

    p19:FadeThumbstick(false);
end;

function u6.FadeThumbstick(p20: table, p21: boolean?) -- Line: 203
    -- upvalues: UserFlag (copy), TweenService (copy), TweenInfo_new_ret (copy), u2 (copy), u1 (copy)
    if not p21 and p20.isTouchActive then
        return;
    end;

    if p20.isFirstTouch then
        return;
    end;

    if p20.startImageFadeTween then
        p20.startImageFadeTween:Cancel();
    end;

    if p20.endImageFadeTween then
        p20.endImageFadeTween:Cancel();
    end;

    if UserFlag and p20.endImageCenterFadeTween then
        p20.endImageCenterFadeTween:Cancel();
    end;

    for i = 1, #p20.middleImages do
        local v22;

        if p20.middleImageFadeTweens[i] then
            p20.middleImageFadeTweens[i]:Cancel();
            v22 = i;
        else
            v22 = i;
        end;
    end;

    if p21 then
        if UserFlag and p20.newStyle then
            p20.startImageFadeTween = TweenService:Create(p20.startImage, TweenInfo_new_ret, {
                BackgroundTransparency = 0.4
            });
            p20.startImageFadeTween:Play();
            p20.endImageFadeTween = TweenService:Create(p20.endImageStroke, TweenInfo_new_ret, {
                Transparency = 0
            });
            p20.endImageFadeTween:Play();
            p20.endImageCenterFadeTween = TweenService:Create(p20.endImageCenter, TweenInfo_new_ret, {
                BackgroundTransparency = 0
            });
            p20.endImageCenterFadeTween:Play();
        else
            p20.startImageFadeTween = TweenService:Create(p20.startImage, TweenInfo_new_ret, {
                ImageTransparency = 0
            });
            p20.startImageFadeTween:Play();
            p20.endImageFadeTween = TweenService:Create(p20.endImage, TweenInfo_new_ret, {
                ImageTransparency = 0.2
            });
            p20.endImageFadeTween:Play();
        end;

        for i = 1, #p20.middleImages do
            if UserFlag and p20.newStyle then
                p20.middleImageFadeTweens[i] = TweenService:Create(p20.middleImages[i], TweenInfo_new_ret, {
                    BackgroundTransparency = u2[i]
                });
            else
                p20.middleImageFadeTweens[i] = TweenService:Create(p20.middleImages[i], TweenInfo_new_ret, {
                    ImageTransparency = u1[i]
                });
            end;

            p20.middleImageFadeTweens[i]:Play();
            local _ = i;
        end;

        return;
    end;

    if UserFlag and p20.newStyle then
        p20.startImageFadeTween = TweenService:Create(p20.startImage, TweenInfo_new_ret, {
            BackgroundTransparency = 1
        });
        p20.startImageFadeTween:Play();
        p20.endImageFadeTween = TweenService:Create(p20.endImageStroke, TweenInfo_new_ret, {
            Transparency = 1
        });
        p20.endImageFadeTween:Play();
        p20.endImageCenterFadeTween = TweenService:Create(p20.endImageCenter, TweenInfo_new_ret, {
            BackgroundTransparency = 1
        });
        p20.endImageCenterFadeTween:Play();
    else
        p20.startImageFadeTween = TweenService:Create(p20.startImage, TweenInfo_new_ret, {
            ImageTransparency = 1
        });
        p20.startImageFadeTween:Play();
        p20.endImageFadeTween = TweenService:Create(p20.endImage, TweenInfo_new_ret, {
            ImageTransparency = 1
        });
        p20.endImageFadeTween:Play();
    end;

    for i = 1, #p20.middleImages do
        if UserFlag and p20.newStyle then
            p20.middleImageFadeTweens[i] = TweenService:Create(p20.middleImages[i], TweenInfo_new_ret, {
                BackgroundTransparency = 1
            });
        else
            p20.middleImageFadeTweens[i] = TweenService:Create(p20.middleImages[i], TweenInfo_new_ret, {
                ImageTransparency = 1
            });
        end;

        p20.middleImageFadeTweens[i]:Play();
        local _ = i;
    end;
end;

function u6.FadeThumbstickFrame(p23: table, p24: number, p25: number) -- Line: 279
    p23.fadeInAndOutHalfDuration = p24 * 0.5;
    p23.fadeInAndOutBalance = p25;
    p23.tweenInAlphaStart = tick();
end;

function u6.DoFadeInBackground(p26) -- Line: 285
    -- upvalues: LocalPlayer (ref)
    local v27 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v28 = false;

    if v27 then
        if v27.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v27.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v28 = p26.hasFadedBackgroundInLandscape;
            p26.hasFadedBackgroundInLandscape = true;
        elseif v27.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v28 = p26.hasFadedBackgroundInPortrait;
            p26.hasFadedBackgroundInPortrait = true;
        end;
    end;

    if not v28 then
        p26.fadeInAndOutHalfDuration = 0.3;
        p26.fadeInAndOutBalance = 0.5;
        p26.tweenInAlphaStart = tick();
    end;
end;

function u6.DoMove(p29: table, p30) -- Line: 308
    local v31;

    if p30.Magnitude < p29.radiusOfDeadZone then
        v31 = Vector2.new();
    else
        v31 = p30.Unit * (1 - math.max(0, (p29.radiusOfMaxSpeed - p30.Magnitude) / p29.radiusOfMaxSpeed));
    end;

    local Vector2_new_ret2 = Vector2.new(v31.X, -v31.Y);
    local DynamicThumbstickScriptableBinding = p29.data.actions.MoveAction:FindFirstChild("DynamicThumbstickScriptableBinding");

    if DynamicThumbstickScriptableBinding then
        DynamicThumbstickScriptableBinding:Fire(Vector2_new_ret2);
    end;
end;

function u6.LayoutMiddleImages(p32: table, p33: vector, p34: vector) -- Line: 328
    -- upvalues: u3 (copy)
    local v35 = p32.thumbstickSize / 2 + p32.middleSize;
    local v36 = p34 - p33;
    local v37 = v36.Magnitude - p32.thumbstickRingSize / 2 - p32.middleSize;
    local Unit = v36.Unit;
    local middleSpacing = p32.middleSpacing;

    if p32.middleSpacing * u3 < v37 then
        middleSpacing = v37 / u3;
    end;

    for i = 1, u3 do
        local v38 = p32.middleImages[i];
        local v39 = v35 + middleSpacing * (i - 1);
        local v40;

        if v35 + middleSpacing * (i - 2) < v37 then
            local v41 = p34 - Unit * v39;
            local math_clamp_ret = math.clamp(1 - (v39 - v37) / middleSpacing, 0, 1);
            v38.Visible = true;
            v38.Position = UDim2.new(0, v41.X, 0, v41.Y);
            v38.Size = UDim2.new(0, p32.middleSize * math_clamp_ret, 0, p32.middleSize * math_clamp_ret);
            v40 = i;
        else
            v38.Visible = false;
            v40 = i;
        end;
    end;
end;

function u6.MoveStick(p42, p43) -- Line: 359
    local v44 = Vector2.new(p42.moveTouchStartPosition.X, p42.moveTouchStartPosition.Y) - p42.thumbstickFrame.AbsolutePosition;
    local v45 = Vector2.new(p43.X, p43.Y) - p42.thumbstickFrame.AbsolutePosition;
    p42.endImage.Position = UDim2.new(0, v45.X, 0, v45.Y);
    p42:LayoutMiddleImages(v44, v45);
end;

function u6.Create(u46: table, u47: userdata) -- Line: 367
    -- upvalues: UserFlag4 (copy), ThumbstickAction (copy), UserFlag (copy), u5 (copy), UserFlag3 (copy), u3 (copy), u2 (copy), u1 (copy), AvatarAbilitiesInterface (copy), UserFlag2 (copy), RunService (copy), Vector2_new_ret (copy), GuiService (copy), TweenService (copy), LocalPlayer (ref)
    if u46.thumbstickFrame then
        if UserFlag4 then
            ThumbstickAction.Enabled = false;

            if u46.thumbstickStateChangedConn then
                u46.thumbstickStateChangedConn:Disconnect();
                u46.thumbstickStateChangedConn = nil;
            end;
        else
            ThumbstickAction.Enabled = false;

            if u46.thumbstickStateChangedConn then
                u46.thumbstickStateChangedConn:Disconnect();
                u46.thumbstickStateChangedConn = nil;
            end;
        end;

        u46.thumbstickFrame:Destroy();
        u46.thumbstickFrame = nil;

        if u46.onRenderSteppedConn then
            u46.onRenderSteppedConn:Disconnect();
            u46.onRenderSteppedConn = nil;
        end;

        if u46.absoluteSizeChangedConn then
            u46.absoluteSizeChangedConn:Disconnect();
            u46.absoluteSizeChangedConn = nil;
        end;

        if not UserFlag and u46.avatarAbilitiesEnabledChangedConn then
            u46.avatarAbilitiesEnabledChangedConn:Disconnect();
            u46.avatarAbilitiesEnabledChangedConn = nil;
        end;

        if UserFlag then
            if u46.cameraChangedConn then
                u46.cameraChangedConn:Disconnect();
                u46.cameraChangedConn = nil;
            end;

            if u46.currentCameraChangedConn then
                u46.currentCameraChangedConn:Disconnect();
                u46.currentCameraChangedConn = nil;
            end;

            if u46.menuOpenedConnection then
                u46.menuOpenedConnection:Disconnect();
                u46.menuOpenedConnection = nil;
            end;

            if u46.playerGuiChangedConn then
                u46.playerGuiChangedConn:Disconnect();
                u46.playerGuiChangedConn = nil;
            end;
        end;
    end;

    local function layoutThumbstickFrame(p48: boolean) -- Line: 415
        -- upvalues: u46 (copy)
        if p48 then
            u46.thumbstickFrame.Size = UDim2.new(1, 100, 0.4, 100);
            u46.thumbstickFrame.Position = UDim2.new(0, -100, 0.6, 0);

            return;
        end;

        u46.thumbstickFrame.Size = UDim2.new(0.4, 100, 0.6666666666666666, 100);
        u46.thumbstickFrame.Position = UDim2.new(0, -100, 0.3333333333333333, 0);
    end;

    local v49 = UserFlag and u5:isEnabled();
    u46.newStyle = v49;
    u46.thumbstickFrame = Instance.new("Frame");
    u46.thumbstickFrame.BorderSizePixel = 0;
    u46.thumbstickFrame.Name = "DynamicThumbstickFrame";
    u46.thumbstickFrame.Visible = false;
    u46.thumbstickFrame.BackgroundTransparency = 1;
    u46.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    u46.thumbstickFrame.Active = false;
    u46.thumbstickFrame.Size = UDim2.new(0.4, 100, 0.6666666666666666, 100);
    u46.thumbstickFrame.Position = UDim2.new(0, -100, 0.3333333333333333, 0);
    u46.thumbstickButton = Instance.new("ImageButton");
    u46.thumbstickButton.Name = "DynamicThumbstickUIModifier";
    u46.thumbstickButton.BackgroundTransparency = 1;
    u46.thumbstickButton.ImageTransparency = 1;
    u46.thumbstickButton.AutoButtonColor = false;
    u46.thumbstickButton.Size = UDim2.new(1, 0, 1, 0);
    u46.thumbstickButton.ZIndex = u46.thumbstickFrame.ZIndex;
    u46.thumbstickButton.Visible = true;
    u46.thumbstickButton.Active = false;
    u46.thumbstickButton.Parent = u46.thumbstickFrame;

    if not UserFlag4 then
        local v50;

        if UserFlag3 then
            v50 = ThumbstickAction:FindFirstChild("DynamicTouchBinding");
        else
            v50 = nil;
        end;

        if not v50 then
            v50 = Instance.new("InputBinding");
            v50.Name = "DynamicTouchBinding";
            v50.KeyCode = Enum.KeyCode.TouchPosition;
            v50.Parent = ThumbstickAction;
        end;

        v50.UIModifier = u46.thumbstickButton;
    end;

    if UserFlag and u46.newStyle then
        u46.startImage = Instance.new("Frame");
        u46.startImage.Name = "ThumbstickStart";
        u46.startImage.BackgroundColor3 = Color3.fromRGB(18, 18, 21);
        u46.startImage.BackgroundTransparency = 0.4;
        u46.startImage.AnchorPoint = Vector2.new(0.5, 0.5);
        u46.startImage.ZIndex = 10;
        u46.startImage.Parent = u46.thumbstickFrame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0.5, 0);
        UICorner.Parent = u46.startImage;
        u46.endImage = Instance.new("Frame");
        u46.endImage.Name = "ThumbstickEnd";
        u46.endImage.BackgroundTransparency = 1;
        u46.endImage.AnchorPoint = Vector2.new(0.5, 0.5);
        u46.endImage.ZIndex = 10;
        u46.endImage.Parent = u46.thumbstickFrame;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = UDim.new(0.5, 0);
        UICorner2.Parent = u46.endImage;
        u46.endImageStroke = Instance.new("UIStroke");
        u46.endImageStroke.Thickness = UserFlag3 and 1.5 or 2;
        u46.endImageStroke.Color = Color3.fromRGB(213, 215, 221);
        u46.endImageStroke.Parent = u46.endImage;
        u46.endImageCenter = Instance.new("Frame");
        u46.endImageCenter.Name = "ThumbstickEndCenter";
        u46.endImageCenter.BackgroundTransparency = 0;
        u46.endImageCenter.BackgroundColor3 = Color3.fromRGB(213, 215, 221);
        u46.endImageCenter.AnchorPoint = Vector2.new(0.5, 0.5);
        u46.endImageCenter.Size = UDim2.new(0.74, 0, 0.74, 0);
        u46.endImageCenter.Position = UDim2.new(0.5, 0, 0.5, 0);
        u46.endImageCenter.ZIndex = 10;
        u46.endImageCenter.Parent = u46.endImage;
        local UICorner3 = Instance.new("UICorner");
        UICorner3.CornerRadius = UDim.new(0.5, 0);
        UICorner3.Parent = u46.endImageCenter;

        for i = 1, u3 do
            u46.middleImages[i] = Instance.new("Frame");
            u46.middleImages[i].Name = "ThumbstickMiddle";
            u46.middleImages[i].Visible = false;
            u46.middleImages[i].BackgroundTransparency = u2[i];
            u46.middleImages[i].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            u46.middleImages[i].AnchorPoint = Vector2.new(0.5, 0.5);
            u46.middleImages[i].ZIndex = 9;
            u46.middleImages[i].Parent = u46.thumbstickFrame;
            local UICorner4 = Instance.new("UICorner");
            UICorner4.CornerRadius = UDim.new(0.5, 0);
            UICorner4.Parent = u46.middleImages[i];
            local _ = i;
        end;
    else
        u46.startImage = Instance.new("ImageLabel");
        u46.startImage.Name = "ThumbstickStart";
        u46.startImage.Visible = true;
        u46.startImage.BackgroundTransparency = 1;
        u46.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u46.startImage.ImageRectOffset = Vector2.new(1, 1);
        u46.startImage.ImageRectSize = Vector2.new(144, 144);
        u46.startImage.ImageColor3 = Color3.new(0, 0, 0);
        u46.startImage.AnchorPoint = Vector2.new(0.5, 0.5);
        u46.startImage.ZIndex = 10;
        u46.startImage.Parent = u46.thumbstickFrame;
        u46.endImage = Instance.new("ImageLabel");
        u46.endImage.Name = "ThumbstickEnd";
        u46.endImage.Visible = true;
        u46.endImage.BackgroundTransparency = 1;
        u46.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u46.endImage.ImageRectOffset = Vector2.new(1, 1);
        u46.endImage.ImageRectSize = Vector2.new(144, 144);
        u46.endImage.AnchorPoint = Vector2.new(0.5, 0.5);
        u46.endImage.ZIndex = 10;
        u46.endImage.Parent = u46.thumbstickFrame;

        for i = 1, u3 do
            u46.middleImages[i] = Instance.new("ImageLabel");
            u46.middleImages[i].Name = "ThumbstickMiddle";
            u46.middleImages[i].Visible = false;
            u46.middleImages[i].BackgroundTransparency = 1;
            u46.middleImages[i].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
            u46.middleImages[i].ImageRectOffset = Vector2.new(1, 1);
            u46.middleImages[i].ImageRectSize = Vector2.new(144, 144);
            u46.middleImages[i].ImageTransparency = u1[i];
            u46.middleImages[i].AnchorPoint = Vector2.new(0.5, 0.5);
            u46.middleImages[i].ZIndex = 9;
            u46.middleImages[i].Parent = u46.thumbstickFrame;
            local _ = i;
        end;
    end;

    local function ResizeThumbstick() -- Line: 557
        -- upvalues: u47 (copy), UserFlag (ref), u46 (copy), AvatarAbilitiesInterface (ref), UserFlag2 (ref)
        local AbsoluteSize = u47.AbsoluteSize;
        local v51 = math.min(AbsoluteSize.X, AbsoluteSize.Y) > 500;
        local v52;

        if UserFlag then
            v52 = u46.newStyle;
        else
            v52 = AvatarAbilitiesInterface.isEnabled();
        end;

        local v53 = UserFlag2 and (v52 and v51) and 1.6216216216216217 or (v51 and 2 or 1);
        u46.thumbstickSize = 45 * v53;
        u46.thumbstickRingSize = 20 * v53;
        u46.middleSize = 10 * v53;
        u46.middleSpacing = 14 * v53;
        u46.radiusOfDeadZone = 2 * v53;
        u46.radiusOfMaxSpeed = 20 * v53;
        local v54 = 74 * v53;

        if not UserFlag or u46.isFirstTouch then
            if v52 then
                u46.startImage.Position = UDim2.new(0, v54 * 0.5 + 100 + (v51 and 100 or 64), 1, -v54 * 0.5 - 100 - (v51 and 112 or 64));
                u46.startImage.Size = UDim2.new(0, v54, 0, v54);
            else
                u46.startImage.Position = UDim2.new(0, u46.thumbstickRingSize * 3.3 + 100, 1, -u46.thumbstickRingSize * 2.8 - 100);
                u46.startImage.Size = UDim2.new(0, v54, 0, v54);
            end;
        end;

        u46.endImage.Position = u46.startImage.Position;

        if UserFlag and u46.newStyle then
            u46.endImage.Size = UDim2.new(0, u46.thumbstickSize * 0.6, 0, u46.thumbstickSize * 0.6);

            return;
        end;

        u46.endImage.Size = UDim2.new(0, u46.thumbstickSize * 0.8, 0, u46.thumbstickSize * 0.8);
    end;

    ResizeThumbstick();
    u46.absoluteSizeChangedConn = u47:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick);

    if not UserFlag then
        u46.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal():Connect(ResizeThumbstick);
    end;

    local function onCurrentCameraChanged() -- Line: 612
        -- upvalues: u46 (copy), layoutThumbstickFrame (copy)
        if u46.cameraChangedConn then
            u46.cameraChangedConn:Disconnect();
            u46.cameraChangedConn = nil;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            local function onViewportSizeChanged() -- Line: 619
                -- upvalues: workspace_CurrentCamera (copy), layoutThumbstickFrame (ref)
                local ViewportSize = workspace_CurrentCamera.ViewportSize;
                layoutThumbstickFrame(ViewportSize.X < ViewportSize.Y);
            end;

            u46.cameraChangedConn = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged);
            local ViewportSize = workspace_CurrentCamera.ViewportSize;
            layoutThumbstickFrame(ViewportSize.X < ViewportSize.Y);
        end;
    end;

    u46.currentCameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged);

    if workspace.CurrentCamera or UserFlag then
        onCurrentCameraChanged();
    end;

    u46.startImageFadeTween = nil;
    u46.endImageFadeTween = nil;
    u46.endImageCenterFadeTween = nil;
    u46.middleImageFadeTweens = {};

    if UserFlag4 and u46.isTouchActive then
        u46:OnInputEnded();
    end;

    u46.moveTouchStartPosition = nil;
    u46.onRenderSteppedConn = RunService.RenderStepped:Connect(function() -- Line: 643
        -- upvalues: u46 (copy)
        if u46.tweenInAlphaStart == nil then
            if u46.tweenOutAlphaStart ~= nil then
                local v55 = tick() - u46.tweenOutAlphaStart;
                local v56 = u46.fadeInAndOutHalfDuration * 2 - u46.fadeInAndOutHalfDuration * 2 * u46.fadeInAndOutBalance;
                u46.thumbstickFrame.BackgroundTransparency = math.min(v55 / v56, 1) * 0.35 + 0.65;

                if v56 < v55 then
                    u46.tweenOutAlphaStart = nil;
                end;
            end;
        else
            local v57 = tick() - u46.tweenInAlphaStart;
            local v58 = u46.fadeInAndOutHalfDuration * 2 * u46.fadeInAndOutBalance;
            u46.thumbstickFrame.BackgroundTransparency = 1 - math.min(v57 / v58, 1) * 0.35;

            if v58 < v57 then
                u46.tweenOutAlphaStart = tick();
                u46.tweenInAlphaStart = nil;
            end;
        end;
    end);

    function u46.onStateChanged(p59) -- Line: 662
        -- upvalues: Vector2_new_ret (ref), GuiService (ref), u46 (copy), TweenService (ref), UserFlag (ref)
        if p59 == Vector2_new_ret then
            if u46.isTouchActive then
                u46:OnInputEnded();
            end;
        else
            local Min = GuiService:GetInsetArea(Enum.ScreenInsets.None).Min;
            local Vector3_new_ret = Vector3.new(p59.X + Min.X, p59.Y + Min.Y, 0);

            if not u46.isTouchActive then
                u46.isTouchActive = true;

                if u46.isFirstTouch then
                    u46.isFirstTouch = false;
                    local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
                    TweenService:Create(u46.startImage, TweenInfo_new_ret2, {
                        Size = UDim2.new(0, 0, 0, 0)
                    }):Play();

                    if not (UserFlag and u46.newStyle) then
                        TweenService:Create(u46.endImage, TweenInfo_new_ret2, {
                            Size = UDim2.new(0, u46.thumbstickSize, 0, u46.thumbstickSize),
                            ImageColor3 = Color3.new(0, 0, 0)
                        }):Play();
                    end;
                end;

                u46.moveTouchStartPosition = Vector3_new_ret;
                u46.moveTouchFirstChanged = true;
                u46:DoFadeInBackground();

                return;
            end;

            if u46.moveTouchFirstChanged then
                u46.moveTouchFirstChanged = false;
                local Vector2_new_ret2 = Vector2.new(u46.moveTouchStartPosition.X - u46.thumbstickFrame.AbsolutePosition.X, u46.moveTouchStartPosition.Y - u46.thumbstickFrame.AbsolutePosition.Y);
                u46.startImage.Visible = true;
                u46.startImage.Position = UDim2.new(0, Vector2_new_ret2.X, 0, Vector2_new_ret2.Y);
                u46.endImage.Visible = true;
                u46.endImage.Position = u46.startImage.Position;
                u46:FadeThumbstick(true);
                u46:MoveStick(u46.moveTouchStartPosition);
            end;

            local Vector2_new_ret2 = Vector2.new(Vector3_new_ret.X - u46.moveTouchStartPosition.X, Vector3_new_ret.Y - u46.moveTouchStartPosition.Y);

            if Vector2_new_ret2.Magnitude > 0 then
                u46:DoMove(Vector2_new_ret2);
                u46:MoveStick(Vector3_new_ret);
            end;
        end;
    end;

    u46.menuOpenedConnection = GuiService.MenuOpened:Connect(function() -- Line: 723
        -- upvalues: u46 (copy)
        if u46.isTouchActive then
            u46:OnInputEnded();
        end;
    end);
    local u60 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    while not u60 do
        LocalPlayer.ChildAdded:wait();
        u60 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    end;

    local u61 = u60.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or u60.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight;

    local function longShowBackground() -- Line: 738
        -- upvalues: u46 (copy)
        u46.fadeInAndOutHalfDuration = 2.5;
        u46.fadeInAndOutBalance = 0.05;
        u46.tweenInAlphaStart = tick();
    end;

    u46.playerGuiChangedConn = u60:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function() -- Line: 744
        -- upvalues: u61 (copy), u60 (ref), u46 (copy)
        if not ((not u61 or u60.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait) and (u61 or u60.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait)) then
            u46.playerGuiChangedConn:Disconnect();
            u46.fadeInAndOutHalfDuration = 2.5;
            u46.fadeInAndOutBalance = 0.05;
            u46.tweenInAlphaStart = tick();

            if u61 then
                u46.hasFadedBackgroundInPortrait = true;

                return;
            end;

            u46.hasFadedBackgroundInLandscape = true;
        end;
    end);
    u46.thumbstickFrame.Parent = u47;

    if game:IsLoaded() then
        u46.fadeInAndOutHalfDuration = 2.5;
        u46.fadeInAndOutBalance = 0.05;
        u46.tweenInAlphaStart = tick();
    else
        coroutine.wrap(function() -- Line: 764
            -- upvalues: u46 (copy)
            game.Loaded:Wait();
            u46.fadeInAndOutHalfDuration = 2.5;
            u46.fadeInAndOutBalance = 0.05;
            u46.tweenInAlphaStart = tick();
        end)();
    end;
end;

return u6;