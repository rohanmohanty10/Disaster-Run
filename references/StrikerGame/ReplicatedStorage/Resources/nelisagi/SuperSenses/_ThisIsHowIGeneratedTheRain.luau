 
 

local workspace_A = workspace.A;
local Puzzles = workspace_A.Design.Puzzles;

for _, descendant in workspace_A:GetDescendants() do
    if descendant:IsA("BasePart") and descendant.Name == "Piece3" then
        descendant:ClearAllChildren();
        local v1 = Puzzles:Clone();
        v1:SetAttribute("IgnoresTheKid", true);
        v1.Parent = descendant;
        v1.Name = "Rain";
        v1.Size = descendant.Size;
        v1.CFrame = descendant.CFrame * CFrame.new(0, 500, 0) * CFrame.Angles(3.141592653589793, 0, 0);
        local v2 = descendant;

        for i, child in v1:GetChildren() do
            if i > 1 then
                child:Destroy();
            else
                child.Speed = NumberRange.new(-505, -500);
                child.Lifetime = NumberRange.new(5);
                child.Drag = 1.2;
                child.SpreadAngle = Vector2.new(5, 5);
                child.Color = ColorSequence.new(v2.Color);
                child.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1, 1), NumberSequenceKeypoint.new(1, 2, 0.5) });
                child.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.9, 0), NumberSequenceKeypoint.new(1, 1) });
                child.Rate = 2;
                child.Acceleration = -child.Acceleration;
                child.ZOffset = 0;
            end;
        end;
    end;
end;