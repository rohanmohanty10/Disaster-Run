  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2) -- Line: 6
    -- upvalues: ReplicatedStorage (copy), ParticleHandler (copy), TweenService (copy)
    local v3 = ReplicatedStorage["Client Assets"].Broly.BrolyBeam:Clone();
    v3.Position = p1;
    v3.Parent = workspace.Effects;

    for _, descendant in pairs(v3:GetDescendants()) do
        if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
            descendant.Color = ParticleHandler.HSVShift(descendant.Color, p2 or {});
            task.spawn(function() -- Line: 15
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
                wait(2.5);
                descendant.Enabled = false;
            end);
        end;

        coroutine.wrap(function() -- Line: 22
            -- upvalues: descendant (copy), TweenService (ref)
            if descendant.Name == "theuppart" then
                TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic), {
                    Position = descendant.Position + Vector3.new(0, 20, 0)
                }):Play();
            end;

            wait(1);

            if descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic), {
                    Width0 = 0.1,
                    Width1 = 0.1
                }):Play();
            end;
        end)();
    end;
end;