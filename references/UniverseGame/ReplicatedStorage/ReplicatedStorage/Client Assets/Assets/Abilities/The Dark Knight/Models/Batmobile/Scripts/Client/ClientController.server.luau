  

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Constants = require(script.Parent.Parent.Constants);
local Controller = require(script.Parent.Parent.Controller);
local Camera = require(script.Parent.Camera);
local Input = require(script.Parent.Input);
local Speedometer = require(script.Parent.Speedometer);
local setJumpingEnabled = require(script.setJumpingEnabled);
local disconnectAndClear = require(script.Parent.disconnectAndClear);
local DestructionHandler = script.DestructionHandler;
local LocalPlayer = Players.LocalPlayer;
local Parent = script.Parent.Parent.Parent;
local DriverSeat = Parent.DriverSeat;
local Engine = Parent.Engine;
local SetNitroEnabled = Parent.Remotes.SetNitroEnabled;
local DriveAnimation = Parent.Animations.DriveAnimation;
local u1 = false;
local u2 = {};
local u3 = nil;

local function startControlling() -- Line: 27
    -- upvalues: u1 (ref), LocalPlayer (copy), setJumpingEnabled (copy), u3 (ref), DriveAnimation (copy), u2 (copy), RunService (copy), Controller (copy), Engine (copy), Constants (copy), SetNitroEnabled (copy), Camera (copy), Input (copy), Speedometer (copy)
    if u1 then
        return;
    end;

    u1 = true;
    local Character = LocalPlayer.Character;

    if Character then
        setJumpingEnabled(Character, false);
        local v4 = Character:FindFirstChildOfClass("Humanoid");
        local v5 = v4 and v4:FindFirstChildOfClass("Animator");

        if v5 then
            u3 = v5:LoadAnimation(DriveAnimation);
            u3:Play();
        end;
    end;

    table.insert(u2, RunService.Stepped:Connect(function(p6, p7) -- Line: 54
        -- upvalues: Controller (ref)
        Controller:update(p7);
    end));
    local v8 = Engine:GetAttributeChangedSignal(Constants.NITRO_ENABLED_ATTRIBUTE);
    table.insert(u2, v8:Connect(function() -- Line: 62
        -- upvalues: Engine (ref), Constants (ref), SetNitroEnabled (ref)
        SetNitroEnabled:FireServer((Engine:GetAttribute(Constants.NITRO_ENABLED_ATTRIBUTE)));
    end));
    Camera:enable();
    Input:enable();
    Speedometer:enable();
end;

local function stopControlling() -- Line: 75
    -- upvalues: u1 (ref), Camera (copy), Input (copy), Speedometer (copy), disconnectAndClear (copy), u2 (copy), Parent (copy), Controller (copy), LocalPlayer (copy), setJumpingEnabled (copy), u3 (ref)
    if not u1 then
        return;
    end;

    u1 = false;
    Camera:disable();
    Input:disable();
    Speedometer:disable();
    disconnectAndClear(u2);

    if Parent:IsDescendantOf(game) then
        Controller:reset();
    end;

    local Character = LocalPlayer.Character;

    if Character then
        setJumpingEnabled(Character, true);
    end;

    if u3 then
        u3:Stop();
        u3 = nil;
    end;
end;

local function setupDestructionHandler() -- Line: 131
    -- upvalues: DestructionHandler (copy), LocalPlayer (copy), Parent (copy), stopControlling (copy)
    local u9 = DestructionHandler:Clone();
    u9.Parent = LocalPlayer.PlayerScripts;
    u9.Enabled = true;
    task.defer(function() -- Line: 137
        -- upvalues: u9 (copy), Parent (ref), stopControlling (ref)
        u9.BindToCar:Fire(Parent, stopControlling);
    end);
end;

local u10 = DestructionHandler:Clone();
u10.Parent = LocalPlayer.PlayerScripts;
u10.Enabled = true;
task.defer(function() -- Line: 137
    -- upvalues: u10 (copy), Parent (copy), stopControlling (copy)
    u10.BindToCar:Fire(Parent, stopControlling);
end);
DriverSeat:GetPropertyChangedSignal("Occupant"):Connect(function() -- Line: 108, Name: onOccupantChanged
    -- upvalues: DriverSeat (copy), Players (copy), LocalPlayer (copy), startControlling (copy), stopControlling (copy)
    local Occupant = DriverSeat.Occupant;

    if Occupant and Players:GetPlayerFromCharacter(Occupant.Parent) == LocalPlayer and true or false then
        startControlling();

        return;
    end;

    stopControlling();
end);