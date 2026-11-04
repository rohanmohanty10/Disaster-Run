 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local MapLocator = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("MapLocator"));
local ArmoryEvent = ChickenOrHero.Weapons:WaitForChild("ArmoryEvent");
local u1 = Panels.screen(LocalPlayer, "LikeReward", 68);
local u2, v3, u4 = Panels.panel(u1, "Panel", 520, 340);
Panels.make("Frame", v3, "TopRule", {
    BorderSizePixel = 0,
    Size = UDim2.new(1, -28, 0, 3),
    Position = UDim2.fromOffset(14, 0),
    BackgroundColor3 = Panels.Gold
});
Skin.band(v3.TopRule, {
    color = Panels.Gold
});
Panels.text(v3, "Eyebrow", "VALLEY RUN  /  FREE REWARD", 28, 24, 400, 18, 11, Panels.Gold);
Panels.text(v3, "Heading", "LIKE REWARD", 28, 61, 450, 40, 30, Panels.Paper).Font = Enum.Font.GothamBold;
Panels.text(v3, "Instructions", "LIKE THE GAME AND REJOIN TO CLAIM", 28, 112, 464, 42, 16, Panels.Muted);
local v5 = Panels.text(v3, "Rewards", "+200 COINS", 28, 171, 464, 40, 27, Panels.Gold);
v5.Font = Enum.Font.GothamBold;
v5.TextXAlignment = Enum.TextXAlignment.Center;
local u6 = Panels.text(v3, "Status", "", 28, 220, 464, 28, 12, Panels.Muted);
u6.TextXAlignment = Enum.TextXAlignment.Center;
local u7 = Panels.button(v3, "Claim", "LOADING…", 28, 270, 464, 44, Color3.fromRGB(81, 67, 39));
local u8 = {
    loaded = false
};
local u9 = false;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = true;
local u14 = {};

local function connect(p15, p16) -- Line: 42
    -- upvalues: u14 (copy)
    table.insert(u14, p15:Connect(p16));
end;

local function remaining() -- Line: 45
    -- upvalues: LocalPlayer (copy)
    local Attribute = LocalPlayer:GetAttribute("LikeRewardReadyAt");

    if type(Attribute) ~= "number" then
        return nil;
    end;

    local v17 = Attribute - workspace:GetServerTimeNow();
    local math_ceil_ret = math.ceil(v17);

    return math.max(0, math_ceil_ret);
end;

local function clockText(p18) -- Line: 52
    return string.format("%d:%02d", math.floor(p18 / 60), p18 % 60);
end;

local function syncWorldReward() -- Line: 55
    -- upvalues: u13 (ref), MapLocator (copy), u8 (ref), u12 (ref), LocalPlayer (copy)
    if not u13 then
        return;
    end;

    local v19 = MapLocator.interactable("FreeReward");

    if not v19 then
        return;
    end;

    if u8.likeRewardClaimed == true then
        v19:Destroy();
        u12 = nil;

        return;
    end;

    local Sign = v19:FindFirstChild("Sign");
    local v20;

    if Sign then
        v20 = Sign:FindFirstChild("Title");
    else
        v20 = Sign;
    end;

    if not (Sign and (Sign:IsA("BillboardGui") and (v20 and v20:IsA("TextLabel")))) then
        return;
    end;

    if not (u12 and u12:IsDescendantOf(Sign)) then
        u12 = Instance.new("TextLabel");
        u12.Name = "LocalRewardCountdown";
        u12.BackgroundTransparency = 1;
        u12.Size = UDim2.fromScale(1, 0.16);
        u12.Position = UDim2.new(0, 0, v20.Position.Y.Scale + v20.Size.Y.Scale + 0.025, v20.Position.Y.Offset + v20.Size.Y.Offset);
        u12.Font = Enum.Font.GothamMedium;
        u12.TextColor3 = Color3.fromRGB(166, 172, 181);
        u12.TextScaled = true;
        u12.TextStrokeColor3 = Color3.fromRGB(25, 29, 35);
        u12.TextStrokeTransparency = 0.35;
        u12.Parent = Sign;
    end;

    local Attribute = LocalPlayer:GetAttribute("LikeRewardReadyAt");
    local v21;

    if type(Attribute) == "number" then
        local v22 = Attribute - workspace:GetServerTimeNow();
        local math_ceil_ret = math.ceil(v22);
        v21 = math.max(0, math_ceil_ret);
    else
        v21 = nil;
    end;

    u12.Text = v21 and (v21 > 0 and string.format("%d:%02d", math.floor(v21 / 60), v21 % 60) .. " until this can be claimed" or "Ready to claim!") or "Loading…";
