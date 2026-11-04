 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local AbilityRule = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("AbilityRule"));
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local EquipmentHudLayoutLegacy = require(ChickenOrHero.Presentation:WaitForChild("EquipmentHudLayoutLegacy"));
local ControlGate = require(ChickenOrHero.Movement.ControlGate);
local GearCatalog = require(ChickenOrHero.Gear.GearCatalog);
local GearEvent = ChickenOrHero.Gear:WaitForChild("GearEvent");
local GearPredictionClient = require(ChickenOrHero.Gear:WaitForChild("GearPredictionClient"));
local HudNavigation = require(ChickenOrHero.Presentation:WaitForChild("HudNavigation"));

local function dashDirection() -- Line: 18
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;
    local v1;

    if Character then
        v1 = Character:FindFirstChildOfClass("Humanoid");
    else
        v1 = Character;
    end;

    local v2 = v1 and v1.MoveDirection or Vector3.new(0, 0, 0);

    if v2.Magnitude > 0.05 then
        return v2.Unit;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v3 = workspace_CurrentCamera and workspace_CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 0);
    local Vector3_new_ret = Vector3.new(v3.X, 0, v3.Z);

    if Vector3_new_ret.Magnitude > 0.01 then
        return Vector3_new_ret.Unit;
    end;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    return Character and Character.CFrame.LookVector or Vector3.new(0, 0, 1);
end;

local u4 = Panels.screen(LocalPlayer, "AbilityControls", 63);
local u5 = Panels.button(u4, "Use", "", 0, 0, 226, 88, Panels.Ink);
u5.AnchorPoint = Vector2.new(1, 0.5);
u5.Position = UDim2.new(1, -24, 0.58, 0);
u5.AutoButtonColor = false;
Panels.stroke(u5, Panels.Gold, 0.25);
local Outline = u5:FindFirstChild("Outline");
local surface = Skin.Palette.surface;

local function cardColors(p6) -- Line: 45
    -- upvalues: surface (copy)
    return ColorSequence.new({ ColorSequenceKeypoint.new(0, surface), ColorSequenceKeypoint.new(0.55, surface), ColorSequenceKeypoint.new(1, p6:Lerp(Color3.new(0, 0, 0), 0.4)) });
end;

u5.BackgroundColor3 = Color3.new(1, 1, 1);
u5.BackgroundTransparency = 0.12;
u5.Corner.CornerRadius = UDim.new(0, 12);
local SkinStroke = u5:FindFirstChild("SkinStroke");

if SkinStroke then
    SkinStroke.Enabled = false;
end;

local v7 = Panels.make("UIScale", u5, "Scale", {});
EquipmentHudLayoutLegacy.register(u5, v7, 1);
local u8 = Panels.make("UIGradient", u5, "Gradient", {
    Rotation = 25,
    Color = cardColors(Panels.Gold)
});
local u9 = Panels.make("ViewportFrame", u5, "Item", {
    BackgroundTransparency = 1,
    LightDirection = Vector3.new(-1, -2, -2),
    Position = UDim2.fromOffset(1, 2),
    Size = UDim2.fromOffset(80, 78),
    Ambient = Color3.fromRGB(210, 210, 210),
    LightColor = Color3.new(1, 1, 1)
});
local u10 = Panels.make("ImageLabel", u5, "AbilityIcon", {
    BackgroundTransparency = 1,
    Visible = false,
    Position = u9.Position,
    Size = u9.Size,
    ScaleType = Enum.ScaleType.Fit
});
local Camera = Instance.new("Camera");
Camera.Parent = u9;
u9.CurrentCamera = Camera;
local WorldModel = Instance.new("WorldModel");
WorldModel.Parent = u9;
local u11 = Panels.text(u5, "Title", "", 80, 11, 138, 35, 15, Panels.Paper);
u11.Font = Enum.Font.GothamBold;
local u12 = Panels.text(u5, "Hint", "", 81, 48, 137, 18, 11, Panels.Gold);
u12.Font = Enum.Font.GothamBold;
local u13 = Panels.text(u5, "Charges", "", 8, 6, 48, 17, 11, Panels.Paper);
u13.Font = Enum.Font.GothamBold;
u13.TextStrokeTransparency = 0.3;
local v14 = Panels.make("Frame", u5, "Track", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(12, 77),
    Size = UDim2.fromOffset(202, 4),
    BackgroundColor3 = Skin.Palette.track
});
Panels.corner(v14, 4);
local u15 = Panels.make("Frame", v14, "Fill", {
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Panels.Gold
});
Panels.corner(u15, 4);
local u16 = Panels.text(u4, "Notice", "", 0, 0, 380, 45, 14, Panels.Gold);
u16.AnchorPoint = Vector2.new(0.5, 0.5);
u16.Position = UDim2.fromScale(0.5, 0.76);
u16.TextXAlignment = Enum.TextXAlignment.Center;
u16.TextStrokeTransparency = 0.4;
local u17 = {
    abilities = {}
};
local u18 = 0;
local u19 = 0;
local u20 = nil;
local u21 = 0;
local u22 = {};

