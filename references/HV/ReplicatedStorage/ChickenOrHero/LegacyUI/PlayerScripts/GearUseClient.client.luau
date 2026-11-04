 

 

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
local u1 = require(ChickenOrHero.Game:WaitForChild("FallenKingBossConfig")).Hearts.Count * 2;

local function inBossFight() -- Line: 18
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("BossHearts") ~= nil;
end;

local function kitHeals() -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (copy)
    local v2 = tonumber(LocalPlayer:GetAttribute("BossHearts"));
    local v3;

    if v2 == nil or (v2 <= 0 or v2 >= u1) then
        v3 = false;
    else
        v3 = LocalPlayer:GetAttribute("RunState") == "Active";
    end;

    return v3;
end;

local GearEvent = ChickenOrHero.Gear:WaitForChild("GearEvent");
local GearPredictionClient = require(ChickenOrHero.Gear:WaitForChild("GearPredictionClient"));
local HudNavigation = require(ChickenOrHero.Presentation:WaitForChild("HudNavigation"));
local u4 = Panels.screen(LocalPlayer, "GearControls", 63);
local u5 = Panels.button(u4, "Use", "", 0, 0, 226, 88, Panels.Ink);
u5.AnchorPoint = Vector2.new(1, 0.5);
u5.Position = UDim2.new(1, -24, 0.58, 0);
u5.AutoButtonColor = false;
Panels.stroke(u5, Panels.Gold, 0.25);
local Outline = u5:FindFirstChild("Outline");
local surface = Skin.Palette.surface;

local function cardColors(p6) -- Line: 38
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
EquipmentHudLayoutLegacy.register(u5, v7, 3);
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
local Camera = Instance.new("Camera");
Camera.Parent = u9;
u9.CurrentCamera = Camera;
local WorldModel = Instance.new("WorldModel");
WorldModel.Parent = u9;
local u10 = Panels.make("ImageLabel", u5, "Icon", {
    BackgroundTransparency = 1,
    Visible = false,
    Position = UDim2.fromOffset(8, 7),
    Size = UDim2.fromOffset(66, 66),
    ScaleType = Enum.ScaleType.Fit
});
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
local Color3_fromRGB_ret = Color3.fromRGB(255, 80, 150);
local u17 = Panels.text(u5, "VowBlocked", "✕", 8, 7, 66, 66, 56, Color3_fromRGB_ret);
u17.Font = Enum.Font.GothamBlack;
u17.TextXAlignment = Enum.TextXAlignment.Center;
u17.TextStrokeTransparency = 0.2;
u17.ZIndex = u5.ZIndex + 5;
u17.Visible = false;
local u18 = {
    gear = {}
};
local u19 = 0;
local u20 = 0;
local u21 = nil;
local u22 = 0;
local u23 = {};

local function on(p24, p25) -- Line: 118
    -- upvalues: u23 (copy)
    table.insert(u23, p24:Connect(p25));
end;

local function noAbilities() -- Line: 123
    -- upvalues: LocalPlayer (copy), AbilityRule (copy)
    local v26;

    if LocalPlayer:GetAttribute("InMatch") == true then
        v26 = AbilityRule.blocked(LocalPlayer);
    else
        v26 = false;
    end;

    return v26;
end;

local Color3_fromRGB_ret2 = Color3.fromRGB(90, 210, 255);

local function soulReapOn() -- Line: 130
    -- upvalues: u18 (ref), GearCatalog (copy)
    local v27;

    if u18.loaded == true then
        v27 = GearCatalog.equippedForRole(u18, "Runner") == "SoulReap";
    else
        v27 = false;
    end;

    return v27;
end;

