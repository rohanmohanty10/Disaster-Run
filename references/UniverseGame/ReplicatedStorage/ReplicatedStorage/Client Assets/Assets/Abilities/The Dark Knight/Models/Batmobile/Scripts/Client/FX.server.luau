  

 

if not script:IsDescendantOf(workspace) then
    return;
end;

local Constants = require(script.Parent.Parent.Constants);
local Audio = require(script.Audio);
local Particles = require(script.Particles);
local Parent = script.Parent.Parent.Parent;
local DriverSeat = Parent.DriverSeat;
local Engine = Parent.Engine;

local function onOccupantChanged() -- Line: 11
    -- upvalues: DriverSeat (copy), Audio (copy)
    if DriverSeat.Occupant then
        Audio.startupEngine();

        return;
    end;

    Audio.shutdownEngine();
end;

local function onNitroEnabledChanged() -- Line: 19
    -- upvalues: Engine (copy), Constants (copy), Audio (copy), Particles (copy)
    if Engine:GetAttribute(Constants.NITRO_ENABLED_ATTRIBUTE) then
        Audio.startNitro();
        Particles.startNitro();

        return;
    end;

    Audio.stopNitro();
    Particles.stopNitro();
end;

local function initialize() -- Line: 30
    -- upvalues: DriverSeat (copy), onOccupantChanged (copy), Engine (copy), Constants (copy), onNitroEnabledChanged (copy), Audio (copy), Particles (copy)
    DriverSeat:GetPropertyChangedSignal("Occupant"):Connect(onOccupantChanged);
    Engine:GetAttributeChangedSignal(Constants.NITRO_ENABLED_ATTRIBUTE):Connect(onNitroEnabledChanged);

    if DriverSeat.Occupant then
        Audio.startupEngine();
    else
        Audio.shutdownEngine();
    end;

    if Engine:GetAttribute(Constants.NITRO_ENABLED_ATTRIBUTE) then
        Audio.startNitro();
        Particles.startNitro();

        return;
    end;

    Audio.stopNitro();
    Particles.stopNitro();
end;

DriverSeat:GetPropertyChangedSignal("Occupant"):Connect(onOccupantChanged);
Engine:GetAttributeChangedSignal(Constants.NITRO_ENABLED_ATTRIBUTE):Connect(onNitroEnabledChanged);

if DriverSeat.Occupant then
    Audio.startupEngine();
else
    Audio.shutdownEngine();
end;

if Engine:GetAttribute(Constants.NITRO_ENABLED_ATTRIBUTE) then
    Audio.startNitro();
    Particles.startNitro();

    return;
end;

Audio.stopNitro();
Particles.stopNitro();