end;

local function eligible() -- Line: 97
    -- upvalues: LocalPlayer (copy)
    local v23;

    if LocalPlayer:GetAttribute("ClientReady") == true then
        v23 = not (LocalPlayer:GetAttribute("InMatch") or LocalPlayer:GetAttribute("TutorialRouting") or (LocalPlayer:GetAttribute("TutorialActive") or LocalPlayer:GetAttribute("TutorialFinishing"))) and not LocalPlayer:GetAttribute("ScreenPresentationActive");
    else
        v23 = false;
    end;

    return v23;
end;

local function render() -- Line: 105
    -- upvalues: u13 (ref), u8 (ref), LocalPlayer (copy), u7 (copy), u9 (ref), eligible (copy), u10 (ref), Skin (copy), u6 (copy), syncWorldReward (copy)
    if not u13 then
        return;
    end;

    local v24 = u8.likeRewardClaimed == true;
    local Attribute = LocalPlayer:GetAttribute("LikeRewardReadyAt");
    local v25;

    if type(Attribute) == "number" then
        local v26 = Attribute - workspace:GetServerTimeNow();
        local math_ceil_ret = math.ceil(v26);
        v25 = math.max(0, math_ceil_ret);
    else
        v25 = nil;
    end;

    local v27 = v25 == nil and true or v25 > 0;
    local v28 = u8.loaded and not v27;
    u7.Text = v24 and "CLAIMED  ✓" or (u9 and "CLAIMING…" or (u8.loaded and (v27 and "REWARD LOCKED" or "CLAIM REWARD") or "LOADING…"));
    local v29 = v28 and not (v24 or u9) and eligible();
    u7.Active = v29;
    u7.Selectable = u7.Active;
    u7.AutoButtonColor = u7.Active;
    u7.TextTransparency = u7.Active and 0 or 0.35;
    local v30 = v24 and "dark" or (u7.Active and "primary" or "secondary");

    if v30 ~= u10 then
        u10 = v30;
        Skin.button(u7, v30);

        if v24 then
            Skin.select(u7, true, Skin.Palette.green);
        end;
    end;

    u6.Text = v24 and "Your reward has been added to your wallet." or (u8.loaded and v25 and (v25 > 0 and string.format("%d:%02d", math.floor(v25 / 60), v25 % 60) .. " until this can be claimed" or "Your reward is ready!") or "Loading your reward…");

    if u8.sessionOnly then
        local v31 = u6;
        v31.Text = v31.Text .. "  (Studio session only)";
    end;

    syncWorldReward();
end;

local function show() -- Line: 147
    -- upvalues: eligible (copy), HudNavigation (copy), u11 (ref), GuiService (copy), u2 (copy), LocalPlayer (copy), render (copy), ArmoryEvent (copy), UserInputService (copy), u7 (copy), u4 (copy)
    if not eligible() then
        return;
    end;

    HudNavigation.opening("LikeReward");
    u11 = GuiService.SelectedObject;
    u2.Visible = true;
    LocalPlayer:SetAttribute("LikeRewardOpen", true);
    LocalPlayer:SetAttribute("SpectateRequestedExit", os.clock());
    render();
    ArmoryEvent:FireServer("Get");

    if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        GuiService.SelectedObject = u7.Active and u7 or u4;
    end;
end;

