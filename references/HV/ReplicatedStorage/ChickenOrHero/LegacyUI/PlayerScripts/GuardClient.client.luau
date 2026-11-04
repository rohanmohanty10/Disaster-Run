 

 

local LocalPlayer = game.Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local MovementGuardEvent = ChickenOrHero.Presentation:WaitForChild("MovementGuardEvent");
local u1 = Panels.screen(LocalPlayer, "ValleyFairPlay", 85);
local u2, v3, v4 = Panels.panel(u1, "Warning", 620, 360);
Panels.text(v3, "Eyebrow", "VALLEY RUN  /  FAIR PLAY", 28, 24, 505, 24, 12, Panels.Gold);
local u5 = Panels.text(v3, "Title", "FAIR PLAY WARNING", 28, 65, 555, 52, 27, Panels.Gold);
u5.Font = Enum.Font.GothamBold;
local u6 = Panels.text(v3, "Message", "", 28, 127, 560, 145, 17);
u6.TextYAlignment = Enum.TextYAlignment.Top;
local v7 = Panels.button(v3, "Acknowledge", "I UNDERSTAND", 28, 297, 564, 40, Color3.fromRGB(87, 57, 43));
v7.Modal = true;
Skin.button(v7, "primary");
v4.Visible = false;
v7.Activated:Connect(function() -- Line: 15
    -- upvalues: u2 (copy), LocalPlayer (copy)
    u2.Visible = false;
    LocalPlayer:SetAttribute("FairPlayNoticeOpen", nil);
end);
local u8 = Panels.make("Frame", u1, "StaffAlert", {
    BorderSizePixel = 0,
    Visible = false,
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -18, 0, 100),
    Size = UDim2.fromOffset(350, 156),
    BackgroundColor3 = Panels.Ink
});
Panels.corner(u8, 12);
Panels.stroke(u8, Panels.Gold, 0.3);
Skin.panel(u8);
Panels.text(u8, "Label", "MODERATION · REVIEW REQUEST", 14, 10, 290, 20, 11, Panels.Gold);
local u9 = Panels.text(u8, "Message", "", 14, 37, 320, 65, 13);
u9.TextYAlignment = Enum.TextYAlignment.Top;
local v10 = Panels.button(u8, "Dismiss", "DISMISS", 14, 115, 100, 28);
local v11 = Panels.button(u8, "Watch", "SPECTATE", 124, 115, 211, 28, Color3.fromRGB(43, 80, 93));
Skin.button(v10, "secondary");
Skin.button(v11, "primary");
local u12 = nil;
local u13 = nil;
local u14 = false;

local function showToast(p15) -- Line: 27
    -- upvalues: u14 (ref), u8 (copy), LocalPlayer (copy)
    u14 = p15;

    if p15 then
        p15 = LocalPlayer:GetAttribute("TestUIHidden") == false;
    end;

    u8.Visible = p15;
end;

local u17 = LocalPlayer:GetAttributeChangedSignal("TestUIHidden"):Connect(function() -- Line: 28
    -- upvalues: u14 (ref), u8 (copy), LocalPlayer (copy)
    local v16 = u14;
    u14 = v16;

    if v16 then
        v16 = LocalPlayer:GetAttribute("TestUIHidden") == false;
    end;

    u8.Visible = v16;
end);
v10.Activated:Connect(function() -- Line: 29
    -- upvalues: u14 (ref), u8 (copy)
    u14 = false;
    u8.Visible = false;
end);
v11.Activated:Connect(function() -- Line: 30
    -- upvalues: LocalPlayer (copy), u9 (copy), ChickenOrHero (copy), u12 (ref), u14 (ref), u8 (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        u9.Text = "Return to the lobby to spectate. Use ;anticheat <player> for evidence.";

        return;
    end;

    ChickenOrHero.Presentation.SpectateEvent:FireServer("Start", u12);
    u14 = false;
    u8.Visible = false;
end);
MovementGuardEvent.OnClientEvent:Connect(function(p18, p19) -- Line: 34
    -- upvalues: u5 (copy), u6 (copy), u2 (copy), LocalPlayer (copy), u12 (ref), u9 (copy), u14 (ref), u8 (copy), u13 (ref)
    if type(p19) ~= "table" then
        return;
    end;

    if p18 ~= "Warning" then
        if p18 == "Staff" then
            u12 = p19.userId;
            u9.Text = p19.message;
            u14 = true;
            u8.Visible = LocalPlayer:GetAttribute("TestUIHidden") == false;
            u13 = os.clock();
            local u20 = u13;
            task.delay(18, function() -- Line: 37
                -- upvalues: u13 (ref), u20 (copy), u14 (ref), u8 (ref)
                if u13 == u20 then
                    u14 = false;
                    u8.Visible = false;
                end;
            end);
        end;

        return;
    end;

    u5.Text = p19.title;
    u6.Text = p19.message;
    u2.Visible = true;
    LocalPlayer:SetAttribute("FairPlayNoticeOpen", true);
end);
script.Destroying:Connect(function() -- Line: 39
    -- upvalues: u17 (copy), LocalPlayer (copy), u1 (copy)
    u17:Disconnect();
    LocalPlayer:SetAttribute("FairPlayNoticeOpen", nil);
    u1:Destroy();
end);