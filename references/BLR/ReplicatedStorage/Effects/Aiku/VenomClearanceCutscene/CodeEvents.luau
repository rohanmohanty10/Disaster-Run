  

local u3 = {
    { 1, function() -- Line: 3
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.ScreenEffect2);
        end },
    { 124, function() -- Line: 6
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.aikuemit1);
        end },
    { 131, function() -- Line: 9
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.Shot);
        end },
    { 132, function() -- Line: 12
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.WindGust1);
        end },
    { 166, function() -- Line: 15
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.Start2);
        end },
    { 189, function() -- Line: 18
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.Start3);
        end },
    { 284, function() -- Line: 21
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            if not v1 then
                return;
            end;

            shared.vfx.emit(v1.Torso.FlowAuraTorsoBlack);
        end },
    { 341, function() -- Line: 32
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.CamZoom2);
        end },
    { 342, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.WindGust2);
        end },
    { 343, function() -- Line: 38
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            if not v2 then
                return;
            end;

            shared.vfx.emit(v2.Torso.FlowAuraTorsoGreen);
        end },
    { 344, function() -- Line: 49
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.aikuemit2);
        end }
};

return function(u4) -- Line: 54
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 55
        -- upvalues: u4 (copy), u3 (ref)
        local v5 = 0;

        while u4:IsPlaying() do
            local CurrentFrame = u4.CurrentFrame;

            for _, v in u3 do
                if v[1] <= CurrentFrame and v5 < v[1] then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v5 = CurrentFrame;
        end;
    end);
end;