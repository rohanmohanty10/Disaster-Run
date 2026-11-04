 

 

local Players = game:GetService("Players");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local GiftConfig = require(Weapons:WaitForChild("GiftConfig"));
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = FFlags.GiftingEnabled == true;
u1.UNAVAILABLE = "This feature is currently not available.";
u1.ICON = "rbxassetid://115583741443536";
local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret2 = Color3.fromRGB(230, 161, 0);
local GiftEvent = Weapons:WaitForChild("GiftEvent", 15);
local BindableEvent = Instance.new("BindableEvent");
u1.changed = BindableEvent.Event;
local u3 = nil;
local u4 = setmetatable({}, {
    __mode = "k"
});
local u5 = nil;

local function getScreen() -- Line: 37
    -- upvalues: u5 (ref), ChickenOrHero (copy), GiftEvent (copy)
    if not u5 then
        u5 = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("GiftScreen")).new(GiftEvent);
    end;

    return u5;
end;

if GiftEvent then
    GiftEvent.OnClientEvent:Connect(function(p6, ...) -- Line: 45
        -- upvalues: u3 (ref), BindableEvent (copy), u5 (ref), ChickenOrHero (copy), GiftEvent (copy)
        if p6 == "Status" then
            local v7 = ...;
            local v8;

            if type(v7) == "table" then
                v8 = v7.canGift == true;
            else
                v8 = false;
            end;

            if v8 ~= u3 then
                u3 = v8;
                BindableEvent:Fire();
            end;
        elseif u5 or (p6 == "Opened" or p6 == "Delivered") then
            if not u5 then
                u5 = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("GiftScreen")).new(GiftEvent);
            end;

            u5:receive(p6, ...);
        end;
    end);
    task.spawn(function() -- Line: 57
        -- upvalues: u2 (copy), GiftEvent (copy), u3 (ref)
        if not u2 then
            return;
        end;

        for i = 1, 5 do
            GiftEvent:FireServer("Status");
            task.wait(8);

            if u3 ~= nil then
                return;
            end;

            local _ = i;
        end;
    end);
end;

local function keyOf(p9) -- Line: 71
    local key = p9.key;

    if type(key) == "function" then
        key = key();
    end;

    return key;
end;

function u1.giftable(p10) -- Line: 79
    -- upvalues: u2 (copy), u3 (ref), GiftConfig (copy)
    local v11 = u2;

    if v11 then
        if u3 == true and type(p10) == "string" then
            v11 = GiftConfig.offer(p10) ~= nil;
        else
            v11 = false;
        end;
    end;

    return v11;
end;

function u1.notice(u12) -- Line: 85
    -- upvalues: FFlags (copy), ChickenOrHero (copy)
    task.spawn(function() -- Line: 86
        -- upvalues: FFlags (ref), ChickenOrHero (ref), u12 (copy)
        local success, result = pcall(function() -- Line: 87
            -- upvalues: FFlags (ref), ChickenOrHero (ref), u12 (ref)
            local v13;

            if FFlags.awaitUIVersion() == "NewGui" then
                v13 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v13 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
            end;

            require(v13).show(u12);
        end);

        if not success then
            warn("Gift notice: " .. tostring(result));
        end;
    end);
end;

function u1.busy() -- Line: 99
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("GiftOpen") ~= nil;
end;

function u1.open(p14) -- Line: 103
    -- upvalues: u1 (copy), u5 (ref), ChickenOrHero (copy), GiftEvent (copy)
    if not u1.giftable(p14) then
        u1.notice(u1.UNAVAILABLE);

        return;
    end;

    if not u5 then
        u5 = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("GiftScreen")).new(GiftEvent);
    end;

    u5:open(p14);
end;

local function icon(p15, p16) -- Line: 111
    -- upvalues: u1 (copy)
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "GiftIcon";
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(0.66, 0.66);
    ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = u1.ICON;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.ZIndex = p16 + 2;
    ImageLabel.Parent = p15;

    return ImageLabel;
end;

