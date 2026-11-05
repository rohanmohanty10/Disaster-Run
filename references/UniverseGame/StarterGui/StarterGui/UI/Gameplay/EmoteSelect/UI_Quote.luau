  

 

return function(u1) -- Line: 1
    local QuoteInfo = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.QuoteInfo);
    local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
    local Parent = script.Parent;

    function u1.AddQuoteButton(p2, u3) -- Line: 6
        -- upvalues: InputFunc (copy)
        local v4 = script.Folder.QuoteTemplate:Clone();
        v4.Text = u3;
        v4.Parent = script.Parent;
        v4.MouseButton1Click:Connect(function() -- Line: 10
            -- upvalues: InputFunc (ref), u3 (copy)
            InputFunc:InvokeServer("Alt-N", u3);
        end);
    end;

    local u5 = require(u1.Knit.Util.Trove).new();
    game:GetService("TweenService");
    local u6 = false;

    local function CharacterAdded(p7) -- Line: 19
        -- upvalues: u5 (copy), QuoteInfo (copy), u1 (copy), u6 (ref), Parent (copy)
        u5:Clean();

        local function SetVisible() -- Line: 22
            -- upvalues: QuoteInfo (ref), u1 (ref), u6 (ref), Parent (ref)
            local v8 = QuoteInfo.Quotes[u1.Player.Data.Ability.Value];
            u6 = v8 and true or false;

            for _, child in pairs(Parent:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy();
                end;
            end;

            if v8 then
                for i, _ in pairs(v8) do
                    u1:AddQuoteButton(i);
                end;
            end;
        end;

        SetVisible();
        u5:Add(u1.Player.Data.Ability.Changed:Connect(SetVisible));
    end;

    if u1.Character then
        CharacterAdded(u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
    game:GetService("UserInputService").InputBegan:Connect(function(p9, p10) -- Line: 51
        -- upvalues: u6 (ref), Parent (copy)
        if p10 then
            return;
        end;

        if p9.KeyCode == Enum.KeyCode.N and u6 then
            Parent.Visible = not Parent.Visible;
        end;
    end);
end;