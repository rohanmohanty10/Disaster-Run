  

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(script.Parent.SoundManager);
require(ReplicatedStorage.Shared.Essentials);

function v1.Emit2(p2) -- Line: 10
    for _, descendant in ipairs(p2:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
            local u3 = descendant:GetAttribute("EmitDelay") or 0;
            local u4 = descendant:GetAttribute("EmitCount") or 1;
            local u5 = descendant:GetAttribute("EmitDuration") or 0;
            task.spawn(function() -- Line: 16
                -- upvalues: u3 (copy), descendant (copy), u4 (copy), u5 (copy)
                task.wait(u3);

                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(u4);
                end;

                if u5 > 0 then
                    descendant.Enabled = true;
                    task.wait(u5);
                    descendant.Enabled = false;
                end;
            end);
        end;
    end;
end;

function v1.Emit(p6) -- Line: 32
    local Descendants = p6:GetDescendants();

    for _, v in pairs(Descendants) do
        if v:IsA("ParticleEmitter") then
            task.defer(function() -- Line: 36
                -- upvalues: v (copy)
                if v:GetAttribute("EmitDelay") and v:GetAttribute("EmitDelay") > 0 and true or false then
                    task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 44
                        -- upvalues: v (ref)
                        v:Emit(v:GetAttribute("EmitCount"));
                    end);

                    return;
                end;

                if not v:GetAttribute("EmitDuration") or v:GetAttribute("EmitDuration") <= 0 then
                    v:Emit(v:GetAttribute("EmitCount"));

                    return;
                end;

                v.Enabled = true;
                task.delay(v:GetAttribute("EmitDuration"), function() -- Line: 56
                    -- upvalues: v (ref)
                    v.Enabled = false;
                end);
            end);
        elseif v:IsA("Sound") then
            v.SoundGroup = game.SoundService.SFX;

            if v:GetAttribute("Delay") then
                task.delay(v:GetAttribute("Delay"), function() -- Line: 68
                    -- upvalues: v (copy)
                    v:Play();
                end);
            else
                v:Play();
            end;
        end;
    end;

    table.clear(Descendants);
end;

function v1.Enable(p7, u8) -- Line: 80
    local Descendants = p7:GetDescendants();

    local function changeAction(u9) -- Line: 83
        -- upvalues: u8 (copy)
        if u9:IsA("ParticleEmitter") then
            task.defer(function() -- Line: 85
                -- upvalues: u9 (copy), u8 (ref)
                u9.Enabled = u8;
            end);
        end;

        if u9:IsA("Beam") then
            task.defer(function() -- Line: 90
                -- upvalues: u9 (copy), u8 (ref)
                u9.Enabled = u8;
            end);
        end;

        if u9:IsA("Trail") then
            task.defer(function() -- Line: 95
                -- upvalues: u9 (copy), u8 (ref)
                u9.Enabled = u8;
            end);
        end;
    end;

    changeAction(p7);

    for _, v in pairs(Descendants) do
        changeAction(v);
    end;

    table.clear(Descendants);
end;

return v1;