table.insert(u14, u4.Activated:Connect(function() -- Line: 140, Name: hide
    -- upvalues: u2 (copy), LocalPlayer (copy), GuiService (copy), u1 (copy), u11 (ref)
    u2.Visible = false;
    LocalPlayer:SetAttribute("LikeRewardOpen", nil);

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1) then
        GuiService.SelectedObject = u11 and (u11.Parent and u11) or nil;
    end;
end));
table.insert(u14, u7.Activated:Connect(function() -- Line: 163
    -- upvalues: u7 (copy), u9 (ref), render (copy), ArmoryEvent (copy), u13 (ref), u6 (copy)
    if not u7.Active then
        return;
    end;

    u9 = true;
    render();
    ArmoryEvent:FireServer("ClaimLikeReward");
    task.delay(5, function() -- Line: 170
        -- upvalues: u13 (ref), u9 (ref), render (ref), u6 (ref)
        if u13 and u9 then
            u9 = false;
            render();
            u6.Text = "Please try again. Your claim can only pay once.";
        end;
    end);
end));
table.insert(u14, ArmoryEvent.OnClientEvent:Connect(function(p32, p33) -- Line: 178
    -- upvalues: u8 (ref), u9 (ref), render (copy), u2 (copy), u6 (copy)
    if p32 ~= "State" or type(p33) ~= "table" then
        return;
    end;

    u8 = p33;

    if not p33.pending then
        u9 = false;
    end;

    render();

    if u2.Visible and p33.message then
        u6.Text = p33.message;
    end;
end));
table.insert(u14, HudNavigation.Opening.Event:Connect(function(p34) -- Line: 191
    -- upvalues: u2 (copy), LocalPlayer (copy), GuiService (copy), u1 (copy), u11 (ref)
    if p34 ~= "LikeReward" then
        u2.Visible = false;
        LocalPlayer:SetAttribute("LikeRewardOpen", nil);

        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1) then
            GuiService.SelectedObject = u11 and (u11.Parent and u11) or nil;
        end;
    end;
end));

for _, v in { "InMatch", "ScreenPresentationActive", "TutorialRouting", "TutorialActive", "TutorialFinishing", "ClientReady", "MatchSummaryVisible" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u14, AttributeChangedSignal:Connect(function() -- Line: 197
        -- upvalues: eligible (copy), LocalPlayer (copy), u2 (copy), GuiService (copy), u1 (copy), u11 (ref)
        if not eligible() or LocalPlayer:GetAttribute("MatchSummaryVisible") then
            u2.Visible = false;
            LocalPlayer:SetAttribute("LikeRewardOpen", nil);

            if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1) then
                GuiService.SelectedObject = u11 and (u11.Parent and u11) or nil;
            end;
        end;
    end));
end;

table.insert(u14, UserInputService.InputBegan:Connect(function(p35) -- Line: 203
    -- upvalues: u2 (copy), UserInputService (copy), LocalPlayer (copy), GuiService (copy), u1 (copy), u11 (ref)
    if u2.Visible and not (UserInputService:GetFocusedTextBox() or p35.KeyCode ~= Enum.KeyCode.Escape and p35.KeyCode ~= Enum.KeyCode.ButtonB) then
        u2.Visible = false;
        LocalPlayer:SetAttribute("LikeRewardOpen", nil);

        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1) then
            GuiService.SelectedObject = u11 and (u11.Parent and u11) or nil;
        end;
    end;
end));
local PromptTriggered = game:GetService("ProximityPromptService").PromptTriggered;
table.insert(u14, PromptTriggered:Connect(function(p36, p37) -- Line: 212
    -- upvalues: MapLocator (copy), LocalPlayer (copy), show (copy)
    local v38 = MapLocator.interactable("FreeReward");

    if p37 == LocalPlayer and (v38 and p36:IsDescendantOf(v38)) then
        show();
    end;
end));
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("LikeRewardReadyAt");
table.insert(u14, AttributeChangedSignal:Connect(render));
local ChildAdded = MapLocator.interactables(10).ChildAdded;
table.insert(u14, ChildAdded:Connect(function(p39) -- Line: 219
    -- upvalues: syncWorldReward (copy)
    if p39.Name == "FreeReward" then
        task.defer(syncWorldReward);
    end;
end));
render();
ArmoryEvent:FireServer("Get");
task.spawn(function() -- Line: 226
    -- upvalues: u13 (ref), render (copy)
    while u13 do
        task.wait(0.25);

        if u13 then
            render();
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 234
    -- upvalues: u13 (ref), u14 (copy), u2 (copy), LocalPlayer (copy), GuiService (copy), u1 (copy), u11 (ref), u12 (ref)
    u13 = false;

    for _, v in u14 do
        v:Disconnect();
    end;

    u2.Visible = false;
    LocalPlayer:SetAttribute("LikeRewardOpen", nil);

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1) then
        GuiService.SelectedObject = u11 and (u11.Parent and u11) or nil;
    end;

    if u12 then
        u12:Destroy();
    end;

    u1:Destroy();
end);