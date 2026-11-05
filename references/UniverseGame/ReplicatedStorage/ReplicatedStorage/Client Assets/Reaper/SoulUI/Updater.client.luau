  

 

local Character = game:GetService("Players").LocalPlayer.Character;
local Label = script.Parent.Label;
Label.Text = `Souls: {Character:GetAttribute("Souls")}`;
Character:GetAttributeChangedSignal("Souls"):Connect(function() -- Line: 6, Name: Update
    -- upvalues: Label (copy), Character (copy)
    Label.Text = `Souls: {Character:GetAttribute("Souls")}`;
end);