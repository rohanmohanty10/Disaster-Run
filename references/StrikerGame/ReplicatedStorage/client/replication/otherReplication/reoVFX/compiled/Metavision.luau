 

 

return {
    { 0, function(p1) -- Line: 3
            for _, v in p1.Tunnel:QueryDescendants("BasePart, Decal, Texture") do
                v.Transparency = 1;
            end;
        end },
    { 14, function(p2) -- Line: 10
            for _, descendant in ipairs(p2.Clash:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in ipairs(p2.Cam1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.9, function() -- Line: 19
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 75, function(p3) -- Line: 25
            for _, descendant in ipairs(p3.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 86, function(p4) -- Line: 34
            for _, descendant in ipairs(p4.Slide:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.6, function() -- Line: 38
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            for _, descendant in ipairs(p4.Cam1Speed:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.8, function() -- Line: 44
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 106, function(p5) -- Line: 50
            for _, descendant in ipairs(p5.Steal:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 178, function(p6) -- Line: 60
            for _, v in { p6.Head } do
                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("SpotLight") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 192, function(p7) -- Line: 76
            if workspace:FindFirstChild("map") and (workspace.map:FindFirstChild("map") and workspace.map.map:FindFirstChild("sanam")) then
                local sanam = workspace.map.map:FindFirstChild("sanam");

                if sanam and sanam:FindFirstChild("main") then
                    if not sanam.main:GetAttribute("og_color") then
                        sanam.main:SetAttribute("og_color", sanam.main.Color);
                    end;

                    sanam:FindFirstChild("main").Color = Color3.fromRGB(0, 0, 0);
                    shared.cached_grass = sanam.main.Material;
                    sanam:FindFirstChild("main").Material = Enum.Material.Neon;

                    for _, descendant in sanam:GetDescendants() do
                        if descendant:IsA("BasePart") and (descendant ~= sanam.main and descendant.Transparency ~= 1) then
                            if not descendant:GetAttribute("originaltransparency") then
                                descendant:SetAttribute("originaltransparency", descendant.Transparency);
                            end;

                            descendant.Transparency = 1;
                        end;
                    end;
                end;
            end;

            for _, v in { p7.Last, p7.Floor } do
                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("SpotLight") then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            for _, v in p7.Tunnel:QueryDescendants("BasePart,Decal,Texture") do
                v.Transparency = 0;
            end;

            for _, descendant in ipairs(p7.Aura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 304, function(p8) -- Line: 125
            local v9 = { p8.Last, p8.Floor };

            if workspace:FindFirstChild("map") and (workspace.map:FindFirstChild("map") and workspace.map.map:FindFirstChild("sanam")) then
                local sanam = workspace.map.map:FindFirstChild("sanam");

                if sanam and (sanam:FindFirstChild("main") and sanam.main:GetAttribute("og_color")) then
                    sanam.main.Color = sanam.main:GetAttribute("og_color");
                    sanam.main.Material = shared.cached_grass or Enum.Material.Grass;
                    shared.cached_grass = nil;

                    for _, descendant in sanam:GetDescendants() do
                        if descendant:IsA("BasePart") and (descendant ~= sanam.main and descendant:GetAttribute("originaltransparency")) then
                            descendant.Transparency = descendant:GetAttribute("originaltransparency");
                        end;
                    end;
                end;
            end;

            for _, v in v9 do
                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("SpotLight") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            local v10 = { p8.CamSpeedlines, p8.Eyes };

            for _, v in p8.Tunnel:QueryDescendants("BasePart,Decal,Texture") do
                v.Transparency = 1;
            end;

            for _, v in v10 do
                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                        descendant:Clear();
                    end;
                end;
            end;

            for _, descendant in ipairs(p8.Head:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant:Clear();
                end;
            end;
        end },
    { 381, function(p11) -- Line: 184
            for _, v in { p11.CamSpeedlines, p11.Eyes } do
                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                        descendant:Clear();
                    end;
                end;
            end;
        end }
};