  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
LocalPlayer:WaitForChild("Data");
local ColorWheel = script.Parent:WaitForChild("ColorWheel");
local Preview = script.Parent.Preview;
local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function update() -- Line: 8
    -- upvalues: Preview (copy), ColorWheel (copy)
    Preview.BackgroundColor3 = ColorWheel:GetAttribute("Color");
end;

for i = 1, 4 do
    local u1 = ColorWheel.Parent["Color" .. i];
    local Value = LocalPlayer.Data.Chroma["ChromaColor" .. i].Value;
    u1.BackgroundColor3 = Value;
    Preview.BackgroundColor3 = Value;
    ColorWheel:SetAttribute("Color", Value);
    ReplicatedStorage.SystemRemotes.ChromaColor:FireServer(Value, i);
    u1.InputBegan:Connect(function(p2, p3) -- Line: 20
        -- upvalues: u1 (copy), ColorWheel (copy), i (copy)
        if p2.UserInputType == Enum.UserInputType.MouseButton1 or p2.UserInputType == Enum.UserInputType.Touch then
            u1.BackgroundColor3 = ColorWheel:GetAttribute("Color");
            game.ReplicatedStorage.SystemRemotes.ChromaColor:FireServer(ColorWheel:GetAttribute("Color"), i);
        end;
    end);
end;

ColorWheel:GetAttributeChangedSignal("Color"):Connect(update);
Preview.BackgroundColor3 = ColorWheel:GetAttribute("Color");