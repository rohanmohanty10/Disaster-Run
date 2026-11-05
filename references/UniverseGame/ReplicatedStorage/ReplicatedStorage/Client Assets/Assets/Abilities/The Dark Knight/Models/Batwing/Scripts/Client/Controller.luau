  

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer:GetMouse();
local SetJumpingEnabled = require(script.SetJumpingEnabled);
local Constraints = require(script.Constraints);
local Camera = require(script.Camera);
local Inputs = require(script.Inputs);
local Parent = script.Parent.Parent.Parent;
local DriverSeat = Parent:WaitForChild("DriverSeat");

return {
    MAX_SPEED = 100,
    ACCELERATION = 150,
    DECELERATION = 200,
    NITRO_SCALAR = 2,
    MAX_TILT = 1.5707963267948966,
    Speed = 0,
    InputVector = Vector3.new(),
    Connections = {},

    Start = function(u2) -- Line: 29, Name: Start
        -- upvalues: LocalPlayer (copy), SetJumpingEnabled (copy), Camera (copy), Inputs (copy), Constraints (copy), RunService (copy), DriverSeat (copy), u1 (copy), Parent (copy)
        u2:CleanConnections();
        local Character = LocalPlayer.Character;

        if Character then
            SetJumpingEnabled(Character, false);
        end;

        Camera:Enable();
        Inputs:Enable();
        local v3 = Constraints:Setup();
        local LinearVelocity = v3.LinearVelocity;
        local AlignOrientation = v3.AlignOrientation;
        table.insert(u2.Connections, RunService.RenderStepped:Connect(function(p4) -- Line: 47
            -- upvalues: DriverSeat (ref), u2 (copy), u1 (ref), Parent (ref), AlignOrientation (copy), LocalPlayer (ref), LinearVelocity (copy)
            if not DriverSeat.Occupant then
                return;
            end;

            u2:UpdateInput();
            local Unit = (u1.Hit.Position - DriverSeat.Position).Unit;
            local CFrame2 = DriverSeat.CFrame;
            local _ = CFrame2.LookVector;
            local v5 = CFrame2.RightVector:Dot(Vector3.new(Unit.X, 0, Unit.Z).Unit);
            local v6 = math.clamp(v5, -1, 1);
            local v7 = math.asin(v6) * 2;
            local v8 = -math.clamp(v7, -u2.MAX_TILT, u2.MAX_TILT);
            local v9 = CFrame.lookAt(DriverSeat.Position, DriverSeat.Position + Unit, Vector3.new(0, 1, 0)) * CFrame.Angles(0, 0, v8);

            if u2.InputVector.Magnitude ~= 0 or Parent:GetAttribute("GunFire") then
                AlignOrientation.CFrame = AlignOrientation.CFrame:Lerp(v9, (math.clamp(p4 * 6, 0, 1)));
            end;

            local v10 = LocalPlayer:GetAttribute("Nitro") == true;
            local v11 = v10 and 1.5 or 1;
            local v12 = u2.MAX_SPEED * v11;
            local v13 = u2.ACCELERATION * v11;

            if u2.InputVector.Z > 0 or v10 then
                u2.Speed = math.clamp(u2.Speed + v13 * p4, -v12 * 0.5, v12);
            elseif u2.InputVector.Z < 0 then
                u2.Speed = math.clamp(u2.Speed - v13 * p4, -v12, v12 * 0.5);
            elseif u2.Speed > 0 then
                u2.Speed = math.max(u2.Speed - u2.DECELERATION * p4, 0);
            elseif u2.Speed < 0 then
                u2.Speed = math.min(u2.Speed + u2.DECELERATION * p4, 0);
            end;

            LinearVelocity.VectorVelocity = DriverSeat.CFrame.LookVector * u2.Speed;
        end));
    end,

    UpdateInput = function(p14) -- Line: 95, Name: UpdateInput
        -- upvalues: DriverSeat (copy)
        p14.InputVector = Vector3.new(0, 0, 0);

        if DriverSeat then
            p14.InputVector = Vector3.new(0, 0, DriverSeat.Throttle);
        end;
    end,

    Stop = function(p15) -- Line: 102, Name: Stop
        -- upvalues: LocalPlayer (copy), SetJumpingEnabled (copy), Camera (copy), Inputs (copy), Constraints (copy)
        local Character = LocalPlayer.Character;

        if Character then
            SetJumpingEnabled(Character, true);
        end;

        p15.Speed = 0;
        Camera:Disable();
        Inputs:Disable();
        Constraints:Reset();
        p15:CleanConnections();
    end,

    CleanConnections = function(p16) -- Line: 118, Name: CleanConnections
        for _, v in p16.Connections do
            v:Disconnect();
        end;

        table.clear(p16.Connections);
    end
};