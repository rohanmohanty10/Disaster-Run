  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(u1.Knit.Util.Trove).new();
    local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);

    function u1.SetDiscHint(p3, p4) -- Line: 7
        -- upvalues: Parent (copy)
        Parent.Hint.Text = p4;
    end;

    local u5 = "Ability";

    local function CharacterAdded(u6) -- Line: 12
        -- upvalues: u2 (copy), Parent (copy), Stands (copy), u1 (copy), u5 (ref)
        u2:Clean();

        local function SetVisible() -- Line: 15
            -- upvalues: Parent (ref), u6 (copy)
            Parent.Visible = u6:GetAttribute("HasDisc") ~= nil;
        end;

        local function UpdateDataOld() -- Line: 19
            -- upvalues: u6 (copy), Parent (ref), Stands (ref)
            local v7 = u6:GetAttribute("AbilityDisc");
            local v8 = u6:GetAttribute("AbilityDiscName");
            local v9 = u6:GetAttribute("MemoryDisc");
            Parent.Stand.Label.Text = v7 and Stands[v7] or "";
            Parent.Stand.Owner.Text = v8 or "";
            Parent.Memory.Label.Text = v9 or "";
        end;

        local function UpdateData() -- Line: 30
            -- upvalues: u6 (copy), Parent (ref), Stands (ref), u1 (ref)
            local v10 = u6:GetAttribute("AbilityDisc");
            local v11 = u6:GetAttribute("AbilityDiscName");
            local u12 = u6:GetAttribute("MemoryDisc");
            local u13 = u6:GetAttribute("VanishedDisc");
            Parent.Stand.Type.Text = string.upper(not (v10 and Stands[v10]) and "STAND" or Stands[v10]);

            if v10 then
                Parent.Stand.Disc.ImageTransparency = 0.1;
                Parent.Stand.Disc.ImageColor3 = Color3.new(1, 1, 1);
            else
                Parent.Stand.Disc.ImageTransparency = 0.6;
                Parent.Stand.Disc.ImageColor3 = Color3.new(0, 0, 0);
                pcall(function() -- Line: 43
                    -- upvalues: u1 (ref), Parent (ref)
                    u1:ClearDisplayIcon(Parent.Stand.Disc.ViewportFrame);
                end);
            end;

            Parent.Stand.Owner.Text = u13 or string.upper(v11 or "");

            if u12 then
                Parent.Memory.Disc.ImageTransparency = 0.1;
                Parent.Memory.Disc.ImageColor3 = Color3.new(1, 1, 1);
                task.spawn(function() -- Line: 52
                    -- upvalues: u13 (copy), u12 (copy), Parent (ref)
                    local success, result = pcall(function() -- Line: 53
                        -- upvalues: u13 (ref), u12 (ref)
                        local v14 = not u13 and game.Players:GetUserIdFromNameAsync(u12);

                        return v14;
                    end);

                    if success and result then
                        Parent.Memory.Disc.Thumbnail.Image = game.Players:GetUserThumbnailAsync(result, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size180x180);

                        return;
                    end;

                    Parent.Memory.Disc.Thumbnail.Image = "";
                end);
            else
                Parent.Memory.Disc.ImageTransparency = 0.6;
                Parent.Memory.Disc.ImageColor3 = Color3.new(0, 0, 0);
                Parent.Memory.Disc.Thumbnail.Image = "";
            end;

            Parent.Memory.Owner.Text = u13 or string.upper(u12 or "");
        end;

        local function UpdateActiveDisc(p15) -- Line: 70
            -- upvalues: u6 (copy), u5 (ref), Parent (ref), u1 (ref)
            local v16 = u6:GetAttribute("ActiveDisc") or p15;

            if v16 ~= nil and v16 ~= u5 then
                u5 = v16;
                Parent.Selected:TweenPosition(UDim2.new(1, 12, u5 == "Memory" and 0.75 or 0.25, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true);
                u1:PlaySound("Click");
            end;
        end;

        Parent.Visible = u6:GetAttribute("HasDisc") ~= nil;
        u2:Add(u6:GetAttributeChangedSignal("HasDisc"):Connect(SetVisible));
        UpdateData();
        u2:Add(u6.AttributeChanged:Connect(UpdateData));
        UpdateActiveDisc("Ability");
        u2:Add(u6:GetAttributeChangedSignal("ActiveDisc"):Connect(UpdateActiveDisc));
        u1:SetDiscHint("");
    end;

    if u1.Character then
        CharacterAdded(u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
end;