  

 

local Parent = script.Parent;
local text = Parent.text;
game.Players.LocalPlayer.Character.ChildAdded:Connect(function(p1) -- Line: 6
    -- upvalues: Parent (copy), text (copy)
    if p1.Name == "SoulCount" then
        Parent.Enabled = true;
        text.Text = "Souls : " .. p1.Value;
        p1.Changed:Connect(function(p2) -- Line: 11
            -- upvalues: text (ref)
            text.Text = "Souls : " .. p2;
        end);
    end;
end);