  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Promise = require(PathShortcuts.KnitPath.Promise);
local Signal = require(PathShortcuts.KnitPath.Signal);
Knit.OnStart():await();
script.Parent:WaitForChild("Sounds");
script.Parent:WaitForChild("Menus");
local UIHandler = require(ReplicatedStorage.ReplicatedModules.UIHandler);
UIHandler.ClockCaches = {};
UIHandler.ClockSignal = Signal.new();
UIHandler.CurrencyUpdated = Signal.new();
UIHandler.InputTypeChanged = Signal.new();
Knit.GetService("ShopService").CurrencyUpdated:Connect(function(...) -- Line: 23
    -- upvalues: UIHandler (copy)
    UIHandler.CurrencyUpdated:Fire(...);
end);
local u1 = PathShortcuts.LinkedPlaces[game.GameId];

local function isGameModePlace() -- Line: 28
    -- upvalues: u1 (copy)
    if u1 then
        return game.PlaceId == u1.GameModePlace;
    end;

    return false;
end;

game:GetService("RunService").PreRender:Connect(function(p2) -- Line: 35
    -- upvalues: UIHandler (copy)
    UIHandler.ClockSignal:Fire("PreRender", p2);

    for _, v in UIHandler.ClockCaches do
        if v.Type == "PreRender" then
            v.TimeCounter = v.TimeCounter + p2;

            if v.TimeCounter >= v.RefreshTime then
                v.TimeCounter = 0;
                task.spawn(v.Callback, unpack(v.Args));
            end;
        end;
    end;
end);

function UIHandler.BindToClock(p3, p4, p5, p6, ...) -- Line: 49
    -- upvalues: UIHandler (copy)
    if UIHandler.ClockCaches[p3] then
        warn(p3, "already binded to clock");
    end;

    UIHandler.ClockCaches[p3] = {
        TimeCounter = 0,
        RefreshTime = p4,
        Type = p5,
        Callback = p6,
        Args = { ... }
    };
end;

UIHandler.Knit = Knit;
UIHandler.KnitPath = PathShortcuts.KnitPath;
UIHandler.PathShortcuts = PathShortcuts;
UIHandler.Xtal = require(game:GetService("ReplicatedStorage"):WaitForChild("Xtal"));
UIHandler.Player = game:GetService("Players").LocalPlayer;
UIHandler.Data = UIHandler.Player:WaitForChild("Data");
UIHandler.Cache = {};
UIHandler.Character = nil;
UIHandler.RootPart = nil;
UIHandler.Humanoid = nil;
UIHandler.UI = script.Parent;
UIHandler.LegacyUI = UIHandler.Player.PlayerGui:WaitForChild("Core", 5);
UIHandler.Camera = workspace.CurrentCamera;

