 
 

local function set_weapon(p1, p2) -- Line: 1
    for _, v in { "Allas", "RienAllas" } do
        local v3 = p1["Right Arm"]:FindFirstChild(v);

        if v3 then
            for _, descendant in v3:GetDescendants() do
                if descendant:IsA("MeshPart") and not descendant:GetAttribute("AlwaysHidden") then
                    descendant.Transparency = p2;
                end;
            end;
        end;
    end;
end;

return {
    { 0, function(p4, p5) -- Line: 16
            -- upvalues: set_weapon (copy)
            shared.vfx.emit(p4.doubt);
            shared.vfx.emit(p5["Right Arm"].Allas.Part:FindFirstChild("yellowstuff") or p5["Right Arm"].Allas.Part);

            for _, descendant in pairs(p5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            set_weapon(p5, 1);
        end },
    { 8, function(p6, p7) -- Line: 30
            -- upvalues: set_weapon (copy)
            set_weapon(p7, 0);
        end },
    { 52, function(p8, p9) -- Line: 35
            shared.vfx.emit(p8.brass);

            for _, descendant in pairs(p9:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 90, function(p10, p11) -- Line: 46
            for _, descendant in pairs(p11:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 120, function(p12, p13) -- Line: 55
            -- upvalues: set_weapon (copy)
            set_weapon(p13, 1);
        end }
};