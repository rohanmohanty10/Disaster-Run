  

 

require(game.ReplicatedStorage.ReplicatedModules.KnitPackage.Promise);
local u1 = {
    Skins = {},
    Particles = {}
};

for _, descendant in script.Particles:GetDescendants() do
    if descendant:IsA("ModuleScript") then
        local success, result = pcall(function() -- Line: 10
            -- upvalues: descendant (copy), u1 (copy)
            for i, v in require(descendant) do
                if u1.Particles[i] then
                    warn(i, "ALREADY FOUND", descendant);
                else
                    u1.Particles[i] = v;
                end;
            end;
        end);

        if not success then
            warn(result);
        end;
    end;
end;

for _, descendant in script.Skins:GetDescendants() do
    if descendant:IsA("ModuleScript") then
        local success, result = pcall(function() -- Line: 28
            -- upvalues: descendant (copy), u1 (copy)
            for i, v in require(descendant) do
                if not v.Testing or game.GameId ~= 1782832995 then
                    if u1.Skins[i] then
                        warn(i, "ALREADY FOUND", descendant);
                    else
                        u1.Skins[i] = v;
                    end;
                end;
            end;
        end);

        if not success then
            warn(result);
        end;
    end;
end;

for _, v in u1.Particles do
    local ParticleInfo = v.ParticleInfo;

    if ParticleInfo then
        for _, v2 in ParticleInfo do
            local AlternateProperties = v2.AlternateProperties;

            if AlternateProperties then
                for i, v3 in pairs(AlternateProperties) do
                    if type(v3) == "string" and AlternateProperties[v3] then
                        AlternateProperties[i] = AlternateProperties[v3];
                    end;
                end;
            end;
        end;
    end;
end;

function u1.GetSkinInfo(p2) -- Line: 61
    -- upvalues: u1 (copy)
    return u1.Skins[p2];
end;

function u1.GetParticleInfo(p3) -- Line: 65
    -- upvalues: u1 (copy)
    return u1.Particles[p3];
end;

return u1;