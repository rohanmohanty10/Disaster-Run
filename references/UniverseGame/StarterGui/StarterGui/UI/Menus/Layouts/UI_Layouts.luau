  

 

return function(u1) -- Line: 1
    while not u1.Mobile do
        task.wait();
    end;

    local Knit = u1.Knit;
    require(Knit.Util.Trove);
    require(Knit.Util.TableUtil);
    local Parent = script.Parent;
    local u2 = Knit.GetService("LayoutService");
    local u3 = {};

    local function GetSlots() -- Line: 17
        -- upvalues: u2 (copy), u1 (copy)
        local v4 = u2:GetSlots():expect();

        if not v4 then
            return false;
        end;

        u1.Mobile.Slots = v4;

        return true;
    end;

    local function Update() -- Line: 26
        -- upvalues: u3 (copy), u1 (copy), Parent (copy), u2 (copy), Update (copy)
        for _, v in u3 do
            v.Button:Destroy();
        end;

        table.clear(u3);

        for i, v in u1.Mobile.Slots do
            local AbilityName = v.AbilityName;
            local StorageType = v.StorageType;
            local v5 = Parent.Assets.Frame:Clone();
            v5.Name = i;
            v5.LayoutOrder = i;
            v5.SlotName.Text = AbilityName;

            if StorageType == "Temporary" then
                v5.SlotName.Text = AbilityName .. " (Temp)";
            end;

            v5.Visible = true;
            v5.Parent = Parent.List;
            v5.Buttons.Delete.MouseButton1Click:Connect(function() -- Line: 47
                -- upvalues: u1 (ref), u2 (ref), AbilityName (copy), Update (ref)
                u1.NewPrompt({
                    Title = "Delete Layout?",
                    Text = "Are you sure you want to delete this ability layout?",
                    Options = { "Yes", "No" },

                    Callback = function(p6) -- Line: 55, Name: Callback
                        -- upvalues: u1 (ref), u2 (ref), AbilityName (ref), Update (ref)
                        if p6.Choice ~= 1 then
                            return;
                        end;

                        u1:PlaySound("Click");
                        u2:Delete(AbilityName):expect();
                        local v7 = u2:GetSlots():expect();

                        if v7 then
                            u1.Mobile.Slots = v7;
                        end;

                        Update();
                    end
                });
            end);
            u3[AbilityName] = {
                Button = v5,
                SlotIndex = i,
                AbilityName = AbilityName,
                StorageType = StorageType
            };
        end;
    end;

    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 74
        -- upvalues: u2 (copy), u1 (copy), Update (copy)
        local v8 = u2:GetSlots():expect();

        if v8 then
            u1.Mobile.Slots = v8;
        end;

        Update();
    end);
    Parent.Buttons.Save.MouseButton1Down:Connect(function() -- Line: 79
        -- upvalues: u1 (copy), u2 (copy), Update (copy)
        u1.NewPrompt({
            Title = "Save Layout?",
            Text = "Are you sure you want to save this ability layout?",
            Options = { "Yes", "No" },

            Callback = function(p9) -- Line: 87, Name: Callback
                -- upvalues: u1 (ref), u2 (ref), Update (ref)
                if p9.Choice ~= 1 then
                    return;
                end;

                u1:PlaySound("Click");
                local v10 = u1.SerializeMobileLayout();

                if not v10 then
                    return;
                end;

                if not u2:Save(v10):expect() then
                    u1.NewPrompt({
                        Title = "Save Failed",
                        Text = "Failed to save Ability Layout"
                    });

                    return;
                end;

                u1.NewPrompt({
                    Title = "Save Successful",
                    Text = "Ability Layout saved"
                });
                local v11 = u2:GetSlots():expect();

                if v11 then
                    u1.Mobile.Slots = v11;
                end;

                Update();
            end
        });
    end);
end;