local function active() -- Line: 133
    -- upvalues: GearCatalog (copy), u18 (ref), LocalPlayer (copy), AbilityRule (copy), u1 (copy), ControlGate (copy), ChickenOrHero (copy)
    local v28 = GearCatalog.get(u18.equippedGear);
    local v29;

    if v28 then
        local v30;

        if LocalPlayer:GetAttribute("InMatch") == true then
            v30 = AbilityRule.blocked(LocalPlayer);
        else
            v30 = false;
        end;

        v29 = not v30;

        if v29 then
            if v28.Kind == "Ability" or (u18.gear[u18.equippedGear] or 0) <= 0 then
                v29 = false;
            else
                v29 = u18.loaded;

                if v29 then
                    if LocalPlayer:GetAttribute("InMatch") == true then
                        local v31;

                        if u18.equippedGear == "RescueKit" and LocalPlayer:GetAttribute("BossHearts") ~= nil then
                            local v32 = tonumber(LocalPlayer:GetAttribute("BossHearts"));
                            local v33;

                            if v32 == nil or (v32 <= 0 or v32 >= u1) then
                                v33 = false;
                            else
                                v33 = LocalPlayer:GetAttribute("RunState") == "Active";
                            end;

                            if v33 then
                                if v28.UseRole and LocalPlayer:GetAttribute("GameRole") ~= v28.UseRole or ControlGate.reason(LocalPlayer) and (u18.equippedGear ~= "RescueKit" or ControlGate.reason(LocalPlayer) ~= "Spectating") then
                                    v29 = false;
                                else
                                    v29 = not ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") and not ChickenOrHero.Game.Session:GetAttribute("MapChanging");
                                end;
                            elseif u18.equippedGear == "RescueKit" and (LocalPlayer:GetAttribute("BossHearts") == nil and (LocalPlayer:GetAttribute("RunState") == "Caught" and (LocalPlayer.Character and (LocalPlayer.Character:GetAttribute("RescueAvailable") == true and LocalPlayer.Character:GetAttribute("VowMarked") ~= true)))) then
                                if u18.loaded == true then
                                    v31 = GearCatalog.equippedForRole(u18, "Runner") == "SoulReap";
                                else
                                    v31 = false;
                                end;

                                if v31 then
                                    if u18.equippedGear == "RescueKit" or LocalPlayer:GetAttribute("RunState") ~= "Active" then
                                        v29 = false;
                                    elseif v28.UseRole and LocalPlayer:GetAttribute("GameRole") ~= v28.UseRole or ControlGate.reason(LocalPlayer) and (u18.equippedGear ~= "RescueKit" or ControlGate.reason(LocalPlayer) ~= "Spectating") then
                                        v29 = false;
                                    else
                                        v29 = not ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") and not ChickenOrHero.Game.Session:GetAttribute("MapChanging");
                                    end;
                                elseif v28.UseRole and LocalPlayer:GetAttribute("GameRole") ~= v28.UseRole or ControlGate.reason(LocalPlayer) and (u18.equippedGear ~= "RescueKit" or ControlGate.reason(LocalPlayer) ~= "Spectating") then
                                    v29 = false;
                                else
                                    v29 = not ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") and not ChickenOrHero.Game.Session:GetAttribute("MapChanging");
                                end;
                            elseif u18.equippedGear == "RescueKit" or LocalPlayer:GetAttribute("RunState") ~= "Active" then
                                v29 = false;
                            elseif v28.UseRole and LocalPlayer:GetAttribute("GameRole") ~= v28.UseRole or ControlGate.reason(LocalPlayer) and (u18.equippedGear ~= "RescueKit" or ControlGate.reason(LocalPlayer) ~= "Spectating") then
                                v29 = false;
                            else
                                v29 = not ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") and not ChickenOrHero.Game.Session:GetAttribute("MapChanging");
                            end;
                        elseif u18.equippedGear == "RescueKit" and (LocalPlayer:GetAttribute("BossHearts") == nil and (LocalPlayer:GetAttribute("RunState") == "Caught" and (LocalPlayer.Character and (LocalPlayer.Character:GetAttribute("RescueAvailable") == true and LocalPlayer.Character:GetAttribute("VowMarked") ~= true)))) then
                            if u18.loaded == true then
                                v31 = GearCatalog.equippedForRole(u18, "Runner") == "SoulReap";
                            else
                                v31 = false;
                            end;

                            if v31 then
                                if u18.equippedGear == "RescueKit" or LocalPlayer:GetAttribute("RunState") ~= "Active" then
                                    v29 = false;
                                elseif v28.UseRole and LocalPlayer:GetAttribute("GameRole") ~= v28.UseRole or ControlGate.reason(LocalPlayer) and (u18.equippedGear ~= "RescueKit" or ControlGate.reason(LocalPlayer) ~= "Spectating") then
                                    v29 = false;
                                else
                                    v29 = not ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") and not ChickenOrHero.Game.Session:GetAttribute("MapChanging");
                                end;
                            elseif v28.UseRole and LocalPlayer:GetAttribute("GameRole") ~= v28.UseRole or ControlGate.reason(LocalPlayer) and (u18.equippedGear ~= "RescueKit" or ControlGate.reason(LocalPlayer) ~= "Spectating") then
                                v29 = false;
                            else
                                v29 = not ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") and not ChickenOrHero.Game.Session:GetAttribute("MapChanging");
                            end;
                        elseif u18.equippedGear == "RescueKit" or LocalPlayer:GetAttribute("RunState") ~= "Active" then
                            v29 = false;
                        elseif v28.UseRole and LocalPlayer:GetAttribute("GameRole") ~= v28.UseRole or ControlGate.reason(LocalPlayer) and (u18.equippedGear ~= "RescueKit" or ControlGate.reason(LocalPlayer) ~= "Spectating") then
                            v29 = false;
                        else
                            v29 = not ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") and not ChickenOrHero.Game.Session:GetAttribute("MapChanging");
                        end;
                    else
                        v29 = false;
                    end;
                end;
            end;
        end;
    else
        v29 = v28;
    end;

    return v29;
