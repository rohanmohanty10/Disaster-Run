  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(u1.Knit.Util.Trove).new();
    local TweenService = game:GetService("TweenService");
    local EffectsHandler = require(game:GetService("ReplicatedStorage").ReplicatedModules.EffectsHandler);
    local u3 = TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    local function SetVisible() -- Line: 9
        -- upvalues: Parent (copy), u1 (copy)
        Parent.Visible = u1.Player.Data.Ability.Value == 35;
    end;

    local function AnimateEmerald(p4, p5) -- Line: 12
        -- upvalues: EffectsHandler (copy)
        for i = 1, p5 and 4 or 3 do
            if not p4 then
                break;
            end;

            p4.Position = UDim2.fromScale(-((p5 and 1 or 0) + i), 0.5);
            EffectsHandler.Wait(0.05);
        end;

        if p4 then
            p4.Position = UDim2.fromScale(0, 0.5);
        end;
    end;

    local function ClearThread(p6) -- Line: 22
        if p6 and (coroutine.status(p6) ~= "running" and coroutine.status(p6) ~= "normal") then
            task.cancel(p6);
        end;
    end;

    local function CharacterAdded(u7) -- Line: 28
        -- upvalues: Parent (copy), u1 (copy), u2 (copy), AnimateEmerald (copy), TweenService (copy), u3 (copy), EffectsHandler (copy)
        Parent.Visible = u1.Player.Data.Ability.Value == 35;

        if not Parent.Visible then
            return;
        end;

        u2:Clean();
        local u8 = nil;
        local u9 = nil;

        local function UpdateTeleports() -- Line: 35
            -- upvalues: u7 (copy), Parent (ref), AnimateEmerald (ref), TweenService (ref), u3 (ref), u9 (ref), u2 (ref), EffectsHandler (ref)
            local v10 = u7:GetAttribute("STHTPStacks");

            if not v10 then
                return;
            end;

            for _, child in Parent.Stacks:GetChildren() do
                if child:IsA("Frame") and (child.Visible and (child.Name ~= "Invalid" and v10 < child:GetAttribute("Id"))) then
                    child:SetAttribute("Id", nil);
                    child.Name = "Invalid";
                    task.spawn(AnimateEmerald, child.Icon);
                    local v11 = TweenService:Create(child.Icon, u3, {
                        ImageTransparency = 1,
                        ImageColor3 = Color3.new(0.5, 0.5, 0.5)
                    });
                    v11:Play();
                    v11.Completed:Once(function() -- Line: 49
                        -- upvalues: child (copy)
                        child:Destroy();
                    end);
                end;
            end;

            for i = 1, v10 do
                if not Parent.Stacks:FindFirstChild((`Stack{i}`)) then
                    local v12 = Parent.Stacks.Emerald:Clone();
                    v12:SetAttribute("Id", i);
                    v12.Parent = Parent.Stacks;
                    v12.Name = `Stack{i}`;
                    v12.Visible = true;
                    task.spawn(AnimateEmerald, v12.Icon, true);
                end;
            end;

            if u9 then
                u2:Remove(u9);
                local v13 = u9;

                if v13 and (coroutine.status(v13) ~= "running" and coroutine.status(v13) ~= "normal") then
                    task.cancel(v13);
                end;
            end;

            u9 = task.spawn(function() -- Line: 70
                -- upvalues: Parent (ref), EffectsHandler (ref), AnimateEmerald (ref)
                local v14 = Parent.Stacks:GetChildren();

                while true do
                    EffectsHandler.Wait(4);

                    for _, v in v14 do
                        if v:IsA("Frame") and (v.Visible and v.Name ~= "Invalid") then
                            task.spawn(AnimateEmerald, v.Icon);
                        end;
                    end;
                end;
            end);
        end;

        local function UpdateRings() -- Line: 82
            -- upvalues: u7 (copy), Parent (ref), u8 (ref), EffectsHandler (ref)
            local v15 = u7:GetAttribute("STHRings") or 0;
            Parent.Rings.Amount.Text = math.clamp(v15, 0, 999);

            if u8 then
                pcall(task.cancel, u8);
                u8 = nil;
            end;

            if v15 == 0 then
                u8 = task.spawn(function() -- Line: 92
                    -- upvalues: EffectsHandler (ref), Parent (ref)
                    while true do
                        EffectsHandler.Wait(0.375);
                        Parent.Rings.Amount.TextColor3 = Parent.Rings.Amount.TextColor3.G > 0 and Color3.new(1, 0, 0) or Color3.new(1, 1, 0);
                    end;
                end);

                return;
            end;

            Parent.Rings.Amount.TextColor3 = Color3.new(1, 1, 0);
        end;

        local u18 = task.spawn(function() -- Line: 103
            -- upvalues: Parent (ref), EffectsHandler (ref)
            local v16 = 0;
            local v17 = false;

            while true do
                v16 = v16 + 1;

                if v16 >= 4 then
                    v16 = 0;
                    v17 = not v17;
                end;

                Parent.Rings.Ring.Icon.Position = UDim2.fromScale(-v16, v17 and -1 or 0);
                EffectsHandler.Wait(0.05);
            end;
        end);
        u2:Add(function() -- Line: 118
            -- upvalues: u18 (copy), u8 (ref)
            local v19 = u18;

            if v19 and (coroutine.status(v19) ~= "running" and coroutine.status(v19) ~= "normal") then
                task.cancel(v19);
            end;

            local v20 = u8;

            if v20 and (coroutine.status(v20) ~= "running" and coroutine.status(v20) ~= "normal") then
                task.cancel(v20);
            end;
        end);
        u2:Connect(u7:GetAttributeChangedSignal("STHTPStacks"), UpdateTeleports);
        u2:Connect(u7:GetAttributeChangedSignal("STHRings"), UpdateRings);
        UpdateTeleports();
        UpdateRings();
    end;

    if u1.Character then
        CharacterAdded(u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
end;