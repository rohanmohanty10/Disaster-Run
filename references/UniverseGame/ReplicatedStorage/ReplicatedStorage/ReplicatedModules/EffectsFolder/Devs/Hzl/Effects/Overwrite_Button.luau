  

 

game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local u1 = _G.Petal("Util");
Knit.OnStart():await();
Knit.GetService("EffectService");

return function(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local _ = p2.Player;
    local Character = p2.Character;
    local Mode = p2.Mode;
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");

    local function AnimateLoop(u3) -- Line: 21
        -- upvalues: u1 (ref), AnimateLoop (copy)
        u1.TweenCallback(u3, {
            C0 = u3.C0:Lerp(u3.C0 * CFrame.new(0, 0.5, 0), 1)
        }, function() -- Line: 24
            -- upvalues: AnimateLoop (ref), u3 (copy)
            AnimateLoop(u3);
        end, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 1, true, 0);
    end;

    local function Start() -- Line: 29
        -- upvalues: Character (copy), HumanoidRootPart (copy), u1 (ref), AnimateLoop (copy)
        local _refOverwrite = Character:FindFirstChild("_refOverwrite");

        if _refOverwrite then
            _refOverwrite:Destroy();
        end;

        local Model = Instance.new("Model");
        Model.Name = "_refOverwrite";
        Model.Parent = Character;
        local v4 = script.Button:Clone();
        local TextPart = v4.TextPart;
        local Size = v4.Size;
        local Size2 = TextPart.Size;
        v4.Size = Vector3.new(Size.X, Size.Y * 3.5, Size.Z);
        TextPart.Size = Vector3.new(Size2.X, Size2.Y * 3.5, Size2.Z);
        v4.Parent = Model;
        local Weld = Instance.new("Weld");
        Weld.Part0 = HumanoidRootPart;
        Weld.Part1 = v4;
        Weld.C0 = CFrame.new(0, 0, -2.5) * CFrame.Angles(-0.7853981633974483, -3.141592653589793, 0);
        Weld.C1 = CFrame.new(0, 0, 0);
        Weld.Parent = v4;
        u1.TweenCallback(v4, {
            Size = Size
        }, function() -- Line: 66
            -- upvalues: AnimateLoop (ref), Weld (copy)
            AnimateLoop(Weld);
        end, 0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
        u1.TweenCallback(TextPart, {
            Size = Size2
        }, nil, 0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
    end;

    local function End() -- Line: 75
        -- upvalues: Character (copy), u1 (ref)
        local _refOverwrite = Character:FindFirstChild("_refOverwrite");

        if not _refOverwrite then
            return;
        end;

        local Button = _refOverwrite:FindFirstChild("Button");
        local v5;

        if Button then
            v5 = Button:FindFirstChild("TextPart");
        else
            v5 = Button;
        end;

        if not (Button and v5) then
            _refOverwrite:Destroy();

            return;
        end;

        u1.TweenCallback(Button, {
            Size = Button.Size * 0.01
        }, nil, 0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.In);
        u1.TweenCallback(v5, {
            Size = v5.Size * 0.01
        }, function() -- Line: 93
            -- upvalues: _refOverwrite (copy)
            _refOverwrite:Destroy();
        end, 0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.In);
    end;

    if Mode then
        Start();

        return;
    end;

    End();
end;