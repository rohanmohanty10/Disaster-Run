  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");

return function(u1, p2) -- Line: 8
    -- upvalues: TweenService (copy)
    if not u1 then
        return;
    end;

    local u3 = p2 or {};
    local v4 = u3.Transparency or 0;
    local u5 = u3.Time or 0;
    local Blacklist = u3.Blacklist;

    if u3.CheckBeforeSetting and not u1:GetAttribute("Invisible") then
        return;
    end;

    local v6 = next;
    local v7, v8 = u1:GetDescendants();

    for _, v in v6, v7, v8 do
        if v.Name ~= "HumanoidRootPart" and not (Blacklist and table.find(Blacklist, v.Name)) then
            if (v:IsA("BasePart") or (v:IsA("Decal") or v:IsA("Texture"))) and v.Transparency < 0.99 then
                v:SetAttribute("OldTransparency", v.Transparency);

                if u5 > 0 then
                    TweenService:Create(v, TweenInfo.new(0.1), {
                        Transparency = v4
                    }):Play();
                else
                    v.Transparency = v4;
                end;
            elseif (v:IsA("ParticleEmitter") or (v:IsA("Trail") or v:IsA("Beam"))) and (v.Enabled ~= false and v4 >= 0.5) then
                v.Enabled = false;
                v:SetAttribute("WasEnabled", true);
            end;
        end;
    end;

    u1:GetAttributeChangedSignal("Invisible"):Once(function() -- Line: 43
        -- upvalues: u1 (copy), u3 (ref), u5 (copy), TweenService (ref)
        if not u1 then
            return;
        end;

        local v9 = next;
        local v10, v11 = u1:GetDescendants();

        for _, v in v9, v10, v11 do
            if (v:IsA("BasePart") or (v:IsA("Decal") or v:IsA("Texture"))) and v:GetAttribute("OldTransparency") then
                local v12 = u3.OldTransparency or v:GetAttribute("OldTransparency");
                v:SetAttribute("OldTransparency", nil);

                if u5 > 0 then
                    TweenService:Create(v, TweenInfo.new(0.1), {
                        Transparency = v12
                    }):Play();
                else
                    v.Transparency = v12;
                end;
            elseif (v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Beam"))) and v:GetAttribute("WasEnabled") then
                v.Enabled = true;
                v:SetAttribute("WasEnabled", nil);
            end;
        end;
    end);
end;