  

 

local Value = Enum.ContextActionPriority.High.Value;
local u1 = { 0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75 };
local u2 = #u1;
local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
    LocalPlayer = Players.LocalPlayer;
end;

local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u4 = setmetatable({}, BaseCharacterController);
u4.__index = u4;

function u4.new() -- Line: 44
    -- upvalues: BaseCharacterController (copy), u4 (copy)
    local v5 = BaseCharacterController.new();
    local v6 = setmetatable(v5, u4);
    v6.moveTouchObject = nil;
    v6.moveTouchLockedIn = false;
    v6.moveTouchFirstChanged = false;
    v6.moveTouchStartPosition = nil;
    v6.startImage = nil;
    v6.endImage = nil;
    v6.middleImages = {};
    v6.startImageFadeTween = nil;
    v6.endImageFadeTween = nil;
    v6.middleImageFadeTweens = {};
    v6.isFirstTouch = true;
    v6.thumbstickFrame = nil;
    v6.onRenderSteppedConn = nil;
    v6.fadeInAndOutBalance = 0.5;
    v6.fadeInAndOutHalfDuration = 0.3;
    v6.hasFadedBackgroundInPortrait = false;
    v6.hasFadedBackgroundInLandscape = false;
    v6.tweenInAlphaStart = nil;
    v6.tweenOutAlphaStart = nil;

    return v6;
end;

function u4.GetIsJumping(p7) -- Line: 79
    local isJumping = p7.isJumping;
    p7.isJumping = false;

    return isJumping;
end;

function u4.Enable(p8, p9, p10) -- Line: 85
    -- upvalues: ContextActionService (copy)
    if p9 == nil then
        return false;
    end;

    local v11 = p9 and true or false;

    if p8.enabled == v11 then
        return true;
    end;

    if v11 then
        if not p8.thumbstickFrame then
            p8:Create(p10);
        end;

        p8:BindContextActions();
    else
        ContextActionService:UnbindAction("DynamicThumbstickAction");
        p8:OnInputEnded();
    end;

    p8.enabled = v11;
    p8.thumbstickFrame.Visible = v11;
end;

function u4.OnInputEnded(p12) -- Line: 108
    p12.moveTouchObject = nil;
    p12.moveVector = Vector3.new(0, 0, 0);
    p12:FadeThumbstick(false);
end;

function u4.FadeThumbstick(p13, p14) -- Line: 114
    -- upvalues: TweenService (copy), u3 (copy), u1 (copy)
    if not p14 and p13.moveTouchObject then
        return;
    end;

    if p13.isFirstTouch then
        return;
    end;

    if p13.startImageFadeTween then
        p13.startImageFadeTween:Cancel();
    end;

    if p13.endImageFadeTween then
        p13.endImageFadeTween:Cancel();
    end;

    for i = 1, #p13.middleImages do
        if p13.middleImageFadeTweens[i] then
            p13.middleImageFadeTweens[i]:Cancel();
        end;
    end;

    if p14 then
        p13.startImageFadeTween = TweenService:Create(p13.startImage, u3, {
            ImageTransparency = 0
        });
        p13.startImageFadeTween:Play();
        p13.endImageFadeTween = TweenService:Create(p13.endImage, u3, {
            ImageTransparency = 0.2
        });
        p13.endImageFadeTween:Play();

        for i = 1, #p13.middleImages do
            p13.middleImageFadeTweens[i] = TweenService:Create(p13.middleImages[i], u3, {
                ImageTransparency = u1[i]
            });
            p13.middleImageFadeTweens[i]:Play();
        end;

        return;
    end;

    p13.startImageFadeTween = TweenService:Create(p13.startImage, u3, {
        ImageTransparency = 1
    });
    p13.startImageFadeTween:Play();
    p13.endImageFadeTween = TweenService:Create(p13.endImage, u3, {
        ImageTransparency = 1
    });
    p13.endImageFadeTween:Play();

    for i = 1, #p13.middleImages do
        p13.middleImageFadeTweens[i] = TweenService:Create(p13.middleImages[i], u3, {
            ImageTransparency = 1
        });
        p13.middleImageFadeTweens[i]:Play();
    end;
