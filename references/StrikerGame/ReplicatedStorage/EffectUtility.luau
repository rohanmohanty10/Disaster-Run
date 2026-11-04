 

 

local u1 = {};

local function IsSettingOn(p2) -- Line: 6
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local v3 = false;

    if LocalPlayer:FindFirstChild("setting") and (not v3 and LocalPlayer.setting:FindFirstChild(p2)) then
        v3 = LocalPlayer.setting:FindFirstChild(p2).Value;
    end;

    return v3;
end;

function u1.ToggleAttachment(p4: userdata, p5: boolean, p6: number?) -- Line: 19
    -- upvalues: u1 (copy)
    for _, descendant in ipairs(p4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p5;
        end;
    end;

    if p6 ~= nil and p6 > 0 then
        task.delay(p6, u1.ToggleAttachment, p4, false);
    end;
end;

function u1.EmitAttachment(p7: userdata) -- Line: 31
    -- upvalues: IsSettingOn (copy)
    if IsSettingOn("NoVFXAtAll") then
        return;
    end;

    for _, descendant in ipairs(p7:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local v8 = descendant:GetAttribute("EmitCount") or 1;
            local v9 = descendant:GetAttribute("EmitDelay") or 0;

            if v9 > 0 then
                task.delay(v9, descendant.Emit, descendant, v8);
            else
                descendant:Emit(v8);
            end;
        end;
    end;
end;

return u1;