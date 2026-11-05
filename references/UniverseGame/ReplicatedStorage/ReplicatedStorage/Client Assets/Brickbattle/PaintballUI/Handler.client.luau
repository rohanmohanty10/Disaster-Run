  

 

local Parent = script.Parent;
local Screen = Parent:WaitForChild("Screen");
local AddSplatter = Parent:WaitForChild("AddSplatter");
local TweenService = game:GetService("TweenService");
local random = math.random;
local fromScale = UDim2.fromScale;
local new = TweenInfo.new;
local wait = task.wait;
local fromRGB = Color3.fromRGB;

local function u8(p1) -- Line: 9
    -- upvalues: random (copy), Screen (copy), fromScale (copy), fromRGB (copy), TweenService (copy), new (copy), wait (copy)
    local v2 = random(10, 100) / 450;
    local v3 = v2 * 1.1 + v2 * v2 / 0.1 + v2 * v2 * v2 * 11;
    local v4 = Screen.Template:Clone();
    v4.Parent = Screen;
    v4.Name = "Temp";
    v4.Visible = true;
    v4.Position = fromScale(random(1, 100) / 100, random(1, 100) / 100);
    local Position = v4.Position;
    v4.Size = fromScale(0, 0);
    v4.Rotation = random(-90, 90);
    v4.ImageColor3 = p1 or fromRGB(0, 0, 0);
    local v5 = random(1, 15) / 10;
    local v6 = random(4, 25) / 10;
    local v7 = random(10, 40) / 10;
    TweenService:Create(v4, new(v5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Size = fromScale(v2, v3),
        Position = fromScale(Position.X.Scale - v2 / 2, Position.Y.Scale - v3 / 2)
    }):Play();
    wait(v7);
    TweenService:Create(v4, new(v6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        ImageTransparency = 1,
        Size = fromScale(0, 0),
        Position = Position
    }):Play();
    wait(v6 + 0.05);
    v4:Destroy();
end;

AddSplatter.Event:Connect(function(p9) -- Line: 38
    -- upvalues: u8 (copy), Parent (copy), fromRGB (copy)
    u8(p9 or (Parent:GetAttribute("SplatterColor") or fromRGB(0, 0, 0)));
end);
u8(Parent:GetAttribute("SplatterColor") or fromRGB(0, 0, 0));