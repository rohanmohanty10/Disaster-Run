  

local u1 = {
    { 164, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX.random:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 165, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.random.Torso);
        end },
    { 166, function() -- Line: 11
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].Distortion);
        end },
    { 171, function() -- Line: 14
            local yellowmesh = workspace.VFX["kaiser ness chem VFX"]:FindFirstChild("yellowmesh");

            if yellowmesh then
                shared.vfx.emit(yellowmesh);
            end;
        end },
    { 172, function() -- Line: 20
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].allhailcruffle);
        end },
    { 174, function() -- Line: 23
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].bachiraspawnemit1, workspace.VFX["kaiser ness chem VFX"].Shot2);
        end },
    { 175, function() -- Line: 26
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].Cast);
        end },
    { 176, function() -- Line: 29
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].Start);
        end },
    { 193, function() -- Line: 32
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].Start2);
        end },
    { 205, function() -- Line: 35
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].meshfb);
        end },
    { 221, function() -- Line: 38
            shared.vfx.emit(workspace.VFX.Blr.CamPart.transition1);
        end },
    { 222, function() -- Line: 41
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].allhailcruffle2, workspace.VFX["kaiser ness chem VFX"].allhailcruffle3);
        end },
    { 251, function() -- Line: 44
            for _, descendant in pairs(workspace.VFX.random:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 299, function() -- Line: 51
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].holdddd);
        end },
    { 360, function() -- Line: 54
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].Hold);
        end },
    { 361, function() -- Line: 57
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].cameraemit3);
        end },
    { 378, function() -- Line: 60
            local meshfb2 = workspace.VFX["kaiser ness chem VFX"]:FindFirstChild("meshfb2");

            if meshfb2 then
                shared.vfx.emit(meshfb2);
            end;
        end },
    { 402, function() -- Line: 66
            shared.vfx.emit(workspace.VFX.Blr.CamPart.transition2);
        end },
    { 490, function() -- Line: 69
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].Hold2);
        end },
    { 547, function() -- Line: 72
            local listenup = workspace.VFX["kaiser ness chem VFX"]:FindFirstChild("listenup");

            if listenup then
                shared.vfx.emit(listenup);
            end;
        end },
    { 550, function() -- Line: 78
            local listenup = workspace.VFX["kaiser ness chem VFX"]:FindFirstChild("listenup");

            if listenup then
                listenup = listenup:FindFirstChild("heresastory");
            end;

            if listenup then
                for _, descendant in pairs(listenup:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.TimeScale = 0.65;
                    end;
                end;
            end;
        end },
    { 558, function() -- Line: 89
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].coolmodelpart2);
        end },
    { 559, function() -- Line: 92
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].camerashake1);
        end },
    { 560, function() -- Line: 95
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].cameraemit4);
        end },
    { 563, function() -- Line: 98
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].meshes1);
        end },
    { 593, function() -- Line: 101
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].SpinModel);
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].Start4);
        end },
    { 630, function() -- Line: 105
            local coolmodelpart = workspace.VFX["kaiser ness chem VFX"]:FindFirstChild("coolmodelpart");

            if coolmodelpart then
                shared.vfx.emit(coolmodelpart);
            end;
        end },
    { 682, function() -- Line: 111
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].camerashake2);
        end },
    { 684, function() -- Line: 114
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].coldhere);
        end },
    { 755, function() -- Line: 117
            shared.vfx.emit(workspace.VFX.Ball.BALL);
        end },
    { 756, function() -- Line: 120
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].kaiserimpact);
        end },
    { 757, function() -- Line: 123
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].cameraemit1);
        end },
    { 758, function() -- Line: 126
            shared.vfx.emit(workspace.VFX["kaiser ness chem VFX"].Flames);
        end },
    { 801, function() -- Line: 129
            local listenup = workspace.VFX["kaiser ness chem VFX"]:FindFirstChild("listenup");

            if listenup then
                listenup = listenup:FindFirstChild("heresastory");
            end;

            if listenup then
                for _, descendant in pairs(listenup:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.TimeScale = 1;
                    end;
                end;
            end;
        end }
};

return function(u2) -- Line: 141
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 142
        -- upvalues: u2 (copy), u1 (ref)
        local v3 = 0;

        while u2:IsPlaying() do
            local CurrentFrame = u2.CurrentFrame;

            for _, v in u1 do
                local v4 = v[1];
                local v5 = v[2];

                if v4 <= CurrentFrame and v3 < v4 then
                    task.spawn(v5);
                end;
            end;

            task.wait();
            v3 = CurrentFrame;
        end;
    end);
end;