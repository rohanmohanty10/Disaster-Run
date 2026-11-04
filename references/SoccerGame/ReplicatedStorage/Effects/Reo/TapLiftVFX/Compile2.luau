  

local u37 = {
    { 0, function() -- Line: 1
            function Emit(u1: userdata)
                if u1:IsA("Beam") or u1:IsA("Trail") then
                    local Attribute = u1:GetAttribute("EmitDelay");
                    local Attribute2 = u1:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 6
                        -- upvalues: Attribute2 (copy), u1 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u1.Enabled = true;

                            if not u1:GetAttribute("pr3") then
                                u1:SetAttribute("pr3", 0);
                            end;

                            local v2 = (u1:GetAttribute("pr3") + 1) % 1000;
                            u1:SetAttribute("pr3", v2);
                            task.wait(Attribute2);

                            if v2 == u1:GetAttribute("pr3") then
                                u1.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u1:GetAttribute("EmitCount");
                local Attribute2 = u1:GetAttribute("EmitDelay");
                local Attribute3 = u1:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 22
                    -- upvalues: u1 (copy), Attribute (copy), Attribute3 (copy)
                    u1:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u1.Enabled = true;

                        if not u1:GetAttribute("pr3") then
                            u1:SetAttribute("pr3", 0);
                        end;

                        local v3 = (u1:GetAttribute("pr3") + 1) % 1000;
                        u1:SetAttribute("pr3", v3);
                        task.wait(Attribute3);

                        if v3 == u1:GetAttribute("pr3") then
                            u1.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.Ball:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 1, function() -- Line: 46
            function Emit(u4: userdata)
                if u4:IsA("Beam") or u4:IsA("Trail") then
                    local Attribute = u4:GetAttribute("EmitDelay");
                    local Attribute2 = u4:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 51
                        -- upvalues: Attribute2 (copy), u4 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u4.Enabled = true;

                            if not u4:GetAttribute("pr3") then
                                u4:SetAttribute("pr3", 0);
                            end;

                            local v5 = (u4:GetAttribute("pr3") + 1) % 1000;
                            u4:SetAttribute("pr3", v5);
                            task.wait(Attribute2);

                            if v5 == u4:GetAttribute("pr3") then
                                u4.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u4:GetAttribute("EmitCount");
                local Attribute2 = u4:GetAttribute("EmitDelay");
                local Attribute3 = u4:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 67
                    -- upvalues: u4 (copy), Attribute (copy), Attribute3 (copy)
                    u4:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u4.Enabled = true;

                        if not u4:GetAttribute("pr3") then
                            u4:SetAttribute("pr3", 0);
                        end;

                        local v6 = (u4:GetAttribute("pr3") + 1) % 1000;
                        u4:SetAttribute("pr3", v6);
                        task.wait(Attribute3);

                        if v6 == u4:GetAttribute("pr3") then
                            u4.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.Pressure:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 2, function() -- Line: 91
            function Emit(u7: userdata)
                if u7:IsA("Beam") or u7:IsA("Trail") then
                    local Attribute = u7:GetAttribute("EmitDelay");
                    local Attribute2 = u7:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 96
                        -- upvalues: Attribute2 (copy), u7 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u7.Enabled = true;

                            if not u7:GetAttribute("pr3") then
                                u7:SetAttribute("pr3", 0);
                            end;

                            local v8 = (u7:GetAttribute("pr3") + 1) % 1000;
                            u7:SetAttribute("pr3", v8);
                            task.wait(Attribute2);

                            if v8 == u7:GetAttribute("pr3") then
                                u7.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u7:GetAttribute("EmitCount");
                local Attribute2 = u7:GetAttribute("EmitDelay");
                local Attribute3 = u7:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 112
                    -- upvalues: u7 (copy), Attribute (copy), Attribute3 (copy)
                    u7:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u7.Enabled = true;

                        if not u7:GetAttribute("pr3") then
                            u7:SetAttribute("pr3", 0);
                        end;

                        local v9 = (u7:GetAttribute("pr3") + 1) % 1000;
                        u7:SetAttribute("pr3", v9);
                        task.wait(Attribute3);

                        if v9 == u7:GetAttribute("pr3") then
                            u7.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.Glass:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 273, function() -- Line: 136
            function Emit(u10: userdata)
                if u10:IsA("Beam") or u10:IsA("Trail") then
                    local Attribute = u10:GetAttribute("EmitDelay");
                    local Attribute2 = u10:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 141
                        -- upvalues: Attribute2 (copy), u10 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u10.Enabled = true;

                            if not u10:GetAttribute("pr3") then
                                u10:SetAttribute("pr3", 0);
                            end;

                            local v11 = (u10:GetAttribute("pr3") + 1) % 1000;
                            u10:SetAttribute("pr3", v11);
                            task.wait(Attribute2);

                            if v11 == u10:GetAttribute("pr3") then
                                u10.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u10:GetAttribute("EmitCount");
                local Attribute2 = u10:GetAttribute("EmitDelay");
                local Attribute3 = u10:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 157
                    -- upvalues: u10 (copy), Attribute (copy), Attribute3 (copy)
                    u10:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u10.Enabled = true;

                        if not u10:GetAttribute("pr3") then
                            u10:SetAttribute("pr3", 0);
                        end;

                        local v12 = (u10:GetAttribute("pr3") + 1) % 1000;
                        u10:SetAttribute("pr3", v12);
                        task.wait(Attribute3);

                        if v12 == u10:GetAttribute("pr3") then
                            u10.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.KickLand2:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 496, function() -- Line: 181
            function Emit(u13: userdata)
                if u13:IsA("Beam") or u13:IsA("Trail") then
                    local Attribute = u13:GetAttribute("EmitDelay");
                    local Attribute2 = u13:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 186
                        -- upvalues: Attribute2 (copy), u13 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u13.Enabled = true;

                            if not u13:GetAttribute("pr3") then
                                u13:SetAttribute("pr3", 0);
                            end;

                            local v14 = (u13:GetAttribute("pr3") + 1) % 1000;
                            u13:SetAttribute("pr3", v14);
                            task.wait(Attribute2);

                            if v14 == u13:GetAttribute("pr3") then
                                u13.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u13:GetAttribute("EmitCount");
                local Attribute2 = u13:GetAttribute("EmitDelay");
                local Attribute3 = u13:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 202
                    -- upvalues: u13 (copy), Attribute (copy), Attribute3 (copy)
                    u13:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u13.Enabled = true;

                        if not u13:GetAttribute("pr3") then
                            u13:SetAttribute("pr3", 0);
                        end;

                        local v15 = (u13:GetAttribute("pr3") + 1) % 1000;
                        u13:SetAttribute("pr3", v15);
                        task.wait(Attribute3);

                        if v15 == u13:GetAttribute("pr3") then
                            u13.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.KickUp:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 561, function() -- Line: 226
            local Ball = workspace:FindFirstChild("VFX"):FindFirstChild("Ball");

            function Emit(u16: userdata)
                if u16:IsA("Beam") or u16:IsA("Trail") then
                    local Attribute = u16:GetAttribute("EmitDelay");
                    local Attribute2 = u16:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 231
                        -- upvalues: Attribute2 (copy), u16 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u16.Enabled = true;

                            if not u16:GetAttribute("pr3") then
                                u16:SetAttribute("pr3", 0);
                            end;

                            local v17 = (u16:GetAttribute("pr3") + 1) % 1000;
                            u16:SetAttribute("pr3", v17);
                            task.wait(Attribute2);

                            if v17 == u16:GetAttribute("pr3") then
                                u16.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u16:GetAttribute("EmitCount");
                local Attribute2 = u16:GetAttribute("EmitDelay");
                local Attribute3 = u16:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 247
                    -- upvalues: u16 (copy), Attribute (copy), Attribute3 (copy)
                    u16:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u16.Enabled = true;

                        if not u16:GetAttribute("pr3") then
                            u16:SetAttribute("pr3", 0);
                        end;

                        local v18 = (u16:GetAttribute("pr3") + 1) % 1000;
                        u16:SetAttribute("pr3", v18);
                        task.wait(Attribute3);

                        if v18 == u16:GetAttribute("pr3") then
                            u16.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in Ball:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 567, function() -- Line: 271
            function Emit(u19: userdata)
                if u19:IsA("Beam") or u19:IsA("Trail") then
                    local Attribute = u19:GetAttribute("EmitDelay");
                    local Attribute2 = u19:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 276
                        -- upvalues: Attribute2 (copy), u19 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u19.Enabled = true;

                            if not u19:GetAttribute("pr3") then
                                u19:SetAttribute("pr3", 0);
                            end;

                            local v20 = (u19:GetAttribute("pr3") + 1) % 1000;
                            u19:SetAttribute("pr3", v20);
                            task.wait(Attribute2);

                            if v20 == u19:GetAttribute("pr3") then
                                u19.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u19:GetAttribute("EmitCount");
                local Attribute2 = u19:GetAttribute("EmitDelay");
                local Attribute3 = u19:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 292
                    -- upvalues: u19 (copy), Attribute (copy), Attribute3 (copy)
                    u19:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u19.Enabled = true;

                        if not u19:GetAttribute("pr3") then
                            u19:SetAttribute("pr3", 0);
                        end;

                        local v21 = (u19:GetAttribute("pr3") + 1) % 1000;
                        u19:SetAttribute("pr3", v21);
                        task.wait(Attribute3);

                        if v21 == u19:GetAttribute("pr3") then
                            u19.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.GlassImpact:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 574, function() -- Line: 316
            function Emit(u22: userdata)
                if u22:IsA("Beam") or u22:IsA("Trail") then
                    local Attribute = u22:GetAttribute("EmitDelay");
                    local Attribute2 = u22:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 321
                        -- upvalues: Attribute2 (copy), u22 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u22.Enabled = true;

                            if not u22:GetAttribute("pr3") then
                                u22:SetAttribute("pr3", 0);
                            end;

                            local v23 = (u22:GetAttribute("pr3") + 1) % 1000;
                            u22:SetAttribute("pr3", v23);
                            task.wait(Attribute2);

                            if v23 == u22:GetAttribute("pr3") then
                                u22.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u22:GetAttribute("EmitCount");
                local Attribute2 = u22:GetAttribute("EmitDelay");
                local Attribute3 = u22:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 337
                    -- upvalues: u22 (copy), Attribute (copy), Attribute3 (copy)
                    u22:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u22.Enabled = true;

                        if not u22:GetAttribute("pr3") then
                            u22:SetAttribute("pr3", 0);
                        end;

                        local v24 = (u22:GetAttribute("pr3") + 1) % 1000;
                        u22:SetAttribute("pr3", v24);
                        task.wait(Attribute3);

                        if v24 == u22:GetAttribute("pr3") then
                            u22.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.Pressure2:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 693, function() -- Line: 361
            function Emit(u25: userdata)
                if u25:IsA("Beam") or u25:IsA("Trail") then
                    local Attribute = u25:GetAttribute("EmitDelay");
                    local Attribute2 = u25:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 366
                        -- upvalues: Attribute2 (copy), u25 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u25.Enabled = true;

                            if not u25:GetAttribute("pr3") then
                                u25:SetAttribute("pr3", 0);
                            end;

                            local v26 = (u25:GetAttribute("pr3") + 1) % 1000;
                            u25:SetAttribute("pr3", v26);
                            task.wait(Attribute2);

                            if v26 == u25:GetAttribute("pr3") then
                                u25.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u25:GetAttribute("EmitCount");
                local Attribute2 = u25:GetAttribute("EmitDelay");
                local Attribute3 = u25:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 382
                    -- upvalues: u25 (copy), Attribute (copy), Attribute3 (copy)
                    u25:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u25.Enabled = true;

                        if not u25:GetAttribute("pr3") then
                            u25:SetAttribute("pr3", 0);
                        end;

                        local v27 = (u25:GetAttribute("pr3") + 1) % 1000;
                        u25:SetAttribute("pr3", v27);
                        task.wait(Attribute3);

                        if v27 == u25:GetAttribute("pr3") then
                            u25.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.JumpScreen:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;

            game:GetService("TweenService"):Create(workspace.BackgroundFX.Sphere2, TweenInfo.new(2), {
                Transparency = 1,
                Color = Color3.fromRGB(162, 0, 255)
            }):Play();
        end },
    { 845, function() -- Line: 407
            function Emit(u28: userdata)
                if u28:IsA("Beam") or u28:IsA("Trail") then
                    local Attribute = u28:GetAttribute("EmitDelay");
                    local Attribute2 = u28:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 412
                        -- upvalues: Attribute2 (copy), u28 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u28.Enabled = true;

                            if not u28:GetAttribute("pr3") then
                                u28:SetAttribute("pr3", 0);
                            end;

                            local v29 = (u28:GetAttribute("pr3") + 1) % 1000;
                            u28:SetAttribute("pr3", v29);
                            task.wait(Attribute2);

                            if v29 == u28:GetAttribute("pr3") then
                                u28.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u28:GetAttribute("EmitCount");
                local Attribute2 = u28:GetAttribute("EmitDelay");
                local Attribute3 = u28:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 428
                    -- upvalues: u28 (copy), Attribute (copy), Attribute3 (copy)
                    u28:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u28.Enabled = true;

                        if not u28:GetAttribute("pr3") then
                            u28:SetAttribute("pr3", 0);
                        end;

                        local v30 = (u28:GetAttribute("pr3") + 1) % 1000;
                        u28:SetAttribute("pr3", v30);
                        task.wait(Attribute3);

                        if v30 == u28:GetAttribute("pr3") then
                            u28.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.SpeedLines:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 872, function() -- Line: 452
            function Emit(u31: userdata)
                if u31:IsA("Beam") or u31:IsA("Trail") then
                    local Attribute = u31:GetAttribute("EmitDelay");
                    local Attribute2 = u31:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 457
                        -- upvalues: Attribute2 (copy), u31 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u31.Enabled = true;

                            if not u31:GetAttribute("pr3") then
                                u31:SetAttribute("pr3", 0);
                            end;

                            local v32 = (u31:GetAttribute("pr3") + 1) % 1000;
                            u31:SetAttribute("pr3", v32);
                            task.wait(Attribute2);

                            if v32 == u31:GetAttribute("pr3") then
                                u31.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u31:GetAttribute("EmitCount");
                local Attribute2 = u31:GetAttribute("EmitDelay");
                local Attribute3 = u31:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 473
                    -- upvalues: u31 (copy), Attribute (copy), Attribute3 (copy)
                    u31:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u31.Enabled = true;

                        if not u31:GetAttribute("pr3") then
                            u31:SetAttribute("pr3", 0);
                        end;

                        local v33 = (u31:GetAttribute("pr3") + 1) % 1000;
                        u31:SetAttribute("pr3", v33);
                        task.wait(Attribute3);

                        if v33 == u31:GetAttribute("pr3") then
                            u31.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.FinalHit:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end },
    { 875, function() -- Line: 497
            function Emit(u34: userdata)
                if u34:IsA("Beam") or u34:IsA("Trail") then
                    local Attribute = u34:GetAttribute("EmitDelay");
                    local Attribute2 = u34:GetAttribute("EmitDuration");
                    task.delay(tonumber(Attribute) or 0, function() -- Line: 502
                        -- upvalues: Attribute2 (copy), u34 (copy)
                        if tonumber(Attribute2) and Attribute2 ~= 0 then
                            u34.Enabled = true;

                            if not u34:GetAttribute("pr3") then
                                u34:SetAttribute("pr3", 0);
                            end;

                            local v35 = (u34:GetAttribute("pr3") + 1) % 1000;
                            u34:SetAttribute("pr3", v35);
                            task.wait(Attribute2);

                            if v35 == u34:GetAttribute("pr3") then
                                u34.Enabled = false;
                            end;
                        end;
                    end);

                    return;
                end;

                local Attribute = u34:GetAttribute("EmitCount");
                local Attribute2 = u34:GetAttribute("EmitDelay");
                local Attribute3 = u34:GetAttribute("EmitDuration");
                task.delay(tonumber(Attribute2) or 0, function() -- Line: 518
                    -- upvalues: u34 (copy), Attribute (copy), Attribute3 (copy)
                    u34:Emit(Attribute or 0);

                    if tonumber(Attribute3) and Attribute3 ~= 0 then
                        u34.Enabled = true;

                        if not u34:GetAttribute("pr3") then
                            u34:SetAttribute("pr3", 0);
                        end;

                        local v36 = (u34:GetAttribute("pr3") + 1) % 1000;
                        u34:SetAttribute("pr3", v36);
                        task.wait(Attribute3);

                        if v36 == u34:GetAttribute("pr3") then
                            u34.Enabled = false;
                        end;
                    end;
                end);
            end;

            for _, descendant in workspace.BeamEnd:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    Emit(descendant);
                end;
            end;
        end }
};

return function(u38) -- Line: 543
    -- upvalues: u37 (copy)
    task.spawn(function() -- Line: 544
        -- upvalues: u38 (copy), u37 (ref)
        local v39 = 0;

        while u38:IsPlaying() do
            local CurrentFrame = u38.CurrentFrame;

            for _, v in u37 do
                local v40 = v[1];
                local v41 = v[2];

                if v40 <= CurrentFrame and v39 < v40 then
                    task.spawn(v41);
                end;
            end;

            task.wait();
            v39 = CurrentFrame;
        end;
    end);
end;