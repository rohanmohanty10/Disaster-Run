  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local u2 = {};

for _, child in pairs(workspace.Map:GetChildren()) do
    if child:FindFirstChild("Collisions") then
        table.insert(u2, child.Collisions);
    end;
end;

local u3 = {};

for _, child in pairs(script:GetChildren()) do
    if child:IsA("ModuleScript") then
        u3[child.Name] = require(child);
    end;
end;

local function RayCastOnMap(p4, p5, p6) -- Line: 19
    -- upvalues: u2 (copy)
    local v7 = RaycastParams.new();
    v7.FilterDescendantsInstances = u2;
    v7.FilterType = Enum.RaycastFilterType.Whitelist;
    local v8 = workspace:Raycast(p4, p5, v7);

    if p6 then
        return v8;
    end;

    if v8 then
        return v8.Position;
    end;

    return p4;
end;

return function(p9, p10, p11) -- Line: 33
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), Debris (copy)
    local _ = p9.CFrame;
    local v12 = u1.TWHV_R.FlashbangExplosion:Clone();
    v12.CFrame = p9.CFrame * CFrame.new(0, 3, 0);
    v12.Orientation = Vector3.new(0, 0, 0);
    local p = v12.CFrame.p;
    local v13 = v12.CFrame.upVector * -3;
    local v14 = RaycastParams.new();
    v14.FilterDescendantsInstances = u2;
    v14.FilterType = Enum.RaycastFilterType.Whitelist;
    local v15 = workspace:Raycast(p, v13, v14);

    if v15 then
        v12.Position = Vector3.new(p9.Position.X, v15.Position.Y + 0.5, p9.Position.Z);
    end;

    v12.Parent = workspace.Effects;
    local Sound = Instance.new("Sound", v12);
    Sound.Volume = 8;
    Sound.SoundId = "rbxassetid://" .. 10850513166;
    Sound:Play();

    for _, descendant in pairs(v12:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 125);

            if p10 then
                u3.TweenSystem:CreateTween({ descendant }, {
                    TweenInfo.new(0.01, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                    {
                        TimeScale = 0
                    }
                });
            end;
        end;
    end;

    v12.PointLight.Enabled = true;
    Debris:AddItem(Sound, 1.5);

    if p10 then
        u3.TweenSystem:CreateTween({ Sound }, {
            TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {
                PlaybackSpeed = 0
            }
        });

        repeat
            task.wait();
        until workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p11;

        u3.TweenSystem:CreateTween({ Sound }, {
            TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {
                PlaybackSpeed = 1
            }
        });
        Sound:Play();

        for _, descendant in pairs(v12:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                u3.TweenSystem:CreateTween({ descendant }, {
                    TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                    {
                        TimeScale = 1
                    }
                });
            end;
        end;
    end;

    u3.TweenSystem:CreateTween({ v12.PointLight }, {
        TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
        {
            Brightness = 0
        }
    });
    Debris:AddItem(v12, 4);
end;