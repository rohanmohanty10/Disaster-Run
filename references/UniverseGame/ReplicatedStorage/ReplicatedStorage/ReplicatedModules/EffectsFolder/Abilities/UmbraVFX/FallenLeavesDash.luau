  

 

local function ApplyLinearKnockback(p1, p2) -- Line: 1
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = p1;
    LinearVelocity.MaxForce = 100000;
    LinearVelocity.VectorVelocity = p2.Velocity;

    if p2.Properties then
        for i, v in p2.Properties do
            LinearVelocity[i] = v;
        end;
    end;

    return LinearVelocity;
end;

return function(p3) -- Line: 17
    if not (p3.Part and p3.Part:IsDescendantOf(workspace)) then
        return;
    end;

    local Part = p3.Part;
    local Speed = p3.Speed;
    local Force = p3.Force;
    local LookVector = Part.CFrame.LookVector;

    if p3.InverseLookVector then
        LookVector = LookVector * -1;
    end;

    local v4 = LookVector * Part:GetMass() * Speed + Force;
    local v5 = p3.Attachment or Part:FindFirstChildOfClass("Attachment");
    local v6 = {
        Velocity = v4,
        Properties = p3.Properties
    };
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = v5;
    LinearVelocity.MaxForce = 100000;
    LinearVelocity.VectorVelocity = v6.Velocity;

    if v6.Properties then
        for i, v in v6.Properties do
            LinearVelocity[i] = v;
        end;
    end;

    LinearVelocity.Parent = Part;
    task.delay(p3.Time or 0.25, LinearVelocity.Destroy, LinearVelocity);
end;