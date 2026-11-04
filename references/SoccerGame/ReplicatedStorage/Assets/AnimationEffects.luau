  

local function safeFFC(p1: userdata, p2: any) -- Line: 1
    for _, v in p2 do
        if not p1 then
            return nil;
        end;

        p1 = p1:FindFirstChild(v);
    end;

    return p1;
end;

return {
    global = { function(p3: userdata) -- Line: 15
            local Parent = p3.Parent;
            p3.Running:Connect(function(p4) -- Line: 17
                -- upvalues: Parent (copy)
                local math_map_ret = math.map(p4, 33, 37.5, 0, 1);
                local math_clamp_ret = math.clamp(math_map_ret, 0, 1);
                local v5 = Parent;

                for _, v in { "WindEffects", "WindTrail1" } do
                    if not v5 then
                        v5 = nil;
                        break;
                    end;

                    v5 = v5:FindFirstChild(v);
                end;

                if v5 then
                    v5.Enabled = math_clamp_ret > 0;
                    v5.LocalTransparencyModifier = 1 - math_clamp_ret;
                end;

                local v6 = Parent;

                for _, v in { "WindEffects", "WindTrail2" } do
                    if not v6 then
                        v6 = nil;
                        break;
                    end;

                    v6 = v6:FindFirstChild(v);
                end;

                if v6 then
                    v6.Enabled = math_clamp_ret > 0;
                    v6.LocalTransparencyModifier = 1 - math_clamp_ret;
                end;
            end);
        end },

    ["rbxassetid://83565912889309"] = function(u7: userdata, p8: userdata) -- Line: 37
        local Parent = u7.Parent;

        return p8:GetMarkerReachedSignal("TouchGround"):Connect(function(p9) -- Line: 39
            -- upvalues: u7 (copy), Parent (copy)
            local math_clamp_ret = math.clamp(u7.RootPart.AssemblyLinearVelocity.Magnitude, 0, 32);
            local math_map_ret = math.map(math_clamp_ret, 0, 32, 0, 1);

            if p9 == "1" then
                local v10 = Parent;

                for _, v in { "Left Leg", "LeftFootAttachment", "StepSparks1" } do
                    if not v10 then
                        v10 = nil;
                        break;
                    end;

                    v10 = v10:FindFirstChild(v);
                end;

                if v10 then
                    v10:Emit(12 + 12 * math_map_ret);
                end;
            else
                local v11 = Parent;

                for _, v in { "Right Leg", "RightFootAttachment", "StepSparks2" } do
                    if not v11 then
                        v11 = nil;
                        break;
                    end;

                    v11 = v11:FindFirstChild(v);
                end;

                if v11 then
                    v11:Emit(12 + 12 * math_map_ret);
                end;
            end;
        end);
    end
};