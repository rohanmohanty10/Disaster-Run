  

 

local RunService = game:GetService("RunService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../mod/common/flipbook");
local u5 = require("../mod/color/Oklab");
local u6 = require("../pkg/Promise");
local u7 = Random.new();

return {
    emit = function(u8, u9, p10, p11, p12) -- Line: 17, Name: emit
        -- upvalues: u1 (copy), u7 (copy), u3 (copy), u2 (copy), RunService (copy), u5 (copy), u4 (copy), u6 (copy)
        local Start = u8:FindFirstChild("Start");
        local End = u8:FindFirstChild("End");

        if not Start or (not End or (not Start:IsA("BasePart") or (not End:IsA("BasePart") or u1.get(u8, "Enabled", false) and not p12))) then
            return;
        end;

        local v13 = u1.get(u8, "Duration", 1, true);
        local v14 = u1.getRange(u8, "EffectDuration", NumberRange.new(v13, v13), NumberRange.new(0, (1 / 0)));
        local v15 = u7:NextNumber(v14.Min, v14.Max);
        local v16 = u1.get(u8, "EmitDelay", 0);
        local v17 = u1.get(u8, "DestroyDelay", 0);
        local v18 = u1.get(u8, "EmitDuration", 0);
        local v19 = u1.get(u8, "Flipbook", false, true);
        local u20 = u1.get(u8, "FlipbookFadeOffset", 0, true);
        local v21 = (v19 or not Start:FindFirstChildOfClass("Decal")) and "Mesh_" or "Decal_";
        local v22 = u8:GetAttribute("StartTransparency");

        if v22 ~= nil then
            u8:SetAttribute(v21 .. "StartTransparency", v22);
            u8:SetAttribute("StartTransparency", nil);
        end;

        local v23 = u8:GetAttribute("EndTransparency");

        if v23 ~= nil then
            u8:SetAttribute(v21 .. "EndTransparency", v23);
            u8:SetAttribute("EndTransparency", nil);
        end;

        local v24 = u8:HasTag(u3.ENABLED_VFX_TAG) and v18 > 0;
        local u25 = u1.get(u8, "Decal_StartTransparency", 0, true);
        local u26 = u1.get(u8, "Decal_EndTransparency", 1, true);
        local v27;

        if Start then
            v27 = Start:FindFirstChildOfClass("Decal");
        else
            v27 = Start;
        end;

        local v28 = v27 and 1 or 0;
        local v29 = u1.get(u8, "Mesh_StartTransparency", v28, true);
        local v30 = u1.get(u8, "Mesh_EndTransparency", v28, true);
        local u31 = u1.get(u8, "SyncPosition", false);
        local u32 = u1.get(u8, "Speed_Start", 1);
        local u33 = u1.get(u8, "Speed_End", 1);
        local u34 = u1.get(u8, "Part_Transparency_Start", v29);
        local u35 = u1.get(u8, "Part_Transparency_End", v30);
        local v36 = u1.get(u8, "SpreadAngle", Vector3.new(0, 0, 0));
        local v37 = u1.getRange(u8, "Part_RotSpeed_Start", NumberRange.new(0, 0));
        local v38 = u1.getRange(u8, "Part_RotSpeed_End", NumberRange.new(0, 0));
        local u39 = u1.get(u8, "RotAroundOrigin", false);
        local v40 = u1.get(u8, "MinInitRot", Vector3.new(0, 0, 0));
        local v41 = u1.get(u8, "MaxInitRot", Vector3.new(0, 0, 0));
        local u42 = u7:NextNumber(v37.Min, v37.Max);
        local u43 = u7:NextNumber(v38.Min, v38.Max);
        local v44 = u7:NextNumber(v40.x, v41.x);
        local v45 = u7:NextNumber(v40.y, v41.y);
        local u46 = vector.create(v44, v45, u7:NextNumber(v40.z, v41.z)) * u3.DEG_TO_RAD;
        task.wait(v16);

        if v24 and not p12 then
            u3.forceEmit(u8, true);
            u1.trigger(u8, "Enabled", true);
            u3.onCancel(p10, function() -- Line: 125
                -- upvalues: u3 (ref), u8 (copy)
                local v47 = u3.stopEmitDuration(u8);

                if v47 then
                    u3.cancelToken(v47);
                end;
            end);

            if u32 ~= u33 then
                u1.setState(u8, "SpeedTweening", true);
                local fromParams = u2.fromParams;
                local v48 = u1.get(u8, "Speed_Curve", u3.default_bezier);
                local v49 = u1.get(u8, "Speed_Duration", 0.1);
                table.insert(p10, fromParams(v48, v49, function(p50, p51) -- Line: 141
                    -- upvalues: u1 (ref), u8 (copy), u3 (ref), u32 (copy), u33 (copy)
                    u1.setState(u8, "SpeedOverride", u3.lerp(u32, u33, p50));

                    return p51;
                end, nil, function() -- Line: 146
                    -- upvalues: u1 (ref), u8 (copy)
                    u1.setState(u8, "SpeedTweening", nil);
                end));
            end;

            task.wait(v18);
            u3.awaitEmitDuration(u3.stopEmitDuration(u8));

            return;
        end;

        local u52 = u8:FindFirstAncestorOfClass("Attachment") or Start;
        local u53;

        if typeof(u9) == "table" then
            u53 = u9._getReal() or u9;
        else
            u53 = u9;
        end;

        local u54 = u3.getTransformedOriginExtents(u52);
        local u55 = Start.CFrame:ToObjectSpace(End.CFrame);
        local u56 = u32;
        local u57 = u42;
        local u58 = CFrame.fromOrientation(u46.x, u46.y, u46.z);
        local identity = CFrame.identity;
        local fromOrientation = CFrame.fromOrientation;
        local v59 = u7:NextNumber(-v36.x, v36.x);
        local v60 = math.rad(v59);
        local v61 = u7:NextNumber(-v36.y, v36.y);
        local u62 = fromOrientation(v60, math.rad(v61), 0);

        local function updatePos(p63) -- Line: 178
            -- upvalues: u31 (copy), u3 (ref), u52 (copy), u54 (copy), u46 (copy), u57 (ref), u58 (ref), u39 (copy), u62 (copy), identity (ref), u9 (copy)
            local v64 = u31 and u3.getTransformedOriginExtents(u52) or u54;
            local v65 = u46:Sign() * u57 * p63;
            u58 = u58 * CFrame.fromOrientation(v65.x, v65.y, v65.z);
            local v66;

            if u39 then
                v66 = v64 * u62 * u58 * identity;
            else
                v66 = v64 * u62 * identity * u58;
            end;

            u9.CFrame = v66 * u58;
        end;

        updatePos(0);
        local u67 = u3.getRandomId();
        RunService:BindToRenderStep(u67, u3.RENDER_PRIORITY + p10.depth, updatePos);
        table.insert(p10, function() -- Line: 204
            -- upvalues: RunService (ref), u67 (copy)
            RunService:UnbindFromRenderStep(u67);
        end);
        local v68 = {};
        local v69 = p10.effects.prepareEmitOnFinish(u9, p10);
        local Finished = p10.effects.emitNested(u9, p10.depth + 1, p10).Finished;
        table.insert(v68, Finished);
        local u70;

        if u32 == u33 or u1.getState(u8, "SpeedOverride", nil) then
            u70 = nil;
        else
            u70 = u2.fromParams(u1.get(u8, "Speed_Curve", u3.default_bezier), u1.get(u8, "Speed_Duration", 0.1), function(p71, p72) -- Line: 222
                -- upvalues: u56 (ref), u3 (ref), u32 (copy), u33 (copy)
                u56 = u3.lerp(u32, u33, p71);

                return p72;
            end);
            table.insert(p10, u70);
        end;

        if u55 ~= CFrame.identity then
            local fromParams = u2.fromParams;
            local v73 = u1.get(u8, "Part_CFrame_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v73, v15, function(p74, p75) -- Line: 234
                -- upvalues: identity (ref), u55 (copy), u1 (ref), u8 (copy), u56 (ref)
                identity = CFrame.identity:Lerp(u55, p74);

                return p75 * u1.getState(u8, "SpeedOverride", u56);
            end, u70));
        end;

        if u42 ~= u43 then
            local fromParams = u2.fromParams;
            local v76 = u1.get(u8, "Part_RotSpeed_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v76, v15, function(p77, p78) -- Line: 247
                -- upvalues: u57 (ref), u3 (ref), u42 (copy), u43 (copy), u1 (ref), u8 (copy), u56 (ref)
                u57 = u3.lerp(u42, u43, p77);

                return p78 * u1.getState(u8, "SpeedOverride", u56);
            end, u70));
        end;

        if u34 == u35 then
            u9.Transparency = u34;
        else
            local fromParams = u2.fromParams;
            local v79 = u1.get(u8, "Part_Transparency_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v79, v15, function(p80, p81) -- Line: 262
                -- upvalues: u9 (copy), u3 (ref), u34 (copy), u35 (copy), u1 (ref), u8 (copy), u56 (ref)
                u9.Transparency = u3.lerp(u34, u35, p80);

                return p81 * u1.getState(u8, "SpeedOverride", u56);
            end, u70));
        end;

        local u82 = Start.Size * p11;
        local u83 = End.Size * p11;

        if u82 == u83 then
            u9.Size = u82;
        else
            local u84 = -1;
            local fromParams = u2.fromParams;
            local v85 = u1.get(u8, "Part_Size_Curve", u3.default_bezier);
            table.insert(p10, fromParams(v85, v15, function(p86, p87) -- Line: 280
                -- upvalues: u1 (ref), u8 (copy), u56 (ref), u84 (ref), u9 (copy), u82 (copy), u83 (copy)
                local v88 = u1.getState(u8, "SpeedOverride", u56);

                if math.abs(p86 - u84) < 0.005 then
                    return p87 * v88;
                end;

                u84 = p86;
                u9.Size = u82:Lerp(u83, p86);

                return p87 * v88;
            end, u70));
        end;

        local v89 = Start:FindFirstChildOfClass("SpecialMesh");
        local v90 = End:FindFirstChildOfClass("SpecialMesh");
        local u91 = u9:FindFirstChildOfClass("SpecialMesh");

        if u91 then
            if v89 and v90 then
                local u92 = v89.Scale * p11;
                local u93 = v90.Scale * p11;

                if u92 ~= u93 then
                    local fromParams = u2.fromParams;
                    local v94 = u1.get(u8, "Mesh_Scale_Curve", u3.default_bezier);
                    table.insert(p10, fromParams(v94, v15, function(p95, p96) -- Line: 313
                        -- upvalues: u91 (copy), u3 (ref), u92 (copy), u93 (copy), u1 (ref), u8 (copy), u56 (ref)
                        u91.Scale = u3.lerp(u92, u93, p95);

                        return p96 * u1.getState(u8, "SpeedOverride", u56);
                    end, u70));
                end;
            else
                u91.Parent = nil;
                table.insert(p10, function() -- Line: 324
                    -- upvalues: u91 (copy), u53 (copy)
                    u91.Parent = u53;
                end);
            end;
        end;

        local u97, v98, v99 = u3.getMeshDecals(u8, u9);
        local v100 = 0;

        if v19 then
            table.sort(u97, function(p101, p102) -- Line: 335
                local v103 = p101.Name:match("%d+") or 0;
                local v104 = p102.Name:match("%d+") or 0;

                return tonumber(v103) < tonumber(v104);
            end);
            local Decal = Instance.new("Decal");
            Decal.Parent = u53;
            table.insert(p10, Decal);

            if u20 > 0 and u25 ~= u26 then
                table.insert(p10, u2.fromParams(u3.default_bezier, v15 + u20, function(p105, p106) -- Line: 351
                    -- upvalues: Decal (copy), u3 (ref), u25 (copy), u26 (copy), u1 (ref), u8 (copy), u56 (ref)
                    Decal.Transparency = u3.lerp(u25, u26, p105);

                    return p106 * u1.getState(u8, "SpeedOverride", u56);
                end, u70));
            end;

            table.insert(p10, u2.fromParams(u3.default_bezier, v15, function(p107, p108) -- Line: 361
                -- upvalues: u97 (copy), Decal (copy), u20 (copy), u3 (ref), u25 (copy), u26 (copy), u1 (ref), u8 (copy), u56 (ref)
                local v109 = math.round(#u97 * p107);
                local v110 = u97[math.max(v109, 1)];
                Decal.Texture = v110.Texture;
                Decal.Color3 = v110.Color3;
                Decal.ZIndex = v110.ZIndex;

                if u20 == 0 then
                    Decal.Transparency = u3.lerp(u25, u26, p107);
                    Decal.ZIndex = v110.ZIndex;
                end;

                return p108 * u1.getState(u8, "SpeedOverride", u56);
            end, u70));
        else
            for _, v in u97 do
                local u111 = v99[v];
                local u112 = u1.get(v, "Transparency_Start", u25);
                local u113 = u1.get(v, "Transparency_End", u26);

                if u112 == u113 then
                    v.Transparency = u112;
                else
                    local fromParams = u2.fromParams;
                    local v114 = u1.get(v, "Transparency_Curve", u3.default_bezier);
                    table.insert(p10, fromParams(v114, v15, function(p115, p116) -- Line: 392
                        -- upvalues: v (copy), u3 (ref), u112 (copy), u113 (copy), u1 (ref), u8 (copy), u56 (ref)
                        v.Transparency = u3.lerp(u112, u113, p115);

                        return p116 * u1.getState(u8, "SpeedOverride", u56);
                    end, u70));
                end;

                if v.Color3 ~= u111.Color3 then
                    local fromParams = u2.fromParams;
                    local v117 = u1.get(v, "Color_Curve", u3.default_bezier);
                    table.insert(p10, fromParams(v117, v15, function(p118, p119) -- Line: 406
                        -- upvalues: u5 (ref), v (copy), u111 (copy), v (copy), u1 (ref), u8 (copy), u56 (ref)
                        local v120 = u5.fromSRGB(v.Color3);
                        local v121 = u5.fromSRGB(u111.Color3);
                        v.Color3 = u5.toSRGB(v120:Lerp(v121, p118), true);

                        return p119 * u1.getState(u8, "SpeedOverride", u56);
                    end, u70));
                end;

                local v122 = v98[v];

                if v122 then
                    local v124 = {
                        ref = v,
                        frames = v122,
                        speedTween = u70,
                        effectDuration = v15,
                        curve = u1.get(v, "Flipbook_Change_Curve", u3.linear_bezier),
                        duration = u1.get(v, "Flipbook_Change_Duration", v15),

                        getSpeed = function() -- Line: 429, Name: getSpeed
                            -- upvalues: u1 (ref), u8 (copy), u56 (ref)
                            return u1.getState(u8, "SpeedOverride", u56);
                        end,

                        setTexture = function(p123) -- Line: 433, Name: setTexture
                            -- upvalues: v (copy)
                            v.Texture = p123;
                        end
                    };
                    local v125 = u4.getChangeDuration(v124);

                    if v100 < v125 then
                        v100 = v125;
                    end;

                    local fromParams = u2.fromParams;
                    local curve = v124.curve;
                    local v126 = u4.createUpdateCallback(v124);
                    table.insert(p10, fromParams(curve, v125, v126, u70));
                end;
            end;
        end;

        u2.timer(math.max(v15, v100) + u20 + v17, function(p127, p128) -- Line: 454
            -- upvalues: u1 (ref), u8 (copy), u56 (ref), u70 (ref)
            local v129 = u1.getState(u8, "SpeedOverride", u56);
            u56 = v129;

            if v129 > 0 then
                return p127 * v129;
            end;

            if p128 > 0 then
                local v130;

                if u70 then
                    v130 = u70.Connected;
                else
                    v130 = u1.getState(u8, "SpeedTweening", false);
                end;

                if v130 then
                    return p127 * v129;
                end;
            end;

            return nil;
        end, u70, p10);
        u6.all(v68):await();
        p10.effects.emitOnFinish(v69, u53, p10.depth + 1, p10).Finished:await();
    end
};