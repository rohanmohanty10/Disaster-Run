 

 

if #game:GetService("ServerStorage"):GetChildren() <= 0 then
    local v1 = {};
    local u2 = Random.new();
    local u3 = {};
    local u4 = {};
    local u5 = {};
    local u6 = tick();
    local u7 = nil;
    game:GetService("RunService"):BindToRenderStep("UI_ParticleModule", Enum.RenderPriority.First.Value + 1, function(p8) --[[ Line: 17 ]]
        -- upvalues: u7 (ref), u6 (copy), u3 (copy), u4 (copy), u5 (copy)
        u7 = tick() - u6;
        for _, v9 in pairs(u3) do
            if v9.Emitter.Enabled and tick() - v9.lastEmission >= v9.Emitter.Rate ^ (-1) then
                v9.lastEmission = tick();
                addParticle(v9.Emitter, v9.Emitter.Parent, v9.Scale);
            end;
        end;
        local v10 = {};
        for _, v11 in pairs(u4) do
            local v12 = tick() - v11.Start;
            local v13 = v12 / v11.Lifetime;
            if v11.Lifetime <= v12 then
                table.insert(v10, v11);
            else
                local v14, v15, v16 = getKeypointsFromTime(v11.Transparency, v13);
                v11.UI.ImageTransparency = lerpValue(v14.Value, v15.Value, v16);
                local v17, v18, v19 = getKeypointsFromTime(v11.Size, v13);
                local v20 = lerpValue(v17.Value, v18.Value, v19) * 100 * v11.Scale;
                v11.UI.Size = UDim2.new(0, v20, 0, v20);
                local v21, v22, v23 = getKeypointsFromTime(v11.Emitter.Color, v13);
                local v24 = v21.Value:Lerp(v22.Value, v23);
                v11.UI.ImageColor3 = v24;
                v11.UI.Rotation = v11.UI.Rotation + v11.RotSpeed * p8;
                local _ = v11.UI.Position;
                local l__Speed__1 = v11.Speed;
                local v25 = 1 - math.min(1, v12 ^ 4 * (v11.Emitter.Drag / 10));
                local l__SpreadAngle__2 = v11.SpreadAngle;
                v11.SpeedDisplacement = v11.SpeedDisplacement + l__Speed__1 * p8 * v25;
                if v11.Emitter.EmissionDirection == Enum.NormalId.Bottom then
                    l__SpreadAngle__2 = l__SpreadAngle__2 + 180;
                elseif v11.Emitter.EmissionDirection == Enum.NormalId.Right then
                    l__SpreadAngle__2 = l__SpreadAngle__2 + 90;
                elseif v11.Emitter.EmissionDirection == Enum.NormalId.Left then
                    l__SpreadAngle__2 = l__SpreadAngle__2 + 270;
                end;
                local l__new__3 = UDim2.new;
                local v26 = math.rad(l__SpreadAngle__2);
                local v27 = math.sin(v26) * v11.SpeedDisplacement;
                local v28 = math.rad(l__SpreadAngle__2);
                local v29 = l__new__3(0, v27, 0, -math.cos(v28) * v11.SpeedDisplacement);
                v11.Accel = v11.Accel + v11.Emitter.Acceleration * 100 * v11.Scale * v12 ^ 2 * p8 * v25;
                v11.UI.Position = v11.StartPos + v29 + UDim2.new(0, v11.Accel.X, 0, -v11.Accel.Y);
            end;
        end;
        for _, v30 in pairs(v10) do
            v30.UI.ImageTransparency = 1;
            local v31 = u5;
            local v32 = {
                UI = v30.UI,
                RemoveAt = tick() + 3 * v30.Emitter.Rate ^ (-1)
            };
            table.insert(v31, v32);
            table.remove(u4, table.find(u4, v30));
        end;
        local v33 = {};
        for _, v34 in pairs(u5) do
            if tick() >= v34.RemoveAt then
                v34.UI:Destroy();
                table.insert(v33, v34);
            end;
        end;
        for _, v35 in pairs(v33) do
            table.remove(u5, table.find(u5, v35));
        end;
    end);
    function lerpValue(p36, p37, p38)
        return p36 + (p37 - p36) * p38;
    end;
    function r_num(p39, p40)
        -- upvalues: u2 (copy)
        return u2:NextNumber(p40 and p39 and p39 or 0, p40 or p39);
    end;
    function r_int(p41, p42)
        -- upvalues: u2 (copy)
        return u2:NextInteger(p42 and p41 and p41 or 0, p42 or p41);
    end;
    function addParticle(p43, p44, p45)
        -- upvalues: u5 (copy), u4 (copy)
        local v46 = nil;
        for _, v47 in pairs(u5) do
            if v47.UI then
                v46 = v47.UI;
                v46.Parent = p44;
                table.remove(u5, table.find(u5, v47));
                break;
            end;
        end;
        if not v46 then
            v46 = Instance.new("ImageLabel", p44);
            v46.BackgroundTransparency = 1;
            v46.AnchorPoint = Vector2.new(0.5, 0.5);
        end;
        v46.Image = p43.Texture;
        v46.ZIndex = p43.ZOffset;
        local v48 = UDim2.new(r_num(0, 1), 0, r_num(0, 1), 0);
        v46.Position = v48;
        v46.ImageColor3 = p43.Color.Keypoints[1].Value;
        local v49 = p43.Size.Keypoints[1];
        local v50 = r_num(v49.Value - v49.Envelope, v49.Value + v49.Envelope) * 100 * p45;
        v46.Size = UDim2.new(0, v50, 0, v50);
        local v51 = p43.Transparency.Keypoints[1];
        v46.ImageTransparency = r_num(v51.Value - v51.Envelope, v51.Value + v51.Envelope);
        v46.Rotation = r_num(p43.Rotation.Min, p43.Rotation.Max);
        local v52 = r_num(p43.Speed.Min, p43.Speed.Max) * 100 * p45;
        local v53 = r_num(p43.RotSpeed.Min, p43.RotSpeed.Max);
        local v54 = r_num(-p43.SpreadAngle.X, p43.SpreadAngle.Y);
        local v55 = getRandomNumberSequence(p43.Transparency);
        local v56 = getRandomNumberSequence(p43.Size);
        local v57 = u4;
        local v58 = {
            SpeedDisplacement = 0,
            Accel = Vector3.new(0, 0, 0),
            Emitter = p43,
            UI = v46,
            Start = tick(),
            Lifetime = r_num(p43.Lifetime.Min, p43.Lifetime.Max),
            Transparency = v55,
            Size = v56,
            Speed = v52,
            RotSpeed = v53,
            SpreadAngle = v54,
            StartPos = v48,
            Scale = p45
        };
        table.insert(v57, v58);
    end;
    function getRandomNumberSequence(p59)
        local v60 = {
            Keypoints = {}
        };
        for _, v61 in pairs(p59.Keypoints) do
            local l__Keypoints__4 = v60.Keypoints;
            local v62 = {
                Time = v61.Time,
                Value = r_num(v61.Value - v61.Envelope, v61.Value + v61.Envelope)
            };
            table.insert(l__Keypoints__4, v62);
        end;
        return v60;
    end;
    function getKeypointsFromTime(p63, p64)
        for v65, v66 in pairs(p63.Keypoints) do
            if p64 < v66.Time then
                local v67 = p63.Keypoints[v65 - 1];
                local v68 = p63.Keypoints[v65];
                return v67, v68, (p64 - v67.Time) / (v68.Time - v67.Time);
            end;
        end;
    end;
    function v1.AddEmitter(_, p69, p70) --[[ Line: 200 ]]
        -- upvalues: u3 (copy)
        local v71 = u3;
        local v72 = {
            Emitter = p69,
            lastEmission = tick(),
            Scale = p70 or 1
        };
        table.insert(v71, v72);
    end;
    function v1.RemoveEmitter(_, p73) --[[ Line: 206 ]]
        -- upvalues: u3 (copy)
        local v74 = {};
        for _, v75 in pairs(u3) do
            if v75.Emitter == p73 then
                table.insert(v74, v75);
                break;
            end;
        end;
        for _, v76 in pairs(v74) do
            table.remove(u3, table.find(u3, v76));
        end;
    end;
    return v1;
end;