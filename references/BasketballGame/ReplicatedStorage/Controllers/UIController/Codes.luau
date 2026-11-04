 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Content = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Codes"):WaitForChild("Content");
local u1 = Knit.CreateController({
    Name = "CodesController"
});

function u1.InitGui() -- Line: 13
    -- upvalues: Knit (copy), Content (copy), Effects (copy)
    local Service = Knit.GetService("CodesService");

    local function RedeemCode() -- Line: 16
        -- upvalues: Content (ref), Service (copy), Effects (ref)
        local Text = Content.TextBox.Text;
        Content.TextBox.Text = "";
        local v2, v3 = Service:RedeemCode(Text);
        Effects:Popup(v3, 2, v2 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0));
    end;

    Content.TextBox.ReturnPressedFromOnScreenKeyboard:Connect(RedeemCode);
    Content.Claim.MouseButton1Click:Connect(RedeemCode);
    Content.Description.Text = "";
    Content.Description.Text = Service:GetDescription();
    Service.OnDescriptionChanged:Connect(function(p4: string) -- Line: 32
        -- upvalues: Content (ref)
        Content.Description.Text = p4;
    end);
end;

function u1.KnitInit(p5) -- Line: 37
    -- upvalues: u1 (copy)
    task.spawn(u1.InitGui);
end;

function u1.KnitStart(p6) -- Line: 41
end;

return u1;