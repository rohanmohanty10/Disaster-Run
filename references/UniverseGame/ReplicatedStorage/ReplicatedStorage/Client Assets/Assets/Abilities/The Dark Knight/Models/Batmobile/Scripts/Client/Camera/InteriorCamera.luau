  

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local Constants = require(script.Parent.Parent.Parent.Constants);
local lerp = require(script.Parent.Parent.Parent.lerp);
local setCharacterVisible = require(script.setCharacterVisible);
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = Workspace.CurrentCamera;
local Parent = script.Parent.Parent.Parent.Parent;
local Chassis = Parent.Chassis;
local Inputs = Parent.Inputs;
local Value = Enum.RenderPriority.Camera.Value;
local u1 = Vector3.new(0, 0, 0);
local u2 = Vector3.new(0, 0, 0);
local u3 = 0;
local u4 = false;
local u5 = {
    attachment = nil,
    forwardHeadTurnAngle = 0,
    reverseHeadTurnAngle = 0
};

local function update(p6) -- Line: 39
    -- upvalues: Inputs (copy), Constants (copy), Chassis (copy), u5 (ref), u3 (ref), lerp (copy), u1 (ref), u2 (ref), CurrentCamera (copy)
    local v7 = Inputs:GetAttribute(Constants.STEERING_INPUT_ATTRIBUTE);
    local v8 = Inputs:GetAttribute(Constants.THROTTLE_INPUT_ATTRIBUTE);
    local v9 = Chassis.CFrame:VectorToObjectSpace(Chassis.AssemblyLinearVelocity);
    local v10 = v7 * u5.forwardHeadTurnAngle;

    if v9.Z > 10 and v8 < 0 then
        v10 = u5.reverseHeadTurnAngle;
    end;

    u3 = lerp(u3, v10, (math.min(p6 * 4, 1)));
    u1 = u1:Lerp(u5.attachment.WorldCFrame.LookVector, (math.min(p6 * 30, 1)));
    u2 = u2:Lerp(u5.attachment.WorldCFrame.UpVector:Lerp(Vector3.new(0, 1, 0), 0.2), (math.min(p6 * 30, 1)));
    local Position = u5.attachment.WorldCFrame.Position;
    CurrentCamera.CFrame = CFrame.lookAt(Position, Position + u1, u2) * CFrame.Angles(0, -u3, 0);
end;

local function initializeValues() -- Line: 65
    -- upvalues: u1 (ref), Chassis (copy), u2 (ref), u3 (ref)
    u1 = Chassis.CFrame.LookVector;
    u2 = Chassis.CFrame.UpVector;
    u3 = 0;
end;

return {
    setParameters = function(p11, p12) -- Line: 73, Name: setParameters
        -- upvalues: u5 (ref)
        u5 = p12;
    end,

    enable = function(p13) -- Line: 77, Name: enable
        -- upvalues: u4 (ref), u1 (ref), Chassis (copy), u2 (ref), u3 (ref), RunService (copy), Value (copy), update (copy), LocalPlayer (copy), setCharacterVisible (copy)
        if u4 then
            return;
        end;

        u4 = true;
        u1 = Chassis.CFrame.LookVector;
        u2 = Chassis.CFrame.UpVector;
        u3 = 0;
        RunService:BindToRenderStep("CarInteriorCamera", Value, update);
        task.defer(function() -- Line: 89
            -- upvalues: LocalPlayer (ref), setCharacterVisible (ref)
            local Character = LocalPlayer.Character;

            if Character then
                setCharacterVisible(Character, false);
            end;
        end);
    end,

    disable = function(p14) -- Line: 97, Name: disable
        -- upvalues: u4 (ref), RunService (copy), LocalPlayer (copy), setCharacterVisible (copy)
        if not u4 then
            return;
        end;

        u4 = false;
        RunService:UnbindFromRenderStep("CarInteriorCamera");
        local Character = LocalPlayer.Character;

        if Character then
            setCharacterVisible(Character, true);
        end;
    end
};