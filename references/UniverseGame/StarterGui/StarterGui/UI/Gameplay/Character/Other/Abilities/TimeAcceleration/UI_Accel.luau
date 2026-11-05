  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(p1.Knit.Util.Trove).new();
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);

    local function CharacterAdded(u3) -- Line: 7
        -- upvalues: u2 (copy), Parent (copy)
        u2:Clean();

        local function SetVisible() -- Line: 10
            -- upvalues: Parent (ref), u3 (copy)
            Parent.Visible = u3:GetAttribute("TimeAccel") ~= nil;
        end;

        local function SetDial(p4, p5) -- Line: 14
            -- upvalues: Parent (ref)
            local v6 = Parent["Dial" .. tostring(p4)];
            local Circle = v6.Dial.Left.Circle;
            local Circle2 = v6.Dial.Right.Circle;
            local v7 = math.clamp(p5 * 3.6, 0, 360);
            Circle.UIGradient.Rotation = 180 - math.clamp(v7, 0, 180);
            Circle2.UIGradient.Rotation = 180 - math.clamp(v7, 180, 360);
        end;

        local function UpdateData() -- Line: 24
            -- upvalues: u3 (copy), Parent (ref)
            local v8 = u3:GetAttribute("TimeAccel");
            local _ = u3:GetAttribute("MaxTimeAccel") or 400;

            if not v8 then
                return;
            end;

            if v8 < 100 then
                local v9 = math.clamp(v8 / 100, 0, 1) * 100;
                local v10 = Parent["Dial" .. tostring(1)];
                local Circle = v10.Dial.Left.Circle;
                local Circle2 = v10.Dial.Right.Circle;
                local v11 = math.clamp(v9 * 3.6, 0, 360);
                Circle.UIGradient.Rotation = 180 - math.clamp(v11, 0, 180);
                Circle2.UIGradient.Rotation = 180 - math.clamp(v11, 180, 360);
                local v12 = Parent["Dial" .. tostring(2)];
                local Circle3 = v12.Dial.Right.Circle;
                v12.Dial.Left.Circle.UIGradient.Rotation = 180;
                Circle3.UIGradient.Rotation = 0;
                local v13 = Parent["Dial" .. tostring(3)];
                local Circle4 = v13.Dial.Right.Circle;
                v13.Dial.Left.Circle.UIGradient.Rotation = 180;
                Circle4.UIGradient.Rotation = 0;
                local v14 = Parent["Dial" .. tostring(4)];
                local Circle5 = v14.Dial.Right.Circle;
                v14.Dial.Left.Circle.UIGradient.Rotation = 180;
                Circle5.UIGradient.Rotation = 0;

                return;
            end;

            if v8 < 200 then
                local v15 = Parent["Dial" .. tostring(1)];
                local Circle = v15.Dial.Right.Circle;
                v15.Dial.Left.Circle.UIGradient.Rotation = 0;
                Circle.UIGradient.Rotation = -180;
                local v16 = math.clamp((v8 - 100) / 100, 0, 1) * 100;
                local v17 = Parent["Dial" .. tostring(2)];
                local Circle2 = v17.Dial.Left.Circle;
                local Circle3 = v17.Dial.Right.Circle;
                local v18 = math.clamp(v16 * 3.6, 0, 360);
                Circle2.UIGradient.Rotation = 180 - math.clamp(v18, 0, 180);
                Circle3.UIGradient.Rotation = 180 - math.clamp(v18, 180, 360);
                local v19 = Parent["Dial" .. tostring(3)];
                local Circle4 = v19.Dial.Right.Circle;
                v19.Dial.Left.Circle.UIGradient.Rotation = 180;
                Circle4.UIGradient.Rotation = 0;
                local v20 = Parent["Dial" .. tostring(4)];
                local Circle5 = v20.Dial.Right.Circle;
                v20.Dial.Left.Circle.UIGradient.Rotation = 180;
                Circle5.UIGradient.Rotation = 0;

                return;
            end;

            if v8 >= 300 then
                if v8 <= 400 then
                    local v21 = Parent["Dial" .. tostring(1)];
                    local Circle = v21.Dial.Right.Circle;
                    v21.Dial.Left.Circle.UIGradient.Rotation = 0;
                    Circle.UIGradient.Rotation = -180;
                    local v22 = Parent["Dial" .. tostring(2)];
                    local Circle2 = v22.Dial.Right.Circle;
                    v22.Dial.Left.Circle.UIGradient.Rotation = 0;
                    Circle2.UIGradient.Rotation = -180;
                    local v23 = Parent["Dial" .. tostring(3)];
                    local Circle3 = v23.Dial.Right.Circle;
                    v23.Dial.Left.Circle.UIGradient.Rotation = 0;
                    Circle3.UIGradient.Rotation = -180;
                    local v24 = math.clamp((v8 - 300) / 100, 0, 1) * 100;
                    local v25 = Parent["Dial" .. tostring(4)];
                    local Circle4 = v25.Dial.Left.Circle;
                    local Circle5 = v25.Dial.Right.Circle;
                    local v26 = math.clamp(v24 * 3.6, 0, 360);
                    Circle4.UIGradient.Rotation = 180 - math.clamp(v26, 0, 180);
                    Circle5.UIGradient.Rotation = 180 - math.clamp(v26, 180, 360);
                end;

                return;
            end;

            local v27 = Parent["Dial" .. tostring(1)];
            local Circle = v27.Dial.Right.Circle;
            v27.Dial.Left.Circle.UIGradient.Rotation = 0;
            Circle.UIGradient.Rotation = -180;
            local v28 = Parent["Dial" .. tostring(2)];
            local Circle2 = v28.Dial.Right.Circle;
            v28.Dial.Left.Circle.UIGradient.Rotation = 0;
            Circle2.UIGradient.Rotation = -180;
            local v29 = math.clamp((v8 - 200) / 100, 0, 1) * 100;
            local v30 = Parent["Dial" .. tostring(3)];
            local Circle3 = v30.Dial.Left.Circle;
            local Circle4 = v30.Dial.Right.Circle;
            local v31 = math.clamp(v29 * 3.6, 0, 360);
            Circle3.UIGradient.Rotation = 180 - math.clamp(v31, 0, 180);
            Circle4.UIGradient.Rotation = 180 - math.clamp(v31, 180, 360);
            local v32 = Parent["Dial" .. tostring(4)];
            local Circle5 = v32.Dial.Right.Circle;
            v32.Dial.Left.Circle.UIGradient.Rotation = 180;
            Circle5.UIGradient.Rotation = 0;
        end;

        Parent.Visible = u3:GetAttribute("TimeAccel") ~= nil;
        u2:Add(u3:GetAttributeChangedSignal("TimeAccel"):Connect(SetVisible));
        UpdateData();
        u2:Add(u3.AttributeChanged:Connect(UpdateData));
    end;

    if p1.Character then
        CharacterAdded(p1.Character);
    end;

    p1.Player.CharacterAdded:Connect(CharacterAdded);
end;