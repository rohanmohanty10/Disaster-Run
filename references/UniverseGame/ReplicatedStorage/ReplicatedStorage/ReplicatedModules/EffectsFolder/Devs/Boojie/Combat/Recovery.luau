  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local ClientAssets = PathShortcuts.ClientAssets;

return function(p1) -- Line: 5
    -- upvalues: ClientAssets (copy), GenericModule (copy)
    if not p1 then
        return;
    end;

    local Torso = p1:FindFirstChild("Torso");

    if not Torso then
        return;
    end;

    local u2 = {};
    local u3 = {};

    local function Add(p4, p5) -- Line: 16
        -- upvalues: u2 (copy), Add (copy), u3 (copy)
        if p4:IsA("ParticleEmitter") then
            table.insert(u2, p4);
        else
            for _, child in pairs(p4:GetChildren()) do
                Add(child, true);
            end;
        end;

        if not p5 then
            table.insert(u3, p4);
        end;
    end;

    for _, child in pairs(ClientAssets.Combat.Recovery:GetChildren()) do
        local v6 = child:Clone();
        Add(v6);
        v6.Parent = Torso;
    end;

    local v7 = 0;

    for _, v in pairs(u2) do
        if v:IsA("ParticleEmitter") then
            local v8 = GenericModule.Emit(v);

            if v7 < v8 then
                v7 = v8;
            end;
        end;
    end;

    task.wait(v7 + 0.5);

    for _, v in pairs(u3) do
        v:Destroy();
    end;
end;