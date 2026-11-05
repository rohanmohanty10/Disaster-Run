  

 

return function(u1) -- Line: 1
    local LocalPlayer = game.Players.LocalPlayer;
    local u2 = LocalPlayer:GetMouse();
    local Parent = script.Parent;
    local ColorPicker = require(script.ColorPicker);
    local Trove = require(u1.Knit.Util.Trove);
    local u3 = {};
    local u4 = nil;
    local u5 = nil;

    local function SetColor(p6, p7) -- Line: 14
        -- upvalues: u3 (copy)
        local v8 = u3[p6];
        print(p6, v8);

        if v8 then
            v8.Color = p7;
            v8.Button.ColorFrame.BackgroundColor3 = p7;
            game.ReplicatedStorage.SystemRemotes.ChromaColor:FireServer(p7, p6);
        end;
    end;

    local function SetVisible() -- Line: 26
        -- upvalues: u1 (copy), LocalPlayer (copy), Parent (copy)
        local v9 = u1.Player.Data.Ability.Value == 658 and true or u1.Player.Data.Ability.Value == 2000;
        local v10 = LocalPlayer.Data.Skin:GetAttribute("SkinName");

        if v10 ~= "CHROMA" and v10 ~= "Chroma Team" then
            v9 = false;
        end;

        Parent.Visible = v9;
    end;

    local function CharacterAdded(p11) -- Line: 37
        -- upvalues: u1 (copy), LocalPlayer (copy), Parent (copy)
        local v12 = u1.Player.Data.Ability.Value == 658 and true or u1.Player.Data.Ability.Value == 2000;
        local v13 = LocalPlayer.Data.Skin:GetAttribute("SkinName");

        if v13 ~= "CHROMA" and v13 ~= "Chroma Team" then
            v12 = false;
        end;

        Parent.Visible = v12;
    end;

    if u1.Character then
        local _ = u1.Character;
        local v14 = u1.Player.Data.Ability.Value == 658 and true or u1.Player.Data.Ability.Value == 2000;
        local v15 = LocalPlayer.Data.Skin:GetAttribute("SkinName");

        if v15 ~= "CHROMA" and v15 ~= "Chroma Team" then
            v14 = false;
        end;

        Parent.Visible = v14;
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
    local v16 = u1.Player.Data.Ability.Value == 658 and true or u1.Player.Data.Ability.Value == 2000;
    local v17 = LocalPlayer.Data.Skin:GetAttribute("SkinName");

    if v17 ~= "CHROMA" and v17 ~= "Chroma Team" then
        v16 = false;
    end;

    Parent.Visible = v16;
    u1.Player.Data.Ability.Changed:Connect(SetVisible);
    (function(p18) -- Line: 51, Name: UpdateInput
        -- upvalues: u3 (copy), u1 (copy), Trove (copy), Parent (copy), u5 (ref), u4 (ref), ColorPicker (copy), u2 (copy)
        for i = 1, p18 do
            if not u3[i] then
                local u19 = {
                    Color = u1.Player.Data.Chroma["ChromaColor" .. i].Value or Color3.new(1, 1, 1)
                };
                local u20 = Trove.new();
                u19.Collector = u20;
                local v21 = u20:Clone(script.Button);
                v21.Name = i;
                v21.LayoutOrder = i;
                v21.Label.Text = i;
                v21.ColorFrame.BackgroundColor3 = u19.Color;
                v21.Parent = Parent;
                u19.Button = v21;
                u20:Connect(v21.MouseButton1Down, function() -- Line: 71
                    -- upvalues: u5 (ref), i (copy), u4 (ref), ColorPicker (ref), u1 (ref), u2 (ref), u19 (copy), u3 (ref), u20 (copy)
                    if u5 == i then
                        if u5 == i then
                            if u4 then
                                u4:Destroy();
                                u4 = nil;
                            end;

                            u5 = nil;
                        end;

                        return;
                    end;

                    if u4 then
                        u4:Destroy();
                        u4 = nil;
                    end;

                    u5 = i;
                    local u22 = ColorPicker.New(u1.UI, u2, {
                        Draggable = true,
                        RoundedCorners = false,
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    });
                    u22:SetColor(u19.Color);
                    u22.Instance.Parent.AnchorPoint = Vector2.new(0.5, 0.5);
                    u22.Finished:Connect(function(p23) -- Line: 87
                        -- upvalues: i (ref), u3 (ref), u4 (ref), u5 (ref)
                        local v24 = i;
                        local v25 = u3[v24];
                        print(v24, v25);

                        if v25 then
                            v25.Color = p23;
                            v25.Button.ColorFrame.BackgroundColor3 = p23;
                            game.ReplicatedStorage.SystemRemotes.ChromaColor:FireServer(p23, v24);
                        end;

                        u4 = nil;
                        u5 = nil;
                    end);
                    u22.Canceled:Connect(function(p26) -- Line: 93
                        -- upvalues: u4 (ref), u5 (ref)
                        u4 = nil;
                        u5 = nil;
                    end);
                    u4 = u22;
                    u20:Add(function() -- Line: 99
                        -- upvalues: u4 (ref), u22 (copy)
                        if u4 == u22 then
                            u4:Destroy();
                            u4 = nil;
                        end;
                    end);
                end);
                u20:AttachToInstance(v21);
                u20:Add(function() -- Line: 115
                    -- upvalues: u3 (ref), i (copy)
                    u3[i] = nil;
                end);
                u3[i] = u19;
            end;
        end;

        for i, v in pairs(u3) do
            if p18 < i then
                v.Collector:Destroy();
            end;
        end;
    end)(4);
end;