end;

local function pop() -- Line: 149
    -- upvalues: TweenService (copy), u5 (copy)
    TweenService:Create(u5, TweenInfo.new(0.08), {
        Rotation = -3
    }):Play();
    task.delay(0.08, function() -- Line: 151
        -- upvalues: u5 (ref), TweenService (ref)
        if u5.Parent then
            TweenService:Create(u5, TweenInfo.new(0.22, Enum.EasingStyle.Back), {
                Rotation = 0
            }):Play();
        end;
    end);
end;

local function vowBlocked() -- Line: 157
    -- upvalues: LocalPlayer (copy), u18 (ref)
    local Character = LocalPlayer.Character;
    local v34;

    if u18.equippedGear == "RescueKit" and (u18.loaded == true and ((u18.gear.RescueKit or 0) > 0 and (LocalPlayer:GetAttribute("InMatch") == true and (LocalPlayer:GetAttribute("RunState") == "Caught" and Character ~= nil)))) then
        v34 = Character:GetAttribute("VowMarked") == true;
    else
        v34 = false;
    end;

    return v34;
end;

local function vowNotice() -- Line: 167
    -- upvalues: u16 (copy), Color3_fromRGB_ret (copy), u20 (ref)
    u16.Text = "VOW BROKEN · Your Rescue Kit can\'t save you. Another runner can.";
    u16.TextColor3 = Color3_fromRGB_ret;
    u20 = os.clock() + 4;
end;

local function soulBlocked() -- Line: 172
    -- upvalues: u18 (ref), LocalPlayer (copy), GearCatalog (copy)
    local v35;

    if u18.equippedGear == "RescueKit" and ((u18.gear.RescueKit or 0) > 0 and LocalPlayer:GetAttribute("InMatch") == true) then
        v35 = LocalPlayer:GetAttribute("BossHearts") == nil;

        if v35 then
            if u18.loaded == true then
                v35 = GearCatalog.equippedForRole(u18, "Runner") == "SoulReap";
            else
                v35 = false;
            end;
        end;
    else
        v35 = false;
    end;

    return v35;
end;

local function soulFail() -- Line: 179
    -- upvalues: u16 (copy), Color3_fromRGB_ret2 (copy), u20 (ref), TweenService (copy), u5 (copy)
    u16.Text = "SOUL REAP · No self-revive while Soul Reap is equipped.";
    u16.TextColor3 = Color3_fromRGB_ret2;
    u20 = os.clock() + 4;
    task.spawn(function() -- Line: 183
        -- upvalues: TweenService (ref), u5 (ref)
        for _, v in { -7, 7, -5, 4, 0 } do
            TweenService:Create(u5, TweenInfo.new(0.05), {
                Rotation = v
            }):Play();
            task.wait(0.05);
        end;
    end);
end;

local u36 = (-1 / 0);

local function vowFail() -- Line: 191
    -- upvalues: u16 (copy), Color3_fromRGB_ret (copy), u20 (ref), TweenService (copy), u5 (copy), u36 (ref), ChickenOrHero (copy)
    u16.Text = "VOW BROKEN · Your Rescue Kit can\'t save you. Another runner can.";
    u16.TextColor3 = Color3_fromRGB_ret;
    u20 = os.clock() + 4;
    task.spawn(function() -- Line: 193
        -- upvalues: TweenService (ref), u5 (ref)
        for _, v in { -7, 7, -5, 4, 0 } do
            TweenService:Create(u5, TweenInfo.new(0.05), {
                Rotation = v
            }):Play();
            task.wait(0.05);
        end;
    end);

    if os.clock() - u36 >= 1 then
        u36 = os.clock();
        local VowAbilityEvent = ChickenOrHero.Weapons:FindFirstChild("VowAbilityEvent");

        if VowAbilityEvent then
            VowAbilityEvent:FireServer("Fizzle");
        end;
    end;
