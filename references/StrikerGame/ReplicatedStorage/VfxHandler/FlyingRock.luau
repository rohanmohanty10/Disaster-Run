 

 

game:GetService("Players");
game:GetService("Lighting");
game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 11
    -- upvalues: Debris (copy), TweenService (copy)
    if game.Players.LocalPlayer:GetAttribute("LowMode") == true then
        return;
    end;

    local Position = p1.Position;
    local v2 = p1.LifeTime or 1;
    local v3 = p1.CanCollide or false;
    local v4 = p1.Material or Enum.Material.Plastic;
    local v5 = p1.Amount or 1;
    local v6 = p1.RandomForce or math.random(70, 100);
    local v7 = p1.RandomSize or math.random(3, 7);
    local v8 = p1.StartTime or 0.15;
    local v9 = p1.TrailEnabled or false;
    local v10 = v7 / 3;

    for i = 1, v5 do
        local Part = Instance.new("Part");
        Part.Transparency = 0.6;
        Part.Massless = false;
        Part.CanTouch = false;
        Part.Material = v4;
        Part.Color = p1.Color or Color3.fromRGB(181, 181, 181);
        Part.CanQuery = false;
        Part.CFrame = Position;
        local math_random_ret = math.random(-360, 360);
        local math_random_ret2 = math.random(-360, 360);
        Part.Orientation = Vector3.new(math_random_ret, math_random_ret2, math.random(-360, 360));
        Part.AssemblyLinearVelocity = Part.CFrame.UpVector * v6;
        Part.Size = Vector3.new(v10, v10, v10);
        Part.CanCollide = v3;
        Part.Parent = workspace.Effects;
        Debris:AddItem(Part, v2 + 0.35);
        local Attachment = Instance.new("Attachment");
        Attachment.Position = Vector3.new(v7 / 2, 0, 0);
        Attachment.Parent = Part;
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Position = Vector3.new(-(v7 / 2), 0, 0);
        Attachment2.Parent = Part;
        local u11 = script.Trail:Clone();
        u11.Attachment1 = Attachment;
        u11.Attachment0 = Attachment2;
        u11.Parent = Part;
        u11.Enabled = v9;
        task.delay(v2 - 0.5, function() -- Line: 57
            -- upvalues: u11 (copy)
            u11.Enabled = false;
        end);
        TweenService:Create(Part, TweenInfo.new(v8), {
            Transparency = 0,
            Size = Vector3.new(v7, v7, v7)
        }):Play();
        task.delay(v2, function() -- Line: 64
            -- upvalues: TweenService (ref), Part (copy)
            TweenService:Create(Part, TweenInfo.new(0.35), {
                Transparency = 1
            }):Play();
        end);
        local _ = i;
    end;
end;