end;

function u4.FadeThumbstickFrame(p15, p16, p17) -- Line: 157
    p15.fadeInAndOutHalfDuration = p16 * 0.5;
    p15.fadeInAndOutBalance = p17;
    p15.tweenInAlphaStart = tick();
end;

function u4.InputInFrame(p18, p19) -- Line: 163
    local AbsolutePosition = p18.thumbstickFrame.AbsolutePosition;
    local v20 = AbsolutePosition + p18.thumbstickFrame.AbsoluteSize;
    local Position = p19.Position;

    return Position.X >= AbsolutePosition.X and (Position.Y >= AbsolutePosition.Y and (Position.X <= v20.X and Position.Y <= v20.Y));
end;

function u4.DoFadeInBackground(p21) -- Line: 175
    -- upvalues: LocalPlayer (ref)
    local v22 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v23 = false;

    if v22 then
        if v22.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v22.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v23 = p21.hasFadedBackgroundInLandscape;
            p21.hasFadedBackgroundInLandscape = true;
        elseif v22.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v23 = p21.hasFadedBackgroundInPortrait;
            p21.hasFadedBackgroundInPortrait = true;
        end;
    end;

    if not v23 then
        p21.fadeInAndOutHalfDuration = 0.3;
        p21.fadeInAndOutBalance = 0.5;
        p21.tweenInAlphaStart = tick();
    end;
end;

function u4.DoMove(p24, p25) -- Line: 198
    local v26;

    if p25.magnitude < p24.radiusOfDeadZone then
        v26 = Vector3.new(0, 0, 0);
    else
        local v27 = p25.unit * (1 - math.max(0, (p24.radiusOfMaxSpeed - p25.magnitude) / p24.radiusOfMaxSpeed));
        v26 = Vector3.new(v27.x, 0, v27.y);
    end;

    p24.moveVector = v26;
end;

function u4.LayoutMiddleImages(p28, p29, p30) -- Line: 216
    -- upvalues: u2 (copy)
    local v31 = p28.thumbstickSize / 2 + p28.middleSize;
    local v32 = p30 - p29;
    local v33 = v32.magnitude - p28.thumbstickRingSize / 2 - p28.middleSize;
    local unit = v32.unit;
    local middleSpacing = p28.middleSpacing;

    if p28.middleSpacing * u2 < v33 then
        middleSpacing = v33 / u2;
    end;

    for i = 1, u2 do
        local v34 = p28.middleImages[i];
        local v35 = v31 + middleSpacing * (i - 1);

        if v31 + middleSpacing * (i - 2) < v33 then
            local v36 = p30 - unit * v35;
            local v37 = math.clamp(1 - (v35 - v33) / middleSpacing, 0, 1);
            v34.Visible = true;
            v34.Position = UDim2.new(0, v36.X, 0, v36.Y);
            v34.Size = UDim2.new(0, p28.middleSize * v37, 0, p28.middleSize * v37);
        else
            v34.Visible = false;
        end;
    end;
end;

function u4.MoveStick(p38, p39) -- Line: 247
    local v40 = Vector2.new(p38.moveTouchStartPosition.X, p38.moveTouchStartPosition.Y) - p38.thumbstickFrame.AbsolutePosition;
    local v41 = Vector2.new(p39.X, p39.Y) - p38.thumbstickFrame.AbsolutePosition;
    p38.endImage.Position = UDim2.new(0, v41.X, 0, v41.Y);
    p38:LayoutMiddleImages(v40, v41);
end;

