 

 

local RunService = game:GetService("RunService");

if not RunService:IsStudio() and game.PlaceId ~= 130574217370467 then
    return;
end;

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Gear = ChickenOrHero:WaitForChild("Gear");
local GearCatalog = require(Gear:WaitForChild("GearCatalog"));
local ValleyPanels = require(ChickenOrHero.Presentation:WaitForChild("ValleyPanels"));
local GearEvent = Gear:WaitForChild("GearEvent");
local GearPredictionClient = require(Gear:WaitForChild("GearPredictionClient"));
local Session = ChickenOrHero.Game:WaitForChild("Session");
local u1 = ValleyPanels.screen(LocalPlayer, "StudioAbilityTests", 80);
u1:SetAttribute("TestOnlyUI", true);
u1.Enabled = LocalPlayer:GetAttribute("TestUIHidden") == false;
local v2 = ValleyPanels.button(u1, "Toggle", "TEST · ABILITIES + ITEMS", 18, 154, 230, 32);
local u3 = ValleyPanels.make("Frame", u1, "Panel", {
    BorderSizePixel = 0,
    Visible = false,
    Position = UDim2.fromOffset(18, 193),
    Size = UDim2.fromOffset(270, 485),
    BackgroundColor3 = ValleyPanels.Ink
});
ValleyPanels.cursorWhileVisible(u3);
ValleyPanels.corner(u3, 12);
ValleyPanels.stroke(u3, ValleyPanels.Gold, 0.4);
local u4 = ValleyPanels.make("UIScale", u3, "Scale", {});
ValleyPanels.text(u3, "Heading", "SESSION-ONLY TEST LOADOUT", 12, 10, 246, 23, 12, ValleyPanels.Gold).Font = Enum.Font.GothamBold;
local v5 = 0;
local u6 = {};

local function dashDirection() -- Line: 14
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;
    local v7;

    if Character then
        v7 = Character:FindFirstChildOfClass("Humanoid");
    else
        v7 = Character;
    end;

    local v8 = v7 and v7.MoveDirection or Vector3.new(0, 0, 0);

    if v8.Magnitude > 0.05 then
        return v8.Unit;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v9 = workspace_CurrentCamera and workspace_CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 0);
    local Vector3_new_ret = Vector3.new(v9.X, 0, v9.Z);

    if Vector3_new_ret.Magnitude > 0.01 then
        return Vector3_new_ret.Unit;
    end;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    return Character and Character.CFrame.LookVector or Vector3.new(0, 0, 1);
end;

for _, v in GearCatalog.Order do
    local v10 = GearCatalog.get(v);

    if v10.Kind == "Ability" then
        v5 = v5 + 1;
        local v11 = ValleyPanels.button(u3, v, (v10.UseRole == "Runner" and "R · " or "C · ") .. v10.Name, 12, (v5 - 1) * 34 + 36, 246, 29);
        v11.TextSize = 11;
        v11.Activated:Connect(function() -- Line: 59
            -- upvalues: GearEvent (copy), v (copy)
            GearEvent:FireServer("StudioEquipAbility", v);
        end);
        u6[v] = v11;
    end;
end;

local u12 = math.max(0, v5 - 6) * 34;
local u13 = ValleyPanels.text(u3, "Status", "Choose an ability above.", 12, 245, 246, 42, 12, ValleyPanels.Paper);
local u14 = ValleyPanels.button(u3, "Use", "USE ABILITY", 12, 291, 120, 31);
local v15 = ValleyPanels.button(u3, "Reset", "RESET TIMER", 138, 291, 120, 31);
u14.TextSize = 11;
v15.TextSize = 11;
local v16 = ValleyPanels.button(u3, "Clear", "RESTORE NORMAL LOADOUT", 12, 329, 246, 28);
v16.TextSize = 11;
local u17 = ValleyPanels.text(u3, "Notice", "Lobby: select any ability, then USE. R/C only matter in real matches.", 12, 363, 246, 34, 10, ValleyPanels.Muted);
ValleyPanels.text(u3, "ItemsHeading", "ITEMS · CLICK TO TEST IN LOBBY", 12, 402, 246, 20, 11, ValleyPanels.Gold);
local u18 = {};

for i, v in { "BananaPeel", "RescueKit", "Adrenaline" } do
    local v19 = ValleyPanels.button(u3, v, ({
        BananaPeel = "BANANA",
        RescueKit = "SELF RESCUE",
        Adrenaline = "ADRENALINE"
    })[v], 12 + (i - 1) * 84, 427, 78, 34);
    v19.TextSize = 10;
    v19.Activated:Connect(function() -- Line: 90
        -- upvalues: GearPredictionClient (copy), v (copy), dashDirection (copy)
        GearPredictionClient.request(v, dashDirection(), "StudioUseItem");
    end);
    table.insert(u18, v19);
