  

 

local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");

return function(p2) -- Line: 3
    -- upvalues: u1 (copy)
    local u3 = {};
    local u4 = {};

    local function Add(p5, p6) -- Line: 7
        -- upvalues: u3 (copy), Add (copy), u4 (copy)
        if p5:IsA("ParticleEmitter") then
            p5.Enabled = false;
            table.insert(u3, p5);
        else
            for _, child in pairs(p5:GetChildren()) do
                Add(child, true);
            end;
        end;

        if not p6 then
            table.insert(u4, p5);
        end;
    end;

    for _, child in pairs(u1.Whitesnake.DisguiseConfirm:GetChildren()) do
        local v7 = child:Clone();
        Add(v7);
        v7.Parent = p2;
    end;

    for _, v in pairs(u3) do
        if v:IsA("ParticleEmitter") then
            v:Emit(v:GetAttribute("EmitCount") or 1);
        end;
    end;

    task.wait(5);

    for _, v in pairs(u4) do
        v:Destroy();
    end;
end;