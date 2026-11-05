  

 

local Constants = require(script.Parent.Constants);
local Units = require(script.Parent.Units);
local lerp = require(script.Parent.lerp);
local Parent = script.Parent.Parent;
local Chassis = Parent.Chassis;
local Inputs = Parent.Inputs;
local Engine = Parent.Engine;
local Steering = Parent.Steering;
local Wheels = Parent.Wheels;
local u1 = {
    Wheels.WheelFR.Wheel,
    Wheels.WheelFL.Wheel,
    Wheels.WheelRR.Wheel,
    Wheels.WheelRL.Wheel
};
local u2 = {
    forwardMaxSpeed = 0,
    reverseMaxSpeed = 0,
    acceleration = 0,
    deceleration = 0,
    braking = 0,
    engineSpeedCorrection = 0,
    minSpeedTorque = 0,
    maxSpeedTorque = 0,
    handBrakeTorque = 0,
    nitroTorque = 0,
    nitroTime = 0,
    nitroRechargeTime = 0,
    nitroMaxSpeed = 0,
    nitroAcceleration = 100
};
local u3 = {
    steeringReduction = 0
};
local u4 = {
    density = 0,
    elasticity = 0,
    staticFriction = 0,
    kineticFriction = 0,
    slipThreshold = 0
};
local u5 = u1[1].Size.Y / 2;

local function getChassisForwardSpeed() -- Line: 52
    -- upvalues: Chassis (copy), Units (copy)
    local v6 = Chassis.CFrame:VectorToObjectSpace(Chassis.AssemblyLinearVelocity);

    return Units.studsPerSecondToMilesPerHour(-v6.Z);
end;

local function updateNitro(p7) -- Line: 59
    -- upvalues: Inputs (copy), Constants (copy), Engine (copy), u2 (copy)
    local v8 = Inputs:GetAttribute(Constants.NITRO_INPUT_ATTRIBUTE);
    local v9 = Engine:GetAttribute(Constants.ENGINE_NITRO_ATTRIBUTE);

    if v8 then
        v8 = v9 > 0;
    end;

    local v10;

    if v8 then
        v10 = math.max(v9 - 1 / u2.nitroTime * p7, 0);

        if v10 == 0 then
            Inputs:SetAttribute(Constants.NITRO_INPUT_ATTRIBUTE, false);
        end;
    else
        v10 = math.min(v9 + 1 / u2.nitroRechargeTime * p7, 1);
    end;

    Engine:SetAttribute(Constants.ENGINE_NITRO_ATTRIBUTE, v10);
    Engine:SetAttribute(Constants.NITRO_ENABLED_ATTRIBUTE, v8);
    Engine.NitroVelocity.Enabled = v8;
    Engine.NitroVelocity.VectorVelocity = Vector3.new(0, 0, -u2.nitroMaxSpeed);
end;

local function updateEngine(p11) -- Line: 87
    -- upvalues: Inputs (copy), Constants (copy), Engine (copy), u2 (copy), Chassis (copy), Units (copy), lerp (copy), u5 (copy)
    local v12 = Inputs:GetAttribute(Constants.HAND_BRAKE_INPUT_ATTRIBUTE);
    local v13 = Inputs:GetAttribute(Constants.THROTTLE_INPUT_ATTRIBUTE);
    local v14 = math.clamp(v13, -1, 1);
    local v15 = math.sign(v14);
    local v16 = Engine:GetAttribute(Constants.ENGINE_SPEED_ATTRIBUTE);
    local v17 = Engine:GetAttribute(Constants.NITRO_ENABLED_ATTRIBUTE);
    local v18 = math.max(u2.forwardMaxSpeed, u2.reverseMaxSpeed);
    local v19;

    if v15 >= 0 then
        v19 = u2.forwardMaxSpeed;
    else
        v19 = u2.reverseMaxSpeed;
    end;

    local v20 = v14 * v19;
    local v21 = Chassis.CFrame:VectorToObjectSpace(Chassis.AssemblyLinearVelocity);
    local v22 = Units.studsPerSecondToMilesPerHour(-v21.Z);
    local v23;

    if v15 == 0 or math.abs(v22) <= 1 then
        v23 = false;
    else
        v23 = v15 ~= math.sign(v22);
    end;

    local acceleration = u2.acceleration;

    if v17 then
        acceleration = u2.nitroAcceleration;
        v20 = u2.nitroMaxSpeed;
    elseif v23 then
        acceleration = u2.braking;
        v20 = 0;
    elseif math.abs(v20) < math.abs(v16) then
        acceleration = u2.deceleration;
    end;

    local v24 = lerp(v16, v22, (math.min(p11 * u2.engineSpeedCorrection, 1)));
    local v25;

    if v24 < v20 then
        v25 = math.min(v24 + acceleration * p11, v20);
    else
        v25 = math.max(v24 - acceleration * p11, v20);
    end;

    Engine:SetAttribute(Constants.ENGINE_SPEED_ATTRIBUTE, v25);
    local v26 = Chassis.CFrame:VectorToObjectSpace(Chassis.AssemblyLinearVelocity);
    local v27 = Units.studsPerSecondToMilesPerHour(-v26.Z);
    local v28 = math.min(v27, v18) / v18;
    local v29 = lerp(u2.minSpeedTorque, u2.maxSpeedTorque, v28);

    if v17 then
        v29 = u2.nitroTorque;
    end;

    local v30 = Units.milesPerHourToStudsPerSecond(v25) / u5;
    Engine.WheelFRMotor.AngularVelocity = v30;
    Engine.WheelFRMotor.MotorMaxTorque = v29;
    Engine.WheelFLMotor.AngularVelocity = -v30;
    Engine.WheelFLMotor.MotorMaxTorque = v29;

    if v12 then
        Engine.WheelRRMotor.AngularVelocity = 0;
        Engine.WheelRRMotor.MotorMaxTorque = u2.handBrakeTorque;
        Engine.WheelRLMotor.AngularVelocity = 0;
        Engine.WheelRLMotor.MotorMaxTorque = u2.handBrakeTorque;

        return;
    end;

    Engine.WheelRRMotor.AngularVelocity = v30;
    Engine.WheelRRMotor.MotorMaxTorque = v29;
    Engine.WheelRLMotor.AngularVelocity = -v30;
    Engine.WheelRLMotor.MotorMaxTorque = v29;
