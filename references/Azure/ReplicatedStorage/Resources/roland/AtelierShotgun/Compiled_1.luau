 
 

local function set_gun_visible(p1, p2) -- Line: 2
    local AtelierShotgun = p1:FindFirstChild("AtelierShotgun");

    if not AtelierShotgun then
        return;
    end;

    for _, descendant in AtelierShotgun:GetDescendants() do
        if descendant:IsA("MeshPart") and descendant.Name ~= "SummonVFX" then
            descendant.Transparency = p2 and 0 or 1;
        end;
    end;
end;

return {
    { 110, function(p3, p4) -- Line: 14
            shared.vfx.emit(p3.VFX.FloorImpact);
        end },
    { 131, function(p5, p6) -- Line: 19
            -- upvalues: set_gun_visible (copy)
            set_gun_visible(p6, true);
        end },
    { 132, function(p7, p8) -- Line: 24
            local AtelierShotgun = p8:FindFirstChild("AtelierShotgun");

            if AtelierShotgun then
                AtelierShotgun = AtelierShotgun:FindFirstChild("SummonVFX");
            end;

            if AtelierShotgun then
                shared.vfx.emit(AtelierShotgun);
            end;
        end },
    { 168, function(p9, p10) -- Line: 33
            shared.vfx.emit(p9.VFX.Shoot);
        end },
    { 194, function(p11, p12) -- Line: 38
            -- upvalues: set_gun_visible (copy)
            set_gun_visible(p12, false);
        end }
};