end;

local function request() -- Line: 207
    -- upvalues: LocalPlayer (copy), AbilityRule (copy), vowBlocked (copy), vowFail (copy), u18 (ref), GearCatalog (copy), u16 (copy), Color3_fromRGB_ret2 (copy), u20 (ref), TweenService (copy), u5 (copy), active (copy), u19 (ref), pop (copy), GearPredictionClient (copy)
    local v37;

    if LocalPlayer:GetAttribute("InMatch") == true then
        v37 = AbilityRule.blocked(LocalPlayer);
    else
        v37 = false;
    end;

    if v37 then
        return;
    end;

    if vowBlocked() then
        vowFail();

        return;
    end;

    local v38;

    if u18.equippedGear == "RescueKit" and ((u18.gear.RescueKit or 0) > 0 and LocalPlayer:GetAttribute("InMatch") == true) then
        v38 = LocalPlayer:GetAttribute("BossHearts") == nil;

        if v38 then
            if u18.loaded == true then
                v38 = GearCatalog.equippedForRole(u18, "Runner") == "SoulReap";
            else
                v38 = false;
            end;
        end;
    else
        v38 = false;
    end;

    if v38 and LocalPlayer:GetAttribute("RunState") == "Caught" then
        u16.Text = "SOUL REAP · No self-revive while Soul Reap is equipped.";
        u16.TextColor3 = Color3_fromRGB_ret2;
        u20 = os.clock() + 4;
        task.spawn(function() -- Line: 183
            -- upvalues: TweenService (ref), u5 (ref)
            for _, v in { -7, 7, -5, 4, 0 } do
                TweenService:Create(u5, TweenInfo.new(0.05), {
                    Rotation = v
                }):Play();
                task.wait(0.05);
            end;
        end);

        return;
    end;

    if not (active() and (os.clock() >= u19 and workspace:GetServerTimeNow() >= (LocalPlayer:GetAttribute("GearReadyAt") or 0))) then
        return;
    end;

    u19 = os.clock() + 0.6;
    pop();
    GearPredictionClient.request(u18.equippedGear, nil, "Use");
end;

local function preview(p39) -- Line: 230
    -- upvalues: WorldModel (copy), u10 (copy), u9 (copy), ChickenOrHero (copy), u18 (ref), Camera (copy)
    WorldModel:ClearAllChildren();
    local v40;

    if type(p39.IconImage) == "string" and p39.IconImage ~= "" then
        v40 = p39.IconImage or nil;
    else
        v40 = nil;
    end;

    u10.Image = v40 or "";
    u10.Visible = v40 ~= nil;
    u9.Visible = v40 == nil;

    if v40 then
        return;
    end;

    local v41 = ChickenOrHero.Gear.Assets:FindFirstChild(p39.Preview or u18.equippedGear);

    if not v41 then
        return;
    end;

    local Model = Instance.new("Model");
    local v42 = v41:Clone();

    for _, descendant in v42:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
        end;
    end;

    if v42:IsA("BasePart") then
        v42.Anchored = true;
    end;

    v42.Parent = Model;
    Model.Parent = WorldModel;
    local BoundingBox, v43 = Model:GetBoundingBox();
    local v44 = math.max(v43.X, v43.Y, v43.Z) * 1.8;
    Camera.CFrame = CFrame.lookAt(BoundingBox.Position + Vector3.new(v44 * 0.65, v44 * 0.35, v44), BoundingBox.Position);
    Camera.FieldOfView = 40;
end;

