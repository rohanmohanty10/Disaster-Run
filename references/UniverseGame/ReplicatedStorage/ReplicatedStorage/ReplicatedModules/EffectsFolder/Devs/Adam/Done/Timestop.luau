  

 

local TweenService = game:GetService("TweenService");
local u1 = nil;

return function(p2, p3, p4) -- Line: 4
    -- upvalues: u1 (ref), TweenService (copy)
    if p3 and u1 then
        u1:Destroy();
        u1 = nil;
    end;

    if not p3 and u1 then
        TweenService:Create(u1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Saturation = 0
        }):Play();
        wait(1);
        u1:Destroy();
        u1 = nil;

        return;
    end;

    u1 = Instance.new("ColorCorrectionEffect");
    u1.Name = "TSEffect";
    u1.Parent = game.Lighting;
    local u5 = u1;
    task.delay(15, function() -- Line: 21
        -- upvalues: u5 (copy), u1 (ref)
        if u5 == u1 then
            u1 = nil;
        end;

        u5:Destroy();
    end);

    for i = 1, 2 do
        local u6 = i == 1 and 75 or (i == 2 and 100 or nil);
        local Part = Instance.new("Part");
        Part.Parent = workspace;
        Part.CastShadow = false;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.Shape = "Ball";
        Part.Material = Enum.Material.ForceField;
        Part.CFrame = p4 and p4.CFrame or p2.HumanoidRootPart.CFrame;
        Part.Size = Vector3.new(2, 2, 2);
        task.spawn(function() -- Line: 46
            -- upvalues: TweenService (ref), Part (copy), u6 (ref), i (copy), u1 (ref)
            TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = Vector3.new(u6, u6, u6)
            }):Play();

            if i == 1 then
                TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FieldOfView = 100
                }):Play();
                task.spawn(function() -- Line: 50
                    -- upvalues: TweenService (ref), u1 (ref)
                    for _ = 1, 10 do
                        TweenService:Create(u1, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Contrast = math.random(-5, 5),
                            Saturation = math.random(-5, 5),
                            TintColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                        }):Play();
                        wait(0.1);
                    end;

                    TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
                    }):Play();
                    TweenService:Create(u1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Contrast = 0,
                        Saturation = -1.5,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                end);
            end;

            wait(1);
            TweenService:Create(Part, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
            wait(0.5);
            Part:Destroy();
        end);
    end;
end;