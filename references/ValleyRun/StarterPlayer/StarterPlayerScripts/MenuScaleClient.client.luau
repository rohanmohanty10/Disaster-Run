 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u1 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and 0.9 or 0.8;
local u2 = {
    ValleyJourney = "Journal"
};
local u3 = {};
local u4 = {
    ValleyArmory = "Canvas",
    HalloweenShop = "HalloweenShop",
    BalloonOffer = "Card",
    MatchSummaryUI = "MatchResult",
    ServerBrowser = "Panel"
};

for _, v in u2 do
    u3[v] = true;
end;

local u5 = {
    ValleyHUD = true,
    HUD = true,
    AdminUI = true,
    StaffPanel = true,
    GlobalGiveaway = true,
    GiveawayPicker = true,
    CreatorStudio = true,
    AdminPanelOld = true,
    StudioKnifePreview = true,
    StudioEmotePreview = true,
    TutorialGuide = true,
    TutorialDone = true,
    SpinWheel = true,
    RankedLoadout = true,
    RankedMenu = true
};
local u6 = setmetatable({}, {
    __mode = "k"
});

local function isMenuScale(p7) -- Line: 50
    -- upvalues: u5 (copy), u4 (copy)
    local Parent = p7.Parent;
    local v8 = p7:FindFirstAncestorWhichIsA("ScreenGui");

    if not (v8 and (Parent and (Parent:IsA("GuiObject") and not u5[v8.Name]))) then
        return false;
    end;

    if u4[v8.Name] == Parent.Name then
        return true;
    end;

    local Parent2 = Parent.Parent;
    local v9;

    if Parent2 == nil then
        v9 = false;
    else
        v9 = Parent2:IsA("GuiObject");

        if v9 then
            if string.sub(Parent2.Name, -5) == "Shade" and Parent2.Size.X.Scale >= 0.99 then
                v9 = Parent2.Size.Y.Scale >= 0.99;
            else
                v9 = false;
            end;
        end;
    end;

    return v9;
end;

local function manage(u10) -- Line: 67
    -- upvalues: u6 (copy), isMenuScale (copy), u1 (copy)
    if u6[u10] or not isMenuScale(u10) then
        return;
    end;

    local u11 = {};
    u6[u10] = u11;

    local function apply() -- Line: 73
        -- upvalues: u10 (copy), u11 (copy), u1 (ref)
        local Scale = u10.Scale;

        if u11.set and math.abs(Scale - u11.set) < 0.00001 then
            return;
        end;

        u11.set = Scale * u1;
        u10.Scale = u11.set;
    end;

    u11.connection = u10:GetPropertyChangedSignal("Scale"):Connect(apply);
    u10.Destroying:Once(function() -- Line: 83
        -- upvalues: u11 (copy), u6 (ref), u10 (copy)
        u11.connection:Disconnect();
        u6[u10] = nil;
    end);
    local Scale = u10.Scale;

    if u11.set and math.abs(Scale - u11.set) < 0.00001 then
        return;
    end;

    u11.set = Scale * u1;
    u10.Scale = u11.set;
end;

local function addScale(p12) -- Line: 90
    -- upvalues: u1 (copy)
    if p12:FindFirstChild("MenuScale") then
        return;
    end;

    local UIScale = Instance.new("UIScale");
    UIScale.Name = "MenuScale";
    UIScale.Scale = u1;
    UIScale.Parent = p12;
end;

local function consider(u13) -- Line: 101
    -- upvalues: u3 (copy), u2 (copy), u1 (copy), manage (copy)
    if u13:IsA("GuiObject") then
        local v14 = u3[u13.Name] and u13:FindFirstAncestorWhichIsA("ScreenGui");

        if v14 and u2[v14.Name] == u13.Name then
            if u13:FindFirstChild("MenuScale") then
                return;
            end;

            local UIScale = Instance.new("UIScale");
            UIScale.Name = "MenuScale";
            UIScale.Scale = u1;
            UIScale.Parent = u13;
        end;
    elseif u13:IsA("UIScale") and u13.Name ~= "MenuScale" then
        task.defer(function() -- Line: 108
            -- upvalues: u13 (copy), manage (ref)
            if u13.Parent then
                manage(u13);
            end;
        end);
    end;
end;

for _, descendant in PlayerGui:GetDescendants() do
    consider(descendant);
end;

local u15 = PlayerGui.DescendantAdded:Connect(consider);
script.Destroying:Connect(function() -- Line: 119
    -- upvalues: u15 (copy), u6 (copy), u1 (copy), PlayerGui (copy)
    u15:Disconnect();

    for i, v in u6 do
        v.connection:Disconnect();

        if i.Parent and v.set then
            i.Scale = v.set / u1;
        end;
    end;

    table.clear(u6);

    for _, descendant in PlayerGui:GetDescendants() do
        if descendant:IsA("UIScale") and descendant.Name == "MenuScale" then
            descendant:Destroy();
        end;
    end;
end);