end;

local function updateSteering() -- Line: 157
    -- upvalues: Inputs (copy), Constants (copy), u2 (copy), Chassis (copy), Units (copy), u3 (copy), Steering (copy)
    local v31 = Inputs:GetAttribute(Constants.STEERING_INPUT_ATTRIBUTE);
    local v32 = math.clamp(v31, -1, 1);
    local v33 = math.max(u2.forwardMaxSpeed, u2.reverseMaxSpeed);
    local v34 = Chassis.CFrame:VectorToObjectSpace(Chassis.AssemblyLinearVelocity);
    local v35 = Units.studsPerSecondToMilesPerHour(-v34.Z);
    local v36 = 1 - math.min(v35, v33) / v33 * u3.steeringReduction;
    local v37 = v32 * math.max(v36, 0);

    if v37 > 0 then
        Steering.SteeringRack.TargetPosition = v37 * Steering.SteeringRack.LowerLimit;

        return;
    end;

    Steering.SteeringRack.TargetPosition = -v37 * Steering.SteeringRack.UpperLimit;
end;

local function updateWheelFriction() -- Line: 172
    -- upvalues: u1 (copy), u5 (copy), u4 (copy)
    for _, v in u1 do
        local v38;

        if math.abs(v.AssemblyLinearVelocity.Magnitude - u5 * v.AssemblyAngularVelocity.Magnitude) > u4.slipThreshold then
            v38 = u4.kineticFriction;
        else
            v38 = u4.staticFriction;
        end;

        v.CustomPhysicalProperties = PhysicalProperties.new(u4.density, v38, u4.elasticity);
    end;
end;

(function() -- Line: 188, Name: initialize
    -- upvalues: u2 (copy), Engine (copy), u3 (copy), Steering (copy), u4 (copy), Wheels (copy)
    for i in u2 do
        Engine:GetAttributeChangedSignal(i):Connect(function() -- Line: 192
            -- upvalues: u2 (ref), i (copy), Engine (ref)
            u2[i] = Engine:GetAttribute(i);
        end);
        u2[i] = Engine:GetAttribute(i);
    end;

    for i in u3 do
        Steering:GetAttributeChangedSignal(i):Connect(function() -- Line: 199
            -- upvalues: u3 (ref), i (copy), Steering (ref)
            u3[i] = Steering:GetAttribute(i);
        end);
        u3[i] = Steering:GetAttribute(i);
    end;

    for i in u4 do
        Wheels:GetAttributeChangedSignal(i):Connect(function() -- Line: 206
            -- upvalues: u4 (ref), i (copy), Wheels (ref)
            u4[i] = Wheels:GetAttribute(i);
        end);
        u4[i] = Wheels:GetAttribute(i);
    end;
end)();

return {
    reset = function(p39) -- Line: 215, Name: reset
        -- upvalues: Engine (copy), Constants (copy), u2 (copy), Steering (copy), u1 (copy), u4 (copy)
        Engine:SetAttribute(Constants.ENGINE_SPEED_ATTRIBUTE, 0);
        Engine:SetAttribute(Constants.ENGINE_NITRO_ATTRIBUTE, 1);
        Engine.WheelFRMotor.AngularVelocity = 0;
        Engine.WheelFRMotor.MotorMaxTorque = u2.minSpeedTorque;
        Engine.WheelFLMotor.AngularVelocity = 0;
        Engine.WheelFLMotor.MotorMaxTorque = u2.minSpeedTorque;
        Engine.WheelRRMotor.AngularVelocity = 0;
        Engine.WheelRRMotor.MotorMaxTorque = u2.minSpeedTorque;
        Engine.WheelRLMotor.AngularVelocity = 0;
        Engine.WheelRLMotor.MotorMaxTorque = u2.minSpeedTorque;
        Engine.NitroVelocity.Enabled = false;
        Steering.SteeringRack.TargetPosition = 0;

        for _, v in u1 do
            v.CustomPhysicalProperties = PhysicalProperties.new(u4.density, u4.staticFriction, u4.elasticity);
        end;
    end,

    update = function(p40, p41) -- Line: 239, Name: update
        -- upvalues: updateNitro (copy), updateEngine (copy), updateSteering (copy), updateWheelFriction (copy)
        updateNitro(p41);
        updateEngine(p41);
        updateSteering();
        updateWheelFriction();
    end
};