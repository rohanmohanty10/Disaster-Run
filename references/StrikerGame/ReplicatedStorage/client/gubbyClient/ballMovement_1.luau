 
 

local RunService = game:GetService("RunService");
local v1 = {};

local function resetBall(p2) -- Line: 5
    local motor = p2.motor;

    if motor and (motor.Parent and (p2.lastTransform and motor.Transform == p2.lastTransform)) then
        motor.Transform = CFrame.identity;
    end;

    p2.motor = nil;
    p2.lastTransform = nil;
end;

local function hasBallMovement(p3) -- Line: 14
    for _, v in p3:GetPlayingAnimationTracks() do
        if v.WeightCurrent > 0 and v.Name ~= "Slide" then
            return true;
        end;
    end;

    return false;
end;

local function updateBall(p4) -- Line: 23
    local character = p4.character;
    local GubbyRig = character:FindFirstChild("GubbyRig");
    local v5;

    if GubbyRig then
        v5 = GubbyRig:FindFirstChildOfClass("AnimationController");
    else
        v5 = GubbyRig;
    end;

    if v5 then
        v5 = v5:FindFirstChildOfClass("Animator");
    end;

    if GubbyRig then
        GubbyRig = GubbyRig:FindFirstChild("Ball");
    end;

    if GubbyRig then
        GubbyRig = GubbyRig:FindFirstChild("Ball");
    end;

    local Ball = character:FindFirstChild("Ball");
    local v6;

    if Ball then
        v6 = Ball:FindFirstChildOfClass("Motor6D");
    else
        v6 = Ball;
    end;

    if character:GetAttribute("Gubby") and (not character:GetAttribute("AlternateBallRig") and (v5 and (GubbyRig and (v6 and v6.Part1 == Ball)))) then
        local v7 = false;

        for _, v in v5:GetPlayingAnimationTracks() do
            if v.WeightCurrent > 0 and v.Name ~= "Slide" then
                v7 = true;
                break;
            end;
        end;

        if v7 then
            if p4.motor ~= v6 then
                local motor = p4.motor;

                if motor and (motor.Parent and (p4.lastTransform and motor.Transform == p4.lastTransform)) then
                    motor.Transform = CFrame.identity;
                end;

                p4.motor = nil;
                p4.lastTransform = nil;
                p4.motor = v6;
            end;

            v6.Transform = GubbyRig.Transform;
            p4.lastTransform = v6.Transform;

            return;
        end;
    end;

    local motor = p4.motor;

    if motor and (motor.Parent and (p4.lastTransform and motor.Transform == p4.lastTransform)) then
        motor.Transform = CFrame.identity;
    end;

    p4.motor = nil;
    p4.lastTransform = nil;
end;

function v1.bind(p8, p9) -- Line: 45
    -- upvalues: RunService (copy), updateBall (copy)
    if not p8:HasTag("Gubby") then
        return;
    end;

    local u10 = {
        character = p8
    };
    p9:Connect(RunService.PreSimulation, function() -- Line: 49
        -- upvalues: updateBall (ref), u10 (copy)
        updateBall(u10);
    end);
    p9:Add(function() -- Line: 52
        -- upvalues: u10 (copy)
        local v11 = u10;
        local motor = v11.motor;

        if motor and (motor.Parent and (v11.lastTransform and motor.Transform == v11.lastTransform)) then
            motor.Transform = CFrame.identity;
        end;

        v11.motor = nil;
        v11.lastTransform = nil;
    end);
end;

return v1;