local function CharacterAdded(u7) -- Line: 79
    -- upvalues: UIHandler (copy), u1 (copy)
    UIHandler.Character = u7;
    task.spawn(function() -- Line: 82
        -- upvalues: UIHandler (ref), u7 (copy)
        UIHandler.RootPart = u7:WaitForChild("HumanoidRootPart", 5);
    end);
    task.spawn(function() -- Line: 86
        -- upvalues: UIHandler (ref), u7 (copy)
        UIHandler.Humanoid = u7:WaitForChild("Humanoid", 5);
    end);
    local StarterGui = game:GetService("StarterGui");
    local RunService = game:GetService("RunService");

    local function CoreCall(p8, ...) -- Line: 94
        -- upvalues: StarterGui (copy), RunService (copy)
        local v9 = {};

        for _ = 1, 3 do
            v9 = { pcall(StarterGui[p8], StarterGui, ...) };

            if v9[1] then
                break;
            end;

            RunService.Stepped:Wait();
        end;

        return unpack(v9);
    end;

    local u10 = true;

    local function UpdateResetButtonState() -- Line: 108
        -- upvalues: u1 (ref), u10 (ref), u7 (copy)
        local v11;

        if u1 then
            v11 = game.PlaceId == u1.GameModePlace;
        else
            v11 = false;
        end;

        if v11 then
            u10 = false;

            return;
        end;

        u10 = not (u7:GetAttribute("MoveActive") or u7:GetAttribute("InCombat"));
    end;

    pcall(function() -- Line: 116
        -- upvalues: u7 (copy), u1 (ref), u10 (ref)
        u7:GetAttributeChangedSignal("MoveActive"):Connect(function() -- Line: 117
            -- upvalues: u1 (ref), u10 (ref), u7 (ref)
            local v12;

            if u1 then
                v12 = game.PlaceId == u1.GameModePlace;
            else
                v12 = false;
            end;

            if v12 then
                u10 = false;

                return;
            end;

            u10 = not (u7:GetAttribute("MoveActive") or u7:GetAttribute("InCombat"));
        end);
        u7:GetAttributeChangedSignal("InCombat"):Connect(function() -- Line: 121
            -- upvalues: u1 (ref), u10 (ref), u7 (ref)
            local v13;

            if u1 then
                v13 = game.PlaceId == u1.GameModePlace;
            else
                v13 = false;
            end;

            if v13 then
                u10 = false;

                return;
            end;

            u10 = not (u7:GetAttribute("MoveActive") or u7:GetAttribute("InCombat"));
        end);
    end);
    local v14;

    if u1 then
        v14 = game.PlaceId == u1.GameModePlace;
    else
        v14 = false;
    end;

    if v14 then
        u10 = false;
    else
        u10 = not (u7:GetAttribute("MoveActive") or u7:GetAttribute("InCombat"));
    end;

    task.spawn(function() -- Line: 128
        -- upvalues: u7 (copy), UIHandler (ref), CoreCall (copy), u10 (ref)
        local u15 = false;
        local u16 = nil;
        u16 = u7.AncestryChanged:Connect(function() -- Line: 131
            -- upvalues: u7 (ref), u16 (ref), u15 (ref)
            if not (u7.Parent and u7:IsDescendantOf(workspace)) then
                u16:Disconnect();
                u15 = true;
            end;
        end);

        while true do
            debug.profilebegin("ui_engine_buttoncallback");

            if not UIHandler or (not UIHandler.Character or u15) then
                break;
            end;

            CoreCall("SetCore", "ResetButtonCallback", u10);
            debug.profileend();
            task.wait(0.075);
        end;

        u16:Disconnect();
    end);
end;

if UIHandler.Player.Character then
    CharacterAdded(UIHandler.Player.Character);
end;

UIHandler.Player.CharacterAdded:Connect(CharacterAdded);

local function Load(u17) -- Line: 160
    -- upvalues: Promise (copy), UIHandler (copy), Load (copy)
    if u17:IsA("ModuleScript") then
        if string.find(u17.Name, "UI_", 1, true) and not u17:GetAttribute("Loaded") then
            Promise.try(require(u17), UIHandler):catch(function(p18) -- Line: 163
                -- upvalues: u17 (copy)
                warn(u17, "\n", p18);
            end);
            u17:SetAttribute("Loaded", true);
        end;
    else
        for _, child in pairs(u17:GetChildren()) do
            Load(child);
        end;
    end;
end;

local RoactRodux = PathShortcuts.ClientLibrary.RoactRodux;
UIHandler.Roact = require(RoactRodux.Roact);
UIHandler.Rodux = require(RoactRodux.Rodux);
UIHandler.RoactRodux = require(RoactRodux.RoactRodux);
UIHandler.RoactComponents = {};

for _, child in ipairs(script.Parent.RoactComponents:GetChildren()) do
    UIHandler.RoactComponents[child.Name] = require(child);
end;

UIHandler.Fusion = require(PathShortcuts.ClientLibrary.Fusion);
UIHandler.FusionComponents = {};

for _, child in ipairs(script.Parent.FusionComponents:GetChildren()) do
    UIHandler.FusionComponents[child.Name] = require(child);
end;

Load(script);
Load(UIHandler.UI);
local UserInputService = game:GetService("UserInputService");
UserInputService.InputBegan:Connect(function(p19) -- Line: 197
    -- upvalues: UserInputService (copy)
    if p19.KeyCode == Enum.KeyCode.C and (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
        script.Parent.Enabled = not script.Parent.Enabled;
    end;
end);