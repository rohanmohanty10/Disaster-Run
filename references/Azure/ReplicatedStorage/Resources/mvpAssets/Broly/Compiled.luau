 

 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.ScreenEffect);
            shared.vfx.emit(p1.BrolyBurst);
        end },
    { 40, function(p2) -- Line: 9
            shared.vfx.emit(p2.BrolyBurst);
        end },
    { 68, function(p3) -- Line: 14
            shared.vfx.emit(p3.BrolyBurst);
        end },
    { 120, function(p4) -- Line: 19
            shared.vfx.emit(p4.BrolyBurst);
        end },
    { 190, function(p5) -- Line: 24
            shared.vfx.emit(p5.BrolyBurst);
        end },
    { 242, function(p6) -- Line: 29
            shared.vfx.emit(p6.BrolyBurst);
        end },
    { 337, function(p7) -- Line: 34
            shared.vfx.emit(p7.BrolyBurst);
        end },
    { 447, function(p8) -- Line: 39
            shared.vfx.emit(p8.BrolyBurst);
        end },
    { 461, function(p9) -- Line: 44
            local RocksStuff = p9:WaitForChild("RocksStuff");

            for _, descendant in ipairs(RocksStuff:GetDescendants()) do
                if descendant:IsA("Highlight") then
                    descendant.Enabled = true;
                end;
            end;

            local BackgroundRocks = p9:WaitForChild("RocksStuff").BackgroundRocks;

            for _, descendant in ipairs(BackgroundRocks:GetDescendants()) do
                if descendant:IsA("Highlight") then
                    descendant.Enabled = true;
                elseif descendant:IsA("BasePart") then
                    descendant.Transparency = 0;
                end;
            end;
        end },
    { 486, function(p10) -- Line: 65
            local RocksStuff = p10:WaitForChild("RocksStuff");

            for _, descendant in ipairs(RocksStuff:GetDescendants()) do
                if descendant:IsA("Highlight") then
                    descendant.Enabled = false;
                end;
            end;

            local BackgroundRocks = p10:WaitForChild("RocksStuff").BackgroundRocks;

            for _, descendant in ipairs(BackgroundRocks:GetDescendants()) do
                if descendant:IsA("Highlight") then
                    descendant.Enabled = false;
                elseif descendant:IsA("BasePart") then
                    descendant.Transparency = 1;
                end;
            end;
        end },
    { 507, function(p11) -- Line: 86
            shared.vfx.emit(p11.SlowedBurst);
        end }
};