local function wire(u17) -- Line: 126
    -- upvalues: u1 (copy)
    local square = u17.square;
    square.Activated:Connect(function() -- Line: 128
        -- upvalues: u17 (copy), u1 (ref)
        if u17.active then
            local open = u1.open;
            local key = u17.key;

            if type(key) == "function" then
                key = key();
            end;

            open(key);
        end;
    end);
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Hit";
    TextButton.Text = "";
    TextButton.BackgroundTransparency = 1;
    TextButton.AnchorPoint = Vector2.new(0.5, 0.5);
    TextButton.Position = UDim2.fromScale(0.5, 0.5);
    TextButton.Size = UDim2.new(1, 10, 1, 14);
    TextButton.ZIndex = square.ZIndex + 3;
    TextButton.Selectable = false;
    TextButton.Parent = square;
    TextButton.Activated:Connect(function() -- Line: 144
        -- upvalues: u17 (copy), u1 (ref)
        if u17.active then
            local open = u1.open;
            local key = u17.key;

            if type(key) == "function" then
                key = key();
            end;

            open(key);
        end;
    end);
end;

local function clearCopied(p18) -- Line: 152
    local v19 = p18.Parent and p18.Parent:FindFirstChild(p18.Name .. "Gift");

    if v19 and v19:FindFirstChild("GiftIcon") then
        v19:Destroy();
    end;
end;

function u1.attach(p20, p21, p22) -- Line: 160
    -- upvalues: icon (copy), u4 (copy), wire (copy)
    local v23 = p20.Parent and p20.Parent:FindFirstChild(p20.Name .. "Gift");

    if v23 and v23:FindFirstChild("GiftIcon") then
        v23:Destroy();
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = p20.Name .. "Gift";
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.BorderSizePixel = 0;
    TextButton.ZIndex = p20.ZIndex;
    TextButton.Visible = false;
    TextButton.Parent = p20.Parent;
    icon(TextButton, p20.ZIndex);
    local v24 = {
        visible = false,
        active = false,
        square = TextButton,
        key = p21,
        paint = p22
    };
    u4[p20] = v24;
    p22(TextButton, false);
    wire(v24);

    return TextButton;
end;

function u1.box(p25, p26, p27, p28, p29) -- Line: 178
    -- upvalues: u4 (copy)
    local v30 = u4[p25];

    if v30 then
        v30.rect = {
            p26,
            p27,
            p28,
            p29
        };
    end;

    if not (v30 and v30.visible) then
        p25.Position = UDim2.fromOffset(p26, p27);
        p25.Size = UDim2.fromOffset(p28, p29);

        return;
    end;

    local math_min_ret = math.min(p29, p28 * 0.4);
    p25.Position = UDim2.fromOffset(p26, p27);
    p25.Size = UDim2.fromOffset(p28 - math_min_ret - 8, p29);
    v30.square.Position = UDim2.fromOffset(p26 + p28 - math_min_ret, p27);
    v30.square.Size = UDim2.fromOffset(math_min_ret, p29);
end;

function u1.sync(p31, p32, p33) -- Line: 197
    -- upvalues: u4 (copy), u1 (copy)
    local v34 = u4[p31];

    if not v34 then
        return;
    end;

    local v35;

    if p32 == true then
        local giftable = u1.giftable;
        local key = v34.key;

        if type(key) == "function" then
            key = key();
        end;

        v35 = giftable(key);
    else
        v35 = false;
    end;

    local v36;

    if v35 then
        if p33 == true then
            v36 = not u1.busy();
        else
            v36 = false;
        end;
    else
        v36 = v35;
    end;

    if v34.visible ~= v35 then
        v34.visible = v35;
        v34.square.Visible = v35;

        if v34.rect then
            u1.box(p31, table.unpack(v34.rect));
        elseif v34.scaled then
            v34.scaled(v35);
        end;
    end;

    if v34.active ~= v36 then
        v34.active = v36;
        v34.square.AutoButtonColor = v36;
        v34.paint(v34.square, v36);
    end;
end;

