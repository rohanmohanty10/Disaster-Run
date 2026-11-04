  

local u1 = {};
local u2 = {};

local function setFieldHidden(p3) -- Line: 4
    -- upvalues: u1 (copy), u2 (copy)
    local Field = workspace:FindFirstChild("Field");

    if not Field then
        return;
    end;

    if p3 then
        for _, descendant in Field:GetDescendants() do
            if descendant:IsA("BasePart") then
                if u1[descendant] == nil then
                    u1[descendant] = descendant.LocalTransparencyModifier;
                end;

                descendant.LocalTransparencyModifier = 1;
            elseif descendant:IsA("Texture") or descendant:IsA("Decal") then
                if u2[descendant] == nil then
                    u2[descendant] = descendant.Transparency;
                end;

                descendant.Transparency = 1;
            end;
        end;

        return;
    end;

    for i, v in u1 do
        if i.Parent then
            i.LocalTransparencyModifier = v;
        end;
    end;

    table.clear(u1);

    for i, v in u2 do
        if i.Parent then
            i.Transparency = v;
        end;
    end;

    table.clear(u2);
end;

local u5 = {
    { 1, function() -- Line: 41
            shared.vfx.emit(workspace.VFX.CutsceneVFX.BallAura);
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Cam1);
        end },
    { 80, function() -- Line: 46
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Transition);
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Background);
        end },
    { 226, function() -- Line: 51
            local v4 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v4 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.CutsceneVFX.JumpStart);
            shared.vfx.emit(workspace.VFX.CutsceneVFX.BallAura2);
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Transition2);
            shared.vfx.emit(v4.Highlight);
        end },
    { 349, function() -- Line: 67
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Step);
        end },
    { 397, function() -- Line: 70
            -- upvalues: setFieldHidden (copy)
            setFieldHidden(true);
        end },
    { 403, function() -- Line: 73
            shared.vfx.emit(workspace.VFX.CutsceneVFX.BallAura3);
        end },
    { 646, function() -- Line: 76
            -- upvalues: u1 (copy), u2 (copy)
            if workspace:FindFirstChild("Field") then
                for i, v in u1 do
                    if i.Parent then
                        i.LocalTransparencyModifier = v;
                    end;
                end;

                table.clear(u1);

                for i, v in u2 do
                    if i.Parent then
                        i.Transparency = v;
                    end;
                end;

                table.clear(u2);
            end;

            shared.vfx.emit(workspace.VFX.FinaleShot);
            shared.vfx.emit(workspace.VFX.CutsceneVFX.FinalBallShotTrail);
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Cam2);
            shared.vfx.emit(workspace.VFX.CutsceneVFX.WindGust);
        end }
};

return function(u6) -- Line: 88
    -- upvalues: u5 (copy), u1 (copy), u2 (copy)
    task.spawn(function() -- Line: 89
        -- upvalues: u6 (copy), u5 (ref), u1 (ref), u2 (ref)
        local v7 = 0;

        while u6:IsPlaying() do
            local CurrentFrame = u6.CurrentFrame;

            for _, v in u5 do
                local v8 = v[1];
                local v9 = v[2];

                if v8 <= CurrentFrame and v7 < v8 then
                    task.spawn(v9);
                end;
            end;

            task.wait();
            v7 = CurrentFrame;
        end;

        if not workspace:FindFirstChild("Field") then
            return;
        end;

        for i, v in u1 do
            if i.Parent then
                i.LocalTransparencyModifier = v;
            end;
        end;

        table.clear(u1);

        for i, v in u2 do
            if i.Parent then
                i.Transparency = v;
            end;
        end;

        table.clear(u2);
    end);
end;