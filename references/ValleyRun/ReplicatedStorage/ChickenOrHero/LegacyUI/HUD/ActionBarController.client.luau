 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local HudStyle = require(Presentation:WaitForChild("HudStyle"));
local DashMeterModel = require(Presentation:WaitForChild("DashMeterModel"));
local CatchMeterModel = require(Presentation:WaitForChild("CatchMeterModel"));
local TackleProfile = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("TackleProfile"));
local Tackle = require(ChickenOrHero.Game.GameConfig).Tackle;
local MovementProfiles = require(ChickenOrHero.Movement:WaitForChild("MovementProfiles"));
local BoostInput = require(ChickenOrHero.Movement:WaitForChild("BoostInput"));
local ControlGate = require(ChickenOrHero.Movement:WaitForChild("ControlGate"));
local BarMainFrame = script.Parent:WaitForChild("MainFrame"):WaitForChild("BarMainFrame");
local Bar = BarMainFrame:WaitForChild("BarBG"):WaitForChild("Bar");
local Status = BarMainFrame:WaitForChild("Status");
local Hint = BarMainFrame:WaitForChild("Hint");
local ControlPrompt = BarMainFrame:WaitForChild("ControlPrompt");
local MeleeControl = BarMainFrame:WaitForChild("MeleeControl");
local u1 = MeleeControl:FindFirstChildWhichIsA("ImageLabel");
local u2;

if u1 then
    u2 = u1.Image;
else
    u2 = u1;
end;

local u3 = nil;
local u4 = 0;
local u5 = false;
local u6 = nil;
local u7 = {};

