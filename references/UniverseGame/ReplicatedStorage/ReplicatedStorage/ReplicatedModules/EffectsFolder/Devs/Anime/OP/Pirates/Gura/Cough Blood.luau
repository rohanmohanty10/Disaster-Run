  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Include;
u3.FilterDescendantsInstances = { workspace.Map };

return function(p4, p5) -- Line: 19
    -- upvalues: u1 (copy), ParticleHandler (copy), u2 (copy), u3 (copy)
    local Head = p4.Head;
    local u6 = u1.Gura.MouthBlood:Clone();
    u6.Parent = p4;
    ParticleHandler.AttachTo(u6, {
        Part = p4.Head,
        Offset = CFrame.identity
    });
    local u7 = ParticleHandler.GenerateEmitInfo(u6);
    task.delay(ParticleHandler.GetMaxLifetime(u6) + p5[#p5] / 60, u6.Destroy, u6);

    for _, v in p5 do
        task.delay(v / 60, function() -- Line: 35
            -- upvalues: ParticleHandler (ref), u6 (copy), u7 (copy), Head (copy), u2 (ref), u1 (ref), u3 (ref)
            ParticleHandler.Emit(u6, u7);

            for _ = 1, math.random(4, 7) do
                if not Head:IsDescendantOf(game) then
                    break;
                end;

                local CFrame2 = Head.CFrame;
                local Angles = CFrame.Angles;
                local v8 = u2:NextNumber(45, 90);
                local v9 = math.rad(v8);
                local v10 = u2:NextNumber(-45, 45);
                local u11 = (CFrame2 * Angles(v9, math.rad(v10), 0)).LookVector * u2:NextNumber(12, 17);
                local u12 = u1.Gura.BloodTrail:Clone();
                u12.Position = (Head.CFrame * CFrame.new(0, -1, -2.5)).Position;
                u12.Parent = workspace.Effects;
                task.spawn(function() -- Line: 51
                    -- upvalues: u12 (copy), u11 (ref), u3 (ref), u1 (ref), ParticleHandler (ref)
                    for _ = 1, 100 do
                        local v13 = task.wait() * 2;
                        local v14 = workspace:Raycast(u12.Position, u11 * v13, u3);

                        if v14 then
                            u12.Position = v14.Position;
                            local v15 = u1.Gura.GroundBlood:Clone();
                            v15.CFrame = CFrame.new(v14.Position, v14.Position + v14.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
                            v15.Parent = workspace.Effects;
                            ParticleHandler.DestroyEmit(v15);
                            ParticleHandler.Emit(v15, ParticleHandler.GenerateEmitInfo(v15));
                            break;
                        end;

                        u11 = u11 - Vector3.new(0, 45, 0) * v13;
                        local v16 = u12;
                        v16.Position = v16.Position + u11 * v13;
                    end;

                    for _, descendant in u12:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                            descendant.Enabled = false;
                        end;
                    end;

                    task.delay(4, u12.Destroy, u12);
                end);
                task.wait(u2:NextNumber(0.01, 0.02));
            end;
        end);
    end;
end;