  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    for _, child in ipairs(p1:GetChildren()) do
        if child:IsA("BasePart") and (child.Name ~= "HumanoidRootPart" and child.Transparency ~= 1) then
            local Part = Instance.new("Part");
            Part.Parent = game.Workspace.Effects;
            Part.Transparency = 0.45;
            Part.CFrame = child.CFrame;
            Part.Size = child.Size + child.Size * 0.05;
            Part.Anchored = false;
            Part.CanCollide = false;
            Part.Name = "Effect";
            Part.BrickColor = BrickColor.new("Institutional white");
            Part.Material = Enum.Material.Neon;
            pcall(function() -- Line: 17
                -- upvalues: Part (copy)
                Part.face:Destroy();
            end);
            pcall(function() -- Line: 21
                -- upvalues: child (copy), Part (copy)
                child.Mesh:Clone().Parent = Part;
            end);
            local Weld = Instance.new("Weld");
            Weld.Parent = child;
            Weld.Part0 = child;
            Weld.Part1 = Part;
            coroutine.wrap(function() -- Line: 30
                -- upvalues: TweenService (ref), Part (copy), Weld (copy)
                TweenService:Create(Part, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                wait(0.5);
                Weld:Destroy();
                Part:Destroy();
            end)();
        end;
    end;
end;