  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3, p4, p5, p6) -- Line: 5
    -- upvalues: ParticleHandler (copy)
    local v7 = p1:Clone();
    local v8;

    if typeof(p2) == "CFrame" then
        v8 = Instance.new("Part");
        v8.CFrame = p2;
    else
        v8 = p2;
    end;

    local wait = task.wait;
    local v9 = {};

    if p6 and p6.HSVData then
        ParticleHandler.Unusualify(v7, {
            HSVData = p6.HSVData
        });
    end;

    v7.Parent = workspace.Effects;

    if p4 == "Enable" then
        for _, descendant in ipairs(v7:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant.Enabled = true;
            end;
        end;
    elseif p4 == "Emit" then
        for _, descendant in ipairs(v7:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                table.insert(v9, descendant);
            end;
        end;
    end;

    local v10 = p5 or 1;
    local v11 = 0;

    while true do
        v7.CFrame = v8.CFrame;

        if p4 == "Emit" then
            for _, v in ipairs(v9) do
                v:Emit(v10);
            end;
        end;

        v11 = v11 + wait();

        if p3 < v11 then
            if p4 == "Enable" then
                for _, descendant in ipairs(v7:GetDescendants()) do
                    if descendant.ClassName == "ParticleEmitter" then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            wait(1);
            v7:Destroy();

            return;
        end;
    end;
end;