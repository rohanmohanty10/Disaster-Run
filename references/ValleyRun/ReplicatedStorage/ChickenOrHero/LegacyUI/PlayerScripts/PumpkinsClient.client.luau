 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local Presentation = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation");
local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local ValleyPanels = require(Presentation:WaitForChild("ValleyPanels"));
local PumpkinScreen = require(Presentation:WaitForChild("PumpkinScreen"));
local v1 = ValleyPanels.screen(LocalPlayer, "Pumpkins", 66);
local u2 = ValleyPanels.make("Frame", v1, "Shade", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Active = true,
    Visible = false,
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(14, 6, 22)
});
ValleyPanels.fullscreenShade(v1, u2);
local u3 = PumpkinScreen.new();
u3.frame.Visible = true;
u3.frame.Parent = u2;
ValleyPanels.cursorWhileVisible(u3.closeButton);
local u4 = ValleyPanels.make("ImageButton", nil, "Pumpkins", {
    BorderSizePixel = 0,
    Visible = false,
    AutoButtonColor = true,
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(1, 14, 0.5, 0),
    Size = UDim2.fromOffset(54, 54),
    BackgroundColor3 = Color3.new(1, 1, 1)
});
u4:SetAttribute("SelfManagedText", true);
ValleyPanels.make("UICorner", u4, "Corner", {
    CornerRadius = UDim.new(0.25, 0)
});
ValleyPanels.make("UIGradient", u4, "Fill", {
    Rotation = 90,
    Color = ColorSequence.new(Color3.fromRGB(255, 176, 70), Color3.fromRGB(226, 92, 8))
});
ValleyPanels.make("UIStroke", u4, "Ring", {
    Thickness = 2,
    Color = Color3.fromRGB(40, 8, 30)
});
ValleyPanels.make("ImageLabel", u4, "Icon", {
    BackgroundTransparency = 1,
    Image = "rbxassetid://122172980164834",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.45),
    Size = UDim2.fromScale(0.8, 0.8),
    ScaleType = Enum.ScaleType.Fit
});
local u5 = ValleyPanels.make("TextLabel", u4, "Count", {
    TextScaled = true,
    Text = "0",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, 6, 0, -6),
    Size = UDim2.fromOffset(26, 20),
    BackgroundColor3 = Color3.fromRGB(176, 98, 255),
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.GothamBold
});
ValleyPanels.make("UICorner", u5, "Corner", {
    CornerRadius = UDim.new(0.5, 0)
});
local u6 = ValleyPanels.make("UIScale", u4, "Bob");
task.spawn(function() -- Line: 68
    -- upvalues: LocalPlayer (copy), u4 (copy)
    local Wallet = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ValleyHUD"):WaitForChild("Wallet");

    local function fit() -- Line: 71
        -- upvalues: Wallet (copy), u4 (ref)
        local math_min_ret = math.min(54, Wallet.Size.Y.Offset);
        u4.Size = UDim2.fromOffset(math_min_ret, math_min_ret);
    end;

    Wallet:GetPropertyChangedSignal("Size"):Connect(fit);
    local math_min_ret = math.min(54, Wallet.Size.Y.Offset);
    u4.Size = UDim2.fromOffset(math_min_ret, math_min_ret);
    u4.Parent = Wallet;
end);
local u7 = false;
local u8 = true;
local u9 = false;
local u10 = 0;

local function setOpen(p11) -- Line: 81
    -- upvalues: u7 (ref), u8 (ref), HudNavigation (copy), u2 (copy), u9 (ref), LocalPlayer (copy), u3 (copy)
    if p11 == u7 or p11 and not u8 then
        return;
    end;

    if p11 then
        HudNavigation.opening("Pumpkins");
    end;

    u7 = p11;
    local v12;

    if p11 then
        v12 = not u9;
    else
        v12 = p11;
    end;

    u2.Visible = v12;
    LocalPlayer:SetAttribute("PumpkinsOpen", p11 or nil);

    if p11 then
        u3:opened();

        return;
    end;

    u3:closed();
end;

local function layout() -- Line: 97
    -- upvalues: u4 (copy), u10 (ref), LocalPlayer (copy), u7 (ref), u5 (copy)
    local v13;

    if u10 > 0 and LocalPlayer:GetAttribute("InMatch") ~= true then
        v13 = not u7;
    else
        v13 = false;
    end;

    u4.Visible = v13;
    u5.Text = u10 > 99 and "99+" or tostring(u10);
end;

LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(layout);
u4.Activated:Connect(function() -- Line: 103
    -- upvalues: u3 (copy), PumpkinScreen (copy), HudNavigation (copy)
    if u3:available() then
        HudNavigation.activate("Pumpkins");

        return;
    end;

    PumpkinScreen.notice(PumpkinScreen.UNAVAILABLE);
end);
u3.closeButton.Activated:Connect(function() -- Line: 110
    -- upvalues: u7 (ref), u2 (copy), LocalPlayer (copy), u3 (copy), u4 (copy), u10 (ref), u5 (copy)
    if u7 ~= false then
        u7 = false;
        u2.Visible = false;
        LocalPlayer:SetAttribute("PumpkinsOpen", nil);
        u3:closed();
    end;

    local v14;

    if u10 > 0 and LocalPlayer:GetAttribute("InMatch") ~= true then
        v14 = not u7;
    else
        v14 = false;
    end;

    u4.Visible = v14;
    u5.Text = u10 > 99 and "99+" or tostring(u10);
end);
HudNavigation.register("Pumpkins", function() -- Line: 114
    -- upvalues: setOpen (copy), u7 (ref), u4 (copy), u10 (ref), LocalPlayer (copy), u5 (copy)
    setOpen(not u7);
    local v15;

    if u10 > 0 and LocalPlayer:GetAttribute("InMatch") ~= true then
        v15 = not u7;
    else
        v15 = false;
    end;

    u4.Visible = v15;
    u5.Text = u10 > 99 and "99+" or tostring(u10);
end);
HudNavigation.Opening.Event:Connect(function(p16) -- Line: 118
    -- upvalues: u7 (ref), u2 (copy), LocalPlayer (copy), u3 (copy), u4 (copy), u10 (ref), u5 (copy)
    if p16 ~= "Pumpkins" then
        if u7 ~= false then
            u7 = false;
            u2.Visible = false;
            LocalPlayer:SetAttribute("PumpkinsOpen", nil);
            u3:closed();
        end;

        local v17;

        if u10 > 0 and LocalPlayer:GetAttribute("InMatch") ~= true then
            v17 = not u7;
        else
            v17 = false;
        end;

        u4.Visible = v17;
        u5.Text = u10 > 99 and "99+" or tostring(u10);
    end;
end);
UserInputService.InputBegan:Connect(function(p18) -- Line: 124
    -- upvalues: u7 (ref), u9 (ref), u2 (copy), LocalPlayer (copy), u3 (copy), u4 (copy), u10 (ref), u5 (copy)
    if u7 and (p18.KeyCode == Enum.KeyCode.Escape and not u9) then
        if u7 ~= false then
            u7 = false;
            u2.Visible = false;
            LocalPlayer:SetAttribute("PumpkinsOpen", nil);
            u3:closed();
        end;

        local v19;

        if u10 > 0 and LocalPlayer:GetAttribute("InMatch") ~= true then
            v19 = not u7;
        else
            v19 = false;
        end;

        u4.Visible = v19;
        u5.Text = u10 > 99 and "99+" or tostring(u10);
    end;
end);
u3:start({
    open = function() -- Line: 131, Name: open
        -- upvalues: u7 (ref), u8 (ref), HudNavigation (copy), u2 (copy), u9 (ref), LocalPlayer (copy), u3 (copy), u4 (copy), u10 (ref), u5 (copy)
        if u7 ~= true and u8 then
            HudNavigation.opening("Pumpkins");
            u7 = true;
            u2.Visible = not u9;
            LocalPlayer:SetAttribute("PumpkinsOpen", true);
            u3:opened();
        end;

        local v20;

        if u10 > 0 and LocalPlayer:GetAttribute("InMatch") ~= true then
            v20 = not u7;
        else
            v20 = false;
        end;

        u4.Visible = v20;
        u5.Text = u10 > 99 and "99+" or tostring(u10);
    end,

    close = function() -- Line: 135, Name: close
        -- upvalues: u7 (ref), u2 (copy), LocalPlayer (copy), u3 (copy), u4 (copy), u10 (ref), u5 (copy)
        if u7 ~= false then
            u7 = false;
            u2.Visible = false;
            LocalPlayer:SetAttribute("PumpkinsOpen", nil);
            u3:closed();
        end;

        local v21;

        if u10 > 0 and LocalPlayer:GetAttribute("InMatch") ~= true then
            v21 = not u7;
        else
            v21 = false;
        end;

        u4.Visible = v21;
        u5.Text = u10 > 99 and "99+" or tostring(u10);
    end,

    isOpen = function() -- Line: 139, Name: isOpen
        -- upvalues: u7 (ref)
        return u7;
    end,

    setAvailable = function(p22) -- Line: 142, Name: setAvailable
        -- upvalues: u8 (ref), HudNavigation (copy)
        u8 = p22;
        HudNavigation.setAvailable("Pumpkins", p22);
    end,

    setHidden = function(p23, p24) -- Line: 147, Name: setHidden
        -- upvalues: u9 (ref), TweenService (copy), u2 (copy), u7 (ref)
        u9 = p23;
        local TweenInfo_new_ret = TweenInfo.new(p24 or 0);
        local v25 = {};
        v25.BackgroundTransparency = 1;
        local v26 = TweenService:Create(u2, TweenInfo_new_ret, v25);

        if p23 then
            v26.Completed:Once(function(p27) -- Line: 151
                -- upvalues: u9 (ref), u2 (ref)
                if p27 == Enum.PlaybackState.Completed and u9 then
                    u2.Visible = false;
                end;
            end);
        else
            u2.Visible = u7;
        end;

        v26:Play();
    end,

    setCount = function(p28) -- Line: 161, Name: setCount
        -- upvalues: u10 (ref), u4 (copy), LocalPlayer (copy), u7 (ref), u5 (copy), u6 (copy), TweenService (copy)
        local v29 = u10 < p28;
        u10 = p28;
        local v30;

        if u10 > 0 and LocalPlayer:GetAttribute("InMatch") ~= true then
            v30 = not u7;
        else
            v30 = false;
        end;

        u4.Visible = v30;
        u5.Text = u10 > 99 and "99+" or tostring(u10);

        if v29 and u4.Visible then
            u6.Scale = 1.3;
            TweenService:Create(u6, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end;
    end
});