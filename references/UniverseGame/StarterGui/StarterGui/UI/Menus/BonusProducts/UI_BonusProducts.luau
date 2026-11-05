  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local TextLabel = Parent.Assets.TextLabel;
    local TimerProducts = p1.Player:WaitForChild("Data"):WaitForChild("TimerProducts");
    Parent.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 15
        -- upvalues: Parent (copy)
        Parent.Visible = Parent.Parent.Visible;
    end);
    local v2 = {
        DoubleUCoins = "2x UCoins",
        DoubleUShards = "2x UShards",
        DoubleXP = "2x XP",
        DoubleTraitPity = "2x Trait Pity"
    };

    while true do
        for i, child in TimerProducts:GetChildren() do
            local Name = child.Name;

            if os.time() > child.Value then
                if Parent:FindFirstChild(Name) then
                    Parent[Name]:Destroy();
                end;
            elseif v2[Name] then
                local v3 = Parent:FindFirstChild(Name);

                if v3 then
                    v3.Text = `{v2[Name]}\n({p1.toHMS(child.Value - os.time())})`;
                else
                    local v4 = TextLabel:Clone();
                    v4.Name = Name;
                    v4.LayoutOrder = i;
                    v4.Text = `{v2[Name]}\n({p1.toHMS(child.Value - os.time())})`;
                    v4.Visible = true;
                    v4.Parent = Parent;
                end;
            end;
        end;

        task.wait(1);
    end;
end;