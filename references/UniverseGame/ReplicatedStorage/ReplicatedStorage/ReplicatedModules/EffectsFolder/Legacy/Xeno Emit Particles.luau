  

 

local u1 = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("FetchUserQualityLevel");

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    local u5 = p4 or {};
    local v6 = {};
    local u7 = {};
    local u8 = u5.Duration or 0;
    local u9 = u5.Amount or 20;

    if type(p2) == "table" then
        v6 = p2;
    else
        table.insert(v6, p2);
    end;

    if type(p3) == "table" then
        u7 = p3;
    else
        table.insert(u7, p3);
    end;

    for i = 1, #v6 do
        local u10 = v6[i];

        for i2 = 1, #u7 do
            coroutine.wrap(function() -- Line: 25
                -- upvalues: u7 (ref), i2 (copy), u10 (copy), u5 (copy), u8 (copy), u1 (ref), u9 (copy)
                local u11 = u7[i2]:Clone();
                u11.CanCollide = false;
                u11.Massless = true;

                if typeof(u10) == "CFrame" then
                    u11.Anchored = true;
                    u11.CFrame = u10;
                elseif typeof(u10) == "Vector3" then
                    u11.Anchored = true;
                    u11.CFrame = CFrame.new(u10);
                else
                    u11.Anchored = false;
                    local Motor6D = Instance.new("Motor6D");
                    Motor6D.Parent = u11;
                    Motor6D.Part0 = u10;
                    Motor6D.Part1 = u11;
                    Motor6D.C0 = u5.Offset or CFrame.new(0, 0, 0);

                    if u5.Detach then
                        coroutine.wrap(function() -- Line: 47
                            -- upvalues: u8 (ref), Motor6D (copy), u11 (ref)
                            wait(u8);
                            Motor6D:Destroy();
                            u11.Anchored = true;
                        end)();
                    end;
                end;

                u11.Parent = workspace.Effects;
                local u12 = nil;
                coroutine.wrap(function() -- Line: 58
                    -- upvalues: u11 (ref), u12 (ref), u5 (ref), u1 (ref), u8 (ref), u9 (ref)
                    for _, descendant in pairs(u11:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                            local Lifetime = descendant.Lifetime;

                            if type(Lifetime) ~= "number" then
                                Lifetime = Lifetime.Max;
                            end;

                            if not u12 or u12 < Lifetime then
                                u12 = Lifetime;
                            end;

                            if u5.Properties then
                                for i3, v in pairs(u5.Properties) do
                                    descendant[i3] = v;
                                end;
                            end;

                            if u5.Emission == "Enable" then
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.Rate = 50 * u1();
                                end;

                                coroutine.wrap(function() -- Line: 80
                                    -- upvalues: descendant (copy), u8 (ref)
                                    descendant.Enabled = true;
                                    wait(u8);
                                    descendant.Enabled = false;
                                end)();
                            elseif descendant:IsA("ParticleEmitter") then
                                descendant:Emit((u5.Config == true and descendant:GetAttribute("EmitCount") or u9) * u1());
                            end;
                        end;
                    end;

                    wait(u12 + u8);
                    u11:Destroy();
                end)();
            end)();
        end;
    end;
end;