table.insert(u23, u5.Activated:Connect(function() -- Line: 264
    -- upvalues: LocalPlayer (copy), HudNavigation (copy), request (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        request();

        return;
    end;

    HudNavigation.activate("Items");
end));
table.insert(u23, u5.MouseEnter:Connect(function() -- Line: 271
    -- upvalues: TweenService (copy), u8 (copy)
    TweenService:Create(u8, TweenInfo.new(0.2), {
        Rotation = 65
    }):Play();
end));
table.insert(u23, u5.MouseLeave:Connect(function() -- Line: 274
    -- upvalues: TweenService (copy), u8 (copy)
    TweenService:Create(u8, TweenInfo.new(0.2), {
        Rotation = 25
    }):Play();
end));
table.insert(u23, UserInputService.InputBegan:Connect(function(p45, p46) -- Line: 277
    -- upvalues: UserInputService (copy), request (copy)
    if not (p46 or (UserInputService:GetFocusedTextBox() or p45.KeyCode ~= Enum.KeyCode.C and p45.KeyCode ~= Enum.KeyCode.ButtonB)) then
        request();
    end;
end));
table.insert(u23, ChickenOrHero.Weapons.ArmoryEvent.OnClientEvent:Connect(function(p47, p48) -- Line: 286
    -- upvalues: u18 (ref)
    if p47 == "State" and type(p48) == "table" then
        u18 = p48;
        u18.gear = u18.gear or {};
    end;
end));
table.insert(u23, GearEvent.OnClientEvent:Connect(function(p49, p50) -- Line: 292
    -- upvalues: u16 (copy), Panels (copy), u20 (ref), u19 (ref)
    if p49 == "Notice" and type(p50) == "string" then
        u16.Text = p50;
        u16.TextColor3 = Panels.Gold;
        u20 = os.clock() + 4;
        u19 = 0;
    end;
end));
local u51 = false;
local u52 = false;
local u53 = nil;
table.insert(u23, RunService.Heartbeat:Connect(function(p54) -- Line: 302
    -- upvalues: u22 (ref), GearCatalog (copy), u18 (ref), LocalPlayer (copy), u5 (copy), AbilityRule (copy), ControlGate (copy), active (copy), u19 (ref), vowBlocked (copy), u17 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u52 (ref), u16 (copy), u20 (ref), u21 (ref), preview (copy), UserInputService (copy), u11 (copy), u13 (copy), u12 (copy), u1 (copy), Panels (copy), u15 (copy), Outline (copy), u53 (ref), u8 (copy), cardColors (copy), u51 (ref), pop (copy), u9 (copy), EquipmentHudLayoutLegacy (copy)
    u22 = u22 + p54;

    if u22 < 0.05 then
        return;
    end;

    u22 = 0;
    local v55 = GearCatalog.get(u18.equippedGear);
    local v56 = LocalPlayer:GetAttribute("InMatch") ~= true;
    local v57;

    if v55 == nil then
        v57 = false;
    else
        local v58;

        if LocalPlayer:GetAttribute("InMatch") == true then
            v58 = AbilityRule.blocked(LocalPlayer);
        else
            v58 = false;
        end;

        v57 = not v58;

        if v57 then
            if v55.Kind == "Ability" or (u18.loaded ~= true or LocalPlayer:GetAttribute("ClientReady") ~= true) then
                v57 = false;
            else
                v57 = not ControlGate.reason(LocalPlayer);

                if not v57 then
                    if u18.equippedGear == "RescueKit" then
                        v57 = ControlGate.reason(LocalPlayer) == "Spectating";
                    else
                        v57 = false;
                    end;
                end;
            end;
        end;
    end;

    u5.Visible = v57;
    local v59 = (LocalPlayer:GetAttribute("GearReadyAt") or 0) - workspace:GetServerTimeNow();
    local math_max_ret = math.max(0, v59);
    local v60 = active();

    if v60 then
        if math_max_ret == 0 then
            v60 = u19 <= os.clock();
        else
            v60 = false;
        end;
    end;

    local v61;

    if LocalPlayer:GetAttribute("InMatch") == true then
        v61 = AbilityRule.blocked(LocalPlayer);
    else
        v61 = false;
    end;

    local v62 = not v61 and vowBlocked();
    local v63;

    if LocalPlayer:GetAttribute("InMatch") == true then
        v63 = AbilityRule.blocked(LocalPlayer);
    else
        v63 = false;
    end;

    local v64 = not (v63 or v62);

    if v64 then
        if u18.equippedGear == "RescueKit" and ((u18.gear.RescueKit or 0) > 0 and LocalPlayer:GetAttribute("InMatch") == true) then
            v64 = LocalPlayer:GetAttribute("BossHearts") == nil;

            if v64 then
                if u18.loaded == true then
                    v64 = GearCatalog.equippedForRole(u18, "Runner") == "SoulReap";
                else
                    v64 = false;
                end;
            end;
        else
            v64 = false;
        end;
    end;

    u5.Active = v60 and true or false or (v62 or (v64 or v56));
    u17.Visible = v62 or v64;
    local v65;

    if v64 then
        v65 = Color3_fromRGB_ret2;
    else
        v65 = Color3_fromRGB_ret;
    end;

    u17.TextColor3 = v65;

    if v62 and not u52 then
        u16.Text = "VOW BROKEN · Your Rescue Kit can\'t save you. Another runner can.";
        u16.TextColor3 = Color3_fromRGB_ret;
        u20 = os.clock() + 4;
    end;

    u52 = v62;

    if v55 then
        if u21 ~= u18.equippedGear then
            u21 = u18.equippedGear;
            preview(v55);
        end;

        local v66 = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and "B" or (UserInputService.PreferredInput == Enum.PreferredInput.Touch and "TAP" or "C");
        u11.Text = string.upper(v55.Name);
        u13.Text = "×" .. tostring(u18.gear[u18.equippedGear] or 0);
        local v67 = v55.UseRole and v55.UseRole ~= LocalPlayer:GetAttribute("GameRole");
        local v68;

        if v56 then
            v68 = "EQUIPPED · ITEM";
        else
            v68 = v67 and (v55.UseRole == "Catcher" and "CHASERS" or "RUNNERS") .. " ONLY";

            if not v68 then
                if v62 or u18.equippedGear == "RescueKit" and (LocalPlayer.Character and LocalPlayer.Character:GetAttribute("VowMarked") == true) then
                    v68 = "VOW BROKEN · CAN\'T USE";
                elseif v64 then
                    v68 = "NO SELF-REVIVE";
                else
                    v68 = math_max_ret > 0 and string.format("READY IN %.1fs", math_max_ret);

                    if not v68 then
                        if u18.equippedGear == "RescueKit" and LocalPlayer:GetAttribute("BossHearts") ~= nil then
                            if v60 then
                                v68 = v66 .. "  ·  +1 HEART";
                            else
                                local v69 = tonumber(LocalPlayer:GetAttribute("BossHearts"));
                                local v70;

                                if v69 == nil or (v69 <= 0 or v69 >= u1) then
                                    v70 = false;
                                else
                                    v70 = LocalPlayer:GetAttribute("RunState") == "Active";
                                end;

                                v68 = v70 and "NOT READY" or (u1 <= (tonumber(LocalPlayer:GetAttribute("BossHearts")) or 0) and "HEARTS FULL" or "CAN\'T USE NOW");
                            end;

                            if not v68 then
                                v68 = u18.equippedGear == "RescueKit" and v60 and v66 .. "  ·  REVIVE YOURSELF" or (u18.equippedGear == "RescueKit" and LocalPlayer:GetAttribute("RunState") == "Active" and "USE WHEN DOWNED" or (v60 and v66 .. "  ·  LET’S GO!" or "NOT READY"));
                            end;
                        else
                            v68 = u18.equippedGear == "RescueKit" and v60 and v66 .. "  ·  REVIVE YOURSELF" or (u18.equippedGear == "RescueKit" and LocalPlayer:GetAttribute("RunState") == "Active" and "USE WHEN DOWNED" or (v60 and v66 .. "  ·  LET’S GO!" or "NOT READY"));
                        end;
                    end;
                end;
            end;
        end;

        u12.Text = v68;
        local v71;

        if v62 then
            v71 = Color3_fromRGB_ret;
        elseif v64 then
            v71 = Color3_fromRGB_ret2;
        else
            v71 = v55.Accent or Panels.Gold;
        end;

        u12.TextColor3 = v71;
        u15.BackgroundColor3 = v71;
        Outline.Color = v71;

        if u53 ~= v71 then
            u53 = v71;
            u8.Color = cardColors(v71);
        end;

        u15.Size = UDim2.fromScale(math.clamp(1 - math_max_ret / (v55.Cooldown or 12), 0, 1), 1);
    end;

    if v60 and (not u51 and u5.Visible) then
        pop();
    end;

    u51 = v60;
    local v72;

    if v60 then
        local v73 = os.clock() * 3;
        v72 = math.sin(v73) * 0.12 + 0.25 or 0.65;
    else
        v72 = 0.65;
    end;

    Outline.Transparency = v72;
    u11.TextTransparency = v60 and 0 or 0.3;
    u9.ImageTransparency = v60 and 0 or 0.35;
    u16.Visible = os.clock() < u20;
    EquipmentHudLayoutLegacy.update(LocalPlayer.PlayerGui);
end));
script.Destroying:Connect(function() -- Line: 370
    -- upvalues: u23 (copy), u4 (copy)
    for _, v in u23 do
        v:Disconnect();
    end;

    u4:Destroy();
end);
ChickenOrHero.Weapons.ArmoryEvent:FireServer("Get");