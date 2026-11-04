 

 

local RunService = game:GetService("RunService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../mod/common/flipbook");
local u5 = require("../mod/color/Oklab");
local u6 = require("../pkg/Promise");
require("../obj/ObjectCache");
local Random_new_ret = Random.new();
local u7 = nil;

return {
    init = function(p8) -- Line: 20, Name: init
        -- upvalues: u7 (ref)
        u7 = p8;
    end,

    deinit = function() -- Line: 24, Name: deinit
        -- upvalues: u7 (ref)
        u7 = nil;
    end,

    emit = function(u9: userdata, u10: userdata, p11: any, p12: number, p13: boolean?) -- Line: 28, Name: emit
        -- upvalues: u1 (copy), Random_new_ret (copy), u3 (copy), u2 (copy), RunService (copy), u5 (copy), u4 (copy), u6 (copy)
        local Start = u9:FindFirstChild("Start");
        local End = u9:FindFirstChild("End");

        if not (Start and (End and (Start:IsA("BasePart") and (End:IsA("BasePart") and (not u9:GetAttribute("Enabled") or p13))))) then
            return;
        end;

        local v14 = u1.get(u9, "Duration", 1, true);
        local Range = u1.getRange(u9, "EffectDuration", NumberRange.new(v14, v14), NumberRange.new(0, (1 / 0)));
        local v15 = Random_new_ret:NextNumber(Range.Min, Range.Max);
        local v16 = u1.get(u9, "EmitDelay", 0);
        local v17 = u1.get(u9, "EmitDuration", 0, true);
        local v18 = u1.get(u9, "Flipbook", false, true);
        local u19 = u1.get(u9, "FlipbookFadeOffset", 0, true);
        local v20 = (v18 or not Start:FindFirstChildOfClass("Decal")) and "Mesh_" or "Decal_";
        local Attribute = u9:GetAttribute("StartTransparency");

        if Attribute ~= nil then
            u9:SetAttribute(v20 .. "StartTransparency", Attribute);
            u9:SetAttribute("StartTransparency", nil);
        end;

        local Attribute2 = u9:GetAttribute("EndTransparency");

        if Attribute2 ~= nil then
            u9:SetAttribute(v20 .. "EndTransparency", Attribute2);
            u9:SetAttribute("EndTransparency", nil);
        end;

        local v21;

        if u9:GetAttribute("Enabled") == nil then
            v21 = false;
        else
            v21 = u9:HasTag(u3.ENABLED_VFX_TAG) and v15 > 0;
        end;

        local u22 = u1.get(u9, "Decal_StartTransparency", 0, true);
        local u23 = u1.get(u9, "Decal_EndTransparency", 1, true);
        local v24;

        if Start then
            v24 = Start:FindFirstChildOfClass("Decal");
        else
            v24 = Start;
        end;

        local v25 = v24 and 1 or 0;
        local v26 = u1.get(u9, "Mesh_StartTransparency", v25, true);
        local v27 = u1.get(u9, "Mesh_EndTransparency", v25, true);
        local u28 = u1.get(u9, "SyncPosition", false);
        local u29 = u1.get(u9, "Speed_Start", 1);
        local u30 = u1.get(u9, "Speed_End", 1);
        local u31 = u1.get(u9, "Part_Transparency_Start", v26);
        local u32 = u1.get(u9, "Part_Transparency_End", v27);
        local v33 = u1.get(u9, "SpreadAngle", Vector3.new(0, 0, 0));
        local Range2 = u1.getRange(u9, "Part_RotSpeed_Start", NumberRange.new(0, 0));
        local Range3 = u1.getRange(u9, "Part_RotSpeed_End", NumberRange.new(0, 0));
        local u34 = u1.get(u9, "RotAroundOrigin", false);
        local v35 = u1.get(u9, "MinInitRot", Vector3.new(0, 0, 0));
        local v36 = u1.get(u9, "MaxInitRot", Vector3.new(0, 0, 0));
        local u37 = Random_new_ret:NextNumber(Range2.Min, Range2.Max);
        local u38 = Random_new_ret:NextNumber(Range3.Min, Range3.Max);
        local v39 = Random_new_ret:NextNumber(v35.x, v36.x);
        local v40 = Random_new_ret:NextNumber(v35.y, v36.y);
        local u41 = vector.create(v39, v40, Random_new_ret:NextNumber(v35.z, v36.z)) * u3.DEG_TO_RAD;
        task.wait(v16);

        if v21 and not p13 then
            u1.trigger(u9, "Enabled", true);

            if u29 ~= u30 then
                u1.setState(u9, "SpeedTweening", true);
                local fromParams = u2.fromParams;
                local v42 = u1.get(u9, "Speed_Curve", u3.default_bezier);
                local v43 = u1.get(u9, "Speed_Duration", 0.1);
                table.insert(p11, fromParams(v42, v43, function(p44, p45) -- Line: 143
                    -- upvalues: u1 (ref), u9 (copy), u3 (ref), u29 (copy), u30 (copy)
                    u1.setState(u9, "SpeedOverride", u3.lerp(u29, u30, p44));

                    return p45;
                end, nil, function() -- Line: 148
                    -- upvalues: u1 (ref), u9 (copy)
                    u1.setState(u9, "SpeedTweening", nil);
                end));
            end;

            task.wait(v17);
            u1.trigger(u9, "Enabled", false);
            u1.clearState(u9);

            return;
        end;

        local u46 = u9:FindFirstAncestorOfClass("Attachment") or Start;
        local u47;

        if typeof(u10) == "table" then
            u47 = u10._getReal() or u10;
        else
            u47 = u10;
        end;

        local TransformedOriginExtents = u3.getTransformedOriginExtents(u46);
        local u48 = Start.CFrame:ToObjectSpace(End.CFrame);
        local u49 = u29;
        local u50 = u37;
        local CFrame_fromOrientation_ret = CFrame.fromOrientation(u41.x, u41.y, u41.z);
        local CFrame_identity = CFrame.identity;
        local CFrame_fromOrientation = CFrame.fromOrientation;
        local v51 = Random_new_ret:NextNumber(-v33.x, v33.x);
        local math_rad_ret = math.rad(v51);
        local v52 = Random_new_ret:NextNumber(-v33.y, v33.y);
        local u53 = CFrame_fromOrientation(math_rad_ret, math.rad(v52), 0);

        local function updatePos(p54: number) -- Line: 181
            -- upvalues: u28 (copy), u3 (ref), u46 (copy), TransformedOriginExtents (copy), u41 (copy), u50 (ref), CFrame_fromOrientation_ret (ref), u34 (copy), u53 (copy), CFrame_identity (ref), u10 (copy)
            local v55 = u28 and u3.getTransformedOriginExtents(u46) or TransformedOriginExtents;
            local v56 = u41:Sign() * u50 * p54;
            CFrame_fromOrientation_ret = CFrame_fromOrientation_ret * CFrame.fromOrientation(v56.x, v56.y, v56.z);
            local v57;

            if u34 then
                v57 = v55 * u53 * CFrame_fromOrientation_ret * CFrame_identity;
            else
                v57 = v55 * u53 * CFrame_identity * CFrame_fromOrientation_ret;
            end;

            u10.CFrame = v57 * CFrame_fromOrientation_ret;
        end;

        updatePos(0);
        local RandomId = u3.getRandomId();
        RunService:BindToRenderStep(RandomId, u3.RENDER_PRIORITY + p11.depth, updatePos);
        table.insert(p11, function() -- Line: 207
            -- upvalues: RunService (ref), RandomId (copy)
            RunService:UnbindFromRenderStep(RandomId);
        end);
        local v58 = {};
        local v59 = p11.effects.prepareEmitOnFinish(u10, p11);
        local Finished = p11.effects.emitNested(u10, p11.depth + 1).Finished;
        table.insert(v58, Finished);
        local u60;

        if u29 == u30 or u1.getState(u9, "SpeedOverride", nil) then
            u60 = nil;
        else
            u60 = u2.fromParams(u1.get(u9, "Speed_Curve", u3.default_bezier), u1.get(u9, "Speed_Duration", 0.1), function(p61, p62) -- Line: 225
                -- upvalues: u49 (ref), u3 (ref), u29 (copy), u30 (copy)
                u49 = u3.lerp(u29, u30, p61);

                return p62;
            end);
            table.insert(p11, u60);
        end;

        if u48 ~= CFrame.identity then
            local fromParams = u2.fromParams;
            local v63 = u1.get(u9, "Part_CFrame_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v63, v15, function(p64, p65) -- Line: 237
                -- upvalues: CFrame_identity (ref), u48 (copy), u1 (ref), u9 (copy), u49 (ref)
                CFrame_identity = CFrame.identity:Lerp(u48, p64);

                return p65 * u1.getState(u9, "SpeedOverride", u49);
            end, u60));
        end;

        if u37 ~= u38 then
            local fromParams = u2.fromParams;
            local v66 = u1.get(u9, "Part_RotSpeed_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v66, v15, function(p67, p68) -- Line: 250
                -- upvalues: u50 (ref), u3 (ref), u37 (copy), u38 (copy), u1 (ref), u9 (copy), u49 (ref)
                u50 = u3.lerp(u37, u38, p67);

                return p68 * u1.getState(u9, "SpeedOverride", u49);
            end, u60));
        end;

        if u31 == u32 then
            u10.Transparency = u31;
        else
            local fromParams = u2.fromParams;
            local v69 = u1.get(u9, "Part_Transparency_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v69, v15, function(p70, p71) -- Line: 265
                -- upvalues: u10 (copy), u3 (ref), u31 (copy), u32 (copy), u1 (ref), u9 (copy), u49 (ref)
                u10.Transparency = u3.lerp(u31, u32, p70);

                return p71 * u1.getState(u9, "SpeedOverride", u49);
            end, u60));
        end;

        local u72 = Start.Size * p12;
        local u73 = End.Size * p12;

        if u72 == u73 then
            u10.Size = u72;
        else
            local u74 = -1;
            local fromParams = u2.fromParams;
            local v75 = u1.get(u9, "Part_Size_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v75, v15, function(p76, p77) -- Line: 283
                -- upvalues: u1 (ref), u9 (copy), u49 (ref), u74 (ref), u10 (copy), u72 (copy), u73 (copy)
                local State = u1.getState(u9, "SpeedOverride", u49);

                if math.abs(p76 - u74) < 0.005 then
                    return p77 * State;
                end;

                u74 = p76;
                u10.Size = u72:Lerp(u73, p76);

                return p77 * State;
            end, u60));
        end;

        local v78 = Start:FindFirstChildOfClass("SpecialMesh");
        local v79 = End:FindFirstChildOfClass("SpecialMesh");
        local u80 = u10:FindFirstChildOfClass("SpecialMesh");

        if u80 then
            if v78 and v79 then
                local u81 = v78.Scale * p12;
                local u82 = v79.Scale * p12;

                if u81 ~= u82 then
                    local fromParams = u2.fromParams;
                    local v83 = u1.get(u9, "Mesh_Scale_Curve", u3.default_bezier);
                    table.insert(p11, fromParams(v83, v15, function(p84, p85) -- Line: 316
                        -- upvalues: u80 (copy), u3 (ref), u81 (copy), u82 (copy), u1 (ref), u9 (copy), u49 (ref)
                        u80.Scale = u3.lerp(u81, u82, p84);

                        return p85 * u1.getState(u9, "SpeedOverride", u49);
                    end, u60));
                end;
            else
                u80.Parent = nil;
                table.insert(p11, function() -- Line: 327
                    -- upvalues: u80 (copy), u47 (copy)
                    u80.Parent = u47;
                end);
            end;
        end;

        local MeshDecals, v86, v87 = u3.getMeshDecals(u9, u10);
        local v88 = 0;

        if v18 then
            table.sort(MeshDecals, function(p89, p90) -- Line: 338
                local v91 = p89.Name:match("%d+") or 0;
                local v92 = p90.Name:match("%d+") or 0;

                return tonumber(v91) < tonumber(v92);
            end);
            local Decal = Instance.new("Decal");
            Decal.Parent = u47;
            table.insert(p11, Decal);

            if u19 > 0 and u22 ~= u23 then
                table.insert(p11, u2.fromParams(u3.default_bezier, v15 + u19, function(p93, p94) -- Line: 354
                    -- upvalues: Decal (copy), u3 (ref), u22 (copy), u23 (copy), u1 (ref), u9 (copy), u49 (ref)
                    Decal.Transparency = u3.lerp(u22, u23, p93);

                    return p94 * u1.getState(u9, "SpeedOverride", u49);
                end, u60));
            end;

            table.insert(p11, u2.fromParams(u3.default_bezier, v15, function(p95, p96) -- Line: 364
                -- upvalues: MeshDecals (copy), Decal (copy), u19 (copy), u3 (ref), u22 (copy), u23 (copy), u1 (ref), u9 (copy), u49 (ref)
                local math_round_ret = math.round(#MeshDecals * p95);
                local v97 = MeshDecals[math.max(math_round_ret, 1)];
                Decal.Texture = v97.Texture;
                Decal.Color3 = v97.Color3;
                Decal.ZIndex = v97.ZIndex;

                if u19 == 0 then
                    Decal.Transparency = u3.lerp(u22, u23, p95);
                    Decal.ZIndex = v97.ZIndex;
                end;

                return p96 * u1.getState(u9, "SpeedOverride", u49);
            end, u60));
        else
            for _, v in MeshDecals do
                local u98 = v87[v];
                local u99 = u1.get(v, "Transparency_Start", u22);
                local u100 = u1.get(v, "Transparency_End", u23);

                if u99 == u100 then
                    v.Transparency = u99;
                else
                    local fromParams = u2.fromParams;
                    local v101 = u1.get(v, "Transparency_Curve", u3.default_bezier);
                    table.insert(p11, fromParams(v101, v15, function(p102, p103) -- Line: 395
                        -- upvalues: v (copy), u3 (ref), u99 (copy), u100 (copy), u1 (ref), u9 (copy), u49 (ref)
                        v.Transparency = u3.lerp(u99, u100, p102);

                        return p103 * u1.getState(u9, "SpeedOverride", u49);
                    end, u60));
                end;

                if v.Color3 ~= u98.Color3 then
                    local fromParams = u2.fromParams;
                    local v104 = u1.get(v, "Color_Curve", u3.default_bezier);
                    table.insert(p11, fromParams(v104, v15, function(p105, p106) -- Line: 409
                        -- upvalues: u5 (ref), v (copy), u98 (copy), v (copy), u1 (ref), u9 (copy), u49 (ref)
                        local v107 = u5.fromSRGB(v.Color3);
                        local v108 = u5.fromSRGB(u98.Color3);
                        v.Color3 = u5.toSRGB(v107:Lerp(v108, p105), true);

                        return p106 * u1.getState(u9, "SpeedOverride", u49);
                    end, u60));
                end;

                local v109 = v86[v];

                if v109 then
                    local v111 = {
                        ref = v,
                        frames = v109,
                        speedTween = u60,
                        effectDuration = v15,
                        curve = u1.get(v, "Flipbook_Change_Curve", u3.linear_bezier),
                        duration = u1.get(v, "Flipbook_Change_Duration", v15),

                        getSpeed = function() -- Line: 432, Name: getSpeed
                            -- upvalues: u1 (ref), u9 (copy), u49 (ref)
                            return u1.getState(u9, "SpeedOverride", u49);
                        end,

                        setTexture = function(p110) -- Line: 436, Name: setTexture
                            -- upvalues: v (copy)
                            v.Texture = p110;
                        end
                    };
                    local ChangeDuration = u4.getChangeDuration(v111);

                    if v88 < ChangeDuration then
                        v88 = ChangeDuration;
                    end;

                    local fromParams = u2.fromParams;
                    local curve = v111.curve;
                    local v112 = u4.createUpdateCallback(v111);
                    table.insert(p11, fromParams(curve, ChangeDuration, v112, u60));
                end;
            end;
        end;

        u2.timer(math.max(v15, v88) + u19, function(p113, p114) -- Line: 455
            -- upvalues: u1 (ref), u9 (copy), u49 (ref), u60 (ref)
            local State = u1.getState(u9, "SpeedOverride", u49);
            u49 = State;

            if State > 0 then
                return p113 * State;
            end;

            if p114 > 0 then
                local v115;

                if u60 then
                    v115 = u60.Connected;
                else
                    v115 = u1.getState(u9, "SpeedTweening", false);
                end;

                if v115 then
                    return p113 * State;
                end;
            end;

            return nil;
        end, u60, p11);
        u6.all(v58):await();
        p11.effects.emitOnFinish(v59, u47, p11.depth + 1).Finished:await();
    end
};