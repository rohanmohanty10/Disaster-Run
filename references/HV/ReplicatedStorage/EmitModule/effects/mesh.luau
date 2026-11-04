 

 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/tween");
require("../types");
local u2 = require("../mod/utility");
local u3 = require("../mod/color/Oklab");
local u4 = require("../pkg/Promise");
local Random_new_ret = Random.new();

return {
    emit = function(u5: userdata, u6: userdata, p7: any, p8: number, p9: boolean?) -- Line: 16, Name: emit
        -- upvalues: u2 (copy), Random_new_ret (copy), u1 (copy), RunService (copy), u3 (copy), CollectionService (copy), u4 (copy)
        local Start = u5:FindFirstChild("Start");
        local End = u5:FindFirstChild("End");

        if not (Start and (End and (Start:IsA("BasePart") and (End:IsA("BasePart") and (not u5:GetAttribute("Enabled") or p9))))) then
            return;
        end;

        local Attribute = u2.getAttribute(u5, "Duration", 1, true);
        local RangeAttribute = u2.getRangeAttribute(u5, "EffectDuration", NumberRange.new(Attribute, Attribute), NumberRange.new(0, (1 / 0)));
        local v10 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
        local Attribute2 = u2.getAttribute(u5, "EmitDelay", 0);
        local Attribute3 = u2.getAttribute(u5, "EmitDuration", 0, true);
        local Attribute4 = u2.getAttribute(u5, "Flipbook", false, true);
        local Attribute5 = u2.getAttribute(u5, "FlipbookFadeOffset", 0, true);
        local v11 = (Attribute4 or not Start:FindFirstChildOfClass("Decal")) and "Mesh_" or "Decal_";
        local Attribute6 = u5:GetAttribute("StartTransparency");

        if Attribute6 ~= nil then
            u5:SetAttribute(v11 .. "StartTransparency", Attribute6);
            u5:SetAttribute("StartTransparency", nil);
        end;

        local Attribute7 = u5:GetAttribute("EndTransparency");

        if Attribute7 ~= nil then
            u5:SetAttribute(v11 .. "EndTransparency", Attribute7);
            u5:SetAttribute("EndTransparency", nil);
        end;

        local v12;

        if u5:GetAttribute("Enabled") == nil then
            v12 = false;
        else
            v12 = u5:HasTag(u2.ENABLED_VFX_TAG) and v10 > 0;
        end;

        local Attribute8 = u2.getAttribute(u5, "Decal_StartTransparency", 0, true);
        local Attribute9 = u2.getAttribute(u5, "Decal_EndTransparency", 1, true);
        local v13;

        if Start then
            v13 = Start:FindFirstChildOfClass("Decal");
        else
            v13 = Start;
        end;

        local v14 = v13 and 1 or 0;
        local Attribute10 = u2.getAttribute(u5, "Mesh_StartTransparency", v14, true);
        local Attribute11 = u2.getAttribute(u5, "Mesh_EndTransparency", v14, true);
        local Attribute12 = u2.getAttribute(u5, "SyncPosition", false);
        local Attribute13 = u2.getAttribute(u5, "Speed_Start", 1);
        local Attribute14 = u2.getAttribute(u5, "Speed_End", 1);
        local Attribute15 = u2.getAttribute(u5, "Part_Transparency_Start", Attribute10);
        local Attribute16 = u2.getAttribute(u5, "Part_Transparency_End", Attribute11);
        local Attribute17 = u2.getAttribute(u5, "SpreadAngle", Vector3.new(0, 0, 0));
        local RangeAttribute2 = u2.getRangeAttribute(u5, "Part_RotSpeed_Start", NumberRange.new(0, 0));
        local RangeAttribute3 = u2.getRangeAttribute(u5, "Part_RotSpeed_End", NumberRange.new(0, 0));
        local Attribute18 = u2.getAttribute(u5, "RotAroundOrigin", false);
        local Attribute19 = u2.getAttribute(u5, "MinInitRot", Vector3.new(0, 0, 0));
        local Attribute20 = u2.getAttribute(u5, "MaxInitRot", Vector3.new(0, 0, 0));
        local u15 = Random_new_ret:NextNumber(RangeAttribute2.Min, RangeAttribute2.Max);
        local u16 = Random_new_ret:NextNumber(RangeAttribute3.Min, RangeAttribute3.Max);
        local v17 = Random_new_ret:NextNumber(Attribute19.x, Attribute20.x);
        local v18 = Random_new_ret:NextNumber(Attribute19.y, Attribute20.y);
        local u19 = vector.create(v17, v18, Random_new_ret:NextNumber(Attribute19.z, Attribute20.z)) * u2.DEG_TO_RAD;
        task.wait(Attribute2);

        if v12 and not p9 then
            u5:SetAttribute("Enabled", true);

            if Attribute13 ~= Attribute14 then
                u5:SetAttribute("SpeedTweening", true);
                local fromParams = u1.fromParams;
                local Attribute21 = u2.getAttribute(u5, "Speed_Curve", u2.default_bezier);
                local Attribute22 = u2.getAttribute(u5, "Speed_Duration", 0.1);
                table.insert(p7, fromParams(Attribute21, Attribute22, function(p20, p21) -- Line: 130
                    -- upvalues: u5 (copy), u2 (ref), Attribute13 (copy), Attribute14 (copy)
                    u5:SetAttribute("SpeedOverride", u2.lerp(Attribute13, Attribute14, p20));

                    return p21;
                end, nil, function() -- Line: 135
                    -- upvalues: u5 (copy)
                    u5:SetAttribute("SpeedTweening", nil);
                end));
            end;

            task.wait(Attribute3);
            u5:SetAttribute("Enabled", false);
            u5:SetAttribute("SpeedOverride", nil);

            return;
        end;

        local u22 = u5:FindFirstAncestorOfClass("Attachment") or Start;
        local u23;

        if typeof(u6) == "table" then
            u23 = u6._getReal() or u6;
        else
            u23 = u6;
        end;

        local TransformedOriginExtents = u2.getTransformedOriginExtents(u22);
        local u24 = Start.CFrame:ToObjectSpace(End.CFrame);
        local u25 = Attribute13;
        local u26 = u15;
        local CFrame_fromOrientation_ret = CFrame.fromOrientation(u19.x, u19.y, u19.z);
        local CFrame_identity = CFrame.identity;
        local CFrame_fromOrientation = CFrame.fromOrientation;
        local v27 = Random_new_ret:NextNumber(-Attribute17.x, Attribute17.x);
        local math_rad_ret = math.rad(v27);
        local v28 = Random_new_ret:NextNumber(-Attribute17.y, Attribute17.y);
        local u29 = CFrame_fromOrientation(math_rad_ret, math.rad(v28), 0);

        local function updatePos(p30: number) -- Line: 168
            -- upvalues: Attribute12 (copy), u2 (ref), u22 (copy), TransformedOriginExtents (copy), u19 (copy), u26 (ref), CFrame_fromOrientation_ret (ref), Attribute18 (copy), u29 (copy), CFrame_identity (ref), u6 (copy)
            local v31 = Attribute12 and u2.getTransformedOriginExtents(u22) or TransformedOriginExtents;
            local v32 = u19:Sign() * u26 * p30;
            CFrame_fromOrientation_ret = CFrame_fromOrientation_ret * CFrame.fromOrientation(v32.x, v32.y, v32.z);
            local v33;

            if Attribute18 then
                v33 = v31 * u29 * CFrame_fromOrientation_ret * CFrame_identity;
            else
                v33 = v31 * u29 * CFrame_identity * CFrame_fromOrientation_ret;
            end;

            u6.CFrame = v33 * CFrame_fromOrientation_ret;
        end;

        updatePos(0);
        local RandomId = u2.getRandomId();
        RunService:BindToRenderStep(RandomId, u2.RENDER_PRIORITY + p7.depth, updatePos);
        table.insert(p7, function() -- Line: 194
            -- upvalues: RunService (ref), RandomId (copy)
            RunService:UnbindFromRenderStep(RandomId);
        end);
        local v34 = {};
        local v35 = p7.effects.prepareEmitOnFinish(u6, p7);
        local Finished = p7.effects.emitNested(u6, p7.depth + 1).Finished;
        table.insert(v34, Finished);
        local u36;

        if Attribute13 == Attribute14 or u5:GetAttribute("SpeedOverride") then
            u36 = nil;
        else
            u36 = u1.fromParams(u2.getAttribute(u5, "Speed_Curve", u2.default_bezier), u2.getAttribute(u5, "Speed_Duration", 0.1), function(p37, p38) -- Line: 212
                -- upvalues: u25 (ref), u2 (ref), Attribute13 (copy), Attribute14 (copy)
                u25 = u2.lerp(Attribute13, Attribute14, p37);

                return p38;
            end);
            table.insert(p7, u36);
        end;

        if u24 ~= CFrame.identity then
            local fromParams = u1.fromParams;
            local Attribute21 = u2.getAttribute(u5, "Part_CFrame_Curve", u2.default_bezier);
            table.insert(p7, fromParams(Attribute21, v10, function(p39, p40) -- Line: 227
                -- upvalues: CFrame_identity (ref), u24 (copy), u5 (copy), u25 (ref)
                CFrame_identity = CFrame.identity:Lerp(u24, p39);

                return p40 * (u5:GetAttribute("SpeedOverride") or u25);
            end, u36));
        end;

        if u15 ~= u16 then
            local fromParams = u1.fromParams;
            local Attribute21 = u2.getAttribute(u5, "Part_RotSpeed_Curve", u2.default_bezier);
            table.insert(p7, fromParams(Attribute21, v10, function(p41, p42) -- Line: 242
                -- upvalues: u26 (ref), u2 (ref), u15 (copy), u16 (copy), u5 (copy), u25 (ref)
                u26 = u2.lerp(u15, u16, p41);

                return p42 * (u5:GetAttribute("SpeedOverride") or u25);
            end, u36));
        end;

        if Attribute15 == Attribute16 then
            u6.Transparency = Attribute15;
        else
            local fromParams = u1.fromParams;
            local Attribute21 = u2.getAttribute(u5, "Part_Transparency_Curve", u2.default_bezier);
            table.insert(p7, fromParams(Attribute21, v10, function(p43, p44) -- Line: 257
                -- upvalues: u6 (copy), u2 (ref), Attribute15 (copy), Attribute16 (copy), u5 (copy), u25 (ref)
                u6.Transparency = u2.lerp(Attribute15, Attribute16, p43);

                return p44 * (u5:GetAttribute("SpeedOverride") or u25);
            end, u36));
        end;

        local u45 = Start.Size * p8;
        local u46 = End.Size * p8;

        if u45 == u46 then
            u6.Size = u45;
        else
            local fromParams = u1.fromParams;
            local Attribute21 = u2.getAttribute(u5, "Part_Size_Curve", u2.default_bezier);
            table.insert(p7, fromParams(Attribute21, v10, function(p47, p48) -- Line: 276
                -- upvalues: u6 (copy), u45 (copy), u46 (copy), u5 (copy), u25 (ref)
                u6.Size = u45:Lerp(u46, p47);

                return p48 * (u5:GetAttribute("SpeedOverride") or u25);
            end, u36));
        end;

        local v49 = Start:FindFirstChildOfClass("SpecialMesh");
        local v50 = End:FindFirstChildOfClass("SpecialMesh");
        local u51 = u6:FindFirstChildOfClass("SpecialMesh");

        if u51 then
            if v49 and v50 then
                local u52 = v49.Scale * p8;
                local u53 = v50.Scale * p8;

                if u52 ~= u53 then
                    local fromParams = u1.fromParams;
                    local Attribute21 = u2.getAttribute(u5, "Mesh_Scale_Curve", u2.default_bezier);
                    table.insert(p7, fromParams(Attribute21, v10, function(p54, p55) -- Line: 302
                        -- upvalues: u51 (copy), u2 (ref), u52 (copy), u53 (copy), u5 (copy), u25 (ref)
                        u51.Scale = u2.lerp(u52, u53, p54);

                        return p55 * (u5:GetAttribute("SpeedOverride") or u25);
                    end, u36));
                end;
            else
                u51.Parent = nil;
                table.insert(p7, function() -- Line: 313
                    -- upvalues: u51 (copy), u23 (copy)
                    u51.Parent = u23;
                end);
            end;
        end;

        local MeshDecals, v56, v57 = u2.getMeshDecals(u5, u6);
        local v58 = 0;

        if Attribute4 then
            table.sort(MeshDecals, function(p59, p60) -- Line: 324
                local v61 = p59.Name:match("%d+") or 0;
                local v62 = p60.Name:match("%d+") or 0;

                return tonumber(v61) < tonumber(v62);
            end);
            local Decal = Instance.new("Decal");
            Decal.Parent = u23;
            table.insert(p7, Decal);

            if Attribute5 > 0 and Attribute8 ~= Attribute9 then
                table.insert(p7, u1.fromParams(u2.default_bezier, v10 + Attribute5, function(p63, p64) -- Line: 340
                    -- upvalues: Decal (copy), u2 (ref), Attribute8 (copy), Attribute9 (copy), u5 (copy), u25 (ref)
                    Decal.Transparency = u2.lerp(Attribute8, Attribute9, p63);

                    return p64 * (u5:GetAttribute("SpeedOverride") or u25);
                end, u36));
            end;

            table.insert(p7, u1.fromParams(u2.default_bezier, v10, function(p65, p66) -- Line: 350
                -- upvalues: MeshDecals (copy), Decal (copy), Attribute5 (copy), u2 (ref), Attribute8 (copy), Attribute9 (copy), u5 (copy), u25 (ref)
                local math_round_ret = math.round(#MeshDecals * p65);
                local v67 = MeshDecals[math.max(math_round_ret, 1)];
                Decal.Texture = v67.Texture;
                Decal.Color3 = v67.Color3;
                Decal.ZIndex = v67.ZIndex;

                if Attribute5 == 0 then
                    Decal.Transparency = u2.lerp(Attribute8, Attribute9, p65);
                    Decal.ZIndex = v67.ZIndex;
                end;

                return p66 * (u5:GetAttribute("SpeedOverride") or u25);
            end, u36));
        else
            for _, v in MeshDecals do
                local u68 = v57[v];
                local Attribute21 = u2.getAttribute(v, "Transparency_Start", Attribute8);
                local Attribute22 = u2.getAttribute(v, "Transparency_End", Attribute9);

                if Attribute21 == Attribute22 then
                    v.Transparency = Attribute21;
                else
                    local fromParams = u1.fromParams;
                    local Attribute23 = u2.getAttribute(v, "Transparency_Curve", u2.default_bezier);
                    table.insert(p7, fromParams(Attribute23, v10, function(p69, p70) -- Line: 381
                        -- upvalues: v (copy), u2 (ref), Attribute21 (copy), Attribute22 (copy), u5 (copy), u25 (ref)
                        v.Transparency = u2.lerp(Attribute21, Attribute22, p69);

                        return p70 * (u5:GetAttribute("SpeedOverride") or u25);
                    end, u36));
                end;

                if v.Color3 ~= u68.Color3 then
                    local fromParams = u1.fromParams;
                    local Attribute23 = u2.getAttribute(v, "Color_Curve", u2.default_bezier);
                    table.insert(p7, fromParams(Attribute23, v10, function(p71, p72) -- Line: 398
                        -- upvalues: u3 (ref), v (copy), u68 (copy), v (copy), u5 (copy), u25 (ref)
                        local v73 = u3.fromSRGB(v.Color3);
                        local v74 = u3.fromSRGB(u68.Color3);
                        v.Color3 = u3.toSRGB(v73:Lerp(v74, p71), true);

                        return p72 * (u5:GetAttribute("SpeedOverride") or u25);
                    end, u36));
                end;

                local u75 = v56[v];

                if u75 then
                    local Attribute23 = u2.getAttribute(v, "Flipbook_Change_Duration", v10);

                    if u2.getAttribute(v, "SyncDuration", false) then
                        Attribute23 = v10;
                    end;

                    if v58 < Attribute23 then
                        v58 = Attribute23;
                    end;

                    local u76 = false;
                    local u77;

                    if RunService:IsStudio() then
                        u77 = v;

                        for _, v2 in CollectionService:GetTags(v) do
                            if v2:match("^_local_flipbook_") then
                                u76 = true;
                                break;
                            end;
                        end;
                    else
                        u77 = v;
                    end;

                    local fromParams = u1.fromParams;
                    local Attribute24 = u2.getAttribute(u77, "Flipbook_Change_Curve", u2.linear_bezier);
                    table.insert(p7, fromParams(Attribute24, Attribute23, function(p78, p79) -- Line: 440
                        -- upvalues: u75 (copy), u77 (copy), u76 (ref), u5 (copy), u25 (ref)
                        local math_round_ret = math.round(#u75 * p78);
                        u77.Texture = `{u76 and "rbxtemp://" or "rbxassetid://"}{u75[math.max(math_round_ret, 1)]}`;

                        return p79 * (u5:GetAttribute("SpeedOverride") or u25);
                    end, u36));
                end;
            end;
        end;

        u1.timer(math.max(v10, v58) + Attribute5, function(p80, p81) -- Line: 453
            -- upvalues: u5 (copy), u25 (ref), u36 (ref)
            local v82 = u5:GetAttribute("SpeedOverride") or u25;
            u25 = v82;

            if v82 > 0 then
                return p80 * v82;
            end;

            if p81 > 0 then
                local v83;

                if u36 then
                    v83 = u36.Connected;
                else
                    v83 = u5:GetAttribute("SpeedTweening");
                end;

                if v83 then
                    return p80 * v82;
                end;
            end;

            return nil;
        end, u36, p7);
        u4.all(v34):await();
        p7.effects.emitOnFinish(v35, u23, p7.depth + 1).Finished:await();
    end
};