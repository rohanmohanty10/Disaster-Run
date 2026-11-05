  

 

return function(p1) -- Line: 1
    local Character = p1.Character;

    if not Character then
        return;
    end;

    local Value = p1.Value;
    local Blades = p1.Blades;
    local v2 = typeof(Blades) == "string" and { Blades } or Blades;
    local v3 = p1.BladesModel or Character:FindFirstChild("Blades");

    if not v3 then
        return;
    end;

    for _, v in pairs(v2) do
        local v4 = v3[v .. "Blade"];
        local LightDancerFX = v4:FindFirstChild("LightDancerFX");

        for _, descendant in pairs(v4:GetDescendants()) do
            if descendant ~= LightDancerFX and not (LightDancerFX and descendant:IsDescendantOf(LightDancerFX)) and (descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam"))) then
                descendant.Enabled = Value;

                if descendant.Parent.Name == "SummonVFX" and Value then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or (descendant.Rate or 5));
                end;
            end;
        end;
    end;
end;