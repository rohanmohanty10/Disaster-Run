  

 

for i = 1, #script.Parent.TextLabel.Text do
    script.Parent.TextLabel.MaxVisibleGraphemes = i;
    local v1 = string.sub(script.Parent.TextLabel.Text, i, i);
    local v2 = {
        ["."] = 0.5,
        [","] = 0.25,
        ["?"] = 0.5,
        ["!"] = 0.5
    };

    if v1 ~= " " then
        script.Parent.sansTalk:Play();
    end;

    wait(v2[v1] or 0.04);
end;

game:GetService("Debris"):AddItem(script.Parent.Parent, 0);