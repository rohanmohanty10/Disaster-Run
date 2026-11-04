  

local VfxManager = require(game.ReplicatedStorage.VfxManager);
local u2 = {
    { 20, function() -- Line: 2
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Fall);
        end },
    { 245, function() -- Line: 6
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Step1);
        end },
    { 290, function() -- Line: 10
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Step2);
        end },
    { 343, function() -- Line: 14
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Step3);
        end },
    { 371, function() -- Line: 18
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Step4);
        end },
    { 502, function() -- Line: 22
            -- upvalues: VfxManager (copy)
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            VfxManager.Emit(v1);
        end },
    { 549, function() -- Line: 33
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Clown);
        end }
};

return function(u3) -- Line: 38
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 39
        -- upvalues: u3 (copy), u2 (ref)
        local v4 = 0;

        while u3:IsPlaying() do
            local CurrentFrame = u3.CurrentFrame;

            for _, v in u2 do
                local v5 = v[1];
                local v6 = v[2];

                if v5 <= CurrentFrame and v4 < v5 then
                    task.spawn(v6);
                end;
            end;

            task.wait();
            v4 = CurrentFrame;
        end;
    end);
end;