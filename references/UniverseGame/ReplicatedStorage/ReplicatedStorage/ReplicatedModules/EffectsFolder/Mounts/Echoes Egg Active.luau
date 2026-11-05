  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
require(PathShortcuts.KnitPath.Trove);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = ReplicatedStorage:FindFirstChild("Client Assets");

return function(p3, p4) -- Line: 18
    -- upvalues: u2 (copy), ParticleHandler (copy), u1 (copy)
    local v5 = p3:WaitForChild(p4 or "Echoes Egg", 5);

    if not v5 then
        return;
    end;

    local v6 = v5.Root:GetChildren();
    local v7 = #v6;
    local v8 = os.clock();
    local v9 = u2.Misc[v5.Name .. " Dust"]:Clone();
    v9.Parent = p3;
    ParticleHandler.AttachTo(v9, {
        Part = p3.HumanoidRootPart,
        Offset = CFrame.new(0, 3, 0)
    });

    while true do
        if v9:IsDescendantOf(game) then
            local v10 = workspace:Raycast(p3.HumanoidRootPart.Position, Vector3.new(0, -5, 0), u1);

            if v10 then
                local v11, v12, v13 = v10.Instance.Color:ToHSV();
                ParticleHandler.HSVShiftParticles(v9, {
                    Hue = v11,
                    Saturation = v12,
                    Value = v13
                });
            end;

            local v14;

            if v10 == nil then
                v14 = false;
            else
                v14 = (p3.HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude > 5;
            end;

            ParticleHandler.EnableParticles(v9, v14);
        end;

        if v5.Name == "Echoes Egg" and os.clock() - v8 > 2 then
            v8 = os.clock();
            local v15;

            repeat
                v15 = v6[math.random(1, v7)];
                task.wait();
            until v15 ~= nil and (v15.Name ~= "EmitBurst" and v15:IsA("Attachment"));

            ParticleHandler.Emit(v15, ParticleHandler.GenerateEmitInfo(v15));
            ParticleHandler.Emit(v5.Root.EmitBurst, ParticleHandler.GenerateEmitInfo(v5.Root.EmitBurst));
        end;

        task.wait(0.1);

        if not (p3:IsDescendantOf(game) and p3:GetAttribute("Mount")) then
            v9:Destroy();

            return;
        end;
    end;
end;