function u1.attachScaled(u37, p38) -- Line: 223
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), icon (copy), u4 (copy), wire (copy)
    local v39 = u37.Parent and u37.Parent:FindFirstChild(u37.Name .. "Gift");

    if v39 and v39:FindFirstChild("GiftIcon") then
        v39:Destroy();
    end;

    local u40 = u37:Clone();
    u40.Name = u37.Name .. "Gift";

    for _, child in u40:GetChildren() do
        if child:IsA("TextLabel") or child:IsA("Frame") and not child:IsA("CanvasGroup") then
            child:Destroy();
        elseif child:IsA("UIGradient") then
            child.Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret2);
        elseif child:IsA("UIStroke") and child.Color ~= Color3.new(0, 0, 0) then
            child.Color = Color3_fromRGB_ret;
        elseif child:IsA("LuaSourceContainer") then
            child:Destroy();
        end;
    end;

    u40.Visible = false;
    u40.Parent = u37.Parent;
    icon(u40, u37.ZIndex);
    local u41 = {
        position = u37.Position,
        size = u37.Size,
        anchor = u37.AnchorPoint
    };
    local u42 = u40:FindFirstChildOfClass("UIGradient");
    local u43 = {
        visible = false,
        active = false,
        square = u40,
        key = p38
    };
    local u44 = u37.Parent and u37.Parent:FindFirstChildWhichIsA("UIListLayout");

    if u44 then
        u40.LayoutOrder = u37.LayoutOrder + 1;
    end;

    local function place() -- Line: 248
        -- upvalues: u37 (copy), u41 (copy), u44 (copy), u43 (copy), u40 (copy)
        local Parent = u37.Parent;

        if not (Parent and (Parent:IsA("GuiObject") and Parent.AbsoluteSize.X > 0)) then
            return;
        end;

        local Scale = u41.size.X.Scale;
        local Scale2 = u41.size.Y.Scale;
        local math_min_ret = math.min(Scale * 0.4, Scale2 * Parent.AbsoluteSize.Y / Parent.AbsoluteSize.X);

        if u44 then
            local Scale3 = u44.Padding.Scale;
            local v45;

            if u43.visible then
                v45 = UDim2.new(Scale - math_min_ret - Scale3, u41.size.X.Offset, Scale2, u41.size.Y.Offset);
            else
                v45 = u41.size;
            end;

            u37.Size = v45;
            u40.Size = UDim2.new(math_min_ret, 0, Scale2, u41.size.Y.Offset);

            return;
        end;

        local math_min_ret2 = math.min(Scale * 0.04, 6 / Parent.AbsoluteSize.X);
        local v46 = u41.position.X.Scale - u41.anchor.X * Scale;
        local Y = u41.position.Y;

        if not u43.visible then
            u37.AnchorPoint = u41.anchor;
            u37.Position = u41.position;
            u37.Size = u41.size;

            return;
        end;

        u37.AnchorPoint = Vector2.new(0, u41.anchor.Y);
        u37.Position = UDim2.new(v46, u41.position.X.Offset, Y.Scale, Y.Offset);
        u37.Size = UDim2.new(Scale - math_min_ret - math_min_ret2, u41.size.X.Offset, Scale2, u41.size.Y.Offset);
        u40.AnchorPoint = Vector2.new(0, u41.anchor.Y);
        u40.Position = UDim2.new(v46 + Scale - math_min_ret, u41.position.X.Offset, Y.Scale, Y.Offset);
        u40.Size = UDim2.new(math_min_ret, 0, Scale2, u41.size.Y.Offset);
    end;

    u43.scaled = place;

    function u43.paint(p47, p48) -- Line: 282
        -- upvalues: u40 (copy), u42 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref)
        u40.Interactable = p48;

        if u42 then
            u42.Color = p48 and ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret2) or ColorSequence.new(Color3.fromRGB(125, 125, 125), Color3.fromRGB(80, 80, 80));
        end;
    end;

    u4[u37] = u43;
    u43.paint(u40, false);
    wire(u43);
    local Parent = u37.Parent;

    if Parent and Parent:IsA("GuiObject") then
        Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(place);
    end;

    return u40;
end;

return u1;