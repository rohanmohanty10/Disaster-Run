  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Constants = require(script.Parent.Parent.Parent.Constants);
local getAverageWheelSlip = require(script.Parent.getAverageWheelSlip);
local getSuspensionLength = require(script.Parent.getSuspensionLength);
local playRandomSound = require(script.Parent.playRandomSound);
local Parent = script.Parent.Parent.Parent.Parent;
local Chassis = Parent.Chassis;
local Engine = Parent.Engine;
local EngineStartupSound = Chassis.EngineStartupSound;
local EngineShutdownSound = Chassis.EngineShutdownSound;
local EngineLoopSound = Chassis.EngineLoopSound;
local DistortionSoundEffect = EngineLoopSound.DistortionSoundEffect;
local TiresLoopSound = Chassis.TiresLoopSound;
local TiresSlidingLoopSound = Chassis.TiresSlidingLoopSound;
local NitroStartSound = Chassis.NitroStartSound;
local NitroStopSound = Chassis.NitroStopSound;
local NitroLoopSound = Chassis.NitroLoopSound;
local u1 = Chassis.SuspensionSounds:GetChildren();
local u2 = Chassis.CollisionSounds:GetChildren();
local Volume = EngineLoopSound.Volume;
local PlaybackSpeed = EngineLoopSound.PlaybackSpeed;
local Volume2 = TiresLoopSound.Volume;
local Volume3 = TiresSlidingLoopSound.Volume;
local u3 = false;
local u4 = false;
local u5 = 0;
local u6 = getSuspensionLength();
local u7 = os.clock();
local u8 = 0;
local Magnitude = Chassis.AssemblyLinearVelocity.Magnitude;
local u9 = os.clock();

local function updateCollisionSounds() -- Line: 56
    -- upvalues: Chassis (copy), Magnitude (ref), u8 (ref), u9 (ref), playRandomSound (copy), u2 (copy)
    local Magnitude2 = Chassis.AssemblyLinearVelocity.Magnitude;
    local v10 = math.abs(Magnitude2 - Magnitude);
    Magnitude = Magnitude2;
    u8 = u8 + v10;
    local v11 = os.clock() - u9;

    if v11 < 0.1 then
        return;
    end;

    u9 = os.clock();
    local v12 = u8 / v11;

    if v12 > 400 then
        playRandomSound(u2, Chassis, v12 * 0.00125);
    end;

    u8 = 0;
end;

local function updateSuspensionSounds() -- Line: 82
    -- upvalues: getSuspensionLength (copy), u6 (ref), u5 (ref), u7 (ref), playRandomSound (copy), u1 (copy), Chassis (copy)
    local v13 = getSuspensionLength();
    local v14 = math.abs(v13 - u6);
    u6 = v13;
    u5 = u5 + v14;
    local v15 = os.clock() - u7;

    if v15 < 0.1 then
        return;
    end;

    u7 = os.clock();
    local v16 = u5 / v15;

    if v16 > 15 then
        playRandomSound(u1, Chassis, v16 * 0.02);
    end;

    u5 = 0;
end;

local function onHeartbeat(p17) -- Line: 105
    -- upvalues: Chassis (copy), Engine (copy), Constants (copy), PlaybackSpeed (copy), EngineLoopSound (copy), DistortionSoundEffect (copy), Volume2 (copy), TiresLoopSound (copy), getAverageWheelSlip (copy), Volume3 (copy), TiresSlidingLoopSound (copy), updateSuspensionSounds (copy), updateCollisionSounds (copy)
    local Z = Chassis.CFrame:VectorToObjectSpace(Chassis.AssemblyLinearVelocity).Z;
    local v18 = math.abs(Z);
    local v19 = Engine:GetAttribute(Constants.ENGINE_SPEED_ATTRIBUTE);
    local v20 = math.max(v18, v19);
    EngineLoopSound.PlaybackSpeed = PlaybackSpeed + v20 * 0.0125;
    DistortionSoundEffect.Level = v20 * 0.005;
    TiresLoopSound.Volume = Volume2 * v18 * 0.01;
    TiresSlidingLoopSound.Volume = Volume3 * getAverageWheelSlip() * 0.0125;
    updateSuspensionSounds();
    updateCollisionSounds();
end;

local v24 = {
    startNitro = function() -- Line: 136, Name: startNitro
        -- upvalues: u4 (ref), NitroStartSound (copy), NitroLoopSound (copy)
        if u4 then
            return;
        end;

        u4 = true;
        NitroStartSound:Play();
        NitroLoopSound:Play();
    end,

    stopNitro = function() -- Line: 147, Name: stopNitro
        -- upvalues: u4 (ref), NitroStopSound (copy), NitroLoopSound (copy)
        if not u4 then
            return;
        end;

        u4 = false;
        NitroStopSound:Play();
        NitroLoopSound:Stop();
    end,

    startupEngine = function() -- Line: 158, Name: startupEngine
        -- upvalues: u3 (ref), EngineStartupSound (copy), EngineLoopSound (copy), TweenService (copy), Volume (copy)
        if u3 then
            return;
        end;

        u3 = true;
        EngineStartupSound:Play();
        EngineLoopSound.Volume = 0;
        EngineLoopSound:Play();
        TweenService:Create(EngineLoopSound, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Volume = Volume
        }):Play();
    end,

    shutdownEngine = function() -- Line: 176, Name: shutdownEngine
        -- upvalues: u3 (ref), EngineShutdownSound (copy), EngineLoopSound (copy)
        if not u3 then
            return;
        end;

        u3 = false;
        EngineShutdownSound:Play();
        EngineLoopSound:Stop();
    end,

    initialize = function() -- Line: 187, Name: initialize
        -- upvalues: TiresLoopSound (copy), TiresSlidingLoopSound (copy), RunService (copy), onHeartbeat (copy), Parent (copy)
        TiresLoopSound.Volume = 0;
        TiresSlidingLoopSound.Volume = 0;
        TiresLoopSound:Play();
        TiresSlidingLoopSound:Play();
        local u21 = RunService.Heartbeat:Connect(onHeartbeat);
        Parent.AncestryChanged:Connect(function(p22, p23) -- Line: 195
            -- upvalues: u21 (copy)
            if not p23 then
                u21:Disconnect();
            end;
        end);
    end
};
v24.initialize();

return v24;