function u4.BindContextActions(u42) -- Line: 255
    -- upvalues: TweenService (copy), ContextActionService (copy), Value (copy)
    local function inputBegan(p43) -- Line: 256
        -- upvalues: u42 (copy), TweenService (ref)
        if u42.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;

        if not u42:InputInFrame(p43) then
            return Enum.ContextActionResult.Pass;
        end;

        if u42.isFirstTouch then
            u42.isFirstTouch = false;
            local v44 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
            TweenService:Create(u42.startImage, v44, {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play();
            TweenService:Create(u42.endImage, v44, {
                Size = UDim2.new(0, u42.thumbstickSize, 0, u42.thumbstickSize),
                ImageColor3 = Color3.new(0, 0, 0)
            }):Play();
        end;

        u42.moveTouchLockedIn = false;
        u42.moveTouchObject = p43;
        u42.moveTouchStartPosition = p43.Position;
        u42.moveTouchFirstChanged = true;
        u42:DoFadeInBackground();

        return Enum.ContextActionResult.Pass;
    end;

    local function inputChanged(p45) -- Line: 288
        -- upvalues: u42 (copy)
        if p45 ~= u42.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;

        if u42.moveTouchFirstChanged then
            u42.moveTouchFirstChanged = false;
            local v46 = Vector2.new(p45.Position.X - u42.thumbstickFrame.AbsolutePosition.X, p45.Position.Y - u42.thumbstickFrame.AbsolutePosition.Y);
            u42.startImage.Visible = true;
            u42.startImage.Position = UDim2.new(0, v46.X, 0, v46.Y);
            u42.endImage.Visible = true;
            u42.endImage.Position = u42.startImage.Position;
            u42:FadeThumbstick(true);
            u42:MoveStick(p45.Position);
        end;

        u42.moveTouchLockedIn = true;
        local v47 = Vector2.new(p45.Position.x - u42.moveTouchStartPosition.x, p45.Position.y - u42.moveTouchStartPosition.y);

        if math.abs(v47.x) > 0 or math.abs(v47.y) > 0 then
            u42:DoMove(v47);
            u42:MoveStick(p45.Position);
        end;

        return Enum.ContextActionResult.Sink;
    end;

    local function inputEnded(p48) -- Line: 321
        -- upvalues: u42 (copy)
        if p48 == u42.moveTouchObject then
            u42:OnInputEnded();

            if u42.moveTouchLockedIn then
                return Enum.ContextActionResult.Sink;
            end;
        end;

        return Enum.ContextActionResult.Pass;
    end;

    ContextActionService:BindActionAtPriority("DynamicThumbstickAction", function(p49, p50, p51) -- Line: 331, Name: handleInput
        -- upvalues: inputBegan (copy), inputChanged (copy), u42 (copy)
        if p50 == Enum.UserInputState.Begin then
            return inputBegan(p51);
        end;

        if p50 == Enum.UserInputState.Change then
            return inputChanged(p51);
        end;

        if p50 == Enum.UserInputState.End then
            if p51 == u42.moveTouchObject then
                u42:OnInputEnded();

                if u42.moveTouchLockedIn then
                    return Enum.ContextActionResult.Sink;
                end;
            end;

            return Enum.ContextActionResult.Pass;
        end;

        if p50 == Enum.UserInputState.Cancel then
            u42:OnInputEnded();
        end;
    end, false, Value, Enum.UserInputType.Touch);
end;

function u4.Create(u52, p53) -- Line: 351
    -- upvalues: u2 (copy), u1 (copy), RunService (copy), UserInputService (copy), GuiService (copy), LocalPlayer (ref)
    if u52.thumbstickFrame then
        u52.thumbstickFrame:Destroy();
        u52.thumbstickFrame = nil;

        if u52.onRenderSteppedConn then
            u52.onRenderSteppedConn:Disconnect();
            u52.onRenderSteppedConn = nil;
        end;
    end;

    u52.thumbstickSize = 45;
    u52.thumbstickRingSize = 20;
    u52.middleSize = 10;
    u52.middleSpacing = u52.middleSize + 4;
    u52.radiusOfDeadZone = 2;
    u52.radiusOfMaxSpeed = 20;
    local AbsoluteSize = p53.AbsoluteSize;

    if math.min(AbsoluteSize.x, AbsoluteSize.y) > 500 then
        u52.thumbstickSize = u52.thumbstickSize * 2;
        u52.thumbstickRingSize = u52.thumbstickRingSize * 2;
        u52.middleSize = u52.middleSize * 2;
        u52.middleSpacing = u52.middleSpacing * 2;
        u52.radiusOfDeadZone = u52.radiusOfDeadZone * 2;
        u52.radiusOfMaxSpeed = u52.radiusOfMaxSpeed * 2;
    end;

    u52.thumbstickFrame = Instance.new("Frame");
    u52.thumbstickFrame.BorderSizePixel = 0;
    u52.thumbstickFrame.Name = "DynamicThumbstickFrame";
    u52.thumbstickFrame.Visible = false;
    u52.thumbstickFrame.BackgroundTransparency = 1;
    u52.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    u52.thumbstickFrame.Active = false;
    u52.thumbstickFrame.Size = UDim2.new(0.4, 0, 0.6666666666666666, 0);
    u52.thumbstickFrame.Position = UDim2.new(0, 0, 0.3333333333333333, 0);
    u52.startImage = Instance.new("ImageLabel");
    u52.startImage.Name = "ThumbstickStart";
    u52.startImage.Visible = true;
    u52.startImage.BackgroundTransparency = 1;
    u52.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u52.startImage.ImageRectOffset = Vector2.new(1, 1);
    u52.startImage.ImageRectSize = Vector2.new(144, 144);
    u52.startImage.ImageColor3 = Color3.new(0, 0, 0);
    u52.startImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u52.startImage.Position = UDim2.new(0, u52.thumbstickRingSize * 3.3, 1, -u52.thumbstickRingSize * 2.8);
    u52.startImage.Size = UDim2.new(0, u52.thumbstickRingSize * 3.7, 0, u52.thumbstickRingSize * 3.7);
    u52.startImage.ZIndex = 10;
    u52.startImage.Parent = u52.thumbstickFrame;
    u52.endImage = Instance.new("ImageLabel");
    u52.endImage.Name = "ThumbstickEnd";
    u52.endImage.Visible = true;
    u52.endImage.BackgroundTransparency = 1;
    u52.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u52.endImage.ImageRectOffset = Vector2.new(1, 1);
    u52.endImage.ImageRectSize = Vector2.new(144, 144);
    u52.endImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u52.endImage.Position = u52.startImage.Position;
    u52.endImage.Size = UDim2.new(0, u52.thumbstickSize * 0.8, 0, u52.thumbstickSize * 0.8);
    u52.endImage.ZIndex = 10;
    u52.endImage.Parent = u52.thumbstickFrame;

    local function layoutThumbstickFrame(p54) -- Line: 379
        -- upvalues: u52 (copy)
        if p54 then
            u52.thumbstickFrame.Size = UDim2.new(1, 0, 0.4, 0);
            u52.thumbstickFrame.Position = UDim2.new(0, 0, 0.6, 0);

            return;
        end;

        u52.thumbstickFrame.Size = UDim2.new(0.4, 0, 0.6666666666666666, 0);
        u52.thumbstickFrame.Position = UDim2.new(0, 0, 0.3333333333333333, 0);
    end;

    for i = 1, u2 do
        u52.middleImages[i] = Instance.new("ImageLabel");
        u52.middleImages[i].Name = "ThumbstickMiddle";
        u52.middleImages[i].Visible = false;
        u52.middleImages[i].BackgroundTransparency = 1;
        u52.middleImages[i].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u52.middleImages[i].ImageRectOffset = Vector2.new(1, 1);
        u52.middleImages[i].ImageRectSize = Vector2.new(144, 144);
        u52.middleImages[i].ImageTransparency = u1[i];
        u52.middleImages[i].AnchorPoint = Vector2.new(0.5, 0.5);
        u52.middleImages[i].ZIndex = 9;
        u52.middleImages[i].Parent = u52.thumbstickFrame;
    end;

    local u55 = nil;

    local function onCurrentCameraChanged() -- Line: 440
        -- upvalues: u55 (ref), layoutThumbstickFrame (copy)
        if u55 then
            u55:Disconnect();
            u55 = nil;
        end;

        local CurrentCamera = workspace.CurrentCamera;

        if CurrentCamera then
            local function onViewportSizeChanged() -- Line: 447
                -- upvalues: CurrentCamera (copy), layoutThumbstickFrame (ref)
                local ViewportSize = CurrentCamera.ViewportSize;
                layoutThumbstickFrame(ViewportSize.X < ViewportSize.Y);
            end;

            u55 = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged);
            local ViewportSize = CurrentCamera.ViewportSize;
            layoutThumbstickFrame(ViewportSize.X < ViewportSize.Y);
        end;
    end;

    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged);

    if workspace.CurrentCamera then
        onCurrentCameraChanged();
    end;

    u52.moveTouchStartPosition = nil;
    u52.startImageFadeTween = nil;
    u52.endImageFadeTween = nil;
    u52.middleImageFadeTweens = {};
    u52.onRenderSteppedConn = RunService.RenderStepped:Connect(function() -- Line: 467
        -- upvalues: u52 (copy)
        if u52.tweenInAlphaStart == nil then
            if u52.tweenOutAlphaStart ~= nil then
                local v56 = tick() - u52.tweenOutAlphaStart;
                local v57 = u52.fadeInAndOutHalfDuration * 2 - u52.fadeInAndOutHalfDuration * 2 * u52.fadeInAndOutBalance;
                u52.thumbstickFrame.BackgroundTransparency = math.min(v56 / v57, 1) * 0.35 + 0.65;

                if v57 < v56 then
                    u52.tweenOutAlphaStart = nil;
                end;
            end;
        else
            local v58 = tick() - u52.tweenInAlphaStart;
            local v59 = u52.fadeInAndOutHalfDuration * 2 * u52.fadeInAndOutBalance;
            u52.thumbstickFrame.BackgroundTransparency = 1 - math.min(v58 / v59, 1) * 0.35;

            if v59 < v58 then
                u52.tweenOutAlphaStart = tick();
                u52.tweenInAlphaStart = nil;
            end;
        end;
    end);
    u52.onTouchEndedConn = UserInputService.TouchEnded:connect(function(p60) -- Line: 486
        -- upvalues: u52 (copy)
        if p60 == u52.moveTouchObject then
            u52:OnInputEnded();
        end;
    end);
    GuiService.MenuOpened:connect(function() -- Line: 492
        -- upvalues: u52 (copy)
        if u52.moveTouchObject then
            u52:OnInputEnded();
        end;
    end);
    local u61 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    while not u61 do
        LocalPlayer.ChildAdded:wait();
        u61 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    end;

    local u62 = nil;
    local u63 = u61.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or u61.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight;

    local function longShowBackground() -- Line: 508
        -- upvalues: u52 (copy)
        u52.fadeInAndOutHalfDuration = 2.5;
        u52.fadeInAndOutBalance = 0.05;
        u52.tweenInAlphaStart = tick();
    end;

    u62 = u61:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function() -- Line: 514
        -- upvalues: u63 (copy), u61 (ref), u62 (ref), u52 (copy)
        if u63 and u61.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait or not u63 and u61.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
            u62:disconnect();
            u52.fadeInAndOutHalfDuration = 2.5;
            u52.fadeInAndOutBalance = 0.05;
            u52.tweenInAlphaStart = tick();

            if u63 then
                u52.hasFadedBackgroundInPortrait = true;

                return;
            end;

            u52.hasFadedBackgroundInLandscape = true;
        end;
    end);
    u52.thumbstickFrame.Parent = p53;

    if game:IsLoaded() then
        u52.fadeInAndOutHalfDuration = 2.5;
        u52.fadeInAndOutBalance = 0.05;
        u52.tweenInAlphaStart = tick();
    else
        coroutine.wrap(function() -- Line: 534
            -- upvalues: u52 (copy)
            game.Loaded:Wait();
            u52.fadeInAndOutHalfDuration = 2.5;
            u52.fadeInAndOutBalance = 0.05;
            u52.tweenInAlphaStart = tick();
        end)();
    end;
end;

return u4;