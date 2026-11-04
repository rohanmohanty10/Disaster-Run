  

local u3 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbddirttrailmoving1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1, function() -- Line: 9
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdcameravfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdcameravfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 3, function() -- Line: 22
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbddirttrailmoving2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 8, function() -- Line: 30
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbddirttrailmoving3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 13, function() -- Line: 38
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbddirttrailmoving4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 24, function() -- Line: 46
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbddirttrailmoving5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 29, function() -- Line: 54
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdatmosphere:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdcameravfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdatmosphere:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 30, function() -- Line: 80
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdballweld:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 117, function() -- Line: 88
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemitstartup:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 123, function() -- Line: 97
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdextraspecs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 124, function() -- Line: 105
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdlight1:GetDescendants()) do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 207, function() -- Line: 112
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdatmosphere:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 237, function() -- Line: 120
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdlight1:GetDescendants()) do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 245, function() -- Line: 127
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit075:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 131
                        -- upvalues: descendant (copy)
                        descendant:Emit(descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 310, function() -- Line: 137
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 316, function() -- Line: 145
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 358, function() -- Line: 162
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdeyeaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 396, function() -- Line: 170
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdeyeauraemit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 480, function() -- Line: 178
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdeyeaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 513, function() -- Line: 186
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdegospeedlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 532, function() -- Line: 194
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdeyeaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 658, function() -- Line: 202
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 665, function() -- Line: 210
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit05:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 800, function() -- Line: 218
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 865, function() -- Line: 226
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdegospeedlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 880, function() -- Line: 234
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 881, function() -- Line: 242
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdballweld.balleffecttimescale:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0;
                end;
            end;
        end },
    { 882, function() -- Line: 250
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0;
                end;
            end;
        end },
    { 899, function() -- Line: 258
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdballweld:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 916, function() -- Line: 266
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdballweld.balleffecttimescale:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end },
    { 917, function() -- Line: 274
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdcameravfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdcameravfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 922, function() -- Line: 287
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemit4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 927, function() -- Line: 301
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdglarecamendpart:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 988, function() -- Line: 308
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdballweld2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 989, function() -- Line: 316
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdemitend:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1075, function() -- Line: 324
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdglarecamendpart:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdglarecamendpart2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1076, function() -- Line: 336
            for _, descendant in pairs(workspace.VFX["Shidou BBD Rework VFX"].bbdballweld2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1077, function() -- Line: 344
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u4) -- Line: 361
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 362
        -- upvalues: u4 (copy), u3 (ref)
        local v5 = 0;

        while u4:IsPlaying() do
            local CurrentFrame = u4.CurrentFrame;

            for _, v in u3 do
                local v6 = v[1];
                local v7 = v[2];

                if v6 <= CurrentFrame and v5 < v6 then
                    task.spawn(v7);
                end;
            end;

            task.wait();
            v5 = CurrentFrame;
        end;
    end);
end;