local function update() -- Line: 29
    -- upvalues: LocalPlayer (copy), BarMainFrame (copy), u6 (ref), u5 (ref), BoostInput (copy), MeleeControl (copy), u1 (copy), u3 (ref), u2 (copy), TackleProfile (copy), Tackle (copy), MovementProfiles (copy), CatchMeterModel (copy), ControlGate (copy), DashMeterModel (copy), HudStyle (copy), Status (copy), Hint (copy), Bar (copy), ControlPrompt (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local v8;

    if Character then
        v8 = Character:FindFirstChildOfClass("Humanoid");
    else
        v8 = Character;
    end;

    local v9;

    if Character then
        v9 = Character:FindFirstChild("HumanoidRootPart");
    else
        v9 = Character;
    end;

    local v10;

    if v8 == nil or (v8.Health <= 0 or v9 == nil) then
        v10 = false;
    else
        v10 = LocalPlayer:GetAttribute("ReleaseCameraForUI") ~= true;
    end;

    BarMainFrame.Visible = v10;

    if not BarMainFrame.Visible then
        u6 = nil;
        u5 = false;

        return;
    end;

    if u6 ~= Character then
        u6 = Character;
        u5 = false;
    end;

    local v11 = v9.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
    local v12 = Character:GetAttribute("MovementLocked") == true and true or (v9.Anchored or (Character:GetAttribute("TackleActive") == true and true or (v8.Sit or v8.PlatformStand or (game.GuiService.MenuIsOpen or (game.UserInputService:GetFocusedTextBox() ~= nil and true or not BoostInput.available(LocalPlayer))))));
    local v13 = LocalPlayer:GetAttribute("GameRole") == "Catcher";
    local PreferredInput = game.UserInputService.PreferredInput;
    local v14;

    if v13 then
        v14 = PreferredInput ~= Enum.PreferredInput.Touch;
    else
        v14 = v13;
    end;

    MeleeControl.Visible = v14;

    if u1 and PreferredInput ~= u3 then
        u3 = PreferredInput;

        if PreferredInput == Enum.PreferredInput.Gamepad then
            local success, result = pcall(game.UserInputService.GetImageForKeyCode, game.UserInputService, Enum.KeyCode.ButtonL2);
            u1.Image = not (success and (result ~= "" and result)) and "rbxasset://textures/ui/Controls/xboxLT.png" or result;
        else
            u1.Image = u2;
        end;
    end;

    local v15;

    if v13 then
        v15 = PreferredInput == Enum.PreferredInput.Touch and "Tap CATCH" or (PreferredInput == Enum.PreferredInput.Gamepad and "RT / R2" or "Space");
    else
        v15 = BoostInput.control();
    end;

    local v16;

    if v13 then
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v17 = Character:GetAttribute("TackleActive") == true;
        local v18 = v17 and Character:GetAttribute("TackleVariant") or TackleProfile.select(Tackle, v11.Magnitude, MovementProfiles.get("Catcher", LocalPlayer).MaxSpeed).Name;
        local read = CatchMeterModel.read;
        local v19 = {};
        local v20 = (LocalPlayer:GetAttribute("TackleReadyAt") or 0) - ServerTimeNow;
        v19.cooldown = math.max(0, v20);
        v19.active = v17;
        v19.elapsed = ServerTimeNow - (Character:GetAttribute("TackleStartedAt") or ServerTimeNow);
        v19.duration = Character:GetAttribute("TackleDuration") or Tackle.Duration;
        v19.variant = v18;
        v19.control = v15;
        v19.grounded = v8.FloorMaterial ~= Enum.Material.Air;
        local v21;

        if LocalPlayer:GetAttribute("RunState") == "Active" and Character:GetAttribute("MovementLocked") ~= true then
            v21 = v8.Sit or (v8.PlatformStand or game.GuiService.MenuIsOpen);

            if not v21 then
                if game.UserInputService:GetFocusedTextBox() == nil and ControlGate.reason(LocalPlayer) == nil then
                    v21 = v9.Anchored and not v17;
                else
                    v21 = true;
                end;
            end;
        else
            v21 = true;
        end;

        v19.paused = v21;
        v16 = read(v19, Tackle);
    else
        local read = DashMeterModel.read;
        local v22 = {};
        local v23 = (Character:GetAttribute("DashCooldownUntil") or 0) - os.clock();
        v22.cooldown = math.max(0, v23);
        local v24 = (Character:GetAttribute("BoostRecoveryUntil") or 0) - os.clock();
        v22.recovery = math.max(0, v24);
        v22.boosting = Character:GetAttribute("MovementState") == "Boosting";
        v22.control = v15;
        v22.ready = Character:GetAttribute("DashReady") == true;
        v22.speed = v11.Magnitude;
        v22.grounded = v8.FloorMaterial ~= Enum.Material.Air;
        v22.paused = v12;
        v16 = read(v22, MovementProfiles.get(LocalPlayer:GetAttribute("GameRole"), LocalPlayer));
    end;

    if v13 and v16.ready then
        v16.hint = "Tag in front  ·  " .. v15 .. " to dive";
    end;

    local v25 = HudStyle.Colors[v16.tone];
    Status.Text = v16.label;
    Hint.Text = v16.hint;
    Status.TextColor3 = v25;
    Bar.BackgroundColor3 = v25;
    Bar.Size = UDim2.fromScale(v16.fill, 1);
    local v26 = v16.ready == true;
    ControlPrompt.Visible = PreferredInput ~= Enum.PreferredInput.Touch;
    local v27 = v13 and "CATCH" or "DASH";
    ControlPrompt.Text = v26 and "PRESS " .. string.upper(v15) .. " TO " .. v27 or string.upper(v15) .. "  ·  " .. v27;
    ControlPrompt.TextColor3 = v26 and HudStyle.Colors.Text or HudStyle.Colors.Muted;

    if v26 and not u5 then
        Bar.BackgroundTransparency = 0.25;
        TweenService:Create(Bar, TweenInfo.new(0.25), {
            BackgroundTransparency = 0
        }):Play();
    end;

    u5 = v26;
end;

table.insert(u7, RunService.RenderStepped:Connect(function(p28) -- Line: 86
    -- upvalues: u4 (ref), update (copy)
    u4 = u4 + p28;

    if u4 < 0.03333333333333333 then
        return;
    end;

    u4 = 0;
    update();
end));
script.Destroying:Connect(function() -- Line: 89
    -- upvalues: u7 (copy)
    for _, v in u7 do
        v:Disconnect();
    end;
end);
update();