local function on(p23, p24) -- Line: 112
    -- upvalues: u22 (copy)
    table.insert(u22, p23:Connect(p24));
end;

local function active() -- Line: 115
    -- upvalues: GearCatalog (copy), u17 (ref), LocalPlayer (copy), ControlGate (copy), ChickenOrHero (copy), AbilityRule (copy)
    local v25 = GearCatalog.get(GearCatalog.equippedForRole(u17, LocalPlayer:GetAttribute("GameRole")));
    local v26;

    if v25 then
        if v25.Kind == "Ability" and u17.abilities[GearCatalog.equippedForRole(u17, LocalPlayer:GetAttribute("GameRole"))] == true then
            v26 = u17.loaded;

            if v26 then
                if LocalPlayer:GetAttribute("InMatch") == true and (LocalPlayer:GetAttribute("RunState") == "Active" and (not v25.UseRole or LocalPlayer:GetAttribute("GameRole") == v25.UseRole)) then
                    v26 = not (ControlGate.reason(LocalPlayer) or (ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") or ChickenOrHero.Game.Session:GetAttribute("MapChanging"))) and not AbilityRule.blocked(LocalPlayer);
                else
                    v26 = false;
                end;
            end;
        else
            v26 = false;
        end;
    else
        v26 = v25;
    end;

    return v26;
end;

local function pop() -- Line: 130
    -- upvalues: TweenService (copy), u5 (copy)
    TweenService:Create(u5, TweenInfo.new(0.08), {
        Rotation = -3
    }):Play();
    task.delay(0.08, function() -- Line: 132
        -- upvalues: u5 (ref), TweenService (ref)
        if u5.Parent then
            TweenService:Create(u5, TweenInfo.new(0.22, Enum.EasingStyle.Back), {
                Rotation = 0
            }):Play();
        end;
    end);
end;

local function request() -- Line: 138
    -- upvalues: active (copy), u18 (ref), LocalPlayer (copy), pop (copy), GearPredictionClient (copy), GearCatalog (copy), u17 (ref), dashDirection (copy)
    if not (active() and (os.clock() >= u18 and workspace:GetServerTimeNow() >= (LocalPlayer:GetAttribute("AbilityReadyAt") or 0))) then
        return;
    end;

    u18 = os.clock() + 0.6;
    pop();
    GearPredictionClient.request(GearCatalog.equippedForRole(u17, LocalPlayer:GetAttribute("GameRole")), dashDirection(), "UseAbility");
end;

local function preview(p27) -- Line: 150
    -- upvalues: WorldModel (copy), u10 (copy), u9 (copy), ChickenOrHero (copy), GearCatalog (copy), u17 (ref), LocalPlayer (copy), Camera (copy)
    WorldModel:ClearAllChildren();
    u10.Visible = p27.IconImage ~= nil;
    u9.Visible = not u10.Visible;
    u10.Image = p27.IconImage or "";
    u10.ImageRectOffset = p27.IconRectOffset or Vector2.zero;
    u10.ImageRectSize = p27.IconRectSize or Vector2.zero;

    if u10.Visible then
        return;
    end;

    local v28 = ChickenOrHero.Gear.Assets:FindFirstChild(p27.Preview or GearCatalog.equippedForRole(u17, LocalPlayer:GetAttribute("GameRole")));

    if not v28 then
        return;
    end;

    local Model = Instance.new("Model");
    local v29 = v28:Clone();

    for _, descendant in v29:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
        end;
    end;

    if v29:IsA("BasePart") then
        v29.Anchored = true;
    end;

    v29.Parent = Model;
    Model.Parent = WorldModel;
    local BoundingBox, v30 = Model:GetBoundingBox();
    local v31 = math.max(v30.X, v30.Y, v30.Z) * 1.8;
    Camera.CFrame = CFrame.lookAt(BoundingBox.Position + Vector3.new(v31 * 0.65, v31 * 0.35, v31), BoundingBox.Position);
    Camera.FieldOfView = 40;
end;

table.insert(u22, u5.Activated:Connect(function() -- Line: 186
    -- upvalues: LocalPlayer (copy), HudNavigation (copy), request (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        request();

        return;
    end;

    HudNavigation.activate("Abilities");
end));
table.insert(u22, u5.MouseEnter:Connect(function() -- Line: 193
    -- upvalues: TweenService (copy), u8 (copy)
    TweenService:Create(u8, TweenInfo.new(0.2), {
        Rotation = 65
    }):Play();
end));
table.insert(u22, u5.MouseLeave:Connect(function() -- Line: 196
    -- upvalues: TweenService (copy), u8 (copy)
    TweenService:Create(u8, TweenInfo.new(0.2), {
        Rotation = 25
    }):Play();
end));
table.insert(u22, UserInputService.InputBegan:Connect(function(p32, p33) -- Line: 199
    -- upvalues: UserInputService (copy), request (copy)
    if not (p33 or (UserInputService:GetFocusedTextBox() or p32.KeyCode ~= Enum.KeyCode.Q and p32.KeyCode ~= Enum.KeyCode.ButtonR1)) then
        request();
    end;
end));
table.insert(u22, ChickenOrHero.Weapons.ArmoryEvent.OnClientEvent:Connect(function(p34, p35) -- Line: 208
    -- upvalues: u17 (ref)
    if p34 == "State" and type(p35) == "table" then
        u17 = p35;
        u17.abilities = u17.abilities or {};
    end;
end));
table.insert(u22, GearEvent.OnClientEvent:Connect(function(p36, p37) -- Line: 214
    -- upvalues: u16 (copy), u19 (ref), u18 (ref)
    if p36 == "Notice" and type(p37) == "string" then
        u16.Text = "";
        u19 = 0;
        u18 = 0;
    end;
end));
local u38 = u5:Clone();
u38.Name = "ChaserEquipped";
u38.Visible = false;
u38.Active = false;
u38.Selectable = false;
u38.Parent = u4;
EquipmentHudLayoutLegacy.register(u38, u38.Scale, 2);
table.insert(u22, u38.Activated:Connect(function() -- Line: 228
    -- upvalues: HudNavigation (copy)
    HudNavigation.activate("Abilities");
end));
local u39 = Panels.text(u5, "NextCharge", "", 81, 61, 137, 13, 10, Skin.Palette.textBody);
u39.Font = Enum.Font.GothamBold;
u39.Visible = false;
local u40 = false;
local u41 = nil;
local u42 = nil;
table.insert(u22, RunService.Heartbeat:Connect(function(p43) -- Line: 239
    -- upvalues: u21 (ref), LocalPlayer (copy), GearCatalog (copy), u17 (ref), ControlGate (copy), u5 (copy), AbilityRule (copy), u38 (copy), Panels (copy), u42 (ref), cardColors (copy), active (copy), u18 (ref), u20 (ref), preview (copy), UserInputService (copy), u11 (copy), u13 (copy), u12 (copy), u39 (copy), u15 (copy), Outline (copy), u41 (ref), u8 (copy), u40 (ref), pop (copy), u9 (copy), u10 (copy), u16 (copy), u19 (ref), EquipmentHudLayoutLegacy (copy)
    u21 = u21 + p43;

    if u21 < 0.05 then
        return;
    end;

    u21 = 0;
    local v44 = LocalPlayer:GetAttribute("InMatch") ~= true;
    local v45 = v44 and "Runner" or LocalPlayer:GetAttribute("GameRole");
    local v46 = GearCatalog.equippedForRole(u17, v45);
    local v47 = GearCatalog.get(v46);
    local v48;

    if u17.loaded == true and LocalPlayer:GetAttribute("ClientReady") == true then
        v48 = not ControlGate.reason(LocalPlayer);
    else
        v48 = false;
    end;

    local v49;

    if v48 then
        if v47 == nil or v47.Kind ~= "Ability" then
            v49 = false;
        else
            local v50 = not v44 and AbilityRule.blocked(LocalPlayer);
            v49 = not v50;
        end;
    else
        v49 = v48;
    end;

    u5.Visible = v49;
    local v51 = v44 and GearCatalog.get(GearCatalog.equippedForRole(u17, "Catcher")) or nil;

    if v48 then
        if v51 == nil then
            v48 = false;
        else
            v48 = v51.Kind == "Ability";
        end;
    end;

    u38.Visible = v48;

    if v51 then
        u38.Title.Text = string.upper(v51.Name);
        u38.Hint.Text = "EQUIPPED · CHASER";
        u38.Hint.TextColor3 = v51.Accent or Panels.Gold;
        u38.Charges.Text = "ABILITY";
        u38.Item.Visible = false;
        u38.AbilityIcon.Visible = true;
        u38.AbilityIcon.Image = v51.IconImage or "";
        u38.AbilityIcon.ImageRectOffset = v51.IconRectOffset or Vector2.zero;
        u38.AbilityIcon.ImageRectSize = v51.IconRectSize or Vector2.zero;
        u38.Outline.Color = v51.Accent or Panels.Gold;

        if u42 ~= u38.Outline.Color then
            u42 = u38.Outline.Color;
            u38.Gradient.Color = cardColors(u42);
        end;

        u38.Track.Fill.BackgroundColor3 = v51.Accent or Panels.Gold;
    end;

    local v52 = (LocalPlayer:GetAttribute("AbilityReadyAt") or 0) - workspace:GetServerTimeNow();
    local math_max_ret = math.max(0, v52);
    local v53;

    if v47 == nil or v47.Charges == nil then
        v53 = false;
    else
        v53 = not v44 and (LocalPlayer:GetAttribute("AbilityCharges") or (v47.StartCharges or v47.Charges)) == 0;
    end;

    local v54 = active();

    if v54 then
        if math_max_ret == 0 and u18 <= os.clock() then
            v54 = not v53;
        else
            v54 = false;
        end;
    end;

    u5.Active = v54 and true or false or v44;
    u38.Active = u38.Visible;

    if v47 then
        if u20 ~= v46 then
            u20 = v46;
            preview(v47);
        end;

        local v55 = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and "R1" or (UserInputService.PreferredInput == Enum.PreferredInput.Touch and "TAP" or "Q");
        u11.Text = string.upper(v47.Name);
        local v56;

        if v47.Charges and not v44 then
            v56 = LocalPlayer:GetAttribute("AbilityCharges") or v47.StartCharges or (v47.Charges or nil);
        else
            v56 = nil;
        end;

        local v57 = (LocalPlayer:GetAttribute("AbilityChargeAt") or 0) - workspace:GetServerTimeNow();
        local math_max_ret2 = math.max(0, v57);
        u13.Text = not v56 and "ABILITY" or v56 .. "/" .. v47.Charges;
        local v58 = v47.UseRole and v47.UseRole ~= LocalPlayer:GetAttribute("GameRole");
        u12.Text = v44 and "EQUIPPED · RUNNER" or (v58 and (v47.UseRole == "Catcher" and "CHASERS" or "RUNNERS") .. " ONLY" or v56 == 0 and not v47.EmptyCooldown and string.format("NEXT IN %.0fs", (math.ceil(math_max_ret2))) or (math_max_ret > 0 and v56 == 0 and string.format("ALL BACK IN %.0fs", (math.ceil(math_max_ret))) or math_max_ret > 0 and string.format("READY IN %.1fs", math_max_ret) or (v54 and v55 .. "  ·  LET’S GO!" or (LocalPlayer:GetAttribute("RunState") == "Caught" and "CAUGHT" or (LocalPlayer:GetAttribute("RunState") == "Active" and "NOT READY" or "WAIT FOR ROUND")))));
        local v59;

        if v56 == nil or (v56 <= 0 or (v56 >= v47.Charges or (v47.ChargeSeconds == nil or math_max_ret2 <= 0))) then
            v59 = false;
        else
            v59 = not v58 and LocalPlayer:GetAttribute("RunState") == "Active";
        end;

        u39.Visible = v59;

        if v59 then
            u39.Text = string.format("NEXT IN %.0fs", (math.ceil(math_max_ret2)));
        end;

        u12.Position = UDim2.fromOffset(81, v59 and 44 or 48);
        local v60 = v47.Accent or Panels.Gold;
        u12.TextColor3 = v60;
        u15.BackgroundColor3 = v60;
        Outline.Color = v60;

        if u41 ~= v60 then
            u41 = v60;
            u8.Color = cardColors(v60);
        end;

        local v61 = v47.Charges and LocalPlayer:GetAttribute("AbilityCooldown") or (v47.Cooldown or 12);

        if v53 and v47.ChargeSeconds then
            u15.Size = UDim2.fromScale(math.clamp(1 - math_max_ret2 / v47.ChargeSeconds, 0, 1), 1);
        else
            u15.Size = UDim2.fromScale(math.clamp(1 - math_max_ret / v61, 0, 1), 1);
        end;
    end;

    if v54 and (not u40 and u5.Visible) then
        pop();
    end;

    u40 = v54;
    local v62;

    if v54 then
        local v63 = os.clock() * 3;
        v62 = math.sin(v63) * 0.12 + 0.25 or 0.65;
    else
        v62 = 0.65;
    end;

    Outline.Transparency = v62;
    u11.TextTransparency = v54 and 0 or 0.3;
    u9.ImageTransparency = v54 and 0 or 0.35;
    u10.ImageTransparency = v54 and 0 or 0.35;
    u16.Visible = os.clock() < u19;
    EquipmentHudLayoutLegacy.update(LocalPlayer.PlayerGui);
end));
script.Destroying:Connect(function() -- Line: 340
    -- upvalues: u22 (copy), u4 (copy)
    for _, v in u22 do
        v:Disconnect();
    end;

    u4:Destroy();
end);
ChickenOrHero.Weapons.ArmoryEvent:FireServer("Get");