end;

ValleyPanels.text(u3, "ItemHelp", "Free demos. Self Rescue falls, then revives you.", 12, 465, 246, 16, 10, ValleyPanels.Muted);

for _, child in u3:GetChildren() do
    if child:IsA("GuiObject") and (child.Position.Y.Offset >= 245 and not u6[child.Name]) then
        child.Position = child.Position + UDim2.fromOffset(0, u12);
    end;
end;

u3.Size = u3.Size + UDim2.fromOffset(0, u12);
v2.Activated:Connect(function() -- Line: 102
    -- upvalues: u3 (copy)
    u3.Visible = not u3.Visible;
end);
u14.Activated:Connect(function() -- Line: 105
    -- upvalues: LocalPlayer (copy), GearCatalog (copy), GearPredictionClient (copy), dashDirection (copy)
    local Attribute = LocalPlayer:GetAttribute("StudioTestAbility");

    if type(Attribute) == "string" and GearCatalog.get(Attribute) then
        GearPredictionClient.request(Attribute, dashDirection(), LocalPlayer:GetAttribute("InMatch") and "UseAbility" or "StudioUseAbility");
    end;
end);
v15.Activated:Connect(function() -- Line: 115
    -- upvalues: GearEvent (copy)
    GearEvent:FireServer("StudioResetAbility");
end);
v16.Activated:Connect(function() -- Line: 118
    -- upvalues: GearEvent (copy)
    GearEvent:FireServer("StudioClearAbility");
end);
local u22 = GearEvent.OnClientEvent:Connect(function(p20, p21) -- Line: 121
    -- upvalues: u17 (copy)
    if p20 == "Notice" and type(p21) == "string" then
        u17.Text = p21;
    end;
end);
local u23 = 0;
local u30 = RunService.Heartbeat:Connect(function(p24) -- Line: 127
    -- upvalues: u23 (ref), LocalPlayer (copy), GearCatalog (copy), u6 (copy), u18 (copy), Session (copy), u13 (copy), u14 (copy), u4 (copy), u1 (copy), u12 (copy)
    u23 = u23 + p24;

    if u23 < 0.1 then
        return;
    end;

    u23 = 0;
    local Attribute = LocalPlayer:GetAttribute("StudioTestAbility");
    local v25 = GearCatalog.get(Attribute);
    local Attribute2 = LocalPlayer:GetAttribute("GameRole");
    local v26 = (LocalPlayer:GetAttribute("AbilityReadyAt") or 0) - workspace:GetServerTimeNow();
    local math_max_ret = math.max(0, v26);

    for i, v in u6 do
        v.BackgroundColor3 = i == Attribute and Color3.fromRGB(69, 66, 43) or Color3.fromRGB(36, 56, 70);
    end;

    local v27 = LocalPlayer:GetAttribute("InMatch") ~= true;

    for _, v in u18 do
        local v28 = v27 and not Session:GetAttribute("GlobalPaused") and not Session:GetAttribute("MapChanging");
        v.Interactable = v28;
        v.TextTransparency = v.Interactable and 0 or 0.5;
    end;

    u13.Text = v25 and (v27 and "LOBBY SANDBOX · press USE. Targets appear automatically. Roles stay unchanged." or (Attribute2 ~= v25.UseRole and "Needs " .. (v25.UseRole == "Runner" and "RUNNER" or "CHASER") .. " role. Roles are not changed." or (LocalPlayer:GetAttribute("RunState") == "Active" and (math_max_ret > 0 and (string.format("Cooldown: %.1fs · reset to try again.", math_max_ret) or "Ready during an open crossing. Aim, then use.") or "Ready during an open crossing. Aim, then use.") or "Wait until you are active on the field."))) or "Choose a test ability. Your real loadout is preserved.";
    local v29;

    if v25 == nil or not (v27 or Attribute2 == v25.UseRole and (LocalPlayer:GetAttribute("RunState") == "Active" and math_max_ret == 0)) then
        v29 = false;
    else
        v29 = not Session:GetAttribute("GlobalPaused") and not Session:GetAttribute("MapChanging");
    end;

    u14.Interactable = v29;
    u14.TextTransparency = u14.Interactable and 0 or 0.5;
    local math_max_ret2 = math.max(0.5, (u1.AbsoluteSize.Y - 210) / (u12 + 485));
    u4.Scale = math.min(1, math_max_ret2, (u1.AbsoluteSize.X - 36) / 270);
end);
script.Destroying:Connect(function() -- Line: 159
    -- upvalues: u30 (copy), u22 (copy), u1 (copy)
    u30:Disconnect();
    u22:Disconnect();
    u1:Destroy();
end);