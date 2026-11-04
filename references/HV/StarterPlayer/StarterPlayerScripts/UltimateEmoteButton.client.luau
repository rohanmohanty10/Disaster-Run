 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local EmoteCatalog = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local TouchActionButton = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("TouchActionButton"));
local TouchCombatLayout = require(ChickenOrHero.Presentation:WaitForChild("TouchCombatLayout"));
local ControlGate = require(ChickenOrHero:WaitForChild("Movement"):WaitForChild("ControlGate"));
local EmoteEvent = ChickenOrHero.Emotes:WaitForChild("EmoteEvent");
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local HUD = PlayerGui:WaitForChild("HUD", 60);

if not HUD then
    warn("UltimateEmoteButton: no PlayerGui.HUD after 60 s; the ULTIMATE button waits for it");
    HUD = PlayerGui:WaitForChild("HUD", (1 / 0));
end;

local u1 = HUD:WaitForChild("CatchButton"):Clone();
u1.Name = "UltimateEmoteButton";
u1.Visible = false;
u1.Label.Text = "ULTIMATE";
u1.Label.TextColor3 = Color3.fromRGB(242, 191, 89);

for _, child in u1:GetChildren() do
    if child:IsA("UISizeConstraint") then
        child:Destroy();
    end;
end;

u1.Parent = HUD;
local u2 = nil;
local u3 = nil;

local function ultimate() -- Line: 37
    -- upvalues: LocalPlayer (copy), u2 (ref), u3 (ref), EmoteCatalog (copy)
    local Attribute = LocalPlayer:GetAttribute("EquippedKnife");

    if Attribute ~= u2 then
        local v4 = EmoteCatalog.ultimate(Attribute);
        u2 = Attribute;
        u3 = v4;
    end;

    return u3;
end;

TouchActionButton.bind(u1, function() -- Line: 45
    -- upvalues: LocalPlayer (copy), u2 (ref), u3 (ref), EmoteCatalog (copy), EmoteEvent (copy)
    local Attribute = LocalPlayer:GetAttribute("EquippedKnife");

    if Attribute ~= u2 then
        local v5 = EmoteCatalog.ultimate(Attribute);
        u2 = Attribute;
        u3 = v5;
    end;

    local v6 = u3;

    if not v6 then
        return;
    end;

    if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("EmoteId") == v6 then
        EmoteEvent:FireServer("Stop");

        return;
    end;

    EmoteEvent:FireServer("Play", v6);
end);
RunService.Heartbeat:Connect(function() -- Line: 56
    -- upvalues: LocalPlayer (copy), u2 (ref), u3 (ref), EmoteCatalog (copy), ControlGate (copy), TouchActionButton (copy), u1 (copy), TouchCombatLayout (copy)
    local Attribute = LocalPlayer:GetAttribute("EquippedKnife");

    if Attribute ~= u2 then
        local v7 = EmoteCatalog.ultimate(Attribute);
        u2 = Attribute;
        u3 = v7;
    end;

    local v8 = u3;
    local v9 = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("EmoteId");
    local v10;

    if v8 == nil or LocalPlayer:GetAttribute("InMatch") == true then
        v10 = false;
    else
        v10 = ControlGate.reason(LocalPlayer) == nil;
    end;

    TouchActionButton.update(u1, v10, 0, v10 and v9 == v8 and "STOP" or "ULTIMATE");

    if u1.Visible then
        TouchCombatLayout.place("Melee", u1);
    end;
end);