  

 

game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
Random.new();

return function(p1) -- Line: 7
    -- upvalues: RunService (copy), Players (copy)
    local v2 = p1 or {};
    local State = v2.State;
    local Attacker = v2.Attacker;
    local Character = v2.Character;

    if RunService:IsClient() and not Character then
        Character = Players.LocalPlayer.Character;
    end;

    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");

    if not State then
        local v3 = HumanoidRootPart:FindFirstChild("Air Lock");

        if v3 then
            v3:Destroy();
        end;

        return;
    end;

    local function GetHeight() -- Line: 27
        -- upvalues: HumanoidRootPart (copy), Attacker (copy)
        local Y = HumanoidRootPart.Position.Y;

        if Attacker then
            Y = Attacker.HumanoidRootPart.Position.Y;
        end;

        return Y;
    end;

    local function GetPosition() -- Line: 35
        -- upvalues: HumanoidRootPart (copy), Attacker (copy)
        local Y = HumanoidRootPart.Position.Y;

        if Attacker then
            Y = Attacker.HumanoidRootPart.Position.Y;
        end;

        return Vector3.new(1, 0, 1) * HumanoidRootPart.Position + Vector3.new(0, Y, 0);
    end;

    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.MaxForce = Vector3.new(0, 1000000, 0);
    local Y = HumanoidRootPart.Position.Y;

    if Attacker then
        Y = Attacker.HumanoidRootPart.Position.Y;
    end;

    BodyPosition.Position = Vector3.new(1, 0, 1) * HumanoidRootPart.Position + Vector3.new(0, Y, 0);
    BodyPosition.Name = "Air Lock";
    BodyPosition.Parent = HumanoidRootPart;
    task.spawn(function() -- Line: 45
        -- upvalues: BodyPosition (copy), HumanoidRootPart (copy), Attacker (copy)
        while BodyPosition:IsDescendantOf(game) do
            local Y2 = HumanoidRootPart.Position.Y;

            if Attacker then
                Y2 = Attacker.HumanoidRootPart.Position.Y;
            end;

            BodyPosition.Position = Vector3.new(1, 0, 1) * HumanoidRootPart.Position + Vector3.new(0, Y2, 0);
            task.wait();
        end;
    end);
end;