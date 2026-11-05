  

 

local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");

return function(p2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    local u4 = {};
    local u5 = {};

    local function Add(p6, p7) -- Line: 7
        -- upvalues: u4 (copy), Add (copy), u5 (copy)
        if p6:IsA("ParticleEmitter") then
            p6.Enabled = true;
            table.insert(u4, p6);
        else
            for _, child in pairs(p6:GetChildren()) do
                Add(child, true);
            end;
        end;

        if not p7 then
            table.insert(u5, p6);
        end;
    end;

    for _, child in pairs(u1.Whitesnake.MeltYourHeartSmoke:GetChildren()) do
        local v8 = child:Clone();
        Add(v8);
        v8.Parent = p2;
    end;

    task.wait(p3);

    for _, v in pairs(u4) do
        if v:IsA("ParticleEmitter") then
            v.Enabled = false;
            task.delay(v.Lifetime.Max + 0.5, function() -- Line: 32
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;
    end;

    task.wait(5);

    for _, v in pairs(u5) do
        v:Destroy();
    end;
end;