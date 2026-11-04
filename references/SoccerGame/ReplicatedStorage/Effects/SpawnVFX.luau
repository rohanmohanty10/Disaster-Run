  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 7
    -- upvalues: Essentials (copy), VfxManager (copy)
    local u2 = u1.Vfx:Clone();
    u2.Parent = workspace;
    u2:PivotTo(u1.Pos);

    if u1.SpawnTo then
        u2.Parent = u1.SpawnTo;
        task.spawn(function() -- Line: 14
            -- upvalues: u2 (copy), u1 (copy)
            u2.CFrame = u1.SpawnTo.CFrame;
        end);
        Essentials:Weld(u2, u1.SpawnTo);
    end;

    if u1.Player and u1.Player.PlayerStats.Style.Value == "Reo" then
        u1.Color = Color3.new(0.921569, 0.32549, 1);
    end;

    if u1.Color then
        local Descendants = u2:GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") ~= false then
                v.Color = ColorSequence.new(u1.Color);
            end;
        end;

        table.clear(Descendants);
    end;

    VfxManager.Emit(u2);

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("Sound") then
            descendant:Play();
        end;
    end;

    task.delay(10, function() -- Line: 43
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;