  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    for _, child in ipairs(p1:GetChildren()) do
        if child:IsA("BasePart") and (child.Name ~= "HumanoidRootPart" and child.Transparency ~= 1) then
            local Part = Instance.new("Part");
            Part.Parent = game.Workspace;
            Part.Transparency = 0;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.Size = child.Size;
            Part.CFrame = child.CFrame;
            Part.BrickColor = BrickColor.new("Really black");
            Part.Material = Enum.Material.Neon;
            pcall(function() -- Line: 16
                -- upvalues: Part (copy)
                Part.face:Destroy();
            end);
            coroutine.wrap(function() -- Line: 20
                -- upvalues: TweenService (ref), Part (copy)
                TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                wait(1);
                Part:Destroy();
            end)();
        end;
    end;

    for i = 1, 4 do
        local v2 = p1["Right Arm"];

        if i == 2 then
            v2 = p1["Left Arm"];
        elseif i == 3 then
            v2 = p1["Right Leg"];
        elseif i == 4 then
            v2 = p1["Left Leg"];
        end;

        local u3 = game.ReplicatedStorage["Client Assets"].Flames2.Attachment:Clone();
        u3.Parent = v2;
        u3.ParticleEmitter.Enabled = true;
        coroutine.wrap(function() -- Line: 40
            -- upvalues: u3 (copy)
            wait(0.4);
            u3.ParticleEmitter.Enabled = false;
            wait(2);
            u3:Destroy();
        end)();
    end;
end;