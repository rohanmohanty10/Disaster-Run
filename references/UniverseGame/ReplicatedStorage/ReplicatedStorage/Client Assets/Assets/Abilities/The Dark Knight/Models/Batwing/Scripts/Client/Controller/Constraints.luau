  

 

local Parent = script.Parent.Parent.Parent.Parent;

return {
    _Setup = false,
    _Constraints = {},

    Setup = function(p1) -- Line: 8, Name: Setup
        -- upvalues: Parent (copy)
        if p1._Setup then
            return;
        end;

        local PrimaryPart = Parent.PrimaryPart;

        if PrimaryPart then
            local Attachment = PrimaryPart:FindFirstChild("Attachment");

            if not Attachment then
                Attachment = Instance.new("Attachment");
                Attachment.Name = "Attachment";
                Attachment.Parent = PrimaryPart;
            end;

            local AlignOrientation = PrimaryPart:FindFirstChild("AlignOrientation");

            if not AlignOrientation then
                AlignOrientation = Instance.new("AlignOrientation");
                AlignOrientation.Name = "AlignOrientation";
                AlignOrientation.Attachment0 = Attachment;
                AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
                AlignOrientation.MaxTorque = (1 / 0);
                AlignOrientation.Responsiveness = 8;
                AlignOrientation.Parent = PrimaryPart;
            end;

            p1.AlignOrientation = AlignOrientation;
            local LinearVelocity = PrimaryPart:FindFirstChild("LinearVelocity");

            if not LinearVelocity then
                LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.Name = "LinearVelocity";
                LinearVelocity.Attachment0 = Attachment;
                LinearVelocity.MaxForce = 1000000;
                LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
                LinearVelocity.Parent = PrimaryPart;
            end;

            p1._Setup = true;
            p1._Constraints = {
                LinearVelocity = LinearVelocity,
                AlignOrientation = AlignOrientation,
                Attachment = Attachment
            };

            return p1._Constraints;
        end;
    end,

    Reset = function(p2) -- Line: 55, Name: Reset
        local _Constraints = p2._Constraints;
        local _ = _Constraints.LinearVelocity;
        local _ = _Constraints.AlignOrientation;
    end,

    GetConstraints = function(p3) -- Line: 69, Name: GetConstraints
